using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Markets;

namespace horizonsb.be.contracts.Markets
{
    public interface ICreateMarketProcessor
    {
        Task<MarketUiModel> CreateMarketAsync(MarketForCreationUiModel newMarketUiModel);
    }
}