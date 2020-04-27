using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders
{
  public class EventWithMarketChangedDetectedInboundCommandBuilder : WsInboundCommandBuilder, IWsInboundCommandBuilder
  {
    private string _payload;
    private string _command;

    public WsInboundCommand Build(string payload)
    {
      _payload = payload;
      BuildMessage(payload);
      return new EventWithMarketChangedDetected(_command, Message);
    }

    public override void BuildPayload()
    {
      _command = Messages[27];
      //Todo: Refactoring to support abstract builder for Attribute JSON
    }

    public override bool IsBuildHeader()
    {
      return true;
    }
  }
}