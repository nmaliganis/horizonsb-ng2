using System;
using System.Collections.Generic;
using horizonsb.be.model.Events.Markets;
using horizonsb.common.infrastructure.Domain;
using horizonsb.common.infrastructure.Domain.Queries;

namespace horizonsb.be.repository.ContractRepositories
{
  public interface IMarketRepository : IRepository<Market, Guid>
  {
    QueryResult<Market> FindAllMarketsPagedOf(int? pageNum, int? pageSize);
    Market FindByName(string name);
    IList<Market> FindByMarketId(string marketId);
    Market FindByNameAndMarketIdAndType(string name, string marketId, string type);
    Market FindByNameAndMarketIdAndTypeAndParentEventId(string name, string marketId, string type, Guid parentEventId);

    Market FindByMarketIdAndEventId(string marketId, string parentEventId);
    IList<Market> FindByMarketAllIdAndEventId(string marketId, Guid eventId);

    int FindCountAllMarkets();
    IList<Market> FindAllMarketsByEventId(string eventId);
  }
}
