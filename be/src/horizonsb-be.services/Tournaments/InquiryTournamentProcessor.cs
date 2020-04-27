using System;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Threading.Tasks;
using horizonsb.be.contracts.Tournaments;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Tournaments;

namespace horizonsb.be.services.Tournaments
{
    public class InquiryTournamentProcessor : IInquiryTournamentProcessor
    {
        private readonly IAutoMapper _autoMapper;
        private readonly ITournamentRepository _tournamentRepository;
        public InquiryTournamentProcessor(ITournamentRepository tournamentRepository, IAutoMapper autoMapper)
        {
            _tournamentRepository = tournamentRepository;
            _autoMapper = autoMapper;
        }

        public Task<TournamentUiModel> GetTournamentAsync(Guid id)
        {
            return Task.Run(() => _autoMapper.Map<TournamentUiModel>(_tournamentRepository.FindBy(id)));
        }

        public Task<int> GetTournamentCountAllAsync()
        {
            return Task.Run(() => _tournamentRepository.FindCountAllTournaments());
        }

        public Task<int> GetTournamentCountPrioritizedAsync()
        {
            return Task.Run(() => _tournamentRepository.FindCountPrioritizedTournaments());
        }
  }
}