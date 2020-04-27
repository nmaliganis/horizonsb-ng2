using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Events;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.UnitOfWorks;

namespace horizonsb.be.services.Events
{
    public class DeleteEventProcessor : IDeleteEventProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly IEventRepository _eventRepository;

        public DeleteEventProcessor(IUnitOfWork uOf,
            IEventRepository eventRepository)
        {
            _uOf = uOf;
            _eventRepository = eventRepository;
        }

        public Task DeleteEventAsync(Guid eventToBeDeletedId)
        {
            throw new NotImplementedException();
        }

        public void DeleteBatchEventAsync()
        {
          _eventRepository.DeleteBatchEvents();
        }
    }
}