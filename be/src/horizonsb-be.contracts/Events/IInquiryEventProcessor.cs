using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.be.model.Events;
using horizonsb.commons.vm.Dtos.Events;

namespace horizonsb.be.contracts.Events
{
  public interface IInquiryEventProcessor
  {
    Task<EventUiModel> GetEventByIdAsync(Guid id);
    Task<EventUiModel> GetEventByEventIdAsync(string eventId);
    Task<EventUiModel> GetEventByMarketLegacyMarketIdAsync(string legacyMarketId);
    Task<EventUiModel> GetEventByCodeAsync(string legacyMarketId);
    Task<int> GetEventCountAllAsync();
    Task<int> GetEventCountPrioritizedAsync();
    Task<int> GetEventCountLivePrioritizedAsync();

    Task<int> GetEventCountUpcomingLiveAsync();
    Task<int> GetEventCountLiveAsync();
    Task<int> GetEventCountFavoriteAsync();

    IList<EventUpcomingLiveUiModel> GetEventsByUpcomingLive();
    Task<List<EventUiModel>> GetEventsFavorite();
    Task<List<EventUiModel>> GetAllForRegisterEvents();
    Task<List<EventUiModel>> GetEventsLiveAndUpcomiongAsync();
  }
}