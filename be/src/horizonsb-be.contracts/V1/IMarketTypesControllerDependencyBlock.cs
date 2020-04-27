using horizonsb.be.contracts.MarketTypes;

namespace horizonsb.be.contracts.V1
{
    public interface IMarketTypesControllerDependencyBlock
    {
        ICreateMarketTypeProcessor CreateMarketTypeProcessor { get; }
        IInquiryMarketTypeProcessor InquiryMarketTypeProcessor { get; }
        IUpdateMarketTypeProcessor UpdateMarketTypeProcessor { get; }
        IInquiryAllMarketTypesProcessor InquiryAllMarketTypesProcessor { get; }
        IDeleteMarketTypeProcessor DeleteMarketTypeProcessor { get; }
    }
}