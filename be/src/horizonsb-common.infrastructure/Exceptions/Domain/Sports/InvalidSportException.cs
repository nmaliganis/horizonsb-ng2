using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Sports
{
    public class InvalidSportException : Exception
    {
        public string BrokenRules { get; private set; }

        public InvalidSportException(string brokenRules)
        {
            BrokenRules = brokenRules;
        }
    }
}
