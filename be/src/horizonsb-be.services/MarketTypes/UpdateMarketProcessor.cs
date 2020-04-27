using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.MarketTypes;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.MarketTypes;

namespace horizonsb.be.services.MarketTypes
{
    public class UpdateMarketTypeProcessor : IUpdateMarketTypeProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly IMarketTypeRepository _marketTypeRepository;
        private readonly IAutoMapper _autoMapper;
        public UpdateMarketTypeProcessor(IUnitOfWork uOf, IAutoMapper autoMapper, IMarketTypeRepository marketTypeRepository)
        {
            _uOf = uOf;
            _marketTypeRepository = marketTypeRepository;
            _autoMapper = autoMapper;
        }

        public Task<MarketTypeUiModel> UpdateMarketTypeAsync(MarketTypeForModificationUiModel updatedMarketType)
        {
            throw new NotImplementedException();
        }
    }
}