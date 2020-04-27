using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Sports;

namespace horizonsb.be.contracts.Sports
{
    public interface IInquirySportProcessor
    {
        Task<SportUiModel> GetSportByIdAsync(Guid id);
        Task<SportUiModel> GetSportBySportIdAsync(string id);
        Task<int> GetSportCountAllAsync();
        Task<int> GetSportCountPrioritizedAsync();
        string GetSportMarketTypesBySportIdAsync(string sportId);
    }
}