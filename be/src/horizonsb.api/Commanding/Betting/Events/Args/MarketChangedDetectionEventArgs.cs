using horizonsb.api.Models.Live.MarketChanged;

namespace horizonsb.api.Commanding.Betting.Events.Args
{
  public class MarketChangedDetectionEventArgs : System.EventArgs
  {
    public MarketChanged MarketChanged { get; private set; }
    public string Payload { get; private set; }

    public MarketChangedDetectionEventArgs(MarketChanged marketChanged,string payload)
    {
      this.MarketChanged = marketChanged;
      this.Payload = payload;
    }
  }
}