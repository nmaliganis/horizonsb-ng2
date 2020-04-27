using horizonsb.be.contracts.Odds;

namespace horizonsb.be.contracts.V1
{
    public interface IOddsControllerDependencyBlock
    {
        ICreateOddProcessor CreateOddProcessor { get; }
        IInquiryOddProcessor InquiryOddProcessor { get; }
        IUpdateOddProcessor UpdateOddProcessor { get; }
        IInquiryAllOddsProcessor InquiryAllOddsProcessor { get; }
        IDeleteOddProcessor DeleteOddProcessor { get; }
    }
}