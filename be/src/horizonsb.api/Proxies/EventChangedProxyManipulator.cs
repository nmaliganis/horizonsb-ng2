using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.api.Commanding.Betting.Events.Args;
using horizonsb.api.Commanding.Betting.Listeners;
using horizonsb.api.Commanding.Betting.Servers;
using horizonsb.api.Proxies.Base;
using horizonsb.api.Redis.Events.Live;
using horizonsb.commons.vm.Dtos.Events;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Serilog;

namespace horizonsb.api.Proxies
{
  public class EventChangedProxyManipulator : BaseProxyManipulator, IEventChangedProxyManipulator, IEventChangedDetectionActionListener
  {
    private readonly ILiveRedisRepository _redisRepository;

    public IConfiguration Configuration { get; }

    public EventChangedProxyManipulator(IConfiguration configuration, ILiveRedisRepository redisRepository, IServiceScopeFactory scopeFactory) : base(scopeFactory)
    {
      Configuration = configuration;
      _redisRepository = redisRepository;
    }

    public void ProxyInitializer()
    {
      WsInboundServer.GetInboundServer.Attach((IEventChangedDetectionActionListener)this);
    }

    public async void Update(object sender, EventChangedDetectionEventArgs e)
    {
      if (e.EventChanged == null)
        return;

      var eventToBeRetrieved = await DoScopedWorkByEventId(e.EventChanged.id);

      if (eventToBeRetrieved == null)
        return;

      if (String.IsNullOrEmpty(eventToBeRetrieved.EventTeamAway) ||
          String.IsNullOrEmpty(eventToBeRetrieved.EventTeamHome))
        return;

      if (!e.EventChanged.americanGround) //EUR
      {
        var liveEuEvent = await _redisRepository.GetLiveEuropeEventAsync(eventToBeRetrieved?.Code);

        await StoreEurToRedis(e, eventToBeRetrieved, liveEuEvent);
      }
      else if (e.EventChanged.americanGround) //USA
      {
        var liveUsaEvent = await _redisRepository.GetLiveUsaEventAsync(eventToBeRetrieved.Code);

        await StoreUsaToRedis(e, eventToBeRetrieved, liveUsaEvent);
      }
    }

    private async Task StoreUsaToRedis(EventChangedDetectionEventArgs e, EventUiModel eventToBeRetrieved,
      LiveMoneyLineRedisModel liveUsaEvent)
    {
      LiveMoneyLineRedisModel liveRedisModel = new LiveMoneyLineRedisModel()
      {
        Code = e.EventChanged?.code,
        LiveTimeOfEvent = e.EventChanged?.time,
        IsUsa = true,
        League = eventToBeRetrieved?.EventTournamentShortName,
        SportName = eventToBeRetrieved?.EventSportName,
        EventCompleted = e.EventChanged?.eventCompleted,
        Status = e.EventChanged?.status,
        EventStarted = e.EventChanged?.eventStarted,
        Live = e.EventChanged?.live,
        Possession = e.EventChanged?.possession,
        CurrentPeriod = e.EventChanged?.currentPeriod,
        kickoff_date = eventToBeRetrieved?.DateEvent,
        timestamp = eventToBeRetrieved?.Timestamp,
        MoneyLinesFinal = liveUsaEvent?.MoneyLinesFinal,
        MoneyLines = liveUsaEvent?.MoneyLines,
        SpreadsFinal = liveUsaEvent?.SpreadsFinal,
        Spreads = liveUsaEvent?.Spreads,
        Stage = new StageGameRedisModel()
        {
          HomeScore = e.EventChanged?.gameScore?.Count < 2 ? "" : e.EventChanged?.gameScore[0].ToString(),
          AwayScore = e.EventChanged?.gameScore?.Count < 2 ? "" : e.EventChanged?.gameScore[1].ToString(),
          Q = e.EventChanged?.currentPeriodName,
          Q_AwayScore = e.EventChanged?.periods?.Count == 0
            ? ""
            : e.EventChanged?.periods.FirstOrDefault(x => x.id == e.EventChanged.currentPeriod)?.away.ToString(),
          Q_HomeScore = e.EventChanged?.periods?.Count == 0
            ? ""
            : e.EventChanged?.periods.FirstOrDefault(x => x.id == e.EventChanged.currentPeriod)?.home.ToString(),
          Q_Id = e.EventChanged?.periods?.Count == 0
            ? ""
            : e.EventChanged?.periods.FirstOrDefault(x => x.id == e.EventChanged.currentPeriod)?.id,
        },
        Games = new List<LiveGameRedisModel>()
        {
          new LiveGameRedisModel()
          {
            TeamName = eventToBeRetrieved?.EventTeamHome,
            Score = e.EventChanged?.score?.Count < 2 ? "" : e.EventChanged?.score[0].ToString(),
          },
          new LiveGameRedisModel()
          {
            TeamName = eventToBeRetrieved?.EventTeamAway,
            Score = e.EventChanged?.score?.Count < 2 ? "" : e.EventChanged?.score[1].ToString(),
          },
        },
      };

      await _redisRepository.UpdateUsaLiveEventAsync(liveRedisModel, eventToBeRetrieved.LivePriority > 1);
    }

    private async Task StoreEurToRedis(EventChangedDetectionEventArgs e, EventUiModel eventToBeRetrieved,
      LiveAxbRedisModel liveEuEvent)
    {
      try
      {
        LiveAxbRedisModel liveAxbRedisModel = new LiveAxbRedisModel()
        {
          Code = e.EventChanged?.code,
          LiveTimeOfEvent = e.EventChanged?.time,
          IsUsa = false,
          League = eventToBeRetrieved?.EventTournamentShortName,
          SportName = eventToBeRetrieved?.EventSportName,
          EventCompleted = e.EventChanged?.eventCompleted,
          Status = e.EventChanged?.status,
          EventStarted = e.EventChanged?.eventStarted,
          Live = e.EventChanged?.live,
          Possession = e.EventChanged?.possession,
          CurrentPeriod = e.EventChanged?.currentPeriod,
          kickoff_date = eventToBeRetrieved?.DateEvent,
          timestamp = eventToBeRetrieved?.Timestamp,
          Stage = new StageGameRedisModel()
          {
            HomeScore = e.EventChanged?.gameScore?.Count < 2 ? "" : e.EventChanged?.gameScore[0].ToString(),
            AwayScore = e.EventChanged?.gameScore?.Count < 2 ? "" : e.EventChanged?.gameScore[1].ToString(),
            Q = e.EventChanged?.currentPeriodName,
            Q_AwayScore = e.EventChanged?.periods?.Count == 0
              ? ""
              : (e.EventChanged?.periods).FirstOrDefault(x => x.id == e.EventChanged?.currentPeriod)?.away.ToString(),
            Q_HomeScore = e.EventChanged?.periods?.Count == 0
              ? ""
              : e.EventChanged?.periods.FirstOrDefault(x => x.id == e.EventChanged?.currentPeriod)?.home.ToString(),
            Q_Id = e.EventChanged?.periods?.Count == 0
              ? ""
              : e.EventChanged?.periods.FirstOrDefault(x => x.id == e.EventChanged?.currentPeriod)?.id,
          },
          Games = new List<LiveGameRedisModel>()
          {
            new LiveGameRedisModel()
            {
              TeamName = eventToBeRetrieved?.EventTeamHome,
              Score = e.EventChanged?.score?.Count < 2 ? "" : e.EventChanged?.score[0].ToString(),
            },
            new LiveGameRedisModel()
            {
              TeamName = eventToBeRetrieved.EventTeamAway,
              Score = e.EventChanged?.score?.Count <  2 ? "" : e.EventChanged?.score[1].ToString(),
            },
          },
          A = liveEuEvent?.A,
          X = liveEuEvent?.X,
          B = liveEuEvent?.B,
          AFinal = liveEuEvent?.AFinal,
          XFinal = liveEuEvent?.XFinal,
          BFinal = liveEuEvent?.BFinal,
        };
        await _redisRepository.UpdateEuropeLiveEventAsync(liveAxbRedisModel, eventToBeRetrieved.LivePriority > 1);
      }
      catch (Exception ex)
      {
        Log.Error($"Event Changed --> Error :{ex.Message}");
      }
    }
  }
}
