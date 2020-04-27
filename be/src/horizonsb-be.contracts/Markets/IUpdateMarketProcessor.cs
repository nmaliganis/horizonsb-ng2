using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Markets;

namespace horizonsb.be.contracts.Markets
{
    public interface IUpdateMarketProcessor
    {
        Task<MarketUiModel> UpdateMarketAsync(MarketForModificationUiModel updatedMarket);
    }
}
