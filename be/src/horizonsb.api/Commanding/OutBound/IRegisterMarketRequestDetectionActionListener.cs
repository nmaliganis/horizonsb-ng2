using horizonsb.api.Commanding.Events.Args;

namespace horizonsb.api.Commanding.OutBound
{
  public interface IRegisterMarketRequestDetectionActionListener
  {
    void Update(object sender, RegisterMarketsForEventsDetectionEventArgs e);
  }
}