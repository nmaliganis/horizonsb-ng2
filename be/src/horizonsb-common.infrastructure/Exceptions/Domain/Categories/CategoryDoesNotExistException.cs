using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Categories
{
    public class CategoryDoesNotExistException : Exception
    {
        public Guid CategoryId { get; }
        public string CategoryCategoryId { get; }

        public CategoryDoesNotExistException(Guid categoryId)
        {
            CategoryId = categoryId;
        }
        public CategoryDoesNotExistException(string categoryCategoryId)
        {
          CategoryCategoryId = categoryCategoryId;
        }

        public override string Message => $"Category with Id: {CategoryId} and or {CategoryCategoryId} doesn't exists!";
    }
}
