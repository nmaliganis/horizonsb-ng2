using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Categories;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.UnitOfWorks;

namespace horizonsb.be.services.Categories
{
    public class DeleteCategoryProcessor : IDeleteCategoryProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly ICategoryRepository _categoryRepository;

        public DeleteCategoryProcessor(IUnitOfWork uOf,
            ICategoryRepository categoryRepository)
        {
            _uOf = uOf;
            _categoryRepository = categoryRepository;
        }

        public Task DeleteCategoryAsync(Guid categoryToBeDeletedId)
        {
            throw new NotImplementedException();
        }
    }
}