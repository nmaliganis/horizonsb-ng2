using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace horizonsb.api.Redis.Events
{
  public interface IEventRedisRepository
  {
    Task<EventRedis> GetEventAsync(string eventId);
    IEnumerable<string> GetEvents();
    Task<EventRedis> UpdateEventAsync(EventRedis sport);
    Task<bool> DeleteEventAsync(string eventId);
  }
}
