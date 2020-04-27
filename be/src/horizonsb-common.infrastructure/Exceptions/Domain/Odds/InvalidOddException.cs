using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Odds
{
    public class InvalidOddException : Exception
    {
        public string BrokenRules { get; private set; }

        public InvalidOddException(string brokenRules)
        {
            BrokenRules = brokenRules;
        }
    }
}
