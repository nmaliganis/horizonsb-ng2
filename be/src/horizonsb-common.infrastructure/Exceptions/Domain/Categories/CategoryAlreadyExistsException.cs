using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Categories
{
    public class CategoryAlreadyExistsException : Exception
    {
        public string Name { get; }
        public string BrokenRules { get; }

        public CategoryAlreadyExistsException(string name, string brokenRules)
        {
            Name = name;
            BrokenRules = brokenRules;
        }

        public override string Message => $" Category with Name:{Name} already Exists!\n Additional info:{BrokenRules}";
    }
}
