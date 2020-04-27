using horizonsb.api.Commanding.Betting.Events.Base;
using horizonsb.api.Commanding.Betting.Servers.Base;

namespace horizonsb.api.Commanding.Betting.Events.Inbounds
{
  public class EventWithMarketChangedDetectionEventRaising : IWsInboundEventRaisingBehavior
  {
    public string Command { get; private set; }
    public string Payload { get; private set; }

    public EventWithMarketChangedDetectionEventRaising(string command, string payload)
    {
      Command = command;
      this.Payload = payload;
    }

    public void RaiseWsEvent(WsInboundBaseServer inboundEventServer)
    {
      inboundEventServer.RaiseEventWithMarketChangedDetection(Command, Payload);
    }
  }
}