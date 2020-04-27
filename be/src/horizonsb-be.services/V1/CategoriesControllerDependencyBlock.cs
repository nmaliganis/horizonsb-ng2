using horizonsb.be.contracts.Categories;
using horizonsb.be.contracts.V1;

namespace horizonsb.be.services.V1
{
    public class CategoriesControllerDependencyBlock : ICategoriesControllerDependencyBlock
    {
        public CategoriesControllerDependencyBlock(ICreateCategoryProcessor createCategoryProcessor,
                                                        IInquiryCategoryProcessor inquiryCategoryProcessor,
                                                        IUpdateCategoryProcessor updateCategoryProcessor,
                                                        IInquiryAllCategoriesProcessor allCategoriesProcessor,
                                                        IDeleteCategoryProcessor deleteCategoryProcessor)

        {
            CreateCategoryProcessor = createCategoryProcessor;
            InquiryCategoryProcessor = inquiryCategoryProcessor;
            UpdateCategoryProcessor = updateCategoryProcessor;
            InquiryAllCategoriesProcessor = allCategoriesProcessor;
            DeleteCategoryProcessor = deleteCategoryProcessor;
        }

        public ICreateCategoryProcessor CreateCategoryProcessor { get; private set; }
        public IInquiryCategoryProcessor InquiryCategoryProcessor { get; private set; }
        public IUpdateCategoryProcessor UpdateCategoryProcessor { get; private set; }
        public IInquiryAllCategoriesProcessor InquiryAllCategoriesProcessor { get; private set; }
        public IDeleteCategoryProcessor DeleteCategoryProcessor { get; private set; }
    }
}