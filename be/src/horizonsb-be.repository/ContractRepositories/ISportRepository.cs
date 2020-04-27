using System;
using horizonsb.be.model.Sports;
using horizonsb.common.infrastructure.Domain;
using horizonsb.common.infrastructure.Domain.Queries;

namespace horizonsb.be.repository.ContractRepositories
{
    public interface ISportRepository : IRepository<Sport, Guid>
    {
        QueryResult<Sport> FindAllSportsPagedOf(int? pageNum, int? pageSize);
        Sport FindByName(string name);
        Sport FindBySportId(string sportId);
        void DeleteBatchSports();

        int FindCountAllSports();
        int FindCountPrioritizedSports();
    }
}
