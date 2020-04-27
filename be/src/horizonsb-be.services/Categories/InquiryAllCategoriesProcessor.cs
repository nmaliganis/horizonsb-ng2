using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Categories;
using horizonsb.be.model.Categories;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Categories;

namespace horizonsb.be.services.Categories
{
    public class InquiryAllCategoriesProcessor : IInquiryAllCategoriesProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly ICategoryRepository _categoryRepository;
        private readonly IPropertyMappingService _propertyMappingService;

        public InquiryAllCategoriesProcessor(IAutoMapper autoMapper,
                            ICategoryRepository categoryRepository, IPropertyMappingService propertyMappingService)
        {
            _autoMapper = autoMapper;
            _categoryRepository = categoryRepository;
            _propertyMappingService = propertyMappingService;
        }

        public Task<PagedList<Category>> GetCategoriesAsync(CategoriesResourceParameters categoriesResourceParameters)
        {
            var collectionBeforePaging =
                QueryableExtensions.ApplySort(_categoryRepository
                        .FindAllCategoriesPagedOf(categoriesResourceParameters.Offset,
                            categoriesResourceParameters.Limit), 
                    categoriesResourceParameters.OrderDirection + " " + categoriesResourceParameters.OrderColumn, 
                    _propertyMappingService.GetPropertyMapping<CategoryUiModel, Category>());


            return Task.Run(() => PagedList<Category>.Create(collectionBeforePaging,
                categoriesResourceParameters.Offset,
                categoriesResourceParameters.Limit));
        }
    }
}