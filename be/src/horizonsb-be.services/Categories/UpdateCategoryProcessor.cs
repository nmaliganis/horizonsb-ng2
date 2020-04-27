using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Categories;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Categories;

namespace horizonsb.be.services.Categories
{
    public class UpdateCategoryProcessor : IUpdateCategoryProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly ICategoryRepository _categoryRepository;
        private readonly IAutoMapper _autoMapper;
        public UpdateCategoryProcessor(IUnitOfWork uOf, IAutoMapper autoMapper, ICategoryRepository categoryRepository)
        {
            _uOf = uOf;
            _categoryRepository = categoryRepository;
            _autoMapper = autoMapper;
        }

        public Task<CategoryUiModel> UpdateCategoryAsync(CategoryForModificationUiModel updatedCategory)
        {
            throw new NotImplementedException();
        }
    }
}