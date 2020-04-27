using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Serilog;
using StackExchange.Redis;

namespace horizonsb.api.Redis.Events.Live
{
  public class LiveRedisRepository : ILiveRedisRepository
  {
    private readonly ConnectionMultiplexer _redis;
    private readonly IDatabase _database;

    public LiveRedisRepository(ConnectionMultiplexer redis)
    {
      _redis = redis;
      _database = redis.GetDatabase();
    }

    private IServer GetServer()
    {
      var endpoint = _redis.GetEndPoints();
      return _redis.GetServer(endpoint.First());
    }

    private string Serialize(object obj)
    {
      return JsonConvert.SerializeObject(obj);
    }

    private T Deserialize<T>(string serialized)
    {
      return JsonConvert.DeserializeObject<T>(serialized);
    }

    public async Task<LiveAxbRedisModel> GetLiveEuropeEventAsync(string code)
    {
      var data = await _database.StringGetAsync(code);
      if (data.IsNullOrEmpty)
      {
        return null;
      }

      var jsonObj = JsonConvert.DeserializeObject<LiveAxbRedisModel>(data);

      return jsonObj ?? new LiveAxbRedisModel();
    }

    public async Task<LiveMoneyLineRedisModel> GetLiveUsaEventAsync(string code)
    {
      var data = await _database.StringGetAsync(code);
      if (data.IsNullOrEmpty)
      {
        return null;
      }

      return JsonConvert.DeserializeObject<LiveMoneyLineRedisModel>(data);
    }

    public async Task<IEnumerable<string>> GetAllLiveCodesEvents()
    {
      IList<string> allLiveEvents = new List<string>();

      var europeLives = await GetAllLiveEuropeEvents();
      var usaLives = await GetAllLiveUsaEvents();

      foreach (var europeLife in europeLives)
      {
        allLiveEvents.Add(europeLife.Code);
      }

      foreach (var usaLife in usaLives)
      {
        allLiveEvents.Add(usaLife.Code);
      }

      return allLiveEvents;
    }

    public async Task<IEnumerable<string>> GetAllLiveCodesToBeDeletedByDateEvents(bool withDate)
    {
      IList<string> allLiveEvents = new List<string>();

      var europeLives = await GetAllLiveAllEuropeEvents();
      var usaLives = await GetAllLiveAllUsaEvents();

      foreach (var europeLife in europeLives)
      {
        if (withDate)
        {
          DateTime kickoffDate = DateTime.Parse(europeLife.kickoff_date);
          bool isBeforeYesterday = DateTime.Today - kickoffDate.Date >= TimeSpan.FromDays(2);

          if (isBeforeYesterday)
            allLiveEvents.Add(europeLife.Code);
        }
        else
        {
          if (europeLife != null)
            allLiveEvents.Add(europeLife.Code);
        }
      }

      foreach (var usaLife in usaLives)
      {
        if (withDate)
        {
          DateTime kickoffDate = DateTime.Parse(usaLife.kickoff_date);
          var isBeforeYesterday = DateTime.Today - kickoffDate.Date >= TimeSpan.FromDays(2);

          if (isBeforeYesterday)
            allLiveEvents.Add(usaLife.Code);
        }
        else
        {
          if (usaLife != null)
            allLiveEvents.Add(usaLife.Code);
        }
      }

      return allLiveEvents;
    }

    public async Task<IEnumerable<LiveRedisModel>> GetAllLiveEvents()
    {
      IList<LiveRedisModel> allLiveEvents = new List<LiveRedisModel>();

      var europeLives = await GetAllLiveEuropeEvents();
      var usaLives = await GetAllLiveUsaEvents();

      foreach (var europeLife in europeLives)
      {
        allLiveEvents.Add(europeLife);
      }

      foreach (var usaLife in usaLives)
      {
        allLiveEvents.Add(usaLife);
      }

      return allLiveEvents;
    }

    public async Task<IEnumerable<LiveAxbRedisModel>> GetAllLiveEuropeEvents()
    {
      List<string> eCodes = new List<string>();

      var eTypes = await _database.StringGetAsync("e-type");
      if (!eTypes.IsNullOrEmpty)
      {
        eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
      }

      IList<LiveAxbRedisModel> storedLiveEvents = new List<LiveAxbRedisModel>();

      foreach (var eCode in eCodes)
      {
        var liveEvent = await GetLiveEuropeEventAsync(eCode);
        storedLiveEvents.Add(liveEvent);
      }

      return storedLiveEvents;
    }

    public async Task<IEnumerable<LiveMoneyLineRedisModel>> GetAllLiveUsaEvents()
    {
      List<string> eCodes = new List<string>();

      var eTypes = await _database.StringGetAsync("u-type");
      if (!eTypes.IsNullOrEmpty)
      {
        eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
      }

      IList<LiveMoneyLineRedisModel> storedLiveEvents = new List<LiveMoneyLineRedisModel>();

      foreach (var eCode in eCodes)
      {
        var liveEvent = await GetLiveUsaEventAsync(eCode);
        storedLiveEvents.Add(liveEvent);
      }

      return storedLiveEvents;
    }

    public async Task<IEnumerable<LiveAxbRedisModel>> GetAllLiveAllEuropeEvents()
    {
      List<string> eCodes = new List<string>();

      var eTypes = await _database.StringGetAsync("e-type-a");
      if (!eTypes.IsNullOrEmpty)
      {
        eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
      }

      IList<LiveAxbRedisModel> storedLiveEvents = new List<LiveAxbRedisModel>();

      foreach (var eCode in eCodes)
      {
        var liveEvent = await GetLiveEuropeEventAsync(eCode);
        storedLiveEvents.Add(liveEvent);
      }

      return storedLiveEvents;
    }

    public async Task<IEnumerable<LiveMoneyLineRedisModel>> GetAllLiveAllUsaEvents()
    {
      List<string> eCodes = new List<string>();

      var eTypes = await _database.StringGetAsync("u-type-a");
      if (!eTypes.IsNullOrEmpty)
      {
        eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
      }

      IList<LiveMoneyLineRedisModel> storedLiveEvents = new List<LiveMoneyLineRedisModel>();

      foreach (var eCode in eCodes)
      {
        var liveEvent = await GetLiveUsaEventAsync(eCode);
        storedLiveEvents.Add(liveEvent);
      }

      return storedLiveEvents;
    }

    public async Task<bool> CheckIfEuropeanEventExists(string code)
    {
      var eTypes = await _database.StringGetAsync("e-type-a");
      if (!eTypes.IsNullOrEmpty)
      {
        var eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
        if (eCodes.Contains(code))
          return true;
      }

      return false;
    }

    public async Task<bool> CheckIfUsaEventExists(string code)
    {
      var eTypes = await _database.StringGetAsync("u-type-a");
      if (!eTypes.IsNullOrEmpty)
      {
        var eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
        if (eCodes.Contains(code))
          return true;
      }

      return false;
    }

    public async Task<LiveMoneyLineRedisModel> UpdateUsaLiveEventAsync(
      LiveMoneyLineRedisModel liveMoneyLineRedisModel, bool isLivePreview)
    {
      if (string.IsNullOrEmpty(liveMoneyLineRedisModel.Code))
        return null;

      List<string> eCodes = new List<string>();

      var eTypes = await _database.StringGetAsync("u-type-a");
      if (!eTypes.IsNullOrEmpty)
      {
        eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
      }

      if (!eCodes.Contains(liveMoneyLineRedisModel.Code))
      {
        eCodes.Add(liveMoneyLineRedisModel.Code);
        var createdCodeList = await _database.StringSetAsync("u-type-a", Serialize(eCodes));
        if (!createdCodeList)
        {
          Log.Error("Problem occured persisting the liveMoneyLineRedisModel new Event.");
          return null;
        }
      }

      if (isLivePreview)
      {
        eTypes = await _database.StringGetAsync("u-type");
        if (!eTypes.IsNullOrEmpty)
        {
          eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
        }

        if (!eCodes.Contains(liveMoneyLineRedisModel.Code))
        {
          eCodes.Add(liveMoneyLineRedisModel.Code);
          var createdCodeList = await _database.StringSetAsync("u-type", Serialize(eCodes));
          if (!createdCodeList)
          {
            Log.Error("Problem occured persisting the LiveAxbRedisModel new Event.");
            return null;
          }
        }
      }


      var created =
        await _database.StringSetAsync(liveMoneyLineRedisModel.Code, Serialize(liveMoneyLineRedisModel));

      if (!created)
      {
        Log.Information("Problem occured persisting the liveMoneyLineRedisModel new Event.");
        return null;
      }

      Log.Information("liveMoneyLineRedisModel item persisted successfully.");

      return await GetLiveUsaEventAsync(liveMoneyLineRedisModel.Code);
    }

    public async Task<LiveAxbRedisModel> UpdateEuropeLiveEventAsync(LiveAxbRedisModel liveAxbRedisModel,
      bool isLivePreview)
    {
      if (string.IsNullOrEmpty(liveAxbRedisModel.Code))
        return null;

      List<string> eCodes = new List<string>();

      var eTypes = await _database.StringGetAsync("e-type-a");
      if (!eTypes.IsNullOrEmpty)
      {
        eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
      }

      if (!eCodes.Contains(liveAxbRedisModel.Code))
      {
        eCodes.Add(liveAxbRedisModel.Code);
        var createdCodeList = await _database.StringSetAsync("e-type-a", Serialize(eCodes));
        if (!createdCodeList)
        {
          Log.Error("Problem occured persisting the LiveAxbRedisModel new Event.");
          return null;
        }
      }

      if (isLivePreview)
      {
        eTypes = await _database.StringGetAsync("e-type");
        if (!eTypes.IsNullOrEmpty)
        {
          eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
        }

        if (!eCodes.Contains(liveAxbRedisModel.Code))
        {
          eCodes.Add(liveAxbRedisModel.Code);
          var createdCodeList = await _database.StringSetAsync("e-type", Serialize(eCodes));
          if (!createdCodeList)
          {
            Log.Error("Problem occured persisting the LiveAxbRedisModel new Event.");
            return null;
          }
        }
      }

      var created = await _database.StringSetAsync(liveAxbRedisModel.Code, Serialize(liveAxbRedisModel));

      if (!created)
      {
        Log.Error("Problem occured persisting the LiveAxbRedisModel new Event.");
        return null;
      }

      Log.Information("LiveAxbRedisModel item persisted successfully.");

      return await GetLiveEuropeEventAsync(liveAxbRedisModel.Code);
    }

    public async Task<bool> DeleteLiveEventFromPreviewAsync(string code)
    {
      List<string> eCodes = new List<string>();

      var eTypes = await _database.StringGetAsync("e-type");
      if (!eTypes.IsNullOrEmpty)
      {
        eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
      }

      if (!eCodes.Contains(code))
      {
        Log.Error("Nothing to Delete");
        return true;
      }
      else if (eCodes.Contains(code))
      {
        eCodes.Remove(code);
        var updatedCodeList = await _database.StringSetAsync("e-type", Serialize(eCodes));
        if (!updatedCodeList)
        {
          Log.Error("Problem occured persisting the new updated e-type Event List.");
          return false;
        }
      }

      return true;
    }

    public async Task<bool> DeleteLiveEventAsync(string code)
    {
      List<string> eCodes = new List<string>();
      List<string> uCodes = new List<string>();

      var eTypes = await _database.StringGetAsync("e-type-a");
      if (!eTypes.IsNullOrEmpty)
      {
        eCodes = JsonConvert.DeserializeObject<List<string>>(eTypes);
      }

      if (eCodes.Contains(code))
      {
        eCodes.Remove(code);
        var updatedCodeList = await _database.StringSetAsync("e-type-a", Serialize(eCodes));
        if (!updatedCodeList)
        {
          Log.Error("Problem occured persisting the new updated e-type-a Event List.");
          return false;
        }

        var eTypesPreview = await _database.StringGetAsync("e-type");

        if (!eTypesPreview.IsNullOrEmpty)
        {
          var eCodesPreview = JsonConvert.DeserializeObject<List<string>>(eTypesPreview);
          if (eCodesPreview.Contains(code))
          {
            eCodesPreview.Remove(code);
            var updatedCodePreviewList = await _database.StringSetAsync("e-type", Serialize(eCodesPreview));
            if (!updatedCodePreviewList)
            {
              Log.Error("Problem occured persisting the new updated e-type Event List.");
              return false;
            }
          }
        }

        await _database.KeyDeleteAsync(code);
      }


      var uTypes = await _database.StringGetAsync("u-type-a");
      if (!uTypes.IsNullOrEmpty)
      {
        uCodes = JsonConvert.DeserializeObject<List<string>>(uTypes);
      }

      if (uCodes.Contains(code))
      {
        uCodes.Remove(code);
        var updatedCodeList = await _database.StringSetAsync("u-type-a", Serialize(uCodes));
        if (!updatedCodeList)
        {
          Log.Error("Problem occured persisting the new updated u-type Event List.");
          return false;
        }

        var uTypesPreview = await _database.StringGetAsync("u-type");

        if (!uTypesPreview.IsNullOrEmpty)
        {
          var uCodesPreview = JsonConvert.DeserializeObject<List<string>>(uTypesPreview);
          if (uCodesPreview.Contains(code))
          {
            uCodesPreview.Remove(code);
            var updatedCodePreviewList = await _database.StringSetAsync("u-type", Serialize(uCodesPreview));
            if (!updatedCodePreviewList)
            {
              Log.Error("Problem occured persisting the new updated u-type Event List.");
              return false;
            }
          }
        }

        await _database.KeyDeleteAsync(code);
      }

      return true;
    }
  }
}
