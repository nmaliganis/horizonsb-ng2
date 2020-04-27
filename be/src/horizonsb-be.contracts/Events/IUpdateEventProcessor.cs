using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Events;

namespace horizonsb.be.contracts.Events
{
  public interface IUpdateEventProcessor
  {
    Task<EventUiModel> UpdateEventAsync(Guid eventIdToBeUpdated, EventForModificationUiModel updatedEvent);

    Task<EventUiModel> UpdateEventWithlivePriorityAsync(Guid eventIdToBeUpdated,
      EventForModificationWithLivePriorityUiModel updatedEvent);

    Task<EventUiModel> UpdateEventWithFavoriteAsync(Guid eventIdToBeUpdated,
      EventForModificationFavoritesUiModel updatedEvent);

    Task<EventUiModel> UpdateEventWithLiveApiAsync(string eventId, bool liveApiUpcomingLive, bool liveApiLive);
  }
}
