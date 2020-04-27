using horizonsb.api.Commanding.Events.Args;

namespace horizonsb.api.Commanding.OutBound
{
  public interface IRegisterEventWithAllMarketRequestDetectionActionListener
  {
    void Update(object sender, RegisterEventWithAllMarketsForEventsDetectionEventArgs e);
  }
}