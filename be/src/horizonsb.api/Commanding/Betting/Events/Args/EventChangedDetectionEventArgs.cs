using horizonsb.api.Models.Live.EventChanged;

namespace horizonsb.api.Commanding.Betting.Events.Args
{
  public class EventChangedDetectionEventArgs : System.EventArgs
  {
    public string Payload { get; private set; }
    public EventChanged EventChanged { get; private set; }

    public EventChangedDetectionEventArgs(EventChanged eventChanged, string payload)
    {
      Payload = payload;
      EventChanged = eventChanged;
    }
  }
}