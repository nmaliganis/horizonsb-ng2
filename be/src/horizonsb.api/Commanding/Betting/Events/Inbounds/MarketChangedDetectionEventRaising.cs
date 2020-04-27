using horizonsb.api.Commanding.Betting.Events.Base;
using horizonsb.api.Commanding.Betting.Servers.Base;
using horizonsb.api.Models.Live.MarketChanged;

namespace horizonsb.api.Commanding.Betting.Events.Inbounds
{
  public class MarketChangedDetectionEventRaising : IWsInboundEventRaisingBehavior
  {
    public MarketChanged MarketChanged { get; }
    public string Payload { get; private set; }

    public MarketChangedDetectionEventRaising(MarketChanged marketChanged, string payload)
    {
      MarketChanged = marketChanged;
      this.Payload = payload;
    }

    public void RaiseWsEvent(WsInboundBaseServer inboundEventServer)
    {
      inboundEventServer.RaiseMarketChangedDetection(MarketChanged, Payload);
    }
  }
}