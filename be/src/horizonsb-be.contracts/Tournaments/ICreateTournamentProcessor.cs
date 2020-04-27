using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Tournaments;

namespace horizonsb.be.contracts.Tournaments
{
    public interface ICreateTournamentProcessor
    {
        Task<TournamentUiModel> CreateTournamentAsync(TournamentForCreationUiModel newTournamentUiModel);
    }
}