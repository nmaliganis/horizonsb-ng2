using System;
using System.Threading.Tasks;
using Quartz;
using RestSharp;
using Serilog;

namespace horizonsb.api.Schedulers
{
    public class KeepAliveWsInitializerJob : IJob
    {
        public Task Execute(IJobExecutionContext context)
        {
            WsServer.GetWsServer.RaiseKeepAliveRequestDetection();
            return Task.CompletedTask;
        }
    }
}
