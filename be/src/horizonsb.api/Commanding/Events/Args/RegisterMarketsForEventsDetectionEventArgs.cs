using System;
using System.Collections.Generic;

namespace horizonsb.api.Commanding.Events.Args
{
  public class RegisterMarketsForEventsDetectionEventArgs : EventArgs
  {
    public string EventId { get; set; }
    public string Market { get; set; }

    public RegisterMarketsForEventsDetectionEventArgs(string eventId, string market)
    {
      EventId = eventId;
      Market = market;
    }
  }
}