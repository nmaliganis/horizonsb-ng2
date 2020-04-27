using System.Collections.Generic;
using System.Threading.Tasks;

namespace horizonsb.api.Redis.Sports
{
  public interface ISportRedisRepository
  {
    Task<SportRedis> GetSportAsync(string sportId);
    IEnumerable<string> GetSports();
    Task<SportRedis> UpdateSportAsync(SportRedis sport);
    Task<bool> DeleteSportAsync(string sportId);
  }
}
