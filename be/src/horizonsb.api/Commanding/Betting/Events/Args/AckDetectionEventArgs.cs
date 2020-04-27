namespace horizonsb.api.Configurations.Commanding.Betting.Events.Args
{
  public class AckDetectionEventArgs : System.EventArgs
  {
    public string Payload { get; private set; }

    public AckDetectionEventArgs(string payload)
    {
      this.Payload = payload;
    }
  }
}