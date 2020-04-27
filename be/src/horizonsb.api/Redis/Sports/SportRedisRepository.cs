using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Serilog;
using StackExchange.Redis;

namespace horizonsb.api.Redis.Sports
{
  public class SportRedisRepository : ISportRedisRepository
  {
    private readonly ConnectionMultiplexer _redis;
    private readonly IDatabase _database;

    public SportRedisRepository(ConnectionMultiplexer redis)
    {
      _redis = redis;
      _database = redis.GetDatabase();
    }

    public async Task<bool> DeleteSportAsync(string sportId)
    {
      return await _database.KeyDeleteAsync(sportId);
    }

    public IEnumerable<string> GetSports()
    {
      var server = GetServer();
      var data = server.Keys();
      return data?.Select(k => k.ToString());
    }

    public async Task<SportRedis> GetSportAsync(string sportId)
    {
      var data = await _database.StringGetAsync(sportId);
      if (data.IsNullOrEmpty)
      {
        return null;
      }

      return new SportRedis(sportId, Int32.Parse(data));
      //return JsonConvert.DeserializeObject<Cart>(data);
    }

    public async Task<SportRedis> UpdateSportAsync(SportRedis sport)
    {
      var created = await _database.StringSetAsync(sport.SportId, sport.Priority);

      if (!created)
      {
        Log.Information("Problem occured persisting the Priority.");
        return null;
      }

      Log.Information("Sport item persisted successfully.");

      return await GetSportAsync(sport.SportId);
    }

    private IServer GetServer()
    {
      var endpoint = _redis.GetEndPoints();
      return _redis.GetServer(endpoint.First());
    }
  }
}
