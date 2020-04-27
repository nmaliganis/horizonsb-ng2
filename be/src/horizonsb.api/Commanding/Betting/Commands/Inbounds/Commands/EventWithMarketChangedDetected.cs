using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Commanding.Betting.Events.Inbounds;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands
{
  internal class EventWithMarketChangedDetected : WsInboundCommand
  {
    private readonly string _command;
    private readonly string _payload;

    public EventWithMarketChangedDetected(string command, string payload)
    {
      _command = command;
      _payload = payload;
      EventRaisingBehavior = new EventWithMarketChangedDetectionEventRaising(_command, _payload);
    }
  }
}