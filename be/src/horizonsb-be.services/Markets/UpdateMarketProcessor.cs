using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Markets;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Markets;

namespace horizonsb.be.services.Markets
{
    public class UpdateMarketProcessor : IUpdateMarketProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly IMarketRepository _sportRepository;
        private readonly IAutoMapper _autoMapper;
        public UpdateMarketProcessor(IUnitOfWork uOf, IAutoMapper autoMapper, IMarketRepository sportRepository)
        {
            _uOf = uOf;
            _sportRepository = sportRepository;
            _autoMapper = autoMapper;
        }

        public Task<MarketUiModel> UpdateMarketAsync(MarketForModificationUiModel updatedMarket)
        {
            throw new NotImplementedException();
        }
    }
}