using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Commanding.Betting.Events.Inbounds;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands
{
  internal class ConnectedDetected : WsInboundCommand
  {
    private readonly string _payload;

    public ConnectedDetected(string payload)
    {
      _payload = payload;
      EventRaisingBehavior = new ConnectedDetectionEventRaising(_payload);
    }
  }
}