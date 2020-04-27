using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.api.Redis.Events.Live;
using horizonsb.api.Redis.Logs;
using horizonsb.be.contracts.Events;
using horizonsb.be.contracts.Markets;
using horizonsb.be.contracts.V1;
using horizonsb.commons.vm.Dtos.Events;
using Microsoft.Extensions.DependencyInjection;
using Quartz;

namespace horizonsb.api.Schedulers
{
  public class RegisterUpcomingWsInitializerJob : IJob
  {
    private readonly ILiveRedisRepository _redisRepository;
    private readonly ILogRedisRepository _redisLogRepository;
    private readonly IServiceScopeFactory _scopeFactory;
    private IInquiryEventProcessor _inquiryEventProcessor;
    private IInquiryAllMarketsProcessor _inquiryAllMarketsProcessor;

    public RegisterUpcomingWsInitializerJob(ILiveRedisRepository redisRepository,
      ILogRedisRepository redisLogRepository, IServiceScopeFactory scopeFactory)
    {
      _redisLogRepository = redisLogRepository;
      _redisRepository = redisRepository;
      _scopeFactory = scopeFactory;
    }

    public async Task Execute(IJobExecutionContext context)
    {
      var logRedisToHaveBeenCreated = await _redisLogRepository.UpdateLogAsync(new LogRedis()
      {
        LastModified = DateTime.Now.ToString(),
        LastModifiedUpcomingLive = DateTime.Now.ToString()
      });

      using (var scope = _scopeFactory.CreateScope())
      {
        var eventBlock = scope.ServiceProvider.GetRequiredService<IEventsControllerDependencyBlock>();
        _inquiryEventProcessor = eventBlock.InquiryEventProcessor;
        IList<EventUpcomingLiveUiModel> upComingLiveEvents = _inquiryEventProcessor.GetEventsByUpcomingLive();

        foreach (var upComingLiveEvent in upComingLiveEvents)
        {
          WsServer.GetWsServer.RaiseRegisterEventRequestDetection(upComingLiveEvent.EventId);
          WsServer.GetWsServer.RaiseRegisterEventStartedRequestDetection(upComingLiveEvent.EventId);
          WsServer.GetWsServer.RaiseRegisterEventEndedRequestDetection(upComingLiveEvent.EventId);
          //Added below
          WsServer.GetWsServer.RaiseRegisterEventWithAllMarketsRequestDetection(upComingLiveEvent.EventId);

          var marketBlock = scope.ServiceProvider.GetRequiredService<IMarketsControllerDependencyBlock>();
          _inquiryAllMarketsProcessor = marketBlock.InquiryAllMarketsProcessor;
          var markets = await _inquiryAllMarketsProcessor.GetAllMarketsAsync(upComingLiveEvent.EventId);
          foreach (var market in markets)
          {
            WsServer.GetWsServer.RaiseRegisterMarketRequestDetection(upComingLiveEvent.EventId,
              market.MarketId);
          }
        }
      }
    }
  }
}