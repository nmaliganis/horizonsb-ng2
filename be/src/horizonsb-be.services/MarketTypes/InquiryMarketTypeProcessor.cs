using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.MarketTypes;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.MarketTypes;

namespace horizonsb.be.services.MarketTypes
{
    public class InquiryMarketTypeProcessor : IInquiryMarketTypeProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly IMarketTypeRepository _marketTypeRepository;
        public InquiryMarketTypeProcessor(IMarketTypeRepository marketTypeRepository, IOddRepository oddRepository, IAutoMapper autoMapper)
        {
            _marketTypeRepository = marketTypeRepository;
            _autoMapper = autoMapper;
        }

        public Task<MarketTypeUiModel> GetMarketTypeAsync(Guid marketTypeId)
        {
            return Task.Run(() => _autoMapper.Map<MarketTypeUiModel>(_marketTypeRepository.FindBy(marketTypeId)));
        }

        public Task<MarketTypeUiModel> GetMarketTypeBySportIdAsync(string sportId)
        {
          return Task.Run(() => _autoMapper.Map<MarketTypeUiModel>(_marketTypeRepository.FindBySportId(sportId)));
        }
    }
}