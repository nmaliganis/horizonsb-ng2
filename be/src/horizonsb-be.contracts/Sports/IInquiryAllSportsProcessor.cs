using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.be.model.Sports;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;

namespace horizonsb.be.contracts.Sports
{
    public interface IInquiryAllSportsProcessor
    {
        Task<IList<Sport>> GetSportsAllAsync();
        Task<PagedList<Sport>> GetSportsAsync(SportsResourceParameters sportsResourceParameters);
        Task<int> GetTotalCountSportsAsync();
    }
}