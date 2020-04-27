using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders
{
  public class AckDetectedInboundCommandBuilder : WsInboundCommandBuilder, IWsInboundCommandBuilder
  {
    private string _payload;

    public WsInboundCommand Build(string payload)
    {
      _payload = payload;
      BuildMessage(payload);
      return new AckDetected(Message);
    }

    public override void BuildPayload()
    {
      Message = _payload;
    }

    public override bool IsBuildHeader()
    {
      return false;
    }
  }
}