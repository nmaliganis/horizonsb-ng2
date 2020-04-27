using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Sports;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Sports;

namespace horizonsb.be.services.Sports
{
    public class InquirySportProcessor : IInquirySportProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly ISportRepository _sportRepository;
        public InquirySportProcessor(ISportRepository sportRepository, IAutoMapper autoMapper)
        {
            _sportRepository = sportRepository;
            _autoMapper = autoMapper;
        }

        public Task<SportUiModel> GetSportByIdAsync(Guid id)
        {
            return Task.Run(() => _autoMapper.Map<SportUiModel>(_sportRepository.FindBy(id)));
        }

        public Task<SportUiModel> GetSportBySportIdAsync(string sportid)
        {
          return Task.Run(() => _autoMapper.Map<SportUiModel>(_sportRepository.FindBySportId(sportid)));
    }

        public Task<int> GetSportCountAllAsync()
        {
            return Task.Run(() => _sportRepository.FindCountAllSports());
        }

        public Task<int> GetSportCountPrioritizedAsync()
        {
            return Task.Run(() => _sportRepository.FindCountPrioritizedSports());
        }

        public string GetSportMarketTypesBySportIdAsync(string sportId)
        {
          var x = _sportRepository.FindBySportId(sportId);
          return "";
        }
    }
}