using System;
using System.Collections.Generic;
using System.Linq;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.be.repository.Repositories.Base;
using horizonsb.common.infrastructure.Domain.Queries;
using horizonsb.common.infrastructure.Paging;
using NHibernate;
using NHibernate.Criterion;
using Serilog;

namespace horizonsb.be.repository.Repositories
{
  public class MarketRepository : RepositoryBase<Market, Guid>, IMarketRepository
  {
    public MarketRepository(ISession session)
      : base(session)
    {
    }

    public QueryResult<Market> FindAllMarketsPagedOf(int? pageNum = -1, int? pageSize = -1)
    {
      var query = Session.QueryOver<Market>();

      if (pageNum == -1 & pageSize == -1)
      {
        return new QueryResult<Market>(query.List().AsQueryable());
      }

      return new QueryResult<Market>(query
            .Skip(ResultsPagingUtility.CalculateStartIndex((int) pageNum, (int) pageSize))
            .Take((int) pageSize).List().AsQueryable(),
          query.ToRowCountQuery().RowCount(),
          (int) pageSize)
        ;
    }

    public Market FindByName(string name)
    {
      return (Market)
        Session.CreateCriteria(typeof(Market))
          .Add(Expression.Eq("Name", name))
          .UniqueResult()
        ;
    }

    public IList<Market> FindByMarketId(string marketId)
    {
      return
          Session.CreateCriteria(typeof(Market))
             .Add(Expression.Eq("MarketId", marketId))
              .SetCacheable(true)
              .SetCacheMode(CacheMode.Normal)
              .SetFlushMode(FlushMode.Never)
              .List<Market>()
          ;
    }

    public IList<Market> FindByMarketAllIdAndEventId(string marketId, Guid eventId)
    {
      return
          Session.CreateCriteria(typeof(Market))
             .CreateAlias("Match", "m")
             .Add(Expression.Eq("m.Id", eventId))
             .Add(Expression.Eq("MarketId", marketId))
              .SetCacheable(true)
              .SetCacheMode(CacheMode.Normal)
              .SetFlushMode(FlushMode.Never)
              .List<Market>()
          ;
    }

    public Market FindByNameAndMarketIdAndType(string name, string marketId, string type)
    {
      return (Market)
        Session.CreateCriteria(typeof(Market))
          .Add(Expression.Eq("Name", name))
          .Add(Expression.Eq("MarketId", marketId))
          .Add(Expression.Eq("Type", type))
          .UniqueResult()
        ;
    }

    public Market FindByMarketIdAndEventId(string marketId, string parentEventId)
    {
      return (Market)
        Session.CreateCriteria(typeof(Market))
          .CreateAlias("Match", "m")
          .Add(Expression.Eq("m.MatchId", parentEventId))
          .Add(Expression.Eq("MarketId", marketId))
          .UniqueResult()
        ;
    }

    public int FindCountAllMarkets()
    {
      int count = 0;
      try
      {
        count = Session
          .CreateCriteria<Market>()
          .SetProjection(
            Projections.Count(Projections.Id())
          )
          .UniqueResult<int>();

      }
      catch (Exception e)
      {
        Log.Error(
          $"FindCountAllMarkets" +
          $"Error Message:{e.Message}" +
          "--MarketRepository--  @fail@ [MarketRepository]." +
          $" @inner-fault:{e?.Message} and {e?.InnerException}");
      }
      return count;
    }

    public IList<Market> FindAllMarketsByEventId(string eventId)
    {
      return
        Session.CreateCriteria(typeof(Market))
          .CreateAlias("Match", "m")
          .Add(Expression.Eq("m.EventId", eventId))
          .SetCacheable(true)
          .SetCacheMode(CacheMode.Normal)
          .SetFlushMode(FlushMode.Never)
          .List<Market>()
        ;
    }

    public Market FindByNameAndMarketIdAndTypeAndParentEventId(string name, string marketId, string type, Guid parentEventId)
    {
      return (Market)
        Session.CreateCriteria(typeof(Market))
        .CreateAlias("Match", "m")
          .Add(Expression.Eq("Name", name))
          .Add(Expression.Eq("MarketId", marketId))
          .Add(Expression.Eq("Type", type))
          .Add(Expression.Eq("m.Id", parentEventId))
          .UniqueResult()
        ;
    }
  }
}
