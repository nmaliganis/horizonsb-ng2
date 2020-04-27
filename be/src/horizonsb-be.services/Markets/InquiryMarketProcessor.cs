using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Markets;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Markets;

namespace horizonsb.be.services.Markets
{
    public class InquiryMarketProcessor : IInquiryMarketProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly IMarketRepository _marketRepository;
        private readonly IOddRepository _oddRepository;
        public InquiryMarketProcessor(IMarketRepository marketRepository, IOddRepository oddRepository, IAutoMapper autoMapper)
        {
            _marketRepository = marketRepository;
            _oddRepository = oddRepository;
            _autoMapper = autoMapper;
        }

        public Task<MarketUiModel> GetMarketAsync(Guid id)
        {
            return Task.Run(() => _autoMapper.Map<MarketUiModel>(_marketRepository.FindBy(id)));
        }

        public Task<int> GetMarketCountAllAsync()
        {
          return Task.Run(() => _marketRepository.FindCountAllMarkets());
        }

        public Task<int> GetOddCountAllAsync()
        {
          return Task.Run(() => _oddRepository.FindCountAllOdds());
        }
    }
}