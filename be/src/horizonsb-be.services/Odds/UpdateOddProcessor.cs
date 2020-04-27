using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Odds;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Odds;

namespace horizonsb.be.services.Odds
{
    public class UpdateOddProcessor : IUpdateOddProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly IOddRepository _oddRepository;
        private readonly IAutoMapper _autoMapper;
        public UpdateOddProcessor(IUnitOfWork uOf, IAutoMapper autoMapper, IOddRepository oddRepository)
        {
            _uOf = uOf;
            _oddRepository = oddRepository;
            _autoMapper = autoMapper;
        }

        public Task<OddUiModel> UpdateOddAsync(OddForModificationUiModel updatedOdd)
        {
            throw new NotImplementedException();
        }
    }
}