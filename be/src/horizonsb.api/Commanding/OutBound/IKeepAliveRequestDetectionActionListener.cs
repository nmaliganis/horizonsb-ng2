using horizonsb.api.Commanding.Events.Args;
using horizonsb.api.Configurations.Commanding.Events.Args;

namespace horizonsb.api.Commanding.OutBound
{
  public interface IKeepAliveRequestDetectionActionListener
  {
    void Update(object sender, KeepAliveDetectionEventArgs e);
  }
}