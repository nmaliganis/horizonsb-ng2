using System.Collections.Generic;
using System.Threading.Tasks;

namespace horizonsb.api.Redis.Events.Live
{
  public interface ILiveRedisRepository
  {
    Task<LiveAxbRedisModel> GetLiveEuropeEventAsync(string code);
    Task<LiveMoneyLineRedisModel> GetLiveUsaEventAsync(string code);
    Task<IEnumerable<string>> GetAllLiveCodesEvents();
    Task<IEnumerable<string>> GetAllLiveCodesToBeDeletedByDateEvents(bool withDate);
    Task<IEnumerable<LiveRedisModel>> GetAllLiveEvents();
    Task<IEnumerable<LiveAxbRedisModel>> GetAllLiveEuropeEvents();
    Task<IEnumerable<LiveMoneyLineRedisModel>> GetAllLiveUsaEvents();
    Task<IEnumerable<LiveAxbRedisModel>> GetAllLiveAllEuropeEvents();
    Task<IEnumerable<LiveMoneyLineRedisModel>> GetAllLiveAllUsaEvents();


    Task<bool> CheckIfEuropeanEventExists(string code);
    Task<bool> CheckIfUsaEventExists(string code);

    Task<LiveMoneyLineRedisModel> UpdateUsaLiveEventAsync(LiveMoneyLineRedisModel liveMoneyLineRedisModel,
      bool isLivePreview);

    Task<LiveAxbRedisModel> UpdateEuropeLiveEventAsync(LiveAxbRedisModel liveAxbRedisModel, bool isLivePreview);

    Task<bool> DeleteLiveEventFromPreviewAsync(string code);
    Task<bool> DeleteLiveEventAsync(string code);
  }
}
