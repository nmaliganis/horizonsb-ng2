using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Markets;
using horizonsb.commons.vm.Dtos.MarketTypes;

namespace horizonsb.be.contracts.MarketTypes
{
    public interface IUpdateMarketTypeProcessor
    {
        Task<MarketTypeUiModel> UpdateMarketTypeAsync(MarketTypeForModificationUiModel updatedMarketType);
    }
}
