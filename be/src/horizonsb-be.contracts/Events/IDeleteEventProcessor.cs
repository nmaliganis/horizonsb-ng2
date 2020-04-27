using System;
using System.Threading.Tasks;

namespace horizonsb.be.contracts.Events
{
    public interface IDeleteEventProcessor
    {
        Task DeleteEventAsync(Guid eventToBeDeletedId);
        void DeleteBatchEventAsync();

  }
}