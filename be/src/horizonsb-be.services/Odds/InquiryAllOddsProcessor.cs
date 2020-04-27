using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Odds;
using horizonsb.be.model.Events.Markets.Odds;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Odds;

namespace horizonsb.be.services.Odds
{
    public class InquiryAllOddsProcessor : IInquiryAllOddsProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly IOddRepository _oddRepository;
        private readonly IPropertyMappingService _propertyMappingService;

        public InquiryAllOddsProcessor(IAutoMapper autoMapper,
                            IOddRepository oddRepository, IPropertyMappingService propertyMappingService)
        {
            _autoMapper = autoMapper;
            _oddRepository = oddRepository;
            _propertyMappingService = propertyMappingService;
        }

        public Task<PagedList<Odd>> GetOddsAsync(OddsResourceParameters oddsResourceParameters)
        {
            var collectionBeforePaging =
                QueryableExtensions.ApplySort(_oddRepository
                        .FindAllOddsPagedOf(oddsResourceParameters.Offset,
                            oddsResourceParameters.Limit), 
                    oddsResourceParameters.OrderDirection + " " + oddsResourceParameters.OrderColumn, 
                    _propertyMappingService.GetPropertyMapping<OddUiModel, Odd>());


            return Task.Run(() => PagedList<Odd>.Create(collectionBeforePaging,
                oddsResourceParameters.Offset,
                oddsResourceParameters.Limit));
        }
    }
}