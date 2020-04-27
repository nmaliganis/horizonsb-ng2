using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.be.model.Categories;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;

namespace horizonsb.be.contracts.Categories
{
    public interface IInquiryAllCategoriesProcessor
    {
        Task<PagedList<Category>> GetCategoriesAsync(CategoriesResourceParameters categoriesResourceParameters);
    }
}