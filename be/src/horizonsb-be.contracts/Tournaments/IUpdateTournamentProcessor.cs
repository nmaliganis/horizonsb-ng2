using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Tournaments;

namespace horizonsb.be.contracts.Tournaments
{
    public interface IUpdateTournamentProcessor
    {
        Task<TournamentUiModel> UpdateTournamentAsync(Guid tournamentIdToBeUpdated, TournamentForModificationUiModel updatedTournament);
    }
}
