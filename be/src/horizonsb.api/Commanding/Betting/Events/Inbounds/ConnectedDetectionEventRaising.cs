using horizonsb.api.Commanding.Betting.Events.Base;
using horizonsb.api.Commanding.Betting.Servers.Base;

namespace horizonsb.api.Commanding.Betting.Events.Inbounds
{
  public class ConnectedDetectionEventRaising : IWsInboundEventRaisingBehavior
  {
    public string Payload { get; private set; }

    public ConnectedDetectionEventRaising(string payload)
    {
      this.Payload = payload;
    }

    public void RaiseWsEvent(WsInboundBaseServer inboundEventServer)
    {
      inboundEventServer.RaiseConnectedDetection(Payload);
    }
  }
}