using System;
using System.Collections.Generic;
using System.Linq;
using horizonsb.be.model.Sports;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.be.repository.Repositories.Base;
using horizonsb.common.infrastructure.Domain.Queries;
using horizonsb.common.infrastructure.Paging;
using NHibernate;
using NHibernate.Criterion;
using Serilog;

namespace horizonsb.be.repository.Repositories
{
  public class SportRepository : RepositoryBase<Sport, Guid>, ISportRepository
  {
    public SportRepository(ISession session)
      : base(session)
    {
    }

    public QueryResult<Sport> FindAllSportsPagedOf(int? pageNum = -1, int? pageSize = -1)
    {
      var query = Session.QueryOver<Sport>();

      if (pageNum == -1 & pageSize == -1)
      {
        return new QueryResult<Sport>(query.List().AsQueryable());
      }

      var pagedResults = new QueryResult<Sport>(query
          .Skip(ResultsPagingUtility.CalculateStartIndex((int) pageNum, (int) pageSize))
          .Take((int) pageSize).List().AsQueryable(),
        query.ToRowCountQuery().RowCount(),
        (int) pageSize);

      return pagedResults;
    }

    public Sport FindByName(string name)
    {
      return (Sport)
        Session.CreateCriteria(typeof(Sport))
          .Add(Expression.Eq("Name", name))
          .UniqueResult()
        ;
    }

    public Sport FindBySportId(string sportId)
    {
      return (Sport)
        Session.CreateCriteria(typeof(Sport))
          .Add(Expression.Eq("SportId", sportId))
          .UniqueResult()
        ;
    }

    public int FindCountAllSports()
    {
      int count = 0;
      try
      {
        count = Session
          .CreateCriteria<Sport>()
          .SetProjection(
            Projections.Count(Projections.Id())
          )
          .UniqueResult<int>();

      }
      catch (Exception e)
      {
        Log.Error(
          $"FindCountAllSports" +
          $"Error Message:{e.Message}" +
          "--SportRepository--  @fail@ [SportRepository]." +
          $" @inner-fault:{e?.Message} and {e?.InnerException}");
      }
      return count;
    }


    public int FindCountPrioritizedSports()
    {
      int count = 0;
      try
      {
        count = Session
          .CreateCriteria<Sport>()
          .Add(Expression.Gt("Priority", 1))
          .SetProjection(
            Projections.Count(Projections.Id())
          )
          .UniqueResult<int>();
      }
      catch (Exception e)
      {
        Log.Error(
          $"FindCountPrioritizedSports" +
          $"Error Message:{e.Message}" +
          "--SportRepository--  @fail@ [SportRepository]." +
          $" @inner-fault:{e?.Message} and {e?.InnerException}");
      }

      return count;
    }

    public void DeleteBatchSports()
    {
      try
      {
        Session.CreateQuery("DELETE FROM Sport").ExecuteUpdate();
      }
      catch (Exception e)
      {
      }
    }
  }
}
