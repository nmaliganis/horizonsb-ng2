using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Odds;

namespace horizonsb.be.contracts.Odds
{
    public interface IUpdateOddProcessor
    {
        Task<OddUiModel> UpdateOddAsync(OddForModificationUiModel updatedOdd);
    }
}
