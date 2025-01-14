﻿namespace horizonsb.common.infrastructure.Domain.Events
{
    public interface IDomainEventHandler<T> where T : IDomainEvent
    {
        void Handle(T domainEvent);
    }
}