using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Markets;
using horizonsb.commons.vm.Dtos.MarketTypes;

namespace horizonsb.be.contracts.MarketTypes
{
    public interface IInquiryMarketTypeProcessor
    {
        Task<MarketTypeUiModel> GetMarketTypeAsync(Guid marketTypeId);
        Task<MarketTypeUiModel> GetMarketTypeBySportIdAsync(string sportId);
    }
}