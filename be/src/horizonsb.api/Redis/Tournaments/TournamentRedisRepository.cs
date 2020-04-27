using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Serilog;
using StackExchange.Redis;

namespace horizonsb.api.Redis.Tournaments
{
  public class TournamentRedisRepository : ITournamentRedisRepository
  {
    private readonly ConnectionMultiplexer _redis;
    private readonly IDatabase _database;

    public TournamentRedisRepository(ConnectionMultiplexer redis)
    {
      _redis = redis;
      _database = redis.GetDatabase();
    }

    public async Task<bool> DeleteTournamentAsync(string tournamentId)
    {
      return await _database.KeyDeleteAsync(tournamentId);
    }

    public IEnumerable<string> GetTournaments()
    {
      var server = GetServer();
      var data = server.Keys();
      return data?.Select(k => k.ToString());
    }

    public async Task<TournamentRedis> GetTournamentAsync(string tournamentId)
    {
      var data = await _database.StringGetAsync(tournamentId);
      if (data.IsNullOrEmpty)
      {
        return null;
      }

      return new TournamentRedis(tournamentId, Int32.Parse(data));
      //return JsonConvert.DeserializeObject<Cart>(data);
    }

    public async Task<TournamentRedis> UpdateTournamentAsync(TournamentRedis sport)
    {
      var created = await _database.StringSetAsync(sport.TournamentId, sport.Priority);

      if (!created)
      {
        Log.Information("Problem occured persisting the Priority.");
        return null;
      }

      Log.Information("Tournament item persisted successfully.");

      return await GetTournamentAsync(sport.TournamentId);
    }

    private IServer GetServer()
    {
      var endpoint = _redis.GetEndPoints();
      return _redis.GetServer(endpoint.First());
    }
  }
}
