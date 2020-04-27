using horizonsb.api.Commanding.Betting.Events.Base;
using horizonsb.api.Commanding.Betting.Servers.Base;

namespace horizonsb.api.Commanding.Betting.Events.Inbounds
{
  public class EventStartedDetectionEventRaising : IWsInboundEventRaisingBehavior
  {
    public string Payload { get; private set; }

    public EventStartedDetectionEventRaising(string payload)
    {
      this.Payload = payload;
    }

    public void RaiseWsEvent(WsInboundBaseServer inboundEventServer)
    {
      inboundEventServer.RaiseEventStartedDetection(Payload);
    }
  }
}