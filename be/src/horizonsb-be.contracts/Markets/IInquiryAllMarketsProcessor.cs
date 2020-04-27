using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.be.model.Events.Markets;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;

namespace horizonsb.be.contracts.Markets
{
    public interface IInquiryAllMarketsProcessor
    {
        Task<PagedList<Market>> GetMarketsAsync(MarketsResourceParameters sportsResourceParameters);
        Task<IList<Market>> GetAllMarketsAsync(string eventId);
    }
}