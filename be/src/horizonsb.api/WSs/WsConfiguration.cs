
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using horizonsb.api.Commanding.Betting.Servers;
using horizonsb.api.Commanding.Events.Args;
using horizonsb.api.Commanding.OutBound;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders;
using horizonsb.api.Configurations.Commanding.Events.Args;
using horizonsb.api.Models.Live.MarketChanged;
using horizonsb.api.Redis.Events.Live;
using horizonsb.api.Redis.Logs;
using horizonsb.be.contracts.Events;
using horizonsb.commons.vm.Dtos.Events;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Serilog;
using WebSocket4Net;

namespace horizonsb.api.WSs
{
  public class WsConfiguration : IWsConfiguration, IKeepAliveRequestDetectionActionListener,
    IRegisterEventStartedRequestDetectionActionListener, 
    IRegisterEventEndedRequestDetectionActionListener, 
    IRegisterEventRequestDetectionActionListener, 
    IRegisterMarketRequestDetectionActionListener,
    IRegisterEventWithAllMarketRequestDetectionActionListener
  {
    public IConfiguration Configuration { get; }


    private readonly ILiveRedisRepository _redisRepository;
    private readonly ILogRedisRepository _redisLogRepository;
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly IServiceProvider _service;
    private WebSocket _websocket;

    public WsConfiguration(IConfiguration configuration, ILiveRedisRepository redisRepository,
      ILogRedisRepository redisLogRepository,
      IServiceScopeFactory scopeFactory)
    {
      Configuration = configuration;

      _redisRepository = redisRepository;
      _redisLogRepository = redisLogRepository;
      _scopeFactory = scopeFactory;
      WsServer.GetWsServer.Attach((IKeepAliveRequestDetectionActionListener) this);
      WsServer.GetWsServer.Attach((IRegisterEventRequestDetectionActionListener) this);
      WsServer.GetWsServer.Attach((IRegisterEventStartedRequestDetectionActionListener) this);
      WsServer.GetWsServer.Attach((IRegisterEventEndedRequestDetectionActionListener) this);
      WsServer.GetWsServer.Attach((IRegisterMarketRequestDetectionActionListener) this);
      WsServer.GetWsServer.Attach((IRegisterEventWithAllMarketRequestDetectionActionListener) this);
    }

    public void EstablishConnection()
    {
      //ws://dsqa.montana.com/socket.io/?EIO=3&transport=websocket
      string url = $"{Configuration["WsRemoteUrl"]}/socket.io/?EIO=3&transport=websocket";
      _websocket = new WebSocket($"{Configuration["WsRemoteUrl"]}/socket.io/?EIO=3&transport=websocket");
      _websocket.Opened += new EventHandler(WebsocketOpened);
      _websocket.Closed += WebsocketClosed;
      _websocket.MessageReceived += WebsocketMessageReceived;
      _websocket.Open();
    }

    private void WebsocketClosed(object sender, EventArgs e)
    {
      _websocket = new WebSocket($"{Configuration["WsRemoteUrl"]}/socket.io/?EIO=3&transport=websocket");
      _websocket.Opened += new EventHandler(WebsocketOpened);
      _websocket.Closed += WebsocketClosed;
      _websocket.MessageReceived += WebsocketMessageReceived;
      _websocket.Open();
    }

    private async void WebsocketMessageReceived(object sender, MessageReceivedEventArgs e)
    {
      var messageCollection =  Regex.Matches(e.Message, "(?<=\")[\\w]+(?!=\")");

      if (e.Message == "3")
      {
        WsServer.GetWsServer.RaiseKeepAliveResponseDetection();

        new AckDetectedInboundCommandBuilder()
          .Build(e.Message).RaiseWsEvent(WsInboundServer.GetInboundServer);

        Log.Information($"WebsocketMessageReceived -- KeepAlive Pong Received");
        return;
      }

      if(messageCollection.Count <= 0)
        return;

      if (messageCollection[0].Value == "sid")
      {
        Log.Information($"SID -- Connected - {e.Message}");
        return;
      }

      if (messageCollection[0].Value == "connected")
      {
        _websocket.Send("42[\"join\",\"en\",\"ds\"]");

        new ConnectedDetectedInboundCommandBuilder()
          .Build(e.Message).RaiseWsEvent(WsInboundServer.GetInboundServer);

        Log.Information($"WebsocketMessageReceived -- Connected");
      }
      else if (messageCollection[0].Value == "eventChanged")
      {
        new EventChangedDetectedInboundCommandBuilder()
          .Build(e.Message).RaiseWsEvent(WsInboundServer.GetInboundServer);

        Log.Information($"WebsocketMessageReceived -- eventChanged");
        Log.Information("--------(EventChanged)----------");
        return;
      }
      else if (messageCollection[0].Value == "marketChanged")
      {
        new MarketChangedDetectedInboundCommandBuilder()
          .Build(e.Message).RaiseWsEvent(WsInboundServer.GetInboundServer);

        Log.Information($"WebsocketMessageReceived -- marketChanged");
        int startIndex = e.Message.IndexOf('{');
        int endIndex = e.Message.Length - e.Message.IndexOf('{');
        string marketChangedJson = e.Message.Substring(startIndex, endIndex);
        marketChangedJson = marketChangedJson.Remove(marketChangedJson.Length - 1);

        MarketChanged marketChanged = JsonConvert.DeserializeObject<MarketChanged>(marketChangedJson);

        var eventToBeRetrieved = DoScopedWorkByLegacyMarket(marketChanged.legacyMarketId).Result;

        if (eventToBeRetrieved == null)
          return;

        if (String.IsNullOrEmpty(eventToBeRetrieved.EventTeamAway) ||
            String.IsNullOrEmpty(eventToBeRetrieved.EventTeamHome))
          return;

        var logRedisToHaveBeenCreatedOrUpdated
          = _redisLogRepository.UpdateLogAsync(new LogRedis()
          {
            LastModified = DateTime.Now.ToString(),
            LastModifiedMarketChanged = DateTime.Now.ToString(),
            LastModifiedChangedMarketId = marketChanged.legacyMarketId,
            LastModifiedWs = DateTime.Now.ToString(),
          });

        var liveEvent = await _redisRepository.GetLiveEuropeEventAsync(eventToBeRetrieved.Code);

        LiveAxbRedisModel liveAxbRedisModel;
        if (eventToBeRetrieved.EventSportConfiguration == 2) //EUR
        {
          if (marketChanged.@type.Contains("AXB"))
          {
            if (marketChanged.@type.Contains("AXB$OU"))
              return;

            try
            {
              var isAlreadyAnUsaEvent = await _redisRepository.CheckIfUsaEventExists(eventToBeRetrieved?.Code);

              if (isAlreadyAnUsaEvent)
                return;

              liveAxbRedisModel = new LiveAxbRedisModel()
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

              if (marketChanged.shortName.Contains("FT") || marketChanged.shortName.Contains("Match Result"))
              {
                foreach (var marketChangedOdd in marketChanged?.odds)
                {
                  switch (marketChangedOdd.clean)
                  {
                    case "HOME":
                      liveAxbRedisModel.AFinal = ValidateOddStringChar(marketChangedOdd?.odd.ToString());
                      break;
                    case "AWAY":
                      liveAxbRedisModel.BFinal = ValidateOddStringChar(marketChangedOdd?.odd.ToString());
                      break;
                    case "Tie":
                      liveAxbRedisModel.XFinal = ValidateOddStringChar(marketChangedOdd?.odd.ToString());
                      break;
                  }
                }
              }
              else
              {
                foreach (var marketChangedOdd in marketChanged.odds)
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
              }


              if (!String.IsNullOrEmpty(liveAxbRedisModel.Code))
                await _redisRepository.UpdateEuropeLiveEventAsync(liveAxbRedisModel, eventToBeRetrieved?.LivePriority > 1);

            }
            catch (Exception ex)
            {
              Log.Error($"{ex.Message}");
            }
          }
          else if (marketChanged.@type.Contains(":OU")) //OU
          {
            try
            {
              var isAlreadyAnUsaEvent = await _redisRepository.CheckIfUsaEventExists(eventToBeRetrieved?.Code);

              if (isAlreadyAnUsaEvent)
                return;

              liveAxbRedisModel = new LiveAxbRedisModel()
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
                CurrentPeriod = liveEvent?.CurrentPeriod,
                Possession = liveEvent?.Possession,
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
                NextTeamToScore = liveEvent?.NextTeamToScore,
                OverFinal = ValidateOddStringChar(marketChanged?.odds[0]?.odd.ToString()),
                TotalsFinal = marketChanged?.lines[0] == null ? "" : marketChanged?.lines[0].ToString(),
                UnderFinal = ValidateOddStringChar(marketChanged?.odds[1]?.odd.ToString()),
                A = liveEvent?.A,
                X = liveEvent?.X,
                B = liveEvent?.B,
                AFinal = liveEvent?.AFinal,
                XFinal = liveEvent?.XFinal,
                BFinal = liveEvent?.BFinal,
              };

              if (!String.IsNullOrEmpty(liveAxbRedisModel.Code))
                await _redisRepository.UpdateEuropeLiveEventAsync(liveAxbRedisModel, eventToBeRetrieved.LivePriority > 1);

            }
            catch (Exception ex)
            {
              Log.Error($"{ex.Message}");
            }
          }
          else if (marketChanged.@type.Contains("3HCP")) //3HCP
          {
            //var isAlreadyAnUsaEvent = await _redisRepository.CheckIfUsaEventExists(eventToBeRetrieved?.Code);

            //if (isAlreadyAnUsaEvent)
            //  return;

            //liveAxbRedisModel = new LiveAxbRedisModel()
            //{
            //  Code = liveEvent?.Code ?? eventToBeRetrieved?.Code,
            //  LiveTimeOfEvent = liveEvent?.LiveTimeOfEvent,
            //  IsUsa = liveEvent.IsUsa,
            //  League = eventToBeRetrieved.EventTournamentShortName,
            //  SportName = eventToBeRetrieved.EventSportName,
            //  EventCompleted = liveEvent?.EventCompleted ?? false,
            //  Status = eventToBeRetrieved?.StatusValue,
            //  EventStarted = liveEvent?.EventStarted ?? false,
            //  Live = liveEvent?.Live ?? false,
            //  CurrentPeriod = liveEvent?.CurrentPeriod,
            //  Possession = liveEvent?.Possession,
            //  kickoff_date = eventToBeRetrieved.DateEvent,
            //  timestamp = eventToBeRetrieved.Timestamp,
            //  Stage = new StageGameRedisModel()
            //  {
            //    HomeScore = liveEvent?.Stage.HomeScore,
            //    AwayScore = liveEvent?.Stage.AwayScore,
            //    Q = liveEvent?.Stage.Q,
            //    Q_AwayScore = liveEvent?.Stage.Q_AwayScore,
            //    Q_HomeScore = liveEvent?.Stage.Q_HomeScore,
            //    Q_Id = liveEvent?.Stage.Q_Id,
            //  },
            //  Games = new List<LiveGameRedisModel>()
            //  {
            //    new LiveGameRedisModel()
            //    {
            //      TeamName = eventToBeRetrieved?.EventTeamHome,
            //      Score = liveEvent?.Games[0]?.Score,
            //    },
            //    new LiveGameRedisModel()
            //    {
            //      TeamName = eventToBeRetrieved?.EventTeamAway,
            //      Score = liveEvent?.Games[1]?.Score,
            //    },
            //  },
            //  NextTeamToScore = new NextTeamToScoreRedisModel()
            //  {
            //    Home = ValidateOddStringChar(marketChanged?.odds[0]?.odd.ToString()),
            //    None = ValidateOddStringChar(marketChanged?.odds[1]?.odd.ToString()),
            //    Visitor = ValidateOddStringChar(marketChanged?.odds[2]?.odd.ToString()),
            //  },
            //  OverFinal = liveEvent?.OverFinal,
            //  TotalsFinal = liveEvent?.TotalsFinal,
            //  UnderFinal = liveEvent?.UnderFinal,
            //  A = liveEvent?.A,
            //  X = liveEvent?.X,
            //  B = liveEvent?.B,
            //  AFinal = liveEvent?.AFinal,
            //  XFinal = liveEvent?.XFinal,
            //  BFinal = liveEvent?.BFinal,
            //};

            //if (!String.IsNullOrEmpty(liveAxbRedisModel.Code))
            //  await _redisRepository.UpdateEuropeLiveEventAsync(liveAxbRedisModel, eventToBeRetrieved.LivePriority > 1);
          }
        }
        Log.Information($"--------------(marketChanged)-----------------");
        return;
      }
      else if (messageCollection[0].Value == "eventStarted")
      {
        new EventStartedDetectedInboundCommandBuilder()
          .Build(e.Message).RaiseWsEvent(WsInboundServer.GetInboundServer);
        Log.Information($"--------------(eventStarted)-----------------");
        return;
      }
      else if (messageCollection[0].Value == "eventEnded")
      {
        new EventEndedDetectedInboundCommandBuilder()
          .Build(e.Message).RaiseWsEvent(WsInboundServer.GetInboundServer);
        Log.Information($"--------------(eventEnded)-----------------");
        return;
      }
      else if (messageCollection[0].Value == "eventWithMarketsChanged")
      {
        new EventWithMarketChangedDetectedInboundCommandBuilder()
          .Build(e.Message).RaiseWsEvent(WsInboundServer.GetInboundServer);
        Log.Information($"--------------(eventWithMarketsChanged)-----------------");
        return;
      }
      else
      {
        Log.Information($"WebsocketMessageReceived --{e.Message}");
      }
      Log.Information($"--------------(End)-----------------");
    }

    private string ValidateOddStringChar(string odd)
    {
      int lengthAfterDot = odd.Length - odd.IndexOf(".") - 1;

      if (!odd.Contains("."))
        return $"{odd}.00";

      switch (lengthAfterDot)
      {
        case 1:
          return $"{odd}0";
        default:
          return odd;
      }
    }


    private async Task<EventUiModel> DoScopedWork(string eventId)
    {
      using (var scope = _scopeFactory.CreateScope())
      {
        var inquiryEventProcessor = scope.ServiceProvider.GetRequiredService<IInquiryEventProcessor>();
        return await inquiryEventProcessor.GetEventByEventIdAsync(eventId);
      }
    }

    private async Task<EventUiModel> DoScopedWorkByLegacyMarket(string legacyMarketId)
    {
      using (var scope = _scopeFactory.CreateScope())
      {
        var inquiryEventProcessor = scope.ServiceProvider.GetRequiredService<IInquiryEventProcessor>();
        return await inquiryEventProcessor.GetEventByMarketLegacyMarketIdAsync(legacyMarketId);
      }
    }

    private async Task<EventUiModel> DoScopedWorkByCode(string eventCode)
    {
      using (var scope = _scopeFactory.CreateScope())
      {
        var inquiryEventProcessor = scope.ServiceProvider.GetRequiredService<IInquiryEventProcessor>();
        return await inquiryEventProcessor.GetEventByCodeAsync(eventCode);
      }
    }


    private void WebsocketOpened(object sender, EventArgs e)
    {
    }

    public void Update(object sender, KeepAliveDetectionEventArgs e)
    {
      if (_websocket.Handshaked)
      {
        _websocket.Send("2");
      }
    }

    public void Update(object sender, RegisterEventDetectionEventArgs e)
    {
      Log.Information($"subscribeEvent was caught -- {e.EventId}");
      if (_websocket.Handshaked)
      {
        string str = $"42[\"subscribeEvent\",\"{e.EventId}\",\"en\",\"ds\"]";
        //Log.Information(str);
        _websocket.Send(str);
      }
    }

    public void Update(object sender, RegisterMarketsForEventsDetectionEventArgs e)
    {
      Log.Information($"subscribeEventMarket -- {e.EventId}-{e.Market}");
      if (_websocket.Handshaked)
      {
        string str = $"42[\"subscribeEventMarket\",\"event-{e.EventId}-{e.Market}\",\"en\",\"ds\"]";
        Log.Information(str);
        _websocket.Send(str);
      }
    }

    public void Update(object sender, RegisterEventStartedDetectionEventArgs e)
    {
      Log.Information($"eventStarted was caught -- {e.EventId}");
      if (_websocket.Handshaked)
      {
        //42["eventStarted","5218105","en","ds"]
        string str = $"42[\"eventStarted\",\"{e.EventId}\",\"en\",\"ds\"]";
        Log.Information(str);
        _websocket.Send(str);
      }
    }

    public void Update(object sender, RegisterEventEndedDetectionEventArgs e)
    {
      Log.Information($"eventEnded was caught -- {e.EventId}");
      if (_websocket.Handshaked)
      {
        //42["eventEnded","5218105","en","ds"]
        string str = $"42[\"eventEnded\",\"{e.EventId}\",\"en\",\"ds\"]";
        Log.Information(str);
        _websocket.Send(str);
      }
    }

    public void Update(object sender, RegisterEventWithAllMarketsForEventsDetectionEventArgs e)
    {
      Log.Information($"subscribeEventWithAllMarkets -- {e.EventId}");
      if (_websocket.Handshaked)
      {
        string str = $"42[\"subscribeEventWithAllMarkets\",{e.EventId},\"en\",\"ds\"]";
        Log.Information(str);
        _websocket.Send(str);
      }
    }
  }
}
