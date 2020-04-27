using horizonsb.api.Commanding.Betting.Commands.Inbounds.Commands.Base;
using horizonsb.api.Commanding.Betting.Events.Inbounds;
using horizonsb.api.Models.Live.EventChanged;

namespace horizonsb.api.Configurations.Commanding.Betting.Commands.Inbounds.Commands
{
  internal class EventChangedDetected : WsInboundCommand
  {
    private readonly string _payload;

    public EventChangedDetected(EventChanged eventChanged, string payload)
    {
      _payload = payload;
      EventRaisingBehavior = new EventChangedDetectionEventRaising(eventChanged, _payload);
    }
  }
}