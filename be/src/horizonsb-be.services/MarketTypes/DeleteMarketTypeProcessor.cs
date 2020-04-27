using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Markets;
using horizonsb.be.contracts.MarketTypes;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.UnitOfWorks;

namespace horizonsb.be.services.MarketTypes
{
    public class DeleteMarketTypeProcessor : IDeleteMarketTypeProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly IMarketRepository _marketRepository;

        public DeleteMarketTypeProcessor(IUnitOfWork uOf,
          IMarketRepository marketRepository)
        {
          _uOf = uOf;
          _marketRepository = marketRepository;
        }

        public Task DeleteMarketTypeAsync(Guid marketTypeToBeDeletedId)
        {
          throw new NotImplementedException();
        }

        public Task DeleteMarketTypeWithSportIdAsync(string sportId)
        {
          throw new NotImplementedException();
        }
    }
}