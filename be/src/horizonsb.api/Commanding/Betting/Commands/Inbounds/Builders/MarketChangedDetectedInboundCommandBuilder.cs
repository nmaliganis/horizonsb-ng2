using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands;
using horizonsb.api.Models.Live.MarketChanged;
using Newtonsoft.Json;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders
{
  public class MarketChangedDetectedInboundCommandBuilder : WsInboundCommandBuilder, IWsInboundCommandBuilder
  {
    private string _payload;
    private string _command;
    private MarketChanged _marketChanged;

    public WsInboundCommand Build(string payload)
    {
      _payload = payload;
      BuildMessage(payload);  
      return new MarketChangedDetected(_marketChanged, _command);
    }

    public override void BuildPayload()
    {
      _command = Messages[5];
      _marketChanged = JsonConvert.DeserializeObject<MarketChanged>(Message);
    }

    public override bool IsBuildHeader() => true;

  }
}