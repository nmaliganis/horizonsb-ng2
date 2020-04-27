using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Commanding.Betting.Events.Inbounds;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands
{
  internal class EventStartedDetected : WsInboundCommand
  {
    private readonly string _payload;

    public EventStartedDetected(string payload)
    {
      _payload = payload;
      EventRaisingBehavior = new EventStartedDetectionEventRaising(_payload);
    }
  }
}