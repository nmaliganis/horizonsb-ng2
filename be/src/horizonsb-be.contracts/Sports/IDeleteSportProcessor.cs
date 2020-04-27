using System;
using System.Threading.Tasks;

namespace horizonsb.be.contracts.Sports
{
    public interface IDeleteSportProcessor
    {
        Task DeleteSportAsync(Guid sportToBeDeletedId);
        void DeleteBatchSportAsync();
    }
}