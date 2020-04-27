using horizonsb.api.Commanding.Events.Args;

namespace horizonsb.api.Commanding.OutBound
{
  public interface IRegisterEventRequestDetectionActionListener
  {
    void Update(object sender, RegisterEventDetectionEventArgs e);
  }
  public interface IRegisterEventStartedRequestDetectionActionListener
  {
    void Update(object sender, RegisterEventStartedDetectionEventArgs e);
  }
  public interface IRegisterEventEndedRequestDetectionActionListener
  {
    void Update(object sender, RegisterEventEndedDetectionEventArgs e);
  }
}