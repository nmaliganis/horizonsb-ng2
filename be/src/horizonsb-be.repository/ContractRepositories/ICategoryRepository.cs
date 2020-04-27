using System;
using System.Collections.Generic;
using horizonsb.be.model.Categories;
using horizonsb.be.model.Tournaments;
using horizonsb.common.infrastructure.Domain;
using horizonsb.common.infrastructure.Domain.Queries;

namespace horizonsb.be.repository.ContractRepositories
{
    public interface ICategoryRepository : IRepository<Category, Guid>
    {
        QueryResult<Category> FindAllCategoriesPagedOf(int? pageNum, int? pageSize);
        Category FindByName(string name);
        Category FindByCategoryId(string categoryId);
    }
}
