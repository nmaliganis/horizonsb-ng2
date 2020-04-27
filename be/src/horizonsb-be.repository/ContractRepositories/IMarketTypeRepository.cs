using System;
using horizonsb.be.model.MarketTypes;
using horizonsb.common.infrastructure.Domain;

namespace horizonsb.be.repository.ContractRepositories
{
  public interface IMarketTypeRepository : IRepository<MarketType, Guid>
  {
    MarketType FindBySportId(string sportId);
  }
}
