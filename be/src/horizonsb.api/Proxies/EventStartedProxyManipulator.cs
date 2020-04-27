using System;
using horizonsb.api.Commanding.Betting.Events.Args;
using horizonsb.api.Commanding.Betting.Listeners;
using horizonsb.api.Commanding.Betting.Servers;
using horizonsb.api.Proxies.Base;
using horizonsb.api.Redis.Events.Live;
using horizonsb.api.Redis.Logs;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Serilog;

namespace horizonsb.api.Proxies
{
  public class EventStartedProxyManipulator : BaseProxyManipulator, IEventStartedProxyManipulator, IEventStartedDetectionActionListener
  {
    private readonly ILiveRedisRepository _redisRepository;
    private readonly ILogRedisRepository _redisLogRepository;
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly IServiceProvider _service;

    public IConfiguration Configuration { get; }

    public EventStartedProxyManipulator(IConfiguration configuration, ILiveRedisRepository redisRepository,
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
      WsInboundServer.GetInboundServer.Attach((IEventStartedDetectionActionListener) this);
    }

    public async void Update(object sender, EventStartedDetectionEventArgs e)
    {
      if (String.IsNullOrEmpty(e.Payload))
        return;

      var eventToBeRetrieved = await DoScopedWorkByEventId(e.Payload);

      if (eventToBeRetrieved == null)
        return;

      if (String.IsNullOrEmpty(eventToBeRetrieved.EventTeamAway) ||
          String.IsNullOrEmpty(eventToBeRetrieved.EventTeamHome))
        return;

      Log.Information($"Just Before Started event {e.Payload} upcoming: {eventToBeRetrieved.UpcomingLive}");
      eventToBeRetrieved = await DoScopedWorkUpdateByUpcomingLive(e.Payload);
      Log.Information($"Just After Started event {e.Payload} upcoming: {eventToBeRetrieved.UpcomingLive}");
    }
  }
}