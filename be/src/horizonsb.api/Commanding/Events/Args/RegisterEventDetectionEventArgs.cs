using System;

namespace horizonsb.api.Commanding.Events.Args
{
  public class RegisterEventDetectionEventArgs : EventArgs
  {
    public string EventId { get; set; }

    public RegisterEventDetectionEventArgs(string eventId)
    {
      EventId = eventId;
    }
  }
}