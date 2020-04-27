using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using horizonsb.api.Helpers.Json;
using horizonsb.api.Models.ForSports;
using horizonsb.api.Models.Live.Apis;
using horizonsb.api.Redis.Events.Live;
using horizonsb.be.contracts.Events;
using horizonsb.be.contracts.Markets;
using horizonsb.be.contracts.V1;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using horizonsb.commons.vm.Dtos.Events;
using horizonsb.commons.vm.Dtos.Teams;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using RestSharp;
using Serilog;

namespace horizonsb.api.Controllers.API
{
  [Produces("application/json")]
  [ResponseCache(Duration = 0, NoStore = true, VaryByHeader = "*")]
  [Route("api/[controller]")]
  [ApiController]
  public class LivesController : ControllerBase
  {
    private readonly IConfiguration _configuration;

    private readonly IJsonSerializer _jsonSerializer;
    private readonly IUrlHelper _urlHelper;
    private readonly ITypeHelperService _typeHelperService;
    private readonly IPropertyMappingService _propertyMappingService;

    private readonly IInquiryEventProcessor _inquiryEventProcessor;
    private readonly IUpdateEventProcessor _updateEventProcessor;
    private readonly ICreateEventProcessor _createEventProcessor;
    private readonly IInquiryAllMarketsProcessor _inquiryAllMarketsProcessor;
    private readonly ILiveRedisRepository _redisRepository;


    public LivesController(IUrlHelper urlHelper,
      ITypeHelperService typeHelperService,
      IJsonSerializer jsonSerializer,
      IPropertyMappingService propertyMappingService,
      IEventsControllerDependencyBlock blockEvent, 
      IMarketsControllerDependencyBlock blockMarket,
      IConfiguration configuration,
      ILiveRedisRepository redisRepository)
    {
      _jsonSerializer = jsonSerializer;
      _configuration = configuration;
      _urlHelper = urlHelper;
      _typeHelperService = typeHelperService;
      _propertyMappingService = propertyMappingService;

      _inquiryEventProcessor = blockEvent.InquiryEventProcessor;
      _updateEventProcessor = blockEvent.UpdateEventProcessor;
      _createEventProcessor = blockEvent.CreateEventProcessor;

      _inquiryAllMarketsProcessor = blockMarket.InquiryAllMarketsProcessor;
      _redisRepository = redisRepository;
    }


    [HttpGet(Name = "GetAllLiveEvent")]
    public async Task<IActionResult> GetAllLiveEventRoot()
    {
      var haveLivePrioritized = await _inquiryEventProcessor.GetEventCountLivePrioritizedAsync();

      IEnumerable<LiveAxbRedisModel> liveEuRedisModel;
      IEnumerable<LiveMoneyLineRedisModel> liveUsRedisModel;

      if (haveLivePrioritized >= 1)
      {
        liveEuRedisModel = await _redisRepository.GetAllLiveEuropeEvents();
        liveUsRedisModel = await _redisRepository.GetAllLiveUsaEvents();
      }
      else
      {
        liveEuRedisModel = await _redisRepository.GetAllLiveAllEuropeEvents();
        liveUsRedisModel = await _redisRepository.GetAllLiveAllUsaEvents();
      }


      List<Object> allLiveEvents = new List<object>();

      foreach (var liveAxbRedisModel in liveEuRedisModel)
      {
        allLiveEvents.Add(liveAxbRedisModel);
      }

      foreach (var liveMoneyLineRedisModel in liveUsRedisModel)
      {
        allLiveEvents.Add(liveMoneyLineRedisModel);
      }

      return Ok(allLiveEvents);
    }


    /// <summary>
    /// Put - Update - Register Live Events
    /// </summary>
    /// <remarks> Update - Register Live Events</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="400">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpPut("register-live", Name = "PutRegisterLiveEventRoute")]
    public async Task<IActionResult> PutRegisterLiveEventAsync()
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

            var previousLivesAndUpcomingLiveEvents = await _inquiryEventProcessor.GetEventsLiveAndUpcomiongAsync();

            foreach (var previousLivesAndUpcomingLiveEvent in previousLivesAndUpcomingLiveEvents)
            {
              var preGameEventToHaveBeenUpdatedWithLive = await _updateEventProcessor
                .UpdateEventWithLiveApiAsync(previousLivesAndUpcomingLiveEvent.Event_Id, false, false);
            }

            if (result.Count <= 0)
            {
              return Ok("NONE_LIVE_EVENT_EXIST");
            }

            foreach (var liveApi in result)
            {
              var preGameEventToHaveBeenUpdatedWithLive =
                await _updateEventProcessor.UpdateEventWithLiveApiAsync(liveApi.id, liveApi.upcomingLive, liveApi.live);

              if (preGameEventToHaveBeenUpdatedWithLive.Message == "EVENT_NOT_EXISTS")
              {
                await _createEventProcessor.CreateEventAsync(new EventForCreationUiModel()
                {
                  Name = liveApi.name,
                  EventId = liveApi.matchId,
                  Id = liveApi.id,
                  Live = liveApi.live,
                  UpcomingLive = liveApi.upcomingLive,
                  AmericanGround = liveApi.americanGround,
                  ParentTournamentId = liveApi.tournament.id,
                  Antepost = liveApi.antepost,
                  AntepostEventUrl = liveApi.antepostEventUrl,
                  AvailableMarkets = liveApi.availableMarkets.ToString(),
                  BetBuilder = liveApi.betBuilder,
                  Code = liveApi.code,
                  CurrentPeriod = liveApi.currentPeriod,
                  CurrentPeriodName = liveApi.currentPeriodName,
                  Neutral = liveApi.neutral,
                  PopularEventUrl = liveApi.popularEventUrl,
                  Possession = liveApi.possession,
                  Path = liveApi.path,
                  Time = liveApi.time,
                  TodayEventUrl = liveApi.todayEventUrl,
                  Version = liveApi.version.ToString(),
                  Status = liveApi.status,
                  Date = liveApi.date,
                  Timestamp = liveApi.timestamp,
                  Resulted = liveApi.resulted,
                  Teams = new List<TeamForCreationUiModel>()
                  {
                    new TeamForCreationUiModel()
                    {
                      Name = liveApi.homeTeam.name,
                      IsHome = true,
                    },
                    new TeamForCreationUiModel()
                    {
                      Name = liveApi.awayTeam.name,
                      IsHome = false,
                    }
                  }
                });
              }

              WsServer.GetWsServer.RaiseRegisterEventRequestDetection(liveApi.id);
              WsServer.GetWsServer.RaiseRegisterEventStartedRequestDetection(liveApi.id);
              WsServer.GetWsServer.RaiseRegisterEventEndedRequestDetection(liveApi.id);
              WsServer.GetWsServer.RaiseRegisterEventWithAllMarketsRequestDetection(liveApi.id);

              var markets = await _inquiryAllMarketsProcessor.GetAllMarketsAsync(liveApi.id);
              foreach (var market in markets)
              {
                WsServer.GetWsServer.RaiseRegisterMarketRequestDetection(liveApi.id,
                  market.MarketId);
              }
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
          catch (Exception e)
          {
            BadRequest(e.Message);
          }
        }
        else
        {
          return BadRequest(response.StatusCode);
        }
      }
      catch (Exception e)
      {
        Log.Error("BadRequest");
        return BadRequest(e.Message);
      }

      return Ok();
    }

    /// <summary>
    /// Get - Retrieve Live Events
    /// </summary>
    /// <remarks>Retrieve All Live Events</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="400">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("ondemand-live", Name = "GetRetrieveOnDemandLiveEventRoute")]
    public async Task<IActionResult> GetRetrieveOnDemandLiveEventAsync()
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
            return Ok(result);
          }
          catch (Exception e)
          {
            BadRequest(e.Message);
          }
        }
        else
        {
          return BadRequest(response.StatusCode);
        }
      }
      catch (Exception e)
      {
        Log.Error("BadRequest");
        return BadRequest(e.Message);
      }

      return Ok();
    }



    /// <summary>
    /// Get - Retrieve Live Events
    /// </summary>
    /// <remarks>Retrieve All Live Events</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="400">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("ondemand-live-lite", Name = "GetRetrieveOnDemandLiveEventLiteRoute")]
    public async Task<IActionResult> GetRetrieveOnDemandLiveEventLiteAsync()
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
          List<LiveApiLite> result = new List<LiveApiLite>();
          try
          {
            result = JsonConvert.DeserializeObject<List<LiveApiLite>>(response.Content, utcDateFormatSettings);
            return Ok(result);
          }
          catch (Exception e)
          {
            BadRequest(e.Message);
          }
        }
        else
        {
          return BadRequest(response.StatusCode);
        }
      }
      catch (Exception e)
      {
        Log.Error("BadRequest");
        return BadRequest(e.Message);
      }

      return Ok();
    }


    /// <summary>
    /// Get - Retrieve Live Events
    /// </summary>
    /// <remarks>Retrieve All Live Events</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="400">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("ondemand-live-lite2", Name = "GetRetrieveOnDemandLiveEventLite2Route")]
    public async Task<IActionResult> GetRetrieveOnDemandLiveEventLite2Αsync()
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
          List<LiveApiLite2> result = new List<LiveApiLite2>();
          try
          {
            result = JsonConvert.DeserializeObject<List<LiveApiLite2>>(response.Content, utcDateFormatSettings);
            return Ok(result);
          }
          catch (Exception e)
          {
            BadRequest(e.Message);
          }
        }
        else
        {
          return BadRequest(response.StatusCode);
        }
      }
      catch (Exception e)
      {
        Log.Error("BadRequest");
        return BadRequest(e.Message);
      }

      return Ok();
    }

    /// <summary>
    /// Get - Retrieve Live Events Count
    /// </summary>
    /// <remarks>Retrieve All Live Events</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="400">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("ondemand-live-count", Name = "GetRetrieveOnDemandLiveEventCountRoute")]
    public async Task<IActionResult> GetRetrieveOnDemandLiveEventCountAsync()
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
            return Ok(result.Count);
          }
          catch (Exception e)
          {
            BadRequest(e.Message);
          }
        }
        else
        {
          return BadRequest(response.StatusCode);
        }
      }
      catch (Exception e)
      {
        Log.Error("BadRequest");
        return BadRequest(e.Message);
      }

      return Ok();
    }

    [HttpGet("{code}", Name = "GetLiveEvent")]
    public async Task<IActionResult> GetLiveEventRoot([Required] string code)
    {
      if (string.IsNullOrEmpty(code))
        BadRequest();

      var liveRedisModel = await _redisRepository.GetLiveEuropeEventAsync(code);

      if (liveRedisModel == null)
        NotFound();

      return Ok(liveRedisModel);
    }


    [HttpPost("usa", Name = "PostUsaLiveEventRoot")]
    public async Task<IActionResult> PostUsaLiveEventAsync([Required] LiveMoneyLineRedisModel liveMoneyLine)
    {
      if (liveMoneyLine == null)
        BadRequest();

      var liveRedisModel = await _redisRepository.UpdateUsaLiveEventAsync(liveMoneyLine, true);

      if (liveRedisModel == null)
        BadRequest();

      return CreatedAtAction(nameof(PostUsaLiveEventAsync), liveRedisModel);
    }


    [HttpPost("europe", Name = "PostEuropeLiveEventRoot")]
    public async Task<IActionResult> PostEuropeLiveEventAsync([Required] LiveAxbRedisModel liveAxbRedis)
    {
      if (liveAxbRedis == null)
        BadRequest();

      var liveRedisModel = await _redisRepository.UpdateEuropeLiveEventAsync(liveAxbRedis, true);

      if (liveRedisModel == null)
        BadRequest();

      return CreatedAtAction(nameof(PostUsaLiveEventAsync), liveRedisModel);
    }


    [HttpPost("register/upcoming", Name = "PostRegisterLiveForUpcomingEvent")]
    public async Task<IActionResult> PostRegisterUpcommingLiveForEventRoot()
    {
      IList<EventUpcomingLiveUiModel> upComingLiveEvents = _inquiryEventProcessor.GetEventsByUpcomingLive();

      foreach (var upComingLiveEvent in upComingLiveEvents)
      {
        WsServer.GetWsServer.RaiseRegisterEventRequestDetection(upComingLiveEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventStartedRequestDetection(upComingLiveEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventEndedRequestDetection(upComingLiveEvent.EventId);
        var markets = await _inquiryAllMarketsProcessor.GetAllMarketsAsync(upComingLiveEvent.EventId);
        foreach (var market in markets)
        {
          WsServer.GetWsServer.RaiseRegisterMarketRequestDetection(upComingLiveEvent.EventId,
            market.MarketId);
        }
      }

      return Ok(upComingLiveEvents.Count);
    }

    [HttpPost("register/upcoming-all-markets", Name = "PostRegisterLiveForUpcomingEventAllMarkets")]
    public async Task<IActionResult> PostRegisterUpcommingLiveForEventAllMarketsRoot()
    {
      IList<EventUpcomingLiveUiModel> upComingLiveEvents = _inquiryEventProcessor.GetEventsByUpcomingLive();

      foreach (var upComingLiveEvent in upComingLiveEvents)
      {
        WsServer.GetWsServer.RaiseRegisterEventRequestDetection(upComingLiveEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventStartedRequestDetection(upComingLiveEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventEndedRequestDetection(upComingLiveEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventWithAllMarketsRequestDetection(upComingLiveEvent.EventId);
      }

      return Ok(upComingLiveEvents.Count);
    }

    [HttpPost("register/all-events", Name = "PostRegisterLiveForAllEventRoot")]
    public async Task<IActionResult> PostRegisterLiveForAllEventAsync()
    {
      IList<EventUiModel> registeredEvents = await _inquiryEventProcessor.GetAllForRegisterEvents();

      foreach (var registerEvent in registeredEvents)
      {
        WsServer.GetWsServer.RaiseRegisterEventRequestDetection(registerEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventStartedRequestDetection(registerEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventEndedRequestDetection(registerEvent.EventId);
        var markets = await _inquiryAllMarketsProcessor.GetAllMarketsAsync(registerEvent.EventId);
        foreach (var market in registerEvent.Markets)
        {
          WsServer.GetWsServer.RaiseRegisterMarketRequestDetection(registerEvent.EventId,
            market.MarketId);
        }
      }

      return Ok(registeredEvents.Count);
    }

    [HttpPost("register/all-events-all-markets", Name = "PostRegisterLiveForAllEventAllMarketsRoot")]
    public async Task<IActionResult> PostRegisterLiveForAllEventAllMarketsAsync()
    {
      IList<EventUiModel> registeredEvents = await _inquiryEventProcessor.GetAllForRegisterEvents();

      foreach (var registerEvent in registeredEvents)
      {
        WsServer.GetWsServer.RaiseRegisterEventRequestDetection(registerEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventStartedRequestDetection(registerEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventEndedRequestDetection(registerEvent.EventId);
        WsServer.GetWsServer.RaiseRegisterEventWithAllMarketsRequestDetection(registerEvent.EventId);
      }

      return Ok(registeredEvents.Count);
    }

    [HttpPost("register/{eventId}", Name = "PostRegisterLiveForEvent")]
    public async Task<IActionResult> PostRegisterLiveForEventRoot(string eventId)
    {
      WsServer.GetWsServer.RaiseRegisterEventRequestDetection(eventId);
      WsServer.GetWsServer.RaiseRegisterEventStartedRequestDetection(eventId);
      WsServer.GetWsServer.RaiseRegisterEventEndedRequestDetection(eventId);

      var markets = await _inquiryAllMarketsProcessor.GetAllMarketsAsync(eventId);

      foreach (var market in markets)
      {
        WsServer.GetWsServer.RaiseRegisterMarketRequestDetection(eventId, market.MarketId);
      }

      return Ok(eventId);
    }

    [HttpPost("register/{eventId}/all-markets", Name = "PostRegisterLiveForEventAllMarkets")]
    public async Task<IActionResult> PostRegisterLiveForEventAllMarketsRoot(string eventId)
    {
      WsServer.GetWsServer.RaiseRegisterEventRequestDetection(eventId);
      WsServer.GetWsServer.RaiseRegisterEventStartedRequestDetection(eventId);
      WsServer.GetWsServer.RaiseRegisterEventEndedRequestDetection(eventId);
      WsServer.GetWsServer.RaiseRegisterEventWithAllMarketsRequestDetection(eventId);

      return Ok(eventId);
    }

    [HttpDelete("clear_cache/{date}", Name = "DeleteEventsFromRedisAsync")]
    public async Task<IActionResult> DeleteEventsFromRedisRoot(bool date)
    {
      int numberOfDeletions = 0;

      var liveEventsToBeDeleted = await _redisRepository.GetAllLiveCodesToBeDeletedByDateEvents(date);
      foreach (var liveEventCode in liveEventsToBeDeleted)
      {
        var resultCollection = await _redisRepository.DeleteLiveEventAsync(liveEventCode);
        if (resultCollection)
          numberOfDeletions++;

      }

      return Ok(numberOfDeletions);
    }
  }
}
