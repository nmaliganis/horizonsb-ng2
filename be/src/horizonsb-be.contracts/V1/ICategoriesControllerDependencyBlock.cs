using horizonsb.be.contracts.Categories;

namespace horizonsb.be.contracts.V1
{
    public interface ICategoriesControllerDependencyBlock
    {
        ICreateCategoryProcessor CreateCategoryProcessor { get; }
        IInquiryCategoryProcessor InquiryCategoryProcessor { get; }
        IUpdateCategoryProcessor UpdateCategoryProcessor { get; }
        IInquiryAllCategoriesProcessor InquiryAllCategoriesProcessor { get; }
        IDeleteCategoryProcessor DeleteCategoryProcessor { get; }
    }
}