using System;
using System.Threading.Tasks;

namespace horizonsb.be.contracts.MarketTypes
{
    public interface IDeleteMarketTypeProcessor
    {
        Task DeleteMarketTypeAsync(Guid marketTypeToBeDeletedId);
        Task DeleteMarketTypeWithSportIdAsync(string sportId);
    }
}