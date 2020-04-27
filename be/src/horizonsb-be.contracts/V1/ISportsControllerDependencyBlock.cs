using horizonsb.be.contracts.Sports;

namespace horizonsb.be.contracts.V1
{
    public interface ISportsControllerDependencyBlock
    {
        ICreateSportProcessor CreateSportProcessor { get; }
        IInquirySportProcessor InquirySportProcessor { get; }
        IUpdateSportProcessor UpdateSportProcessor { get; }
        IInquiryAllSportsProcessor InquiryAllSportsProcessor { get; }
        IDeleteSportProcessor DeleteSportProcessor { get; }
    }
}