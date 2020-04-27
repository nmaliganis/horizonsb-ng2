using System;
using System.Linq;
using horizonsb.be.model.Admin;
using horizonsb.be.repository.ContractRepositories.Admin;
using horizonsb.be.repository.Repositories.Base;
using horizonsb.common.infrastructure.Domain.Queries;
using horizonsb.common.infrastructure.Paging;
using NHibernate;
using NHibernate.Criterion;
using NHibernate.SqlCommand;

namespace horizonsb.be.repository.Repositories.Admin
{
  public class UserRepository : RepositoryBase<User, Guid>, IUserRepository
  {
    public UserRepository(ISession session)
        : base(session)
    {
    }

    public QueryResult<User> GetUsersPagedAsync(int? pageNum, int? pageSize)
    {
      var query = Session.QueryOver<User>();

      if (pageNum == -1 & pageSize == -1)
      {
        return new QueryResult<User>(query
            .WhereNot(u => u.Login == "su@digitalabs.tech")
            .Where(u => u.IsActive == true)
            .List().AsQueryable());
      }

      return new QueryResult<User>(query
                  .WhereNot(u => u.Login == "su@digitalabs.tech")
                  .Where(u => u.IsActive == true)
                  .Skip(ResultsPagingUtility.CalculateStartIndex((int)pageNum, (int)pageSize))
                  .Take((int)pageSize).List().AsQueryable(),
              query.ToRowCountQuery().RowCount(),
              (int)pageSize)
          ;
    }

    public User FindUserByLoginAndEmail(string login, string email)
    {
      return (User)
          Session.CreateCriteria(typeof(User))
              .CreateAlias("Person", "p", JoinType.InnerJoin)
              .Add(Restrictions.Or(
                  Restrictions.Eq("Login", login),
                  Restrictions.Eq("p.Email", email)))
              .Add(Expression.Eq("IsActive", true))
              .Add(Expression.Eq("p.IsActive", true))
              .SetCacheable(true)
              .SetCacheMode(CacheMode.Normal)
              .SetFlushMode(FlushMode.Never)
              .UniqueResult()
          ;

    }

    public User FindUserByLogin(string login)
    {
      return (User)
          Session.CreateCriteria(typeof(User))
              .CreateAlias("Person", "p", JoinType.InnerJoin)
              .Add(Restrictions.Or(
                  Restrictions.Eq("Login", login),
                  Restrictions.Eq("p.Email", login)))
              .Add(Expression.Eq("IsActive", true))
              .Add(Expression.Eq("p.IsActive", true))
              .SetCacheable(true)
              .SetCacheMode(CacheMode.Normal)
              .SetFlushMode(FlushMode.Never)
              .UniqueResult()
          ;
    }

    public User FindUserByLoginAndPasswordAsync(string login, string password)
    {
      return
          (User)
          Session.CreateCriteria(typeof(User))
              .Add(Expression.Eq("Login", login))
              .Add(Expression.Eq("PasswordHash", password))
              .Add(Expression.Eq("IsActive", true))
              .SetCacheable(true)
              .SetCacheMode(CacheMode.Get)
              .SetFlushMode(FlushMode.Never)
              .UniqueResult()
          ;
    }

    public User FindByUserIdAndActivationKey(Guid userIdToBeActivated, Guid activationKey)
    {
      return
          (User)
          Session.CreateCriteria(typeof(User))
              .Add(Expression.Eq("Id", userIdToBeActivated))
              .Add(Expression.Eq("ActivationKey", activationKey))
              .SetCacheable(true)
              .SetCacheMode(CacheMode.Normal)
              .SetFlushMode(FlushMode.Never)
              .UniqueResult()
          ;
    }

    public User FindUserByRefreshTokenAsync(Guid refreshToken)
    {
      return (User)
          Session.CreateCriteria(typeof(User))
              .CreateAlias("UserTokens", "t", JoinType.InnerJoin)
              .Add(Expression.Eq("IsActive", true))
              .Add(Expression.Eq("t.RefreshToken", refreshToken))
              .Add(Expression.Eq("t.Expired", false))
              .Add(Expression.Eq("t.IsActive", true))
              .SetCacheable(true)
              .SetCacheMode(CacheMode.Normal)
              .SetFlushMode(FlushMode.Never)
              .UniqueResult()
          ;
    }
  }
}
