using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using horizonsb.api.Models.ForEvents;
using horizonsb.api.Models.ForSports;
using horizonsb.api.Redis.Events;
using horizonsb.be.contracts.Categories;
using horizonsb.be.contracts.Events;
using horizonsb.be.contracts.Markets;
using horizonsb.be.contracts.MarketTypes;
using horizonsb.be.contracts.Odds;
using horizonsb.be.contracts.Sports;
using horizonsb.be.contracts.Tournaments;
using horizonsb.be.contracts.V1;
using horizonsb.common.infrastructure.Helpers;
using horizonsb.commons.vm.Dtos.Categories;
using horizonsb.commons.vm.Dtos.Events;
using horizonsb.commons.vm.Dtos.Markets;
using horizonsb.commons.vm.Dtos.Odds;
using horizonsb.commons.vm.Dtos.Sports;
using horizonsb.commons.vm.Dtos.Teams;
using horizonsb.commons.vm.Dtos.Tournaments;
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
  public class WsController : ControllerBase
  {
    private readonly IConfiguration _configuration;
    private readonly ICreateSportProcessor _createSportProcessor;
    private readonly IInquiryAllSportsProcessor _inquiryAllSportsProcessor;

    private readonly IEventRedisRepository _eventRedisRepository;
    private readonly ICreateEventProcessor _createEventProcessor;
    private readonly ICreateMarketProcessor _createMarketProcessor;
    private readonly ICreateOddProcessor _createOddProcessor;
    private readonly ICreateCategoryProcessor _createCategoryProcessor;
    private readonly ICreateTournamentProcessor _createTournamentProcessor;
    private readonly IInquiryAllMarketTypesProcessor _marketTypesProcessor;


    public WsController(IOddsControllerDependencyBlock oddBlock, 
      IMarketsControllerDependencyBlock marketBlock,
      IMarketTypesControllerDependencyBlock marketTypeBlock,
      IEventsControllerDependencyBlock eventBlock, 
      ISportsControllerDependencyBlock sportBlock,
      ICategoriesControllerDependencyBlock categoryBlock, 
      ITournamentsControllerDependencyBlock tournamentBlock,
      IConfiguration configuration, IEventRedisRepository eventRedisRepository)
    {
      _configuration = configuration;
      _eventRedisRepository = eventRedisRepository;
      _createSportProcessor = sportBlock.CreateSportProcessor;
      _inquiryAllSportsProcessor = sportBlock.InquiryAllSportsProcessor;

      _createMarketProcessor = marketBlock.CreateMarketProcessor;
      _marketTypesProcessor = marketTypeBlock.InquiryAllMarketTypesProcessor;
      _createOddProcessor = oddBlock.CreateOddProcessor;
      _createEventProcessor = eventBlock.CreateEventProcessor;
      _createCategoryProcessor = categoryBlock.CreateCategoryProcessor;
      _createTournamentProcessor = tournamentBlock.CreateTournamentProcessor;
    }

    /// <summary>
    /// Get - Keep Alive Live WebSocket
    /// </summary>
    /// <remarks>Get - Keep Alive Live WebSocket</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("ws-keeplalive", Name = "GetKeeAliveRequest")]
    public async Task<IActionResult> GetKeeAliveRequestAsync()
    {
      WsServer.GetWsServer.RaiseKeepAliveRequestDetection();
      return Ok();
    }

    [HttpGet("market-types", Name = "GetMarketTypesRoot")]
    public async Task<IActionResult> GetMarketTypesAsync()
    {
      var marketTypesFromRepo = await _marketTypesProcessor.GetAllMarketTypesAsync();

      Dictionary<string, List<string>> marketTypes = new Dictionary<string, List<string>>();

      foreach (var marketType in marketTypesFromRepo)
      {
        marketTypes.Add(marketType.SportId, JsonConvert.DeserializeObject<List<string>>(marketType.Type.Jsonb));
      }

      return Ok(marketTypes);
    }

    /// <summary>
    /// Get - Sports - Categories - Tournaments
    /// </summary>
    /// <remarks>Retrieve Sports - Categories - Tournaments</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("sports", Name = "GetRetrieveSportRoute")]
    public async Task<IActionResult> GetRetrieveSportAsync()
    {
      var marketTypesFromRepo = await _marketTypesProcessor.GetAllMarketTypesAsync();

      Dictionary<string, List<string>> marketTypes = new Dictionary<string, List<string>>();

      foreach (var marketType in marketTypesFromRepo)
      {
        marketTypes.Add(marketType.SportId, JsonConvert.DeserializeObject<List<string>>(marketType.Type.Jsonb));
      }

      var client = new RestClient($"{_configuration["RemoteUrl"]}/en/webservice/available/sports");

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
          List<SportApi> result = new List<SportApi>();
          try
          {
            result = JsonConvert.DeserializeObject<List<SportApi>>(response.Content, utcDateFormatSettings);
          }
          catch (Exception e)
          {
            return BadRequest($"1:{e.Message}");
          }

          if (result != null)
          {
            foreach (var sportApi in result)
            {
              if(!marketTypes.ContainsKey(sportApi.Id))
                continue;

              await _createSportProcessor.CreateSportAsync(new SportForCreationUiModel()
              {
                Name = sportApi.Name,
                SportId = sportApi.Id,
                Highlight = sportApi.Highlight,
                NumEvents = sportApi.NumEvents,
                NumInPlayEvents = sportApi.NumInplayEvents,
              });

              foreach (var categoryApi in sportApi.SubCategories)
              {
                dynamic categoryApiNames = categoryApi.Names;
                if (DynamicExpando.IsPropertyExist(categoryApiNames, "longName") &&
                    DynamicExpando.IsPropertyExist(categoryApiNames, "shortName"))
                {
                  await _createCategoryProcessor.CreateCategoryAsync(new CategoryForCreationUiModel()
                  {
                    CategoryId = categoryApi.Id,
                    Name = categoryApi.Name,
                    LongName = categoryApiNames.longName,
                    ShortName = categoryApiNames.shortName,
                    VeryShortName = categoryApiNames.veryshortName,
                    NumEvents = categoryApi.NumEvents,
                    NumInPlayEvents = categoryApi.NumInplayEvents,
                    Weighting = categoryApi.Weighting,
                    ParentSportId = sportApi.Id,
                  });
                }

                foreach (var tournamentApi in categoryApi.SubCategories)
                {
                  dynamic tournamentApiNames = tournamentApi.Names;
                  if (DynamicExpando.IsPropertyExist(tournamentApiNames, "longName") &&
                      DynamicExpando.IsPropertyExist(tournamentApiNames, "shortName"))
                  {
                    await _createTournamentProcessor.CreateTournamentAsync(
                      new TournamentForCreationUiModel()
                      {
                        Name = tournamentApi.Name,
                        TournamentId = tournamentApi.Id,
                        LongName = tournamentApiNames.longName,
                        ShortName = tournamentApiNames.shortName,
                        VeryShortName = tournamentApiNames.veryshortName,
                        NumEvents = tournamentApi.NumEvents,
                        NumOutrightEvents = tournamentApi.NumOutrightEvents,
                        Order = tournamentApi.Order,
                        ParentCategoryId = categoryApi.Id,
                      });
                  }
                }
              }
            }
          }
        }
        else
        {
          return BadRequest($"2:{response.StatusCode}");
        }
      }
      catch (Exception e)
      {
        return BadRequest($"3:{e.Message}");
      }

      return Ok();
    }


    /// <summary>
    /// Get - Retrieve All Sports Events
    /// </summary>
    /// <remarks>Retrieve All Sports Events</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="400">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("all", Name = "GetRetrieveAllEventRoute")]
    public async Task<IActionResult> GetRetrieveAllEventAsync()
    {
      var sportsFromRetrieval = await _inquiryAllSportsProcessor.GetSportsAllAsync();

      if (sportsFromRetrieval == null)
        return BadRequest($"4: Null Sports Retrieved");

      var marketTypesFromRepo = await _marketTypesProcessor.GetAllMarketTypesAsync();

      Dictionary<string, List<string>> marketTypes = new Dictionary<string, List<string>>();

      foreach (var marketType in marketTypesFromRepo)
      {
        marketTypes.Add(marketType.SportId, JsonConvert.DeserializeObject<List<string>>(marketType.Type.Jsonb));
      }

      foreach (var sport in sportsFromRetrieval)
      {
        string url;

        if (marketTypes.ContainsKey(sport.SportId))
        {
          List<string> value = marketTypes[sport.SportId];
          url = $"{_configuration["RemoteUrl"]}/en/webservice/events/{sport.SportId}?normal=1&marketLimit=0";
          foreach (var v in value)
          {
            url += $"&marketTypes[]={v}";
          }
        }
        else
        {
          //url = $"{_configuration["RemoteUrl"]}/en/webservice/events/{sport.SportId}?normal=1&marketLimit=0";
          continue;
        }

        var client = new RestClient(url);
        var request = new RestRequest("", Method.GET);
        request.AddHeader("Accept", "*/*");
        request.AddHeader("Content-Type", "application/json");
        request.AddHeader("Service-Token", "94c54e775eb11e98b383372a71702613");
        request.AddHeader("Cache-Control", "no-cache");

        var utcDateFormatSettings = new JsonSerializerSettings
        {
          DateFormatHandling = DateFormatHandling.MicrosoftDateFormat,
          DateTimeZoneHandling = DateTimeZoneHandling.Utc
        };

        try
        {
          var response = client.Execute<Event>(request);

          if (response.StatusCode == HttpStatusCode.OK)
          {
            List<Event> result = new List<Event>(); 
            try
            { 
              result = JsonConvert.DeserializeObject<List<Event>>(response.Content, utcDateFormatSettings);
            }
            catch (Exception e)
            {
              var resultError = JsonConvert.DeserializeObject<EventError>(response.Content, utcDateFormatSettings);
              if (resultError.error)
              {
                //Todo: Log to Redis for this
                Log.Error($"error: {resultError.message}");
              }
            }

            if (result != null)
            {
              foreach (var @event in result)
              {
                var eventStoredFromRedis = await _eventRedisRepository.GetEventAsync(@event.MatchId);
                int priorityFromRedis = 1;
                if (eventStoredFromRedis != null)
                  priorityFromRedis = eventStoredFromRedis.Priority;

                var responseCreateEvent = await _createEventProcessor.CreateEventAsync(
                  new EventForCreationUiModel()
                  {
                    Name = @event.Name,
                    EventId = @event.MatchId,
                    Id = @event.Id,
                    Live = @event.live,
                    UpcomingLive = @event.upcomingLive,
                    AmericanGround = @event.AmericanGround,
                    //Todo: Exclude UpcomingLive for BL
                    ParentTournamentId = @event.Tournament?.id,
                    Antepost = @event.AntePost,
                    AntepostEventUrl = @event.AntePostEventUrl,
                    AvailableMarkets = @event.AvailableMarkets.ToString(),
                    BetBuilder = @event.BetBuilder,
                    Code = @event.Code,
                    CurrentPeriod = @event.CurrentPeriod,
                    CurrentPeriodName = @event.CurrentPeriodName,
                    Neutral = @event.Neutral,
                    PopularEventUrl = @event.PopularEventUrl,
                    Possession = @event.Possession,
                    Path = @event.Path,
                    Time = @event.Time,
                    TodayEventUrl = @event.TodayEventUrl,
                    Version = @event.Version,
                    Status = @event.Status,
                    Date = @event.Date,
                    Timestamp = @event.Timestamp,
                    Resulted = @event.Resulted,
                    Teams = new List<TeamForCreationUiModel>()
                    {
                      new TeamForCreationUiModel()
                      {
                        Name = @event.HomeTeam.name,
                        IsHome = true,
                      },
                      new TeamForCreationUiModel()
                      {
                        Name = @event.AwayTeam.name,
                        IsHome = false,
                      }
                    },
                  }, priorityFromRedis);

                if (responseCreateEvent.Status)
                {
                  if (@event.Markets?.Count <= 3)
                    await StoreEventsSmallCount(@event);
                  else
                    await StoreEvents(@event);
                }
              }
            }
          }
          else
          {
            return BadRequest($"5:{response.StatusCode}");
          }
        }
        catch (Exception e)
        {
          return BadRequest($"6:{e.Message}");
        }
      }
      return Ok();
    }

    #region Local Private Members

    private async Task StoreEventsSmallCount(Event @event)
    {
      foreach (var eventMarket in @event.Markets)
      {
        var responseCreateMarket = await _createMarketProcessor.CreateMarketAsync(new MarketForCreationUiModel()
        {
          Name = eventMarket.Name,
          MarketId = eventMarket.Id,
          MarketFixedId = eventMarket.FixedId,
          Type = eventMarket.Type,
          Status = eventMarket.Status,
          Balanced = eventMarket.Balanced,
          Antepost = eventMarket.Antepost,
          LegacyMarket = eventMarket.LegacyMarketId,
          MarketGroupId = eventMarket.MarketGroupId,
          SubGroupId = eventMarket.SubGroupId,
          ParentEventId = @event.MatchId,
          Displayed = eventMarket.Displayed,
          IsChanged = eventMarket.IsChanged,
          WinningLegsBonus = eventMarket.WinningLegsBonus,
          Description = eventMarket.Description,
          Lines = eventMarket.Lines
        });

        if (responseCreateMarket.Status)
        {
          foreach (var odd in eventMarket.Odds)
          {
            await _createOddProcessor.CreateOddAsync(new OddForCreationUiModel()
            {
              Name = odd.Name,
              OddId = odd.Id,
              Type = (string) odd.Type,
              ParentMarketId = eventMarket.Id,
              ParentEventId = @event.MatchId,
              Short = odd.Short,
              Clean = odd.Clean,
              Status = odd.Status,
              Handicap = odd.Handicap,
              Displayed = odd.Displayed,
              Code = odd.Code,
              Row = odd.Row,
              Col = odd.Col,
              OddNum = odd.odd
            });
          }
        }
      }
    }

    private async Task StoreEvents(Event @event)
    {
      foreach (var eventMarket in @event.Markets)
      {
        if (eventMarket.Balanced || eventMarket.Type.Contains("ML") || eventMarket.Type.Contains("AXB") ||
            eventMarket.Type.Contains("WAY"))
        {
          var responseCreateMarket = await _createMarketProcessor.CreateMarketAsync(
            new MarketForCreationUiModel()
            {
              Name = eventMarket.Name,
              MarketId = eventMarket.Id,
              LegacyMarket = eventMarket.LegacyMarketId,
              MarketFixedId = eventMarket.FixedId,
              Type = eventMarket.Type,
              Status = eventMarket.Status,
              Balanced = eventMarket.Balanced,
              Antepost = eventMarket.Antepost,
              MarketGroupId = eventMarket.MarketGroupId,
              SubGroupId = eventMarket.SubGroupId,
              ParentEventId = @event.MatchId,
              Displayed = eventMarket.Displayed,
              IsChanged = eventMarket.IsChanged,
              WinningLegsBonus = eventMarket.WinningLegsBonus,
              Description = eventMarket.Description,
              Lines = eventMarket.Lines
            });

          if (responseCreateMarket.Status)
          {
            foreach (var odd in eventMarket.Odds)
            {
              await _createOddProcessor.CreateOddAsync(new OddForCreationUiModel()
              {
                Name = odd.Name,
                OddId = odd.Id,
                Type = (string) odd.Type,
                ParentMarketId = eventMarket.Id,
                ParentEventId = @event.MatchId,
                Short = odd.Short,
                Clean = odd.Clean,
                Status = odd.Status,
                Handicap = odd.Handicap,
                Displayed = odd.Displayed,
                Code = odd.Code,
                Row = odd.Row,
                Col = odd.Col,
                OddNum = odd.odd
              });
            }
          }
        }
      }
    }

    #endregion
  }
}
