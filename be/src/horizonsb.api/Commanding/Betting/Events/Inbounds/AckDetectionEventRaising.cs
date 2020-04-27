using horizonsb.api.Commanding.Betting.Events.Base;
using horizonsb.api.Commanding.Betting.Servers.Base;

namespace horizonsb.api.Commanding.Betting.Events.Inbounds
{
  public class AckDetectionEventRaising : IWsInboundEventRaisingBehavior
  {
    public string Payload { get; private set; }

    public AckDetectionEventRaising(string payload)
    {
      this.Payload = payload;
    }

    public void RaiseWsEvent(WsInboundBaseServer inboundEventServer)
    {
      inboundEventServer.RaiseAckDetection( Payload);
    }
  }
}