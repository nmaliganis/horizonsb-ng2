using System;
using System.Collections.Generic;
using System.Linq;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.model.Events.Markets.Odds;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.be.repository.Repositories.Base;
using horizonsb.common.infrastructure.Domain.Queries;
using horizonsb.common.infrastructure.Paging;
using NHibernate;
using NHibernate.Criterion;
using Serilog;

namespace horizonsb.be.repository.Repositories
{
  public class OddRepository : RepositoryBase<Odd, Guid>, IOddRepository
  {
    public OddRepository(ISession session)
      : base(session)
    {
    }

    public QueryResult<Odd> FindAllOddsPagedOf(int? pageNum = -1, int? pageSize = -1)
    {
      var query = Session.QueryOver<Odd>();

      if (pageNum == -1 & pageSize == -1)
      {
        return new QueryResult<Odd>(query.List().AsQueryable());
      }

      return new QueryResult<Odd>(query
            .Skip(ResultsPagingUtility.CalculateStartIndex((int) pageNum, (int) pageSize))
            .Take((int) pageSize).List().AsQueryable(),
          query.ToRowCountQuery().RowCount(),
          (int) pageSize)
        ;
    }

    public Odd FindByName(string name)
    {
      return (Odd)
        Session.CreateCriteria(typeof(Odd))
          .Add(Expression.Eq("Name", name))
          .UniqueResult()
        ;
    }

    public Odd FindByOddId(string sportId)
    {
      return (Odd)
        Session.CreateCriteria(typeof(Odd))
          .Add(Expression.Eq("OddId", sportId))
          .UniqueResult()
        ;
    }

    public IList<Odd> FindByNameAndOddId(string name, string sportId)
    {
      return
        Session.CreateCriteria(typeof(Odd))
          .Add(Expression.Eq("Name", name))
          .Add(Expression.Eq("OddId", sportId))
          .SetCacheable(true)
          .SetCacheMode(CacheMode.Normal)
          .SetFlushMode(FlushMode.Never)
          .List<Odd>()
          ;
    }

    public int FindCountAllOdds()
    {
      int count = 0;
      try
      {
        count = Session
          .CreateCriteria<Odd>()
          .SetProjection(
            Projections.Count(Projections.Id())
          )
          .UniqueResult<int>();

      }
      catch (Exception e)
      {
        Log.Error(
          $"FindCountAllOdds" +
          $"Error Message:{e.Message}" +
          "--OddRepository--  @fail@ [OddRepository]." +
          $" @inner-fault:{e?.Message} and {e?.InnerException}");
      }
      return count;
    }
  }
}
