using System.Collections.Generic;

namespace horizonsb.common.infrastructure.Domain.Events
{
    public interface IDomainEventHandlerFactory
    {
        IEnumerable<IDomainEventHandler<T>> GetDomainEventHandlersFor<T>(T domainEvent)
            where T : IDomainEvent;
    }
}