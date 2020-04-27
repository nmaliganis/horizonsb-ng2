using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Commanding.Betting.Events.Inbounds;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands
{
  internal class EventEndedDetected : WsInboundCommand
  {
    private readonly string _payload;

    public EventEndedDetected(string payload)
    {
      _payload = payload;
      EventRaisingBehavior = new EventEndedDetectionEventRaising(_payload);
    }
  }
}