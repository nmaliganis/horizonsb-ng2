using System;
using System.Threading.Tasks;

namespace horizonsb.be.contracts.Tournaments
{
    public interface IDeleteTournamentProcessor
    {
        Task DeleteTournamentAsync(Guid tournamentToBeDeletedId);
    }
}