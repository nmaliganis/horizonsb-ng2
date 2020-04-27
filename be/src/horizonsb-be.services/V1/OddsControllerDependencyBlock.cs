using horizonsb.be.contracts.Odds;
using horizonsb.be.contracts.V1;

namespace horizonsb.be.services.V1
{
    public class OddsControllerDependencyBlock : IOddsControllerDependencyBlock
    {
        public OddsControllerDependencyBlock(ICreateOddProcessor createOddProcessor
          ,IInquiryOddProcessor inquiryOddProcessor
          ,IUpdateOddProcessor updateOddProcessor
          ,IInquiryAllOddsProcessor allOddProcessor
          ,IDeleteOddProcessor deleteOddProcessor
          )

        {
            CreateOddProcessor = createOddProcessor;
            InquiryOddProcessor = inquiryOddProcessor;
            UpdateOddProcessor = updateOddProcessor;
            InquiryAllOddsProcessor = allOddProcessor;
            DeleteOddProcessor = deleteOddProcessor;
        }

        public ICreateOddProcessor CreateOddProcessor { get; private set; }
        public IInquiryOddProcessor InquiryOddProcessor { get; private set; }
        public IUpdateOddProcessor UpdateOddProcessor { get; private set; }
        public IInquiryAllOddsProcessor InquiryAllOddsProcessor { get; private set; }
        public IDeleteOddProcessor DeleteOddProcessor { get; private set; }
    }
}