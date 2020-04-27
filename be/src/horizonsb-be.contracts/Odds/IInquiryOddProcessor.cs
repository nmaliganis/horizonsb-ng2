using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Odds;

namespace horizonsb.be.contracts.Odds
{
    public interface IInquiryOddProcessor
    {
        Task<OddUiModel> GetOddAsync(Guid id);
    }
}