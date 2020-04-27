using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Markets;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.UnitOfWorks;

namespace horizonsb.be.services.Markets
{
    public class DeleteMarketProcessor : IDeleteMarketProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly IMarketRepository _marketRepository;

        public DeleteMarketProcessor(IUnitOfWork uOf,
            IMarketRepository marketRepository)
        {
            _uOf = uOf;
            _marketRepository = marketRepository;
        }

        public Task DeleteMarketAsync(Guid sportToBeDeletedId)
        {
            throw new NotImplementedException();
        }
    }
}