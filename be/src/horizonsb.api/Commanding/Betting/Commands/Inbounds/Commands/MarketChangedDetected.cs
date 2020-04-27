using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Commanding.Betting.Events.Inbounds;
using horizonsb.api.Models.Live.MarketChanged;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands
{
  internal class MarketChangedDetected : WsInboundCommand
  {
    private readonly MarketChanged _marketChanged;
    private readonly string _payload;

    public MarketChangedDetected(MarketChanged marketChanged, string payload)
    {
      _marketChanged = marketChanged;
      _payload = payload;
      EventRaisingBehavior = new MarketChangedDetectionEventRaising(_marketChanged, _payload);
    }
  }
}