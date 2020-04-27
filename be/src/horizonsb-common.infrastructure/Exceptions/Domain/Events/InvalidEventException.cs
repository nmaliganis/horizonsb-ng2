using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Events
{
    public class InvalidEventException : Exception
    {
        public string BrokenRules { get; private set; }

        public InvalidEventException(string brokenRules)
        {
            BrokenRules = brokenRules;
        }
    }
}
