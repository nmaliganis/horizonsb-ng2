using System;
using System.Threading.Tasks;

namespace horizonsb.be.contracts.Odds
{
    public interface IDeleteOddProcessor
    {
        Task DeleteOddAsync(Guid sportToBeDeletedId);
    }
}