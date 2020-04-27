using System;
using System.Collections.Generic;
using horizonsb.api.Commanding.Betting.Events.Args;
using horizonsb.api.Commanding.Betting.Listeners;
using horizonsb.api.Commanding.Betting.Servers;
using horizonsb.api.Models.Live.MarketChanged;
using horizonsb.api.Proxies.Base;
using horizonsb.api.Redis.Events.Live;
using horizonsb.api.Redis.Logs;
using horizonsb.commons.vm.Dtos.Events;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Serilog;

namespace horizonsb.api.Proxies
{
  public class MarketChangedProxyManipulator : BaseProxyManipulator, IMarketChangedProxyManipulator, IMarketChangedDetectionActionListener
  {
    private readonly ILiveRedisRepository _redisRepository;
    private readonly ILogRedisRepository _redisLogRepository;
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly IServiceProvider _service;

    public IConfiguration Configuration { get; }

    public MarketChangedProxyManipulator(IConfiguration configuration, ILiveRedisRepository redisRepository,
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
      WsInboundServer.GetInboundServer.Attach((IMarketChangedDetectionActionListener) this);
    }

    public async void Update(object sender, MarketChangedDetectionEventArgs e)
    {
      Log.Information($"********************************************************\r\n");
      Log.Information($"Market Id:{e.MarketChanged.id} -- Market {e.MarketChanged.id}\r\n");
      Log.Information($"********************************************************\r\n");

      EventUiModel eventToBeRetrieved = await DoScopedWorkByLegacyMarket(e.MarketChanged.legacyMarketId);

      if (eventToBeRetrieved == null)
        return;

      if (String.IsNullOrEmpty(eventToBeRetrieved.EventTeamAway) ||
          String.IsNullOrEmpty(eventToBeRetrieved.EventTeamHome))
        return;

      var liveEvent = await _redisRepository.GetLiveEuropeEventAsync(eventToBeRetrieved.Code);

      if (eventToBeRetrieved.EventSportConfiguration == 1)
      {
        var isAlreadyAnEuropeanEvent =
          await _redisRepository.CheckIfEuropeanEventExists(eventToBeRetrieved?.Code);

        if (isAlreadyAnEuropeanEvent)
          return;

        try
        {
          var liveMoneyLineRedisModel = new LiveMoneyLineRedisModel()
          {
            Code = liveEvent?.Code ?? eventToBeRetrieved?.Code,
            LiveTimeOfEvent = liveEvent?.LiveTimeOfEvent,
            IsUsa = liveEvent?.IsUsa,
            League = eventToBeRetrieved.EventTournamentShortName,
            SportName = eventToBeRetrieved.EventSportName,
            EventCompleted = liveEvent?.EventCompleted ?? false,
            Status = eventToBeRetrieved?.StatusValue,
            EventStarted = liveEvent?.EventStarted ?? false,
            Live = liveEvent?.Live ?? false,
            CurrentPeriod = liveEvent?.CurrentPeriod,
            Possession = liveEvent?.Possession,
            kickoff_date = eventToBeRetrieved.DateEvent,
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
                TeamName = eventToBeRetrieved.EventTeamHome,
                Score = liveEvent?.Games[0]?.Score,
              },
              new LiveGameRedisModel()
              {
                TeamName = eventToBeRetrieved.EventTeamAway,
                Score = liveEvent?.Games[1]?.Score,
              },
            },
            OverFinal = liveEvent?.OverFinal,
            TotalsFinal = liveEvent?.TotalsFinal,
            UnderFinal = liveEvent?.UnderFinal,
          };

          if (e.MarketChanged.@type.Contains("FT") || e.MarketChanged.shortName.Contains("Match Result"))
          {
            foreach (var marketChangedOdd in e.MarketChanged.odds)
            {
              switch (marketChangedOdd.clean)
              {
                case "HOME":
                  liveMoneyLineRedisModel.MoneyLinesFinal.Add(ValidateOddStringChar(marketChangedOdd.odd.ToString()));
                  break;
                case "AWAY":
                  liveMoneyLineRedisModel.MoneyLinesFinal.Add(ValidateOddStringChar(marketChangedOdd.odd.ToString()));
                  break;
                case "U":
                  liveMoneyLineRedisModel.UnderFinal = ValidateOddStringChar(marketChangedOdd.odd.ToString());
                  break;
                case "O":
                  liveMoneyLineRedisModel.OverFinal = ValidateOddStringChar(marketChangedOdd.odd.ToString());
                  break;
              }
            }
          }
          else
          {
            foreach (var marketChangedOdd in e.MarketChanged.odds)
            {
              switch (marketChangedOdd.clean)
              {
                case "HOME":
                  liveMoneyLineRedisModel.MoneyLines.Add(ValidateOddStringChar(marketChangedOdd.odd.ToString()));
                  break;
                case "AWAY":
                  liveMoneyLineRedisModel.MoneyLines.Add(ValidateOddStringChar(marketChangedOdd.odd.ToString()));
                  break;
                case "U":
                  liveMoneyLineRedisModel.Under = ValidateOddStringChar(marketChangedOdd.odd.ToString());
                  break;
                case "O":
                  liveMoneyLineRedisModel.Over = ValidateOddStringChar(marketChangedOdd.odd.ToString());
                  break;
              }
            }
          }

          if (!String.IsNullOrEmpty(liveMoneyLineRedisModel.Code))
            await _redisRepository.UpdateUsaLiveEventAsync(liveMoneyLineRedisModel,
              eventToBeRetrieved.LivePriority > 1);
        }
        catch (Exception ex)
        {
          Log.Error($"{ex.Message}");
        }

      }

      if (e.Payload.Contains("FT:NG"))
      {
        Log.Information("Next Goal");
      }

      if (e.Payload.Contains(":P:"))
      {
        Log.Information("Period");
      }
    }
  }
}