using System.Collections.Generic;
using System.Threading.Tasks;

namespace horizonsb.api.Redis.Tournaments
{
  public interface ITournamentRedisRepository
  {
    Task<TournamentRedis> GetTournamentAsync(string tournamentId);
    IEnumerable<string> GetTournaments();
    Task<TournamentRedis> UpdateTournamentAsync(TournamentRedis sport);
    Task<bool> DeleteTournamentAsync(string tournamentId);
  }
}
