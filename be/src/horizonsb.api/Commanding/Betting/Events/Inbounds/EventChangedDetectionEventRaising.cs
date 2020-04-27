using horizonsb.api.Commanding.Betting.Events.Base;
using horizonsb.api.Commanding.Betting.Servers.Base;
using horizonsb.api.Models.Live.EventChanged;

namespace horizonsb.api.Commanding.Betting.Events.Inbounds
{
  public class EventChangedDetectionEventRaising : IWsInboundEventRaisingBehavior
  {
    private readonly EventChanged _eventChanged;
    private readonly string _payload;

    public EventChangedDetectionEventRaising(EventChanged eventChanged, string payload)
    {
      _eventChanged = eventChanged;
      _payload = payload;
    }

    public void RaiseWsEvent(WsInboundBaseServer inboundEventServer)
    {
      inboundEventServer.RaiseEventChangedDetection(_eventChanged, _payload);
    }
  }
}