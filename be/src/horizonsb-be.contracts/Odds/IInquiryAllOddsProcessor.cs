using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.be.model.Events.Markets.Odds;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;

namespace horizonsb.be.contracts.Odds
{
    public interface IInquiryAllOddsProcessor
    {
        Task<PagedList<Odd>> GetOddsAsync(OddsResourceParameters oddsResourceParameters);
    }
}