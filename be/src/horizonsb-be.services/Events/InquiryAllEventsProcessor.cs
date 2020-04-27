using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Events;
using horizonsb.be.model.Events;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Events;

namespace horizonsb.be.services.Events
{
    public class InquiryAllEventsProcessor : IInquiryAllEventsProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly IEventRepository _eventRepository;
        private readonly IPropertyMappingService _propertyMappingService;

        public InquiryAllEventsProcessor(IAutoMapper autoMapper,
                            IEventRepository eventRepository, IPropertyMappingService propertyMappingService)
        {
            _autoMapper = autoMapper;
            _eventRepository = eventRepository;
            _propertyMappingService = propertyMappingService;
        }

        public Task<PagedList<Match>> GetEventsAsync(EventsResourceParameters eventsResourceParameters)
        {
            var collectionBeforePaging =
                QueryableExtensions.ApplySort(_eventRepository
                        .FindAllEventsPagedOf(eventsResourceParameters.Offset,
                            eventsResourceParameters.Limit), 
                    eventsResourceParameters.OrderColumn + " " + eventsResourceParameters.OrderDirection, 
                    _propertyMappingService.GetPropertyMapping<EventUiModel, Match>());

            return Task.Run(() => PagedList<Match>.Create(collectionBeforePaging,
                eventsResourceParameters.Offset,
                eventsResourceParameters.Limit));
        }

        public Task<PagedList<Match>> GetFavoriteEventsAsync(EventsResourceParameters eventsResourceParameters)
        {
          var collectionBeforePaging =
            QueryableExtensions.ApplySort(_eventRepository
                .FindAllFavoriteEventsPagedOf(eventsResourceParameters.Offset,
                  eventsResourceParameters.Limit),
              eventsResourceParameters.OrderColumn + " " + eventsResourceParameters.OrderDirection,
              _propertyMappingService.GetPropertyMapping<EventUiModel, Match>());

          return Task.Run(() => PagedList<Match>.Create(collectionBeforePaging,
            eventsResourceParameters.Offset,
            eventsResourceParameters.Limit));
    }

        public Task<PagedList<Match>> GetLiveEventsAsync(EventsResourceParameters eventsResourceParameters)
        {
          var collectionBeforePaging =
            QueryableExtensions.ApplySort(_eventRepository
                .FindAllEventsPagedOf(eventsResourceParameters.Offset,
                  eventsResourceParameters.Limit),
              eventsResourceParameters.OrderColumn + " " + eventsResourceParameters.OrderDirection,
              _propertyMappingService.GetPropertyMapping<EventUiModel, Match>());

          return Task.Run(() => PagedList<Match>.Create(collectionBeforePaging,
            eventsResourceParameters.Offset,
            eventsResourceParameters.Limit));
    }


        public Task<int> GetTotalCountEventsAsync()
        {
          var totalCountEvents = _eventRepository.FindAllEventsPagedOf(-1, -1).QueriedItems.Count();
          return Task.Run(() => totalCountEvents);
        }
    }
}