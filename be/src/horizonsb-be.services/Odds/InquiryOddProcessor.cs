using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Odds;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Odds;

namespace horizonsb.be.services.Odds
{
    public class InquiryOddProcessor : IInquiryOddProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly IOddRepository _oddRepository;
        public InquiryOddProcessor(IOddRepository oddRepository, IAutoMapper autoMapper)
        {
            _oddRepository = oddRepository;
            _autoMapper = autoMapper;
        }

        public Task<OddUiModel> GetOddAsync(Guid id)
        {
            return Task.Run(() => _autoMapper.Map<OddUiModel>(_oddRepository.FindBy(id)));
        }
    }
}