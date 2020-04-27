using horizonsb.api.Commanding.Betting.Events.Base;
using horizonsb.api.Commanding.Betting.Servers.Base;

namespace horizonsb.api.Commanding.Betting.Events.Inbounds
{
  public class EventEndedDetectionEventRaising : IWsInboundEventRaisingBehavior
  {
    public string Payload { get; private set; }

    public EventEndedDetectionEventRaising(string payload)
    {
      this.Payload = payload;
    }

    public void RaiseWsEvent(WsInboundBaseServer inboundEventServer)
    {
      inboundEventServer.RaiseEventEndedDetection(Payload);
    }
  }
}