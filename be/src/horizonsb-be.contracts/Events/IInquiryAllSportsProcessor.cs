using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.be.model.Events;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;

namespace horizonsb.be.contracts.Events
{
    public interface IInquiryAllEventsProcessor
    {
        Task<PagedList<Match>> GetEventsAsync(EventsResourceParameters eventsResourceParameters);
        Task<PagedList<Match>> GetFavoriteEventsAsync(EventsResourceParameters eventsResourceParameters);
        Task<PagedList<Match>> GetLiveEventsAsync(EventsResourceParameters eventsResourceParameters);
        Task<int> GetTotalCountEventsAsync();
    }
}