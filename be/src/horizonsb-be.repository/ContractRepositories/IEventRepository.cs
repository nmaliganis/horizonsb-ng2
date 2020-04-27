using System;
using System.Collections.Generic;
using horizonsb.be.model.Events;
using horizonsb.common.infrastructure.Domain;
using horizonsb.common.infrastructure.Domain.Queries;

namespace horizonsb.be.repository.ContractRepositories
{
  public interface IEventRepository : IRepository<Match, Guid>
  {
    QueryResult<Match> FindAllLiveEventsPagedOf(int? pageNum, int? pageSize);
    QueryResult<Match> FindAllEventsPagedOf(int? pageNum, int? pageSize);
    QueryResult<Match> FindAllFavoriteEventsPagedOf(int? pageNum, int? pageSize);
    Match FindByName(string name);
    Match FindOneByEventId(string eventId);
    Match FindOneByEventCode(string eventCode);
    Match FindOneByMarketLegacyId(string marketLegacyId);
    IList<Match> FindByEventId(string eventId);
    IList<Match> FindByEventIdAndCode(string eventId, string code);
    void DeleteBatchEvents();
    int FindCountAllEvents();
    int FindCountPrioritizedEvents();
    int FindCountFavoritesEvents();
    int FindCountLivePrioritizedEvents();

    int FindCountUpcomingLiveEvents();
    int FindCountLiveEvents();

    IList<Match> FindAllUpcomingEvent();
    IList<Match> FindAllFavorites();
    IList<Match> FindAllLivesOrUpcoming();
    IList<Match> FindAllForRegister();
  }
}
