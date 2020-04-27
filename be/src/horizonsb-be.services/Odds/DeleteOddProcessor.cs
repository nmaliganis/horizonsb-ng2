using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Odds;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.UnitOfWorks;

namespace horizonsb.be.services.Odds
{
    public class DeleteOddProcessor : IDeleteOddProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly IOddRepository _oddRepository;

        public DeleteOddProcessor(IUnitOfWork uOf,
            IOddRepository oddRepository)
        {
            _uOf = uOf;
            _oddRepository = oddRepository;
        }

        public Task DeleteOddAsync(Guid sportToBeDeletedId)
        {
            throw new NotImplementedException();
        }
    }
}