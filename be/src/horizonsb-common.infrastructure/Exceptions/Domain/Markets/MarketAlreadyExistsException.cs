using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Markets
{
    public class MarketAlreadyExistsException : Exception
    {
        public string Name { get; }
        public string BrokenRules { get; }

        public MarketAlreadyExistsException(string name, string brokenRules)
        {
            Name = name;
            BrokenRules = brokenRules;
        }

        public override string Message => $" Market with Name:{Name} already Exists!\n Additional info:{BrokenRules}";
    }
}
