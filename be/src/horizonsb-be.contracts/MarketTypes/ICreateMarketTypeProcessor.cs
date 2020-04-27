using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Markets;
using horizonsb.commons.vm.Dtos.MarketTypes;

namespace horizonsb.be.contracts.MarketTypes
{
    public interface ICreateMarketTypeProcessor
    {
        Task<MarketTypeUiModel> CreateMarketTypeAsync(MarketTypeForCreationUiModel newMarketTypeUiModel);
    }
}