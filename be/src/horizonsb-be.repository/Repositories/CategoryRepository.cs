using System;
using System.Linq;
using horizonsb.be.model.Categories;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.be.repository.Repositories.Base;
using horizonsb.common.infrastructure.Domain.Queries;
using horizonsb.common.infrastructure.Paging;
using NHibernate;
using NHibernate.Criterion;

namespace horizonsb.be.repository.Repositories
{
  public class CategoryRepository : RepositoryBase<Category, Guid>, ICategoryRepository
  {
    public CategoryRepository(ISession session)
      : base(session)
    {
    }

    public QueryResult<Category> FindAllCategoriesPagedOf(int? pageNum = -1, int? pageSize = -1)
    {
      var query = Session.QueryOver<Category>();

      return new QueryResult<Category>(query
            .Skip(ResultsPagingUtility.CalculateStartIndex((int)pageNum, (int)pageSize))
            .Take((int)pageSize).List().AsQueryable(),
          query.ToRowCountQuery().RowCount(),
          (int)pageSize)
        ;
    }

    public Category FindByName(string name)
    {
      return (Category)
        Session.CreateCriteria(typeof(Category))
          .Add(Expression.Eq("Name", name))
          .UniqueResult()
        ;
    }

    public Category FindByCategoryId(string categoryId)
    {
      return (Category)
        Session.CreateCriteria(typeof(Category))
          .Add(Expression.Eq("CategoryId", categoryId))
          .UniqueResult()
        ;
    }
  }
}
