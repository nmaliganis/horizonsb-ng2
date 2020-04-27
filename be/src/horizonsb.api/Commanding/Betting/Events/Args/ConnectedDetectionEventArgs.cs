namespace horizonsb.api.Commanding.Betting.Events.Args
{
  public class ConnectedDetectionEventArgs : System.EventArgs
  {
    public string Payload { get; private set; }

    public ConnectedDetectionEventArgs(string payload)
    {
      this.Payload = payload;
    }
  }
}