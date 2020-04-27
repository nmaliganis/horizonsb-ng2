using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Events
{
    public class EventAlreadyExistsException : Exception
    {
        public string Name { get; }
        public string BrokenRules { get; }

        public EventAlreadyExistsException(string name, string brokenRules)
        {
            Name = name;
            BrokenRules = brokenRules;
        }

        public override string Message => $" Event with Name:{Name} already Exists!\n Additional info:{BrokenRules}";
    }
}
