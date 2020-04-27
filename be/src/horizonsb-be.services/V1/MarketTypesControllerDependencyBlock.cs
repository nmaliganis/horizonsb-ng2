using horizonsb.be.contracts.MarketTypes;
using horizonsb.be.contracts.V1;

namespace horizonsb.be.services.V1
{
    public class MarketTypesControllerDependencyBlock : IMarketTypesControllerDependencyBlock
    {
        public MarketTypesControllerDependencyBlock(ICreateMarketTypeProcessor createMarketTypeProcessor
          ,IInquiryMarketTypeProcessor inquiryMarketTypeProcessor
          ,IUpdateMarketTypeProcessor updateMarketTypeProcessor
          ,IInquiryAllMarketTypesProcessor allMarketTypeProcessor
          ,IDeleteMarketTypeProcessor deleteMarketTypeProcessor
          )

        {
            CreateMarketTypeProcessor = createMarketTypeProcessor;
            InquiryMarketTypeProcessor = inquiryMarketTypeProcessor;
            UpdateMarketTypeProcessor = updateMarketTypeProcessor;
            InquiryAllMarketTypesProcessor = allMarketTypeProcessor;
            DeleteMarketTypeProcessor = deleteMarketTypeProcessor;
        }

        public ICreateMarketTypeProcessor CreateMarketTypeProcessor { get; private set; }
        public IInquiryMarketTypeProcessor InquiryMarketTypeProcessor { get; private set; }
        public IUpdateMarketTypeProcessor UpdateMarketTypeProcessor { get; private set; }
        public IInquiryAllMarketTypesProcessor InquiryAllMarketTypesProcessor { get; private set; }
        public IDeleteMarketTypeProcessor DeleteMarketTypeProcessor { get; private set; }
    }
}