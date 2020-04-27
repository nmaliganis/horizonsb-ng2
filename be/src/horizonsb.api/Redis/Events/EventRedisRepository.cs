using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Serilog;
using StackExchange.Redis;

namespace horizonsb.api.Redis.Events
{
  public class EventRedisRepository : IEventRedisRepository
  {
    private readonly ConnectionMultiplexer _redis;
    private readonly IDatabase _database;

    public EventRedisRepository(ConnectionMultiplexer redis)
    {
      _redis = redis;
      _database = redis.GetDatabase();
    }

    public async Task<bool> DeleteEventAsync(string eventId)
    {
      return await _database.KeyDeleteAsync(eventId);
    }

    public IEnumerable<string> GetEvents()
    {
      var server = GetServer();
      var data = server.Keys();
      return data?.Select(k => k.ToString());
    }



    public async Task<EventRedis> GetEventAsync(string eventId)
    {
      var data = await _database.StringGetAsync(eventId);
      if (data.IsNullOrEmpty)
      {
        return null;
      }

      return new EventRedis(eventId, Int32.Parse(data));
      //return JsonConvert.DeserializeObject<Cart>(data);
    }

    public async Task<EventRedis> UpdateEventAsync(EventRedis sport)
    {
      var created = await _database.StringSetAsync(sport.EventId, sport.Priority);

      if (!created)
      {
        Log.Information("Problem occured persisting the Priority.");
        return null;
      }

      Log.Information("Event item persisted successfully.");

      return await GetEventAsync(sport.EventId);
    }

    private IServer GetServer()
    {
      var endpoint = _redis.GetEndPoints();
      return _redis.GetServer(endpoint.First());
    }
  }
}
