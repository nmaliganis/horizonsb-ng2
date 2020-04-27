using System;
using System.Collections.Generic;
using horizonsb.be.model.Tournaments;
using horizonsb.common.infrastructure.Domain;
using horizonsb.common.infrastructure.Domain.Queries;

namespace horizonsb.be.repository.ContractRepositories
{
    public interface ITournamentRepository : IRepository<Tournament, Guid>
    {
        QueryResult<Tournament> FindAllTournamentsPagedOf(int? pageNum, int? pageSize);
        QueryResult<Tournament> FindAllTournamentsWithSportIdPagedOf(Guid sportId, int? pageNum, int? pageSize);

        QueryResult<Tournament> FindAllTournamentsWithSportNamePagedOf(string sportName, int? pageNum, int? pageSize);
        Tournament FindByName(string name);
        Tournament FindByTournamentId(string tournamentId);
        int FindCountAllTournaments();
        int FindCountPrioritizedTournaments();
    }
}
