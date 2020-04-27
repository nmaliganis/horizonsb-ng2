namespace horizonsb.api.Redis.Events
{
  public class EventRedis
  {
    public string EventId { get; set; }
    public int Priority { get; set; }

    public EventRedis(string eventId, int priority)
    {
      EventId = eventId;
      Priority = priority;
    }
  }
}
