namespace horizonsb.api.Commanding.Betting.Events.Args
{
  public class EventWithMarketChangedDetectionEventArgs : System.EventArgs
  {
    public string Command { get; private set; }
    public string Payload { get; private set; }

    public EventWithMarketChangedDetectionEventArgs(string command, string payload)
    {
      this.Command = command;
      this.Payload = payload;
    }
  }
}