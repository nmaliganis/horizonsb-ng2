using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Quartz;
using RestSharp;
using Serilog;

namespace horizonsb.api.Schedulers
{
    public class PostgresInitializerJob : IJob
    {
        private readonly IConfiguration _configuration;


        public PostgresInitializerJob(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public Task Execute(IJobExecutionContext context)
        {
            Log.Information(
                $"PostgresInitializerJob: --Execute--  @Ready@ [PostgresInitializerJob]. Message: Scheduler is executed at {DateTime.Now}");

            var client = new RestClient($"{_configuration["LocalUrl"]}/api/events");
            var request = new RestRequest("", Method.DELETE);
            request.AddHeader("Content-Type", "application/json");
            request.AddHeader("Cache-Control", "no-cache");

            IRestResponse responseSports = client.Execute(request);

            if (responseSports.IsSuccessful)
            {
                Log.Information(
                    $"PostgresInitializerJob: --Execute--  @Complete@ [PostgresInitializerJob]. Message: All Events are Deleted {DateTime.Now}");
            }

            return Task.CompletedTask;
        }
    }
}
