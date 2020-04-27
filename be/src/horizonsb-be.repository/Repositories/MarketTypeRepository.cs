using System;
using horizonsb.be.model.Events;
using horizonsb.be.model.MarketTypes;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.be.repository.Repositories.Base;
using NHibernate;
using NHibernate.Criterion;

namespace horizonsb.be.repository.Repositories
{
  public class MarketTypeRepository : RepositoryBase<MarketType, Guid>, IMarketTypeRepository
  {
    public MarketTypeRepository(ISession session)
      : base(session)
    {
    }

    public MarketType FindBySportId(string sportId)
    {
      return
        (MarketType)
        Session.CreateCriteria(typeof(MarketType))
          .Add(Expression.Eq("SportId", sportId))
          .SetCacheable(true)
          .SetCacheMode(CacheMode.Normal)
          .SetFlushMode(FlushMode.Never)
          .UniqueResult<MarketType>()
        ;
    }
  }
}
