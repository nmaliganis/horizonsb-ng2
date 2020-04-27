using horizonsb.api.Commanding.Events.Args;
using horizonsb.api.Configurations.Commanding.Events.Args;

namespace horizonsb.api.Commanding.Inbound
{
  public interface IKeepAliveResponseDetectionActionListener
  {
    void Update(object sender, KeepAliveDetectionEventArgs e);
  }
}