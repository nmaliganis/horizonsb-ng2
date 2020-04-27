using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.api.Redis.Sports;

namespace horizonsb.api.Redis.Logs
{
  public interface ILogRedisRepository
  {
    Task<LogRedis> GetLogAsync();
    Task<LogRedis> UpdateLogAsync(LogRedis log);
  }
}
