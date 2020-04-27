using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Categories;

namespace horizonsb.be.contracts.Categories
{
    public interface ICreateCategoryProcessor
    {
        Task<CategoryUiModel> CreateCategoryAsync(CategoryForCreationUiModel newCategoryUiModel);
    }
}