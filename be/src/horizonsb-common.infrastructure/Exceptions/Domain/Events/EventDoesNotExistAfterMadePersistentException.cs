using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Events
{
    public class EventDoesNotExistAfterMadePersistentException : Exception
    {
        public string Name { get; private set; }

        public EventDoesNotExistAfterMadePersistentException(string name)
        {
            Name = name;
        }

        public override string Message => $" Event with Name: {Name} was not made Persistent!";
    }
}