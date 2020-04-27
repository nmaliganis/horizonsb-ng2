using System.Collections.Generic;
using System.Threading.Tasks;
using horizonsb.be.model.MarketTypes;

namespace horizonsb.be.contracts.MarketTypes
{
    public interface IInquiryAllMarketTypesProcessor
    {
        Task<IList<MarketType>> GetAllMarketTypesAsync();
    }
}