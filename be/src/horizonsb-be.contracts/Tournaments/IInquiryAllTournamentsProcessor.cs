using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.be.model.Tournaments;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;

namespace horizonsb.be.contracts.Tournaments
{
    public interface IInquiryAllTournamentsProcessor
    {
        Task<PagedList<Tournament>> GetTournamentsAsync(TournamentsResourceParameters tournamentsResourceParameters);
        Task<PagedList<Tournament>> GetTournamentsAsync(Guid sportId, TournamentsResourceParameters tournamentsResourceParameters);
        Task<int> GetTotalCountTournamentsAsync();
    }
}