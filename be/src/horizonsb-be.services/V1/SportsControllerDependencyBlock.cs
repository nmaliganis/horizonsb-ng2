using horizonsb.be.contracts.Sports;
using horizonsb.be.contracts.V1;

namespace horizonsb.be.services.V1
{
    public class SportsControllerDependencyBlock : ISportsControllerDependencyBlock
    {
        public SportsControllerDependencyBlock(ICreateSportProcessor createSportProcessor
          ,IInquirySportProcessor inquirySportProcessor
          ,IUpdateSportProcessor updateSportProcessor
          ,IInquiryAllSportsProcessor allSportProcessor
          ,IDeleteSportProcessor deleteSportProcessor
          )

        {
            CreateSportProcessor = createSportProcessor;
            InquirySportProcessor = inquirySportProcessor;
            UpdateSportProcessor = updateSportProcessor;
            InquiryAllSportsProcessor = allSportProcessor;
            DeleteSportProcessor = deleteSportProcessor;
        }

        public ICreateSportProcessor CreateSportProcessor { get; private set; }
        public IInquirySportProcessor InquirySportProcessor { get; private set; }
        public IUpdateSportProcessor UpdateSportProcessor { get; private set; }
        public IInquiryAllSportsProcessor InquiryAllSportsProcessor { get; private set; }
        public IDeleteSportProcessor DeleteSportProcessor { get; private set; }
    }
}