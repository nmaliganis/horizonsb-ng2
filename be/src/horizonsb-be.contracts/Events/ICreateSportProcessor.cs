using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Events;

namespace horizonsb.be.contracts.Events
{
    public interface ICreateEventProcessor
    {
        Task<EventUiModel> CreateEventAsync(EventForCreationUiModel newEventUiModel, int priority = 1);
    }
}