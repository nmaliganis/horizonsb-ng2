using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using horizonsb.api.Models.ForSports;
using horizonsb.api.Models.Live.Apis;
using horizonsb.api.Redis.Events;
using horizonsb.api.Redis.Events.Live;
using horizonsb.api.Redis.Logs;
using horizonsb.be.contracts.Events;
using horizonsb.be.contracts.V1;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Quartz;
using RestSharp;
using Serilog;

namespace horizonsb.api.Schedulers
{
  public class LiveBetInitializerJob : IJob
  {
    private readonly ILiveRedisRepository _redisRepository;
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly IConfiguration _configuration;

    private IInquiryEventProcessor _inquiryEventProcessor;
    private IUpdateEventProcessor _updateEventProcessor;

    public LiveBetInitializerJob(ILiveRedisRepository redisRepository, ILogRedisRepository redisLogRepository,
      IServiceScopeFactory scopeFactory,
      IConfiguration configuration, IEventRedisRepository eventRedisRepository)
    {
      _redisRepository = redisRepository;
      _scopeFactory = scopeFactory;
      _configuration = configuration;
    }

    public async Task Execute(IJobExecutionContext context)
    {
      //http://dsqa.montana.com/en/webservice/available/lives
      var client = new RestClient($"{_configuration["RemoteUrl"]}/en/webservice/available/lives");

      var request = new RestRequest("", Method.GET);
      request.AddHeader("Accept", "*/*");
      request.AddHeader("Content-Type", "application/json");
      request.AddHeader("Service-Token", "94c54e775eb11e98b383372a71702613");
      request.AddHeader("Cache-Control", "no-cache");

      try
      {
        var response = client.Execute<SportApi>(request);
        var utcDateFormatSettings = new JsonSerializerSettings
        {
          DateFormatHandling = DateFormatHandling.MicrosoftDateFormat,
          DateTimeZoneHandling = DateTimeZoneHandling.Utc
        };
        if (response.StatusCode == HttpStatusCode.OK)
        {
          List<LiveApi> result = new List<LiveApi>();
          try
          {
            result = JsonConvert.DeserializeObject<List<LiveApi>>(response.Content, utcDateFormatSettings);

            using (var scope = _scopeFactory.CreateScope())
            {
              var eventBlock = scope.ServiceProvider.GetRequiredService<IEventsControllerDependencyBlock>();
              _inquiryEventProcessor = eventBlock.InquiryEventProcessor;
              _updateEventProcessor = eventBlock.UpdateEventProcessor;
              var previousLivesAndUpcomingLiveEvents = await _inquiryEventProcessor.GetEventsLiveAndUpcomiongAsync();
              foreach (var previousLivesAndUpcomingLiveEvent in previousLivesAndUpcomingLiveEvents)
              {
                var preGameEventToHaveBeenUpdatedWithLive =
                  await _updateEventProcessor.UpdateEventWithLiveApiAsync(previousLivesAndUpcomingLiveEvent.Event_Id,
                    false, false);
              }
              if (result.Count <= 0)
              {
                Log.Information("NONE_LIVE_EVENT_EXIST");
              }

              foreach (var liveApi in result)
              {
                var preGameEventToHaveBeenUpdatedWithLive =
                  await _updateEventProcessor.UpdateEventWithLiveApiAsync(liveApi.id, liveApi.upcomingLive,
                    liveApi.live);
              }
              IEnumerable<LiveAxbRedisModel> liveAllEuRedisModel = await _redisRepository.GetAllLiveAllEuropeEvents();
              IEnumerable<LiveMoneyLineRedisModel> liveAllUsRedisModel = await _redisRepository.GetAllLiveAllUsaEvents();

              foreach (var item in liveAllEuRedisModel.ToList())
              {
                if (result.FirstOrDefault(x => x.code == item.Code) == null && liveAllUsRedisModel.FirstOrDefault(x => x.Code == item.Code) == null)
                {
                  await _redisRepository.DeleteLiveEventAsync(item.Code);
                }
              }

              liveAllEuRedisModel = await _redisRepository.GetAllLiveAllEuropeEvents();
              liveAllUsRedisModel = await _redisRepository.GetAllLiveAllUsaEvents();

              foreach (var item in liveAllUsRedisModel.ToList())
              {
                if (result.FirstOrDefault(x => x.code == item.Code) == null && liveAllEuRedisModel.FirstOrDefault(x => x.Code == item.Code) == null)
                {
                  await _redisRepository.DeleteLiveEventAsync(item.Code);
                }
              }
            }
          }
          catch (Exception e)
          {
            Log.Error("BadRequest");
          }
        }
        else
        {
          Log.Error("BadRequest");
        }
      }
      catch (Exception e)
      {
        Log.Error("BadRequest");
      }
    }
  }
}
