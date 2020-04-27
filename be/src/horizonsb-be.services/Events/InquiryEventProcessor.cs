using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using horizonsb.be.contracts.Events;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Events;

namespace horizonsb.be.services.Events
{
  public class InquiryEventProcessor : IInquiryEventProcessor
  {
    private readonly IAutoMapper _autoMapper;
    private readonly IEventRepository _eventRepository;

    public InquiryEventProcessor(IEventRepository eventRepository, IAutoMapper autoMapper)
    {
      _eventRepository = eventRepository;
      _autoMapper = autoMapper;
    }

    public Task<EventUiModel> GetEventByIdAsync(Guid id)
    {
      return Task.Run(() => _autoMapper.Map<EventUiModel>(_eventRepository.FindBy(id)));
    }

    public Task<EventUiModel> GetEventByEventIdAsync(string eventId)
    {
      return Task.Run(() => _autoMapper.Map<EventUiModel>(_eventRepository.FindOneByEventId(eventId)));
    }

    public Task<EventUiModel> GetEventByMarketLegacyMarketIdAsync(string legacyMarketId)
    {
        return Task.Run(() => _autoMapper.Map<EventUiModel>(_eventRepository.FindOneByMarketLegacyId(legacyMarketId)));
    }

    public Task<EventUiModel> GetEventByCodeAsync(string eventCode)
    {
        return Task.Run(() => _autoMapper.Map<EventUiModel>(_eventRepository.FindOneByEventCode(eventCode)));
    }

    public Task<int> GetEventCountAllAsync()
    {
      return Task.Run(() => _eventRepository.FindCountAllEvents());
    }

    public Task<int> GetEventCountPrioritizedAsync()
    {
      return Task.Run(() => _eventRepository.FindCountPrioritizedEvents());
    }

    public Task<int> GetEventCountLivePrioritizedAsync()
    {
        return Task.Run(() => _eventRepository.FindCountLivePrioritizedEvents());
    }

        public Task<int> GetEventCountUpcomingLiveAsync()
    {
      return Task.Run(() => _eventRepository.FindCountUpcomingLiveEvents());
    }

    public Task<int> GetEventCountLiveAsync()
    {
      return Task.Run(() => _eventRepository.FindCountLiveEvents());
    }

    public Task<int> GetEventCountFavoriteAsync()
    {
      return Task.Run(() => _eventRepository.FindCountFavoritesEvents());
    }

    public IList<EventUpcomingLiveUiModel> GetEventsByUpcomingLive()
    {
      var upComingLiveEvents = _eventRepository.FindAllUpcomingEvent();

      var upComingLiveEventsEventIds = Mapper.Map<IList<EventUpcomingLiveUiModel>>(upComingLiveEvents);

      return upComingLiveEventsEventIds;
    }

    public Task<List<EventUiModel>> GetEventsFavorite()
    {
      var favoritesEvents = _eventRepository.FindAllFavorites();

      return Task.Run(() => _autoMapper.Map<List<EventUiModel>>(favoritesEvents));
    }
    public Task<List<EventUiModel>> GetEventsLiveAndUpcomiongAsync()
    {
      var liveOrUpcomiongEvents = _eventRepository.FindAllLivesOrUpcoming();

      return Task.Run(() => _autoMapper.Map<List<EventUiModel>>(liveOrUpcomiongEvents));
    }

    public Task<List<EventUiModel>> GetAllForRegisterEvents()
    {
      var registeredEvents = _eventRepository.FindAllForRegister();
      return Task.Run(() => _autoMapper.Map<List<EventUiModel>>(registeredEvents));
    }
  }
}