namespace horizonsb.api.Commanding.Betting.Events.Args
{
  public class EventEndedDetectionEventArgs : System.EventArgs
  {
    public string Payload { get; private set; }

    public EventEndedDetectionEventArgs(string payload)
    {
      this.Payload = payload;
    }
  }
}