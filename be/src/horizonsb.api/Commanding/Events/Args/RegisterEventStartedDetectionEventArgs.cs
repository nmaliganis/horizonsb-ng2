using System;

namespace horizonsb.api.Commanding.Events.Args
{
  public class RegisterEventStartedDetectionEventArgs : EventArgs
  {
    public string EventId { get; set; }

    public RegisterEventStartedDetectionEventArgs(string eventId)
    {
      EventId = eventId;
    }
  }
}