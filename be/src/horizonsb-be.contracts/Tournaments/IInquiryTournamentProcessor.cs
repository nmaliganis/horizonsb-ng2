using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Tournaments;

namespace horizonsb.be.contracts.Tournaments
{
    public interface IInquiryTournamentProcessor
    {
        Task<TournamentUiModel> GetTournamentAsync(Guid id);
        Task<int> GetTournamentCountAllAsync();
        Task<int> GetTournamentCountPrioritizedAsync();
    }
}