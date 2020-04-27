using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Markets;

namespace horizonsb.be.contracts.Markets
{
    public interface IInquiryMarketProcessor
    {
        Task<MarketUiModel> GetMarketAsync(Guid id);
        Task<int> GetMarketCountAllAsync();
        Task<int> GetOddCountAllAsync();
    }
}