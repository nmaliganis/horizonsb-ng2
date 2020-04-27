using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Tournaments;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.UnitOfWorks;

namespace horizonsb.be.services.Tournaments
{
    public class DeleteTournamentProcessor : IDeleteTournamentProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly ITournamentRepository _tournamentRepository;

        public DeleteTournamentProcessor(IUnitOfWork uOf,
            ITournamentRepository tournamentRepository)
        {
            _uOf = uOf;
            _tournamentRepository = tournamentRepository;
        }

        public Task DeleteTournamentAsync(Guid tournamentToBeDeletedId)
        {
            throw new NotImplementedException();
        }
    }
}