using System;
using System.Collections.Generic;
using System.Linq;
using horizonsb.api.Commanding.Betting.Events.Args;
using horizonsb.api.Commanding.Betting.Listeners;
using horizonsb.api.Commanding.Betting.Servers;
using horizonsb.api.Proxies.Base;
using horizonsb.api.Redis.Events.Live;
using horizonsb.api.Redis.Logs;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Serilog;

namespace horizonsb.api.Proxies
{
  public class EventWithMarketChangedProxyManipulator : BaseProxyManipulator, IEventWithMarketChangedProxyManipulator,
    IEventWithMarketChangedDetectionActionListener
  {
    private readonly ILiveRedisRepository _redisRepository;
    private readonly ILogRedisRepository _redisLogRepository;
    private readonly IServiceScopeFactory _scopeFactory;

    public IConfiguration Configuration { get; }

    public EventWithMarketChangedProxyManipulator(IConfiguration configuration, ILiveRedisRepository redisRepository,
      ILogRedisRepository redisLogRepository,
      IServiceScopeFactory scopeFactory) : base(scopeFactory)
    {
      Configuration = configuration;

      _redisRepository = redisRepository;
      _redisLogRepository = redisLogRepository;
      _scopeFactory = scopeFactory;
    }

    public void ProxyInitializer()
    {
      WsInboundServer.GetInboundServer.Attach((IEventWithMarketChangedDetectionActionListener) this);
    }

    public async void Update(object sender, EventWithMarketChangedDetectionEventArgs e)
    { 
      EventWithAllMarketChanged marketWithAllMarketChanged =
        JsonConvert.DeserializeObject<EventWithAllMarketChanged>(e.Payload);
      MarketEvent marketEventToBeStored = new MarketEvent();

      Log.Information($"********************************************************\r\n");

      for (var index = 0; index < marketWithAllMarketChanged.markets.Count; index++)
      {
        var market = marketWithAllMarketChanged.markets[index];
        Log.Information($"Market Id:{market.id} -- Index: {index}\r\n");
      }
      Log.Information($"********************************************************\r\n");

      if (e.Payload.Contains("FT:NG"))
      {
        Log.Information("Next Goal");
        if (marketWithAllMarketChanged.markets != null && marketWithAllMarketChanged.markets.Count > 0)
        {
          marketEventToBeStored =
            marketWithAllMarketChanged.markets.FirstOrDefault(m => m.id.Contains("FT:NG"));

          if (marketEventToBeStored != null)
          {
            var eventToBeRetrieved = await DoScopedWorkByCode(marketWithAllMarketChanged.code);

            if (eventToBeRetrieved == null)
              return;

            if (String.IsNullOrEmpty(eventToBeRetrieved.EventTeamAway) ||
                String.IsNullOrEmpty(eventToBeRetrieved.EventTeamHome))
              return;

            var liveEvent = await _redisRepository.GetLiveEuropeEventAsync(eventToBeRetrieved.Code);
            if (eventToBeRetrieved.EventSportConfiguration == 2) //EUR
            {
              var isAlreadyAnUsaEvent = await _redisRepository.CheckIfUsaEventExists(eventToBeRetrieved?.Code);

              if (isAlreadyAnUsaEvent)
                return;

              try
              {
                var liveAxbRedisModel = new LiveAxbRedisModel()
                {
                  Code = liveEvent?.Code ?? eventToBeRetrieved?.Code,
                  LiveTimeOfEvent = liveEvent?.LiveTimeOfEvent,
                  IsUsa = liveEvent?.IsUsa,
                  League = eventToBeRetrieved?.EventTournamentShortName,
                  SportName = eventToBeRetrieved?.EventSportName,
                  EventCompleted = liveEvent?.EventCompleted ?? false,
                  Status = eventToBeRetrieved?.StatusValue,
                  EventStarted = liveEvent?.EventStarted ?? false,
                  Live = liveEvent?.Live ?? false,
                  Possession = liveEvent?.Possession,
                  CurrentPeriod = liveEvent?.CurrentPeriod,
                  kickoff_date = eventToBeRetrieved?.DateEvent,
                  timestamp = eventToBeRetrieved?.Timestamp,
                  Stage = new StageGameRedisModel()
                  {
                    HomeScore = liveEvent?.Stage.HomeScore,
                    AwayScore = liveEvent?.Stage.AwayScore,
                    Q = liveEvent?.Stage.Q,
                    Q_AwayScore = liveEvent?.Stage.Q_AwayScore,
                    Q_HomeScore = liveEvent?.Stage.Q_HomeScore,
                    Q_Id = liveEvent?.Stage.Q_Id,
                  },
                  Games = new List<LiveGameRedisModel>()
                  {
                    new LiveGameRedisModel()
                    {
                      TeamName = eventToBeRetrieved?.EventTeamHome,
                      Score = liveEvent?.Games[0]?.Score,
                    },
                    new LiveGameRedisModel()
                    {
                      TeamName = eventToBeRetrieved?.EventTeamAway,
                      Score = liveEvent?.Games[1]?.Score,
                    },
                  },
                  AFinal = liveEvent?.AFinal,
                  BFinal = liveEvent?.BFinal,
                  XFinal = liveEvent?.XFinal,
                  A = liveEvent?.A,
                  B = liveEvent?.B,
                  X = liveEvent?.X,
                  OverFinal = liveEvent?.OverFinal,
                  TotalsFinal = liveEvent?.TotalsFinal,
                  UnderFinal = liveEvent?.UnderFinal,
                  NextTeamToScore = liveEvent?.NextTeamToScore,
                };

                foreach (var marketChangedOdd in marketEventToBeStored?.odds)
                {
                  switch (marketChangedOdd.clean)
                  {
                    case "HOME":
                      if (liveAxbRedisModel.NextTeamToScore != null)
                        liveAxbRedisModel.NextTeamToScore.Home = ValidateOddStringChar(marketChangedOdd?.odd.ToString());
                      break;
                    case "AWAY":
                      if (liveAxbRedisModel.NextTeamToScore != null)
                        liveAxbRedisModel.NextTeamToScore.Visitor =
                          ValidateOddStringChar(marketChangedOdd?.odd.ToString());
                      break;
                    case "M3":
                      if (liveAxbRedisModel.NextTeamToScore != null)
                        liveAxbRedisModel.NextTeamToScore.None = ValidateOddStringChar(marketChangedOdd?.odd.ToString());
                      break;
                  }
                }

                if (!String.IsNullOrEmpty(liveAxbRedisModel.Code))
                  await _redisRepository.UpdateEuropeLiveEventAsync(liveAxbRedisModel, eventToBeRetrieved?.LivePriority > 1);
              }
              catch (Exception ex)
              {
                Log.Error($"Period - NG - Next Goal --> Error :{ex.Message}");
              }
            }
          }
        }
      }

      if (e.Payload.Contains(":P:ML_"))
      {
        Log.Information($"Market ML\r\n");
      }

      if (e.Payload.Contains(":FT:ML_"))
      {
        Log.Information($"Market ML\r\n");
      }

      if (e.Payload.Contains(":P:AXB"))
      {
        marketEventToBeStored = new MarketEvent();
        Log.Information("Period - AXB");
        if (marketWithAllMarketChanged.markets != null && marketWithAllMarketChanged.markets.Count > 0)
        {
          marketEventToBeStored =
            marketWithAllMarketChanged.markets.FirstOrDefault(m => m.id.Contains("P:AXB"));
          if (marketEventToBeStored != null)
          {
            var eventToBeRetrieved = await DoScopedWorkByCode(marketWithAllMarketChanged.code);

            if (eventToBeRetrieved == null)
              return;

            if (String.IsNullOrEmpty(eventToBeRetrieved.EventTeamAway) ||
                String.IsNullOrEmpty(eventToBeRetrieved.EventTeamHome))
              return;

            var liveEvent = await _redisRepository.GetLiveEuropeEventAsync(eventToBeRetrieved.Code);
            if (eventToBeRetrieved.EventSportConfiguration == 2) //EUR
            {
              var isAlreadyAnUsaEvent = await _redisRepository.CheckIfUsaEventExists(eventToBeRetrieved?.Code);

              if (isAlreadyAnUsaEvent)
                return;

              try
              {
                var liveAxbRedisModel = new LiveAxbRedisModel()
                {
                  Code = liveEvent?.Code ?? eventToBeRetrieved?.Code,
                  LiveTimeOfEvent = liveEvent?.LiveTimeOfEvent,
                  IsUsa = liveEvent?.IsUsa,
                  League = eventToBeRetrieved?.EventTournamentShortName,
                  SportName = eventToBeRetrieved?.EventSportName,
                  EventCompleted = liveEvent?.EventCompleted ?? false,
                  Status = eventToBeRetrieved?.StatusValue,
                  EventStarted = liveEvent?.EventStarted ?? false,
                  Live = liveEvent?.Live ?? false,
                  Possession = liveEvent?.Possession,
                  CurrentPeriod = liveEvent?.CurrentPeriod,
                  kickoff_date = eventToBeRetrieved?.DateEvent,
                  timestamp = eventToBeRetrieved?.Timestamp,
                  Stage = new StageGameRedisModel()
                  {
                    HomeScore = liveEvent?.Stage.HomeScore,
                    AwayScore = liveEvent?.Stage.AwayScore,
                    Q = liveEvent?.Stage.Q,
                    Q_AwayScore = liveEvent?.Stage.Q_AwayScore,
                    Q_HomeScore = liveEvent?.Stage.Q_HomeScore,
                    Q_Id = liveEvent?.Stage.Q_Id,
                  },
                  Games = new List<LiveGameRedisModel>()
                  {
                    new LiveGameRedisModel()
                    {
                      TeamName = eventToBeRetrieved?.EventTeamHome,
                      Score = liveEvent?.Games[0]?.Score,
                    },
                    new LiveGameRedisModel()
                    {
                      TeamName = eventToBeRetrieved?.EventTeamAway,
                      Score = liveEvent?.Games[1]?.Score,
                    },
                  },
                  AFinal = liveEvent?.AFinal,
                  BFinal = liveEvent?.BFinal,
                  XFinal = liveEvent?.XFinal,
                  A = liveEvent?.A,
                  B = liveEvent?.B,
                  X = liveEvent?.X,
                  OverFinal = liveEvent?.OverFinal,
                  TotalsFinal = liveEvent?.TotalsFinal,
                  UnderFinal = liveEvent?.UnderFinal,
                  NextTeamToScore = liveEvent?.NextTeamToScore,
                };

                foreach (var marketChangedOdd in marketEventToBeStored.odds)
                {
                  switch (marketChangedOdd.clean)
                  {
                    case "HOME":
                      liveAxbRedisModel.A = ValidateOddStringChar(marketChangedOdd?.odd.ToString());
                      break;
                    case "AWAY":
                      liveAxbRedisModel.B = ValidateOddStringChar(marketChangedOdd?.odd.ToString());
                      break;
                    case "Tie":
                      liveAxbRedisModel.X = ValidateOddStringChar(marketChangedOdd?.odd.ToString());
                      break;
                  }
                }

                if (!String.IsNullOrEmpty(liveAxbRedisModel.Code))
                  await _redisRepository.UpdateEuropeLiveEventAsync(liveAxbRedisModel, eventToBeRetrieved?.LivePriority > 1);
              }
              catch (Exception ex)
              {
                Log.Error($"Period - AXB --> Error :{ex.Message}");
              }
            }
          }
        }
      }

      if (e.Payload.Contains(":P:OU"))
      {

        Log.Information("Period - Under- Over");
        switch (marketWithAllMarketChanged.currentPeriodName)
        {
          case "P1":
          {
            marketEventToBeStored = marketWithAllMarketChanged.markets.FirstOrDefault(m => m.id.Contains("P:OU_P1"));
            break;
          }
          case "P2":
          {
            marketEventToBeStored = marketWithAllMarketChanged.markets.FirstOrDefault(m => m.id.Contains("P:OU_P2"));
            break;
          }
          case "P3":
          {
            marketEventToBeStored = marketWithAllMarketChanged.markets.FirstOrDefault(m => m.id.Contains("P:OU_P3"));
            break;
          }
          case "P4":
          {
            marketEventToBeStored = marketWithAllMarketChanged.markets.FirstOrDefault(m => m.id.Contains("P:OU_P4"));
            break;
          }
          case "HT":
          {
            if (marketWithAllMarketChanged.markets.Count == 1)
              marketEventToBeStored = marketWithAllMarketChanged.markets[0];
            else if (marketWithAllMarketChanged.currentPeriod.Contains("FIRST"))
              marketEventToBeStored = marketWithAllMarketChanged.markets.FirstOrDefault(m => m.id.Contains("P:OU_P2"));
            else if (marketWithAllMarketChanged.currentPeriod.Contains("SECOND"))
              marketEventToBeStored = marketWithAllMarketChanged.markets.FirstOrDefault(m => m.id.Contains("P:OU_P3"));
            else if (marketWithAllMarketChanged.currentPeriod.Contains("THIRD"))
              marketEventToBeStored = marketWithAllMarketChanged.markets.FirstOrDefault(m => m.id.Contains("P:OU_P4"));

            break;
          }
        }

        if (marketEventToBeStored != null)
        {
          var eventToBeRetrieved = await DoScopedWorkByCode(marketWithAllMarketChanged.code);

          if (eventToBeRetrieved == null)
            return;

          if (String.IsNullOrEmpty(eventToBeRetrieved.EventTeamAway) ||
              String.IsNullOrEmpty(eventToBeRetrieved.EventTeamHome))
            return;

          var liveEvent = await _redisRepository.GetLiveEuropeEventAsync(eventToBeRetrieved.Code);
          if (eventToBeRetrieved.EventSportConfiguration == 2) //EUR
          {
            var isAlreadyAnUsaEvent = await _redisRepository.CheckIfUsaEventExists(eventToBeRetrieved?.Code);

            if (isAlreadyAnUsaEvent)
              return;

            try
            {
              var liveAxbRedisModel = new LiveAxbRedisModel
              {
                Code = liveEvent?.Code ?? eventToBeRetrieved?.Code,
                LiveTimeOfEvent = liveEvent?.LiveTimeOfEvent,
                IsUsa = liveEvent?.IsUsa,
                League = eventToBeRetrieved?.EventTournamentShortName,
                SportName = eventToBeRetrieved?.EventSportName,
                EventCompleted = liveEvent?.EventCompleted ?? false,
                Status = eventToBeRetrieved?.StatusValue,
                EventStarted = liveEvent?.EventStarted ?? false,
                Live = liveEvent?.Live ?? false,
                Possession = liveEvent?.Possession,
                CurrentPeriod = liveEvent?.CurrentPeriod,
                kickoff_date = eventToBeRetrieved?.DateEvent,
                timestamp = eventToBeRetrieved?.Timestamp,
                Stage = new StageGameRedisModel()
                {
                  HomeScore = liveEvent?.Stage.HomeScore,
                  AwayScore = liveEvent?.Stage.AwayScore,
                  Q = liveEvent?.Stage.Q,
                  Q_AwayScore = liveEvent?.Stage.Q_AwayScore,
                  Q_HomeScore = liveEvent?.Stage.Q_HomeScore,
                  Q_Id = liveEvent?.Stage.Q_Id,
                },
                Games = new List<LiveGameRedisModel>()
                {
                  new LiveGameRedisModel()
                  {
                    TeamName = eventToBeRetrieved?.EventTeamHome, Score = liveEvent?.Games[0]?.Score,
                  },
                  new LiveGameRedisModel()
                  {
                    TeamName = eventToBeRetrieved?.EventTeamAway, Score = liveEvent?.Games[1]?.Score,
                  },
                },
                AFinal = liveEvent?.AFinal,
                BFinal = liveEvent?.BFinal,
                XFinal = liveEvent?.XFinal,
                A = liveEvent?.A,
                B = liveEvent?.B,
                X = liveEvent?.X,
                OverFinal = liveEvent?.OverFinal,
                TotalsFinal = liveEvent?.TotalsFinal,
                UnderFinal = liveEvent?.UnderFinal,
                NextTeamToScore = liveEvent?.NextTeamToScore,

              };
              if (marketEventToBeStored?.odds == null)
                return;

              if (marketEventToBeStored?.odds.Count == 2)
              {
                liveAxbRedisModel.Over = ValidateOddStringChar(marketEventToBeStored?.odds[1].ToString());
                liveAxbRedisModel.Under = ValidateOddStringChar(marketEventToBeStored?.odds[0].ToString());
              }
              else
              {
                liveAxbRedisModel.Over = ValidateOddStringChar(marketEventToBeStored?.odds[2].ToString());
                liveAxbRedisModel.Totals = ValidateOddStringChar(marketEventToBeStored?.odds[1].ToString());
                liveAxbRedisModel.Under = ValidateOddStringChar(marketEventToBeStored?.odds[0].ToString());
              }

              if (!String.IsNullOrEmpty(liveAxbRedisModel.Code))
                await _redisRepository.UpdateEuropeLiveEventAsync(liveAxbRedisModel, eventToBeRetrieved?.LivePriority > 1);
            }
            catch (Exception ex)
            {
              Log.Error($"Period - Under- Over --> Error :{ex.Message}");
            }
          }
        }
      }
    }
  }
}