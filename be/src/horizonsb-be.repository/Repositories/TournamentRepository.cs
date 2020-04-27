using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using horizonsb.be.model.Categories;
using horizonsb.be.model.Sports;
using horizonsb.be.model.Tournaments;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.be.repository.Repositories.Base;
using horizonsb.common.infrastructure.Domain.Queries;
using horizonsb.common.infrastructure.Paging;
using NHibernate;
using NHibernate.Criterion;
using Serilog;

namespace horizonsb.be.repository.Repositories
{
  public class TournamentRepository : RepositoryBase<Tournament, Guid>, ITournamentRepository
  {
    public TournamentRepository(ISession session)
      : base(session)
    {
    }

    public QueryResult<Tournament> FindAllTournamentsPagedOf(int? pageNum = -1, int? pageSize = -1)
    {
      var query = Session.QueryOver<Tournament>();

      //if (pageNum == -1 & pageSize == -1)
      //{
      return new QueryResult<Tournament>(query.List().AsQueryable());
      //}

      //return new QueryResult<Tournament>(query
      //      .Skip(ResultsPagingUtility.CalculateStartIndex((int) pageNum/10 + 1, (int) pageSize))
      //      .Take((int) pageSize).List().AsQueryable(),
      //    query.ToRowCountQuery().RowCount(),
      //    (int) pageSize)
      //  ;
    }

    public QueryResult<Tournament> FindAllTournamentsWithSportIdPagedOf(Guid sportId, int? pageNum, int? pageSize)
    {
      var query = Session.QueryOver<Tournament>()
        .JoinQueryOver<Category>(t => t.Category)
        .JoinQueryOver<Sport>(c => c.Sport)
        .Where(s => s.Id == sportId);

      if (pageNum == -1 & pageSize == -1)
      {
        return new QueryResult<Tournament>(query.List().AsQueryable());
      }

      return new QueryResult<Tournament>(query
            .Skip(ResultsPagingUtility.CalculateStartIndex((int) pageNum, (int) pageSize))
            .Take((int) pageSize).List().AsQueryable(),
          query.ToRowCountQuery().RowCount(),
          (int) pageSize)
        ;
    }

    public QueryResult<Tournament> FindAllTournamentsWithSportNamePagedOf(string sportName, int? pageNum,
      int? pageSize)
    {
      var query = Session.QueryOver<Tournament>()
        .JoinQueryOver<Category>(t => t.Category)
        .JoinQueryOver<Sport>(c => c.Sport)
        .Where(s => s.Name == sportName);

      if (pageNum == -1 & pageSize == -1)
      {
        return new QueryResult<Tournament>(query.List().AsQueryable());
      }

      return new QueryResult<Tournament>(query
            .Skip(ResultsPagingUtility.CalculateStartIndex((int) pageNum, (int) pageSize))
            .Take((int) pageSize).List().AsQueryable(),
          query.ToRowCountQuery().RowCount(),
          (int) pageSize)
        ;
    }

    public Tournament FindByName(string name)
    {
      return (Tournament)
        Session.CreateCriteria(typeof(Tournament))
          .Add(Expression.Eq("Name", name))
          .UniqueResult()
        ;
    }

    public Tournament FindByTournamentId(string tournamentId)
    {
      return (Tournament)
        Session.CreateCriteria(typeof(Tournament))
          .Add(Expression.Eq("TournamentId", tournamentId))
          .UniqueResult()
        ;
    }

    public int FindCountAllTournaments()
    {
      int count = 0;
      try
      {
        count = Session
          .CreateCriteria<Tournament>()
          .SetProjection(
            Projections.Count(Projections.Id())
          )
          .UniqueResult<int>();
      }
      catch (Exception e)
      {
        Log.Error(
          $"FindCountAllTournaments" +
          $"Error Message:{e.Message}" +
          "--TournamentRepository--  @fail@ [TournamentRepository]." +
          $" @inner-fault:{e?.Message} and {e?.InnerException}");
      }
      return count;
    }

    public int FindCountPrioritizedTournaments()
    {
      int count = 0;
      try
      {
        count = Session
          .CreateCriteria<Tournament>()
          .Add(Expression.Gt("Priority", 1))
          .SetProjection(
            Projections.Count(Projections.Id())
          )
          .UniqueResult<int>();

      }
      catch (Exception e)
      {
        Log.Error(
          $"FindCountPrioritizedTournaments" +
          $"Error Message:{e.Message}" +
          "--TournamentRepository--  @fail@ [TournamentRepository]." +
          $" @inner-fault:{e?.Message} and {e?.InnerException}");
      }
      return count;
    }
  }
}
