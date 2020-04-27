using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Categories
{
    public class CategoryDoesNotExistAfterMadePersistentException : Exception
    {
        public string Name { get; private set; }

        public CategoryDoesNotExistAfterMadePersistentException(string name)
        {
            Name = name;
        }

        public override string Message => $" Category with Name: {Name} was not made Persistent!";
    }
}