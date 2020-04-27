using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Odds;

namespace horizonsb.be.contracts.Odds
{
    public interface ICreateOddProcessor
    {
        Task<OddUiModel> CreateOddAsync(OddForCreationUiModel newOddUiModel);
    }
}