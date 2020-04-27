using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using AspNetCoreRateLimit;
using HealthChecks.UI.Client;
using horizonsb.api.Configurations;
using horizonsb.api.Configurations.AutoMappingProfiles;
using horizonsb.api.Proxies;
using horizonsb.api.Schedulers;
using horizonsb.api.WSs;
using horizonsb.be.model.CustomTypes;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using Microsoft.AspNetCore.Mvc.Routing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Npgsql;
using Quartz;
using Quartz.Impl;
using Quartz.Spi;
using Serilog;
using Serilog.Events;
using StackExchange.Redis;
using Swashbuckle.AspNetCore.Swagger;

namespace horizonsb.api
{
  public class Startup
  {
    public Startup(IConfiguration configuration, IHostingEnvironment hostEnv)
    {
      Configuration = configuration;
      HostEnv = hostEnv;
    }

    private const string CorsPolicyName = "AllowSpecificOrigins";

    public IConfiguration Configuration { get; }
    public IHostingEnvironment HostEnv { get; }

    public void ConfigureServices(IServiceCollection services)
    {
      services.AddCors(options =>
      {
        options.AddPolicy(CorsPolicyName,
          builderCors => { builderCors.AllowAnyMethod().AllowAnyHeader().AllowAnyOrigin(); });
      });

      services.Configure<CookiePolicyOptions>(options =>
      {
        options.CheckConsentNeeded = context => true;
        options.MinimumSameSitePolicy = SameSiteMode.None;
      });

      var name = Assembly.GetExecutingAssembly().GetName();

      Log.Logger = new LoggerConfiguration()
        .ReadFrom.Configuration(Configuration)
        .MinimumLevel.Information()
        .MinimumLevel.Override("ilot", LogEventLevel.Information)
        .Enrich.FromLogContext()
        .Enrich.WithMachineName()
        .Enrich.WithProperty("Assembly", $"{name.Name}")
        .Enrich.WithProperty("Revision", $"{name.Version}")
        .WriteTo.Debug(
          outputTemplate:
          "[{Timestamp:HH:mm:ss} {Level:u3}] {Message:lj} {NewLine}{HttpContext} {NewLine}{Exception}")
        .WriteTo.RollingFile(HostEnv.WebRootPath + @"log-{Date}.txt", Serilog.Events.LogEventLevel.Information,
          retainedFileCountLimit: 7)
        .CreateLogger();

      services.AddLogging(loggingBuilder =>
        loggingBuilder
          .AddSerilog(dispose: true));


      services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);


      var key = Encoding.ASCII.GetBytes(Configuration.GetSection("TokenAuthentication:SecretKey").Value);
      services.AddAuthentication(x =>
        {
          x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
          x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
        })
        .AddJwtBearer(x =>
        {
          x.RequireHttpsMetadata = false;
          x.SaveToken = true;
          x.TokenValidationParameters = new TokenValidationParameters
          {
            ValidateIssuerSigningKey = true,
            ValidateLifetime = true,
            IssuerSigningKey = new SymmetricSecurityKey(key),
            ValidateIssuer = false,
            ValidateAudience = false,
            ClockSkew = TimeSpan.Zero,
            ValidIssuer = Configuration.GetSection("TokenAuthentication:Issuer").Value,
            ValidAudience = Configuration.GetSection("TokenAuthentication:Audience").Value,
          };
        });

      NpgsqlConnection.GlobalTypeMapper.UseJsonNet(new[] { typeof(JsonbType) });

      services.Configure<IpRateLimitOptions>((options) =>
      {
        options.GeneralRules = new System.Collections.Generic.List<RateLimitRule>()
        {
          new RateLimitRule()
          {
            Endpoint = "*",
            Limit = 1000,
            Period = "5m"
          },
          new RateLimitRule()
          {
            Endpoint = "*",
            Limit = 200,
            Period = "10s"
          }
        };
      });

      services.AddSingleton<IRateLimitCounterStore, MemoryCacheRateLimitCounterStore>();
      services.AddSingleton<IIpPolicyStore, MemoryCacheIpPolicyStore>();
      services.AddSingleton<IActionContextAccessor, ActionContextAccessor>();
      services.AddScoped<IUrlHelper>(implementationFactory =>
      {
        var actionContext = implementationFactory.GetService<IActionContextAccessor>()
          .ActionContext;
        return new UrlHelper(actionContext);
      });

      services.AddScoped<IUrlHelper>(x =>
      {
        var actionContext = x.GetRequiredService<IActionContextAccessor>().ActionContext;
        var factory = x.GetRequiredService<IUrlHelperFactory>();
        return factory.GetUrlHelper(actionContext);
      });

      Config.ConfigureRepositories(services);
      Config.ConfigureAutoMapper(services);
      Config.ConfigureNHibernate(services, Configuration["ConnectionString"]);

      services.AddSingleton<IJobFactory, JobFactory>();
      services.AddSingleton<ISchedulerFactory, StdSchedulerFactory>();
      services.AddHostedService<QuartzHostedService>();

      services.AddSingleton<PostgresInitializerJob>();
      services.AddSingleton<BetDataInitializerJob>();
      services.AddSingleton<RegisterUpcomingWsInitializerJob>();
      services.AddSingleton<KeepAliveWsInitializerJob>();
      services.AddSingleton<LiveBetInitializerJob>();

      //0 15 10 * * ? Fire at 03:15am every day
      services.AddSingleton(new JobSchedule(
        jobType: typeof(PostgresInitializerJob),
        cronExpression: "0 15 3 * * ?"));

      services.AddSingleton(new JobSchedule(
        jobType: typeof(BetDataInitializerJob),
        cronExpression: "10 0/20 * * * ?")); //(i.e. 10:00:10 am, 10:20:10 am, etc.).

      services.AddSingleton(new JobSchedule(
        jobType: typeof(RegisterUpcomingWsInitializerJob), 
        //cronExpression: "30 0/2 * * * ?")); //(i.e. 10:00:30 am, 10:02:30 am, etc.).
        cronExpression: "0/25 * * * * ?")); // run every 25 seconds

      services.AddSingleton(new JobSchedule(
        jobType: typeof(KeepAliveWsInitializerJob),
        cronExpression: "0/5 * * * * ?")); // run every 5 seconds
                                           
      services.AddSingleton(new JobSchedule(
        jobType: typeof(LiveBetInitializerJob),
        cronExpression: "0/30 * * * * ?")); // run every 30 seconds

      services.AddSingleton<ConnectionMultiplexer>(sp =>
      {
        ConfigurationOptions options = new ConfigurationOptions
        {
          EndPoints = {{Configuration["RedisConnectionString"], 6379}},
          AllowAdmin = true,
          ConnectTimeout = 600 * 1000,
          ResolveDns = true,
          AbortOnConnectFail = false,
          Password = "horizonsb"
        };

        return ConnectionMultiplexer.Connect(options);
      });
      services.AddSwaggerGen(options =>
      {
        options.DescribeAllEnumsAsStrings();
        options.SwaggerDoc("v1", new Swashbuckle.AspNetCore.Swagger.Info()
        {
          Title = "horizonsb.api - HTTP API",
          Version = "v1",
          Description = "The Catalog Microservice HTTP API for horizonsb.api service.",
          TermsOfService = ""
        });
        options.AddSecurityDefinition("Bearer", new ApiKeyScheme
        {
          Description =
            "Authorization: Bearer {token}",
          Name = "Authorization",
          In = "header",
          Type = "apiKey"
        });
        options.AddSecurityRequirement(new Dictionary<string, IEnumerable<string>>
        {
          {"Bearer", new string[] { }}
        });
        var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
        var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
        options.IncludeXmlComments(xmlPath);
      });
      services.AddCors(options =>
      {
        options.AddPolicy("CorsPolicy",
          builderCors => builderCors.AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader()
            .AllowCredentials());
      });

      services.AddSingleton<IWsConfiguration, WsConfiguration>();
      services.AddSingleton<IEventChangedProxyManipulator, EventChangedProxyManipulator>();
      services.AddSingleton<IMarketChangedProxyManipulator, MarketChangedProxyManipulator>();
      services.AddSingleton<IEventWithMarketChangedProxyManipulator, EventWithMarketChangedProxyManipulator>();
      services.AddSingleton<IEventEndedProxyManipulator, EventEndedProxyManipulator>();
      services.AddSingleton<IEventStartedProxyManipulator, EventStartedProxyManipulator>();


      services.AddHealthChecks()
        .AddNpgSql(Configuration.GetConnectionString("PostgreSqlDatabase"), failureStatus: HealthStatus.Unhealthy,
          name: "PostgreSQL database", tags: new[] { "ready" })
        .AddRedis(redisConnectionString: Configuration.GetConnectionString("RedisCache"),
          name: "Redis",
          failureStatus: HealthStatus.Unhealthy, tags: new[] { "ready" });
    }

    public void Configure(IApplicationBuilder app, IHostingEnvironment env)
    {
      if (env.IsDevelopment())
      {
        app.UseDeveloperExceptionPage();
      }

      app.UseHealthChecks("/health/ready",
        new HealthCheckOptions
        {

          ResultStatusCodes =
          {
            [HealthStatus.Healthy] = StatusCodes.Status200OK,
            [HealthStatus.Degraded] = StatusCodes.Status500InternalServerError,
            [HealthStatus.Unhealthy] = StatusCodes.Status503ServiceUnavailable,
          },

          Predicate = (check) => check.Tags.Contains("ready"),
          AllowCachingResponses = false,
          ResponseWriter = WriteHealthCheckReadyResponse
        });

      app.UseHealthChecks("/health/live",
        new HealthCheckOptions
        {
          Predicate = (check) => !check.Tags.Contains("live"),
          ResponseWriter = WriteHealthCheckLiveResponse,
          AllowCachingResponses = false
        });

      app.UseHealthChecks("/health", new HealthCheckOptions
      {
        Predicate = _ => true,
        ResultStatusCodes =
        {
          [HealthStatus.Healthy] = StatusCodes.Status200OK,
          [HealthStatus.Degraded] = StatusCodes.Status500InternalServerError,
          [HealthStatus.Unhealthy] = StatusCodes.Status503ServiceUnavailable,
        },
        AllowCachingResponses = false,
        ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
      });

      app.UseSwagger().UseSwaggerUI(c => { c.SwaggerEndpoint("/swagger/v1/swagger.json", "horizonsb.api V1"); });
      var serviceProvider = app.ApplicationServices;
      var serviceWs = (IWsConfiguration) serviceProvider.GetService(typeof(IWsConfiguration));
      serviceWs.EstablishConnection();

      var serviceEventChangedProxy = (IEventChangedProxyManipulator)serviceProvider.GetService(typeof(IEventChangedProxyManipulator));
      serviceEventChangedProxy.ProxyInitializer();

      var serviceMarketChangedProxy = (IMarketChangedProxyManipulator)serviceProvider.GetService(typeof(IMarketChangedProxyManipulator));
      serviceMarketChangedProxy.ProxyInitializer();

      var serviceEventWithMarketChangedProxy = (IEventWithMarketChangedProxyManipulator)serviceProvider.GetService(typeof(IEventWithMarketChangedProxyManipulator));
      serviceEventWithMarketChangedProxy.ProxyInitializer();

      var serviceEventEndedProxy = (IEventEndedProxyManipulator)serviceProvider.GetService(typeof(IEventEndedProxyManipulator));
      serviceEventEndedProxy.ProxyInitializer();

      var serviceEventStartedProxy = (IEventStartedProxyManipulator)serviceProvider.GetService(typeof(IEventStartedProxyManipulator));
      serviceEventStartedProxy.ProxyInitializer();

      app.UseHealthChecksUI();

      app.UseCors(CorsPolicyName);
      app.UseCookiePolicy();
      app.UseHttpsRedirection();
      app.UseAuthentication();


      AutoMapper.Mapper.Initialize(cfg =>
      {
        cfg.AddProfile<MarketTypeEntityToMarketTypetUiAutoMapperProfile>();
        cfg.AddProfile<SportEntityToSportUiAutoMapperProfile>();
        cfg.AddProfile<TournamentEntityToTournamentUiAutoMapperProfile>();
        cfg.AddProfile<EventEntityToEventUiAutoMapperProfile>();
        cfg.AddProfile<EventEntityToEventUpcomingLiveUiAutoMapperProfile>();
        cfg.AddProfile<MarketEntityToMarketUiAutoMapperProfile>();
      });

      app.UseMvc();
    }

    private Task WriteHealthCheckLiveResponse(HttpContext httpContext, HealthReport result)
    {
      httpContext.Response.ContentType = "application/json";

      var json = new JObject(
        new JProperty("OverallStatus", result.Status.ToString()),
        new JProperty("TotalChecksDuration", result.TotalDuration.TotalSeconds.ToString("0:0.00"))
      );

      return httpContext.Response.WriteAsync(json.ToString(Formatting.Indented));
    }

    private Task WriteHealthCheckReadyResponse(HttpContext httpContext, HealthReport result)
    {
      httpContext.Response.ContentType = "application/json";

      var json = new JObject(
        new JProperty("OverallStatus", result.Status.ToString()),
        new JProperty("TotalChecksDuration", result.TotalDuration.TotalSeconds.ToString("0:0.00")),
        new JProperty("DependencyHealthChecks", new JObject(result.Entries.Select(dicItem =>
          new JProperty(dicItem.Key, new JObject(
            new JProperty("Status", dicItem.Value.Status.ToString()),
            new JProperty("Duration", dicItem.Value.Duration.TotalSeconds.ToString("0:0.00")),
            new JProperty("Exception", dicItem.Value.Exception?.Message),
            new JProperty("Data", new JObject(dicItem.Value.Data.Select(dicData =>
              new JProperty(dicData.Key, dicData.Value))))
          ))
        )))
      );

      return httpContext.Response.WriteAsync(json.ToString(Formatting.Indented));
    }
  }
}

