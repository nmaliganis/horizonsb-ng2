using System;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;
using horizonsb.api.Helpers.Json;
using horizonsb.api.Helpers.Services;
using horizonsb.api.Redis.Events;
using horizonsb.api.Redis.Events.Live;
using horizonsb.api.Redis.Logs;
using horizonsb.api.Redis.Sports;
using horizonsb.api.Redis.Tournaments;
using horizonsb.be.contracts.Admin.Roles;
using horizonsb.be.contracts.Admin.Users;
using horizonsb.be.contracts.Categories;
using horizonsb.be.contracts.Events;
using horizonsb.be.contracts.Markets;
using horizonsb.be.contracts.MarketTypes;
using horizonsb.be.contracts.Odds;
using horizonsb.be.contracts.Sports;
using horizonsb.be.contracts.Tournaments;
using horizonsb.be.contracts.V1;
using horizonsb.be.contracts.V1.Admin;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.be.repository.ContractRepositories.Admin;
using horizonsb.be.repository.Mappings.Sports;
using horizonsb.be.repository.NhUnitOfWork;
using horizonsb.be.repository.Repositories;
using horizonsb.be.repository.Repositories.Admin;
using horizonsb.be.services.Admin.Roles;
using horizonsb.be.services.Admin.Users;
using horizonsb.be.services.Categories;
using horizonsb.be.services.Events;
using horizonsb.be.services.Markets;   
using horizonsb.be.services.MarketTypes;
using horizonsb.be.services.Odds;
using horizonsb.be.services.Sports;
using horizonsb.be.services.Tournaments;
using horizonsb.be.services.V1;
using horizonsb.be.services.V1.Admin;
using horizonsb.common.infrastructure.Exceptions.Repositories;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using Microsoft.Extensions.DependencyInjection;
using NHibernate;

namespace horizonsb.api.Configurations
{
  public static class Config
  {
    public static void ConfigureRepositories(IServiceCollection services)
    {
      services.AddTransient<ISportRedisRepository, SportRedisRepository>();
      services.AddTransient<ITournamentRedisRepository, TournamentRedisRepository>();
      services.AddTransient<IEventRedisRepository, EventRedisRepository>();
      services.AddTransient<ILiveRedisRepository, LiveRedisRepository>();
      services.AddTransient<ILogRedisRepository, LogRedisRepository>();

      services.AddSingleton<IJsonSerializer, JsonSerializer>();

      services.AddSingleton<IPropertyMappingService, PropertyMappingService>();
      services.AddSingleton<ITypeHelperService, TypeHelperService>();

      services.AddScoped<IInquiryUserProcessor, InquiryUserProcessor>();
      services.AddScoped<IInquiryAllUsersProcessor, InquiryAllUsersProcessor>();
      services.AddScoped<ICreateUserProcessor, CreateUserProcessor>();
      services.AddScoped<IUpdateUserProcessor, UpdateUserProcessor>();
      services.AddScoped<IActivateUserProcessor, ActivateUserProcessor>();
      services.AddScoped<IUserRepository, UserRepository>();
      services.AddScoped<IUsersControllerDependencyBlock, UsersControllerDependencyBlock>();

      services.AddScoped<IInquiryRoleProcessor, InquiryRoleProcessor>();
      services.AddScoped<IInquiryAllRolesProcessor, InquiryAllRolesProcessor>();
      services.AddScoped<ICreateRoleProcessor, CreateRoleProcessor>();
      services.AddScoped<IUpdateRoleProcessor, UpdateRoleProcessor>();
      services.AddScoped<IDeleteRoleProcessor, DeleteRoleProcessor>();
      services.AddScoped<IRoleRepository, RoleRepository>();
      services.AddScoped<IRolesControllerDependencyBlock, RolesControllerDependencyBlock>();

      services.AddScoped<IInquirySportProcessor, InquirySportProcessor>();
      services.AddScoped<IInquiryAllSportsProcessor, InquiryAllSportsProcessor>();
      services.AddScoped<ICreateSportProcessor, CreateSportProcessor>();
      services.AddScoped<IUpdateSportProcessor, UpdateSportProcessor>();
      services.AddScoped<IDeleteSportProcessor, DeleteSportProcessor>();
      services.AddScoped<ISportRepository, SportRepository>();
      services.AddScoped<ISportsControllerDependencyBlock, SportsControllerDependencyBlock>();

      services.AddScoped<IInquiryMarketTypeProcessor, InquiryMarketTypeProcessor>();
      services.AddScoped<IInquiryAllMarketTypesProcessor, InquiryAllMarketTypesProcessor>();
      services.AddScoped<ICreateMarketTypeProcessor, CreateMarketTypeProcessor>();
      services.AddScoped<IUpdateMarketTypeProcessor, UpdateMarketTypeProcessor>();
      services.AddScoped<IDeleteMarketTypeProcessor, DeleteMarketTypeProcessor>();
      services.AddScoped<IMarketTypeRepository, MarketTypeRepository>();
      services.AddScoped<IMarketTypesControllerDependencyBlock, MarketTypesControllerDependencyBlock>();

      services.AddScoped<IInquiryMarketProcessor, InquiryMarketProcessor>();
      services.AddScoped<IInquiryAllMarketsProcessor, InquiryAllMarketsProcessor>();
      services.AddScoped<ICreateMarketProcessor, CreateMarketProcessor>();
      services.AddScoped<IUpdateMarketProcessor, UpdateMarketProcessor>();
      services.AddScoped<IDeleteMarketProcessor, DeleteMarketProcessor>();
      services.AddScoped<IMarketRepository, MarketRepository>();
      services.AddScoped<IMarketsControllerDependencyBlock, MarketsControllerDependencyBlock>();

      services.AddScoped<IInquiryOddProcessor, InquiryOddProcessor>();
      services.AddScoped<IInquiryAllOddsProcessor, InquiryAllOddsProcessor>();
      services.AddScoped<ICreateOddProcessor, CreateOddProcessor>();
      services.AddScoped<IUpdateOddProcessor, UpdateOddProcessor>();
      services.AddScoped<IDeleteOddProcessor, DeleteOddProcessor>();
      services.AddScoped<IOddRepository, OddRepository>();
      services.AddScoped<IOddsControllerDependencyBlock, OddsControllerDependencyBlock>();

      services.AddScoped<IInquiryEventProcessor, InquiryEventProcessor>();
      services.AddScoped<IInquiryAllEventsProcessor, InquiryAllEventsProcessor>();
      services.AddScoped<ICreateEventProcessor, CreateEventProcessor>();
      services.AddScoped<IUpdateEventProcessor, UpdateEventProcessor>();
      services.AddScoped<IDeleteEventProcessor, DeleteEventProcessor>();
      services.AddScoped<IEventRepository, EventRepository>();
      services.AddScoped<IEventsControllerDependencyBlock, EventsControllerDependencyBlock>();

      services.AddScoped<IInquiryCategoryProcessor, InquiryCategoryProcessor>();
      services.AddScoped<IInquiryAllCategoriesProcessor, InquiryAllCategoriesProcessor>();
      services.AddScoped<ICreateCategoryProcessor, CreateCategoryProcessor>();
      services.AddScoped<IUpdateCategoryProcessor, UpdateCategoryProcessor>();
      services.AddScoped<IDeleteCategoryProcessor, DeleteCategoryProcessor>();
      services.AddScoped<ICategoryRepository, CategoryRepository>();
      services.AddScoped<ICategoriesControllerDependencyBlock, CategoriesControllerDependencyBlock>();

      services.AddScoped<IInquiryTournamentProcessor, InquiryTournamentProcessor>();
      services.AddScoped<IInquiryAllTournamentsProcessor, InquiryAllTournamentsProcessor>();
      services.AddScoped<ICreateTournamentProcessor, CreateTournamentProcessor>();
      services.AddScoped<IUpdateTournamentProcessor, UpdateTournamentProcessor>();
      services.AddScoped<IDeleteTournamentProcessor, DeleteTournamentProcessor>();
      services.AddScoped<ITournamentRepository, TournamentRepository>();
      services.AddScoped<ITournamentsControllerDependencyBlock, TournamentsControllerDependencyBlock>();
    }

    public static void ConfigureAutoMapper(IServiceCollection services)
    {
      services.AddSingleton<IAutoMapper, AutoMapperAdapter>();
    }

    public static void ConfigureNHibernate(IServiceCollection services, string connectionString)
    {
      try
      {
        var cfg =
          PostgreSQLConfiguration.PostgreSQL82.ConnectionString(connectionString)
            .MaxFetchDepth(5)
            .FormatSql()
            .Raw("transaction.use_connection_on_system_prepare", "true")
            .AdoNetBatchSize(100);

        var sessionFactory =
          Fluently.Configure().Database(cfg)
            .Mappings(
              m => m.FluentMappings.AddFromAssemblyOf<SportMap>())
            .Cache(c => c.UseSecondLevelCache().UseQueryCache()
              .ProviderClass(typeof(NHibernate.Caches.RtMemoryCache.RtMemoryCacheProvider)
                .AssemblyQualifiedName)
            )
            .CurrentSessionContext("web")
            .BuildSessionFactory();

        services.AddSingleton<ISessionFactory>(sessionFactory);


        services.AddScoped<ISession>((ctx) =>
        {
          var sf = ctx.GetRequiredService<ISessionFactory>();
          return sf.OpenSession();

        });

        services.AddScoped<IUnitOfWork, NhUnitOfWork>();
      }
      catch (Exception ex)
      {
          throw new NHibernateInitializationException(ex.Message, ex.InnerException?.Message);
      }
    }
  }
}
