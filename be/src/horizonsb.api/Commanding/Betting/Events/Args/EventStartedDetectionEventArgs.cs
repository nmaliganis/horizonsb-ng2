namespace horizonsb.api.Commanding.Betting.Events.Args
{
  public class EventStartedDetectionEventArgs : System.EventArgs
  {
    public string Payload { get; private set; }

    public EventStartedDetectionEventArgs(string payload)
    {
      this.Payload = payload;
    }
  }
}