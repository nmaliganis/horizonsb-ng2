using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders.Base;
using horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands;
using horizonsb.api.Models.Live.EventChanged;
using Newtonsoft.Json;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Builders
{
  public class EventChangedDetectedInboundCommandBuilder : WsInboundCommandBuilder, IWsInboundCommandBuilder
  {
    private string _payload;
    private EventChanged _eventChanged;

    public WsInboundCommand Build(string payload)
    {
      _payload = payload;
      BuildMessage(payload);
      return new EventChangedDetected(_eventChanged, Message);
    }
    public override void BuildPayload()
    {
      _eventChanged = JsonConvert.DeserializeObject<EventChanged>(Message);
    }

    public override bool IsBuildHeader()
    {
      return true;
    }
  }
}