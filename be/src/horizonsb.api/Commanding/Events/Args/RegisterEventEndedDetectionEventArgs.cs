using System;

namespace horizonsb.api.Commanding.Events.Args
{
  public class RegisterEventEndedDetectionEventArgs : EventArgs
  {
    public string EventId { get; set; }

    public RegisterEventEndedDetectionEventArgs(string eventId)
    {
      EventId = eventId;
    }
  }
}