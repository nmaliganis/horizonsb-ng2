using System;
using System.Collections.Generic;
using horizonsb.be.model.Events.Markets.Odds;
using horizonsb.common.infrastructure.Domain;
using horizonsb.common.infrastructure.Domain.Queries;

namespace horizonsb.be.repository.ContractRepositories
{
    public interface IOddRepository : IRepository<Odd, Guid>
    {
        QueryResult<Odd> FindAllOddsPagedOf(int? pageNum, int? pageSize);
        Odd FindByName(string name);
        Odd FindByOddId(string sportId);
        IList<Odd> FindByNameAndOddId(string name, string sportId);

        int FindCountAllOdds();
  }
}
