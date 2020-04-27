using horizonsb.be.contracts.Markets;

namespace horizonsb.be.contracts.V1
{
    public interface IMarketsControllerDependencyBlock
    {
        ICreateMarketProcessor CreateMarketProcessor { get; }
        IInquiryMarketProcessor InquiryMarketProcessor { get; }
        IUpdateMarketProcessor UpdateMarketProcessor { get; }
        IInquiryAllMarketsProcessor InquiryAllMarketsProcessor { get; }
        IDeleteMarketProcessor DeleteMarketProcessor { get; }
    }
}