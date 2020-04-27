using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders
{
  public class EventEndedDetectedInboundCommandBuilder : WsInboundCommandBuilder, IWsInboundCommandBuilder
  {
    private string _event;
    private string _payload;

    public WsInboundCommand Build(string payload)
    {
      _payload = payload;
      BuildMessage(payload);
      return new EventEndedDetected(_event);
    }

    public override void BuildPayload()
    {
      _event = Messages[3];
    }

    public override bool IsBuildHeader()
    {
      return false;
    }
  }
}