using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Markets;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Markets;

namespace horizonsb.be.services.Markets
{
    public class InquiryAllMarketsProcessor : IInquiryAllMarketsProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly IMarketRepository _marketRepository;
        private readonly IPropertyMappingService _propertyMappingService;

        public InquiryAllMarketsProcessor(IAutoMapper autoMapper,
                            IMarketRepository marketRepository, IPropertyMappingService propertyMappingService)
        {
            _autoMapper = autoMapper;
            _marketRepository = marketRepository;
            _propertyMappingService = propertyMappingService;
        }

        public Task<PagedList<Market>> GetMarketsAsync(MarketsResourceParameters sportsResourceParameters)
        {
            var collectionBeforePaging =
                QueryableExtensions.ApplySort(_marketRepository
                        .FindAllMarketsPagedOf(sportsResourceParameters.Offset,
                            sportsResourceParameters.Limit), 
                    sportsResourceParameters.OrderDirection + " " + sportsResourceParameters.OrderColumn, 
                    _propertyMappingService.GetPropertyMapping<MarketUiModel, Market>());


            return Task.Run(() => PagedList<Market>.Create(collectionBeforePaging,
                sportsResourceParameters.Offset,
                sportsResourceParameters.Limit));
        }

        public Task<IList<Market>> GetAllMarketsAsync(string eventId)
        {
          return Task.Run(() => _marketRepository.FindAllMarketsByEventId(eventId));
        }
    }
}