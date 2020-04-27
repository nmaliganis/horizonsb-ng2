using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using horizonsb.api.Models.ForEvents;
using horizonsb.api.Models.ForSports;
using horizonsb.api.Redis.Events;
using horizonsb.api.Redis.Events.Live;
using horizonsb.api.Redis.Logs;
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
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Quartz;
using RestSharp;
using Serilog;

namespace horizonsb.api.Schedulers
{
  public class BetDataInitializerJob : IJob
  {
    private readonly ILiveRedisRepository _redisRepository;
    private readonly ILogRedisRepository _redisLogRepository;

    private ICreateOddProcessor _createOddProcessor;
    private ICreateMarketProcessor _createMarketProcessor;
    private ICreateEventProcessor _createEventProcessor;
    private ICreateCategoryProcessor _createCategoryProcessor;
    private ICreateSportProcessor _createSportProcessor;

    private IInquiryAllMarketTypesProcessor _marketTypesProcessor;

    private readonly IEventRedisRepository _eventRedisRepository;

    private IInquiryAllSportsProcessor _inquiryAllSportsProcessor;
    private ICreateTournamentProcessor _createTournamentProcessor;
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly IConfiguration _configuration;

    public BetDataInitializerJob(ILiveRedisRepository redisRepository, ILogRedisRepository redisLogRepository,
      IServiceScopeFactory scopeFactory,
      IConfiguration configuration, IEventRedisRepository eventRedisRepository)
    {
      _redisLogRepository = redisLogRepository;
      _redisRepository = redisRepository;
      _scopeFactory = scopeFactory;
      _configuration = configuration;
      _eventRedisRepository = eventRedisRepository;
    }

    public async Task Execute(IJobExecutionContext context)
    {
      Dictionary<string, List<string>> marketTypes = new Dictionary<string, List<string>>();

      using (var scope = _scopeFactory.CreateScope())
      {
        var marketTypeBlock = scope.ServiceProvider.GetRequiredService<IMarketTypesControllerDependencyBlock>();
        _marketTypesProcessor = marketTypeBlock.InquiryAllMarketTypesProcessor;

        var marketTypesFromRepo = await _marketTypesProcessor.GetAllMarketTypesAsync();
        
        foreach (var marketType in marketTypesFromRepo)
        {
          marketTypes.Add(marketType.SportId, JsonConvert.DeserializeObject<List<string>>(marketType.Type.Jsonb));
        }
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
        if (response.StatusCode == HttpStatusCode.OK)
        {
          var utcDateFormatSettings = new JsonSerializerSettings
          {
            DateFormatHandling = DateFormatHandling.MicrosoftDateFormat,
            DateTimeZoneHandling = DateTimeZoneHandling.Utc
          };
          List<SportApi> result = Newtonsoft.Json.JsonConvert.DeserializeObject<List<SportApi>>(response.Content, utcDateFormatSettings);

          if (result != null)
          {
            foreach (var sportApi in result)
            {
              if (!marketTypes.ContainsKey(sportApi.Id))
                continue;

              using (var scope = _scopeFactory.CreateScope())
              {
                var sportBlock = scope.ServiceProvider.GetRequiredService<ISportsControllerDependencyBlock>();
                _createSportProcessor = sportBlock.CreateSportProcessor;
                await _createSportProcessor.CreateSportAsync(new SportForCreationUiModel()
                {
                  Name = sportApi.Name,
                  SportId = sportApi.Id,
                  Highlight = sportApi.Highlight,
                  NumEvents = sportApi.NumEvents,
                  NumInPlayEvents = sportApi.NumInplayEvents,
                });
              }

              foreach (var categoryApi in sportApi.SubCategories)
              {
                dynamic categoryApiNames = categoryApi.Names;

                using (var scope = _scopeFactory.CreateScope())
                {
                  var categoryBlock = scope.ServiceProvider
                    .GetRequiredService<ICategoriesControllerDependencyBlock>();
                  _createCategoryProcessor = categoryBlock.CreateCategoryProcessor;
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
                }


                foreach (var tournamentApi in categoryApi.SubCategories)
                {
                  dynamic tournamentApiNames = tournamentApi.Names;

                  using (var scope = _scopeFactory.CreateScope())
                  {
                    var tournamentBlock = scope.ServiceProvider
                      .GetRequiredService<ITournamentsControllerDependencyBlock>();
                    _createTournamentProcessor = tournamentBlock.CreateTournamentProcessor;
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
        }
        else
        {
          Log.Error(
            $"BetDataInitializerJob: --Execute--  @Ready@ [BetDataInitializerJob]. response.StatusCode:  {response.StatusCode} Message: Scheduler is executed at {DateTime.Now}");
        }
      }
      catch (Exception e)
      {
        Log.Error(
          $"BetDataInitializerJob: --Execute--  @Ready@ [BetDataInitializerJob]. Message: Scheduler is executed at {DateTime.Now}");
      }

      using (var scope = _scopeFactory.CreateScope())
      {
        var sportBlock = scope.ServiceProvider.GetRequiredService<ISportsControllerDependencyBlock>();
        _inquiryAllSportsProcessor = sportBlock.InquiryAllSportsProcessor;
        var sportsFromRetrieval = await _inquiryAllSportsProcessor.GetSportsAllAsync();

        if (sportsFromRetrieval == null)
          return;

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

          client = new RestClient(url);

          try
          {
            var response = client.Execute<Event>(request);
            var utcDateFormatSettings = new JsonSerializerSettings
            {
              DateFormatHandling = DateFormatHandling.MicrosoftDateFormat,
              DateTimeZoneHandling = DateTimeZoneHandling.Utc
            };

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
                  //Todo: Log to Redis for this9
                  //tLog.Error($"error: {resultError.message}");
                }
              }

              if (result != null)
              {
                foreach (var @event in result)
                {
                  var eventBlock = scope.ServiceProvider.GetRequiredService<IEventsControllerDependencyBlock>();
                  _createEventProcessor = eventBlock.CreateEventProcessor;

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
                    {
                      foreach (var eventMarket in @event.Markets)
                      {
                        var marketBlock = scope.ServiceProvider.GetRequiredService<IMarketsControllerDependencyBlock>();
                        _createMarketProcessor = marketBlock.CreateMarketProcessor;
                        var responseCreateMarket = await _createMarketProcessor.CreateMarketAsync(
                          new MarketForCreationUiModel()
                          {
                            Name = eventMarket.Name,
                            MarketId = eventMarket.Id,
                            MarketFixedId = eventMarket.FixedId,
                            Type = eventMarket.Type,
                            Status = eventMarket.Status,
                            Balanced = eventMarket.Balanced,
                            Antepost = eventMarket.Antepost,
                            MarketGroupId = eventMarket.MarketGroupId,
                            LegacyMarket = eventMarket.LegacyMarketId,
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
                            var oddBlock = scope.ServiceProvider.GetRequiredService<IOddsControllerDependencyBlock>();
                            _createOddProcessor = oddBlock.CreateOddProcessor;
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
                    else
                    {
                      foreach (var eventMarket in @event.Markets)
                      {
                        if (eventMarket.Balanced || eventMarket.Type.Contains("ML") ||
                            eventMarket.Type.Contains("AXB") ||
                            eventMarket.Type.Contains("WAY"))
                        {
                          var marketBlock =
                            scope.ServiceProvider.GetRequiredService<IMarketsControllerDependencyBlock>();
                          _createMarketProcessor = marketBlock.CreateMarketProcessor;
                          var responseCreateMarket = await _createMarketProcessor.CreateMarketAsync(
                            new MarketForCreationUiModel()
                            {
                              Name = eventMarket.Name,
                              MarketId = eventMarket.Id,
                              MarketFixedId = eventMarket.FixedId,
                              Type = eventMarket.Type,
                              Status = eventMarket.Status,
                              Balanced = eventMarket.Balanced,
                              Antepost = eventMarket.Antepost,
                              MarketGroupId = eventMarket.MarketGroupId,
                              LegacyMarket = eventMarket.LegacyMarketId,
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
                              var oddBlock = scope.ServiceProvider.GetRequiredService<IOddsControllerDependencyBlock>();
                              _createOddProcessor = oddBlock.CreateOddProcessor;
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
                  }
                }
              }

              var logRedisToHaveBeenCreated = await _redisLogRepository.UpdateLogAsync(new LogRedis()
              {
                LastModified = DateTime.Now.ToString(),
                LastModifiedPostgres = DateTime.Now.ToString()
              });
            }
            else
            {
              Log.Error(
                $"BetDataInitializerJob: --Execute--  @Ready@ [BetDataInitializerJob].response.StatusCode: {response.StatusCode} Message: Scheduler is executed at {DateTime.Now}");
            }
          }
          catch (Exception e)
          {
            Log.Error(
              $"BetDataInitializerJob: --Execute--  @Ready@ [BetDataInitializerJob]. Message: Scheduler is executed at {DateTime.Now}");
          }
        }
      }
    }
  }
}
