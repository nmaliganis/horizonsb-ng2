using System;
using System.Collections.Generic;
using System.Linq;
using horizonsb.be.model.Events;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.be.repository.Repositories.Base;
using horizonsb.common.infrastructure.Domain.Queries;
using NHibernate;
using NHibernate.Criterion;
using Serilog;

namespace horizonsb.be.repository.Repositories
{
    public class EventRepository : RepositoryBase<Match, Guid>, IEventRepository
    {
        public EventRepository(ISession session)
            : base(session)
        {
        }

        public QueryResult<Match> FindAllLiveEventsPagedOf(int? pageNum = -1, int? pageSize = -1)
        {
          {
            IQueryable<Match> eventsWithLiveOrDateEvent;

            if (pageNum == -1 & pageSize == -1)
            {
              eventsWithLiveOrDateEvent = Session.CreateCriteria<Match>()
                .Add(Expression.Eq("Live", true))
                .AddOrder(Order.Asc("DateEvent"))
                .List<Match>()
                .AsQueryable();
            }
            else
            {
              eventsWithLiveOrDateEvent = Session.CreateCriteria<Match>()
                .Add(Expression.Eq("Live", true))
                .AddOrder(Order.Asc("DateEvent"))
                .SetFirstResult((int) pageNum)
                .SetMaxResults((int) pageSize)
                .List<Match>()
                .AsQueryable();
            }

            return new QueryResult<Match>(eventsWithLiveOrDateEvent);
          }
        }

        public QueryResult<Match> FindAllEventsPagedOf(int? pageNum = -1, int? pageSize = -1)
        {
          IQueryable<Match> eventsWithLiveOrDateEvent;

          if (pageNum == -1 & pageSize == -1)
          {
            eventsWithLiveOrDateEvent = Session.CreateCriteria<Match>()
              .Add(Expression.Disjunction()
                .Add(Restrictions.Eq("Live", true))
                .Add(Restrictions.Ge("DateEvent", DateTime.Now.AddHours(-1)))
              )
              .AddOrder(Order.Asc("DateEvent"))
              .List<Match>()
              .AsQueryable();
          }
          else
          {
            eventsWithLiveOrDateEvent = Session.CreateCriteria<Match>()
              .Add(Expression.Disjunction()
                .Add(Restrictions.Eq("Live", true))
                .Add(Restrictions.Ge("DateEvent", DateTime.Now.AddHours(-1)))
              )
              .AddOrder(Order.Asc("DateEvent"))
              .SetFirstResult((int)pageNum)
              .SetMaxResults((int)pageSize)
              .List<Match>()
              .AsQueryable();
          }

          return new QueryResult<Match>(eventsWithLiveOrDateEvent);
    }

        public QueryResult<Match> FindAllFavoriteEventsPagedOf(int? pageNum, int? pageSize)
        {
          IQueryable<Match> eventsWithLiveOrDateEvent;

          if (pageNum == -1 & pageSize == -1)
          {
            eventsWithLiveOrDateEvent = Session.CreateCriteria<Match>()
              .Add(Expression.Ge("DateEvent", DateTime.Now.AddHours(-1)))
              .Add(Expression.Eq("IsFavorite", true))
              .AddOrder(Order.Asc("DateEvent"))
              .List<Match>()
              .AsQueryable();
          }
          else
          {
            eventsWithLiveOrDateEvent = Session.CreateCriteria<Match>()
              .Add(Expression.Ge("DateEvent", DateTime.Now.AddHours(-1)))
              .Add(Expression.Eq("IsFavorite", true))
              .AddOrder(Order.Asc("DateEvent"))
              .SetFirstResult((int)pageNum)
              .SetMaxResults((int)pageSize)
              .List<Match>()
              .AsQueryable();
          }

          return new QueryResult<Match>(eventsWithLiveOrDateEvent);
    }

        public Match FindByName(string name)
        {
            return (Match)
                Session.CreateCriteria(typeof(Match))
                    .Add(Expression.Eq("Name", name))
                    .UniqueResult()
                ;
        }

        public Match FindOneByEventId(string eventId)
        {
            return (Match)
                Session.CreateCriteria(typeof(Match))
                    .Add(Expression.Eq("EventId", eventId))
                    .UniqueResult()
                ;
        }

        public Match FindOneByEventCode(string eventCode)
        {
            return (Match)
                Session.CreateCriteria(typeof(Match))
                    .Add(Expression.Eq("Code", eventCode))
                    .UniqueResult()
                ;
        }

        public Match FindOneByMarketLegacyId(string marketLegacyId)
        {
            Match selection = Session.QueryOver<Match>()
                    .JoinQueryOver<Market>(m => m.Markets)
                    .Where(mr => mr.LegacyMarket == marketLegacyId)
                    .SingleOrDefault()
                ;

            return selection;
        }

        public IList<Match> FindByEventId(string eventId)
        {
            return
                Session.CreateCriteria(typeof(Match))
                    .Add(Expression.Eq("MatchId", eventId))
                    .SetCacheable(true)
                    .SetCacheMode(CacheMode.Normal)
                    .SetFlushMode(FlushMode.Never)
                    .List<Match>()
                ;
        }

        public int FindCountAllEvents()
        {
            IList<int> selection =
                Session.QueryOver<Match>()
                    .SelectList(list => list
                        .SelectCount(c => c.Id))
                    .List<int>();

            return selection[0];
        }

        public int FindCountLivePrioritizedEvents()
        {
            IList<int> selection =
                Session.QueryOver<Match>()
                    .Where(r => r.LivePriority > 1)
                    .SelectList(list => list
                        .SelectCount(c => c.Id))
                    .List<int>();

            return selection[0];
        }

        public int FindCountUpcomingLiveEvents()
        {
            IList<int> selection =
                Session.QueryOver<Match>()
                    .Where(r => r.UpcomingLive == true)
                    .SelectList(list => list
                        .SelectCount(c => c.Id))
                    .List<int>();

            return selection[0];
        }

        public int FindCountLiveEvents()
        {
            IList<int> selection =
                Session.QueryOver<Match>()
                    .Where(r => r.Live == true)
                    .SelectList(list => list
                        .SelectCount(c => c.Id))
                    .List<int>();

            return selection[0];
        }

        public IList<Match> FindAllUpcomingEvent()
        {
            return
                Session.CreateCriteria(typeof(Match))
                    .Add(Expression.Eq("UpcomingLive", true))
                    .SetCacheable(true)
                    .SetCacheMode(CacheMode.Normal)
                    .SetFlushMode(FlushMode.Never)
                    .List<Match>()
                ;
        }

        public IList<Match> FindAllFavorites()
        {
          return
            Session.CreateCriteria(typeof(Match))
              .Add(Expression.Eq("IsFavorite", true))
              .SetCacheable(true)
              .SetCacheMode(CacheMode.Normal)
              .SetFlushMode(FlushMode.Never)
              .List<Match>()
            ;
        }

        public IList<Match> FindAllLivesOrUpcoming()
        {
          var eventsWithLiveOrDateEvent =
              Session.CreateCriteria<Match>()
                .Add(Expression.Disjunction()
                  .Add(Restrictions.Eq("Live", true))
                  .Add(Restrictions.Eq("UpcomingLive", true))
                )
                .AddOrder(Order.Asc("DateEvent"))
                .List<Match>()
            ;

          return eventsWithLiveOrDateEvent;
    }

        public IList<Match> FindAllForRegister()
        {
          var query = Session.QueryOver<Match>();

          return new List<Match>(query
            .Where(d => d.DateEvent >= DateTime.UtcNow)
            .OrderBy(x => x.DateEvent).Asc
            .List());
        }


        public int FindCountPrioritizedEvents()
        {
            IList<int> selection =
                Session.QueryOver<Match>()
                    .Where(r => r.Priority > 1)
                    .SelectList(list => list
                        .SelectCount(c => c.Id))
                    .List<int>();

            return selection[0];
        }

        public int FindCountFavoritesEvents()
        {
          int selection = Session.CreateCriteria<Match>()
            .Add(Expression.Ge("DateEvent", DateTime.Now.AddHours(-1)))
            .Add(Expression.Eq("IsFavorite", true))
            .AddOrder(Order.Asc("DateEvent"))
            .List<Match>()
            .Count;

          return selection;
        }

        public IList<Match> FindByEventIdAndCode(string eventId, string code)
        {
            return
                Session.CreateCriteria(typeof(Match))
                    .Add(Expression.Eq("MatchId", eventId))
                    .Add(Expression.Eq("Code", code))
                    .SetCacheable(true)
                    .SetCacheMode(CacheMode.Normal)
                    .SetFlushMode(FlushMode.Never)
                    .List<Match>()
                ;
        }

        public void DeleteBatchEvents()
        {
            try
            {
                Session.CreateQuery("DELETE FROM Match").ExecuteUpdate();
            }
            catch (Exception e)
            {
                Log.Error($"DeleteBatchEvents failed at:{DateTime.Now}. Details: {e.Message} and :{e.InnerException?.Message} ");
            }
        }
    }
}
