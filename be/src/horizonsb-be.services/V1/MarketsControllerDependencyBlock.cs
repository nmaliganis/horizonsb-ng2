using horizonsb.be.contracts.Markets;
using horizonsb.be.contracts.V1;

namespace horizonsb.be.services.V1
{
    public class MarketsControllerDependencyBlock : IMarketsControllerDependencyBlock
    {
        public MarketsControllerDependencyBlock(ICreateMarketProcessor createMarketProcessor
          ,IInquiryMarketProcessor inquiryMarketProcessor
          ,IUpdateMarketProcessor updateMarketProcessor
          ,IInquiryAllMarketsProcessor allMarketProcessor
          ,IDeleteMarketProcessor deleteMarketProcessor
          )

        {
            CreateMarketProcessor = createMarketProcessor;
            InquiryMarketProcessor = inquiryMarketProcessor;
            UpdateMarketProcessor = updateMarketProcessor;
            InquiryAllMarketsProcessor = allMarketProcessor;
            DeleteMarketProcessor = deleteMarketProcessor;
        }

        public ICreateMarketProcessor CreateMarketProcessor { get; private set; }
        public IInquiryMarketProcessor InquiryMarketProcessor { get; private set; }
        public IUpdateMarketProcessor UpdateMarketProcessor { get; private set; }
        public IInquiryAllMarketsProcessor InquiryAllMarketsProcessor { get; private set; }
        public IDeleteMarketProcessor DeleteMarketProcessor { get; private set; }
    }
}