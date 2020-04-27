using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Events
{
    public class EventDoesNotExistException : Exception
    {
        public Guid EventId { get; }
        public string EventEventId { get; }

        public EventDoesNotExistException(Guid sportId)
        {
            EventId = sportId;
        }
        public EventDoesNotExistException(string sportId)
        {
          EventEventId = sportId;
        }

        public override string Message => $"Event with Id: {EventId} and Or sportid:{EventEventId}  doesn't exists!";
    }
}
