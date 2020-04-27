using System;
using System.Threading.Tasks;

namespace horizonsb.be.contracts.Markets
{
    public interface IDeleteMarketProcessor
    {
        Task DeleteMarketAsync(Guid sportToBeDeletedId);
    }
}