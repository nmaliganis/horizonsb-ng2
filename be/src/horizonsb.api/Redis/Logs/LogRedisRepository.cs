using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Serilog;
using StackExchange.Redis;

namespace horizonsb.api.Redis.Logs
{
    public class LogRedisRepository : ILogRedisRepository
    {
        private readonly ConnectionMultiplexer _redis;
        private readonly IDatabase _database;

        public LogRedisRepository(ConnectionMultiplexer redis)
        {
            _redis = redis;
            _database = redis.GetDatabase();
        }

        private string Serialize(object obj)
        {
            return JsonConvert.SerializeObject(obj);
        }

        public async Task<LogRedis> GetLogAsync()
        {
            var data = await _database.StringGetAsync("log");
            if (data.IsNullOrEmpty)
            {
                return null;
            }

            var jsonObj = JsonConvert.DeserializeObject<LogRedis>(data);
            return jsonObj ?? new LogRedis();
        }

        public async Task<LogRedis> UpdateLogAsync(LogRedis log)
        {
            var logRedis = await _database.StringGetAsync("log");
            var logData = new LogRedis();
            if (!logRedis.IsNullOrEmpty)
            {
                logData = JsonConvert.DeserializeObject<LogRedis>(logRedis);
            }

            logData.Id = log.Id ?? logData.Id;
            logData.Created = log.Created ?? logData.Created;
            logData.LastModified = log.LastModified ?? logData.LastModified;
            logData.LastModifiedPostgres = log.LastModifiedPostgres ?? logData.LastModifiedPostgres;
            logData.LastModifiedUpcomingLive = log.LastModifiedUpcomingLive ?? logData.LastModifiedUpcomingLive;
            logData.LastModifiedWs = log.LastModifiedWs ?? logData.LastModifiedWs;
            logData.LastModifiedClearCache = log.LastModifiedClearCache ?? logData.LastModifiedClearCache;
            logData.LastModifiedEventChanged = log.LastModifiedEventChanged ?? logData.LastModifiedEventChanged;
            logData.LastModifiedChangedEventId = log.LastModifiedChangedEventId ?? logData.LastModifiedChangedEventId;
            logData.LastModifiedMarketChanged = log.LastModifiedMarketChanged ?? logData.LastModifiedEventChanged;
            logData.LastModifiedChangedMarketId = log.LastModifiedChangedMarketId ?? logData.LastModifiedChangedMarketId;

            var createdOrUpdated = await _database.StringSetAsync("log", Serialize(logData));

            if (!createdOrUpdated)
            {
                Log.Error("Problem occured persisting the UpdateLogAsync");
                return null;
            }

            Log.Information("UpdateLogAsync item persisted successfully.");

            return logData;
        }
    }
}
