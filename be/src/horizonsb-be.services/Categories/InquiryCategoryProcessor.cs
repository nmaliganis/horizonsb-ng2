using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Categories;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Categories;

namespace horizonsb.be.services.Categories
{
    public class InquiryCategoryProcessor : IInquiryCategoryProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly ICategoryRepository _categoryRepository;
        public InquiryCategoryProcessor(ICategoryRepository categoryRepository, IAutoMapper autoMapper)
        {
            _categoryRepository = categoryRepository;
            _autoMapper = autoMapper;
        }

        public Task<CategoryUiModel> GetCategoryAsync(Guid id)
        {
            return Task.Run(() => _autoMapper.Map<CategoryUiModel>(_categoryRepository.FindBy(id)));
        }
    }
}