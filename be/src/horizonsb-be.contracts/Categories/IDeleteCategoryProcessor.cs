using System;
using System.Threading.Tasks;

namespace horizonsb.be.contracts.Categories
{
    public interface IDeleteCategoryProcessor
    {
        Task DeleteCategoryAsync(Guid categoryToBeDeletedId);
    }
}