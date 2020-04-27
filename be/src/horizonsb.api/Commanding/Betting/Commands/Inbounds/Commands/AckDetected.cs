using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Commanding.Betting.Events.Inbounds;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands
{
  internal class AckDetected : WsInboundCommand
  {
    private readonly string _payload;

    public AckDetected( string payload)
    {
      _payload = payload;
      EventRaisingBehavior = new AckDetectionEventRaising(_payload);
    }
  }
}