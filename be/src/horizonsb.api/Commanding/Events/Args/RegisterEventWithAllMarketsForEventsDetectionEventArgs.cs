using System;

namespace horizonsb.api.Commanding.Events.Args
{
  public class RegisterEventWithAllMarketsForEventsDetectionEventArgs : EventArgs
  {
    public string EventId { get; set; }

    public RegisterEventWithAllMarketsForEventsDetectionEventArgs(string eventId)
    {
      EventId = eventId;
    }
  }
}