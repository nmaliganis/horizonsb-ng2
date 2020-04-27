using horizonsb.api.Commanding.Betting.Events.Args;
using horizonsb.api.Configurations.Commanding.Betting.Events.Args;

namespace horizonsb.api.Commanding.Betting.Listeners
{
  public interface IConnectedDetectionActionListener
  {
    void Update(object sender, ConnectedDetectionEventArgs e);
  }
  public interface IAckDetectionActionListener
  {
    void Update(object sender, AckDetectionEventArgs e);
  }
  public interface IEventChangedDetectionActionListener
  {
    void Update(object sender, EventChangedDetectionEventArgs e);
  }
  public interface IEventWithMarketChangedDetectionActionListener
  {
    void Update(object sender, EventWithMarketChangedDetectionEventArgs e);
  }
  public interface IMarketChangedDetectionActionListener
  {
    void Update(object sender, MarketChangedDetectionEventArgs e);
  }
  public interface IEventStartedDetectionActionListener
  {
    void Update(object sender, EventStartedDetectionEventArgs e);
  }
  public interface IEventEndedDetectionActionListener
  {
    void Update(object sender, EventEndedDetectionEventArgs e);
  }
}