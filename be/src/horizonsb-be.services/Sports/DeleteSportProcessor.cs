using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Sports;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.UnitOfWorks;

namespace horizonsb.be.services.Sports
{
    public class DeleteSportProcessor : IDeleteSportProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly ISportRepository _sportRepository;

        public DeleteSportProcessor(IUnitOfWork uOf,
            ISportRepository sportRepository)
        {
            _uOf = uOf;
            _sportRepository = sportRepository;
        }

        public Task DeleteSportAsync(Guid sportToBeDeletedId)
        {
            throw new NotImplementedException();
        }

        public void DeleteBatchSportAsync()
        {
           _sportRepository.DeleteBatchSports();
        }
    }
}