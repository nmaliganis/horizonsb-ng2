using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Markets
{
    public class InvalidMarketException : Exception
    {
        public string BrokenRules { get; private set; }

        public InvalidMarketException(string brokenRules)
        {
            BrokenRules = brokenRules;
        }
    }
}
