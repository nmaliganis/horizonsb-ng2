using horizonsb.be.contracts.Events;
using horizonsb.be.contracts.V1;

namespace horizonsb.be.services.V1
{
    public class EventsControllerDependencyBlock : IEventsControllerDependencyBlock
    {
        public EventsControllerDependencyBlock(ICreateEventProcessor createEventProcessor
          , IInquiryEventProcessor inquiryEventProcessor
          , IUpdateEventProcessor updateEventProcessor
          , IInquiryAllEventsProcessor allEventProcessor
          , IDeleteEventProcessor deleteEventProcessor
          )

        {
            CreateEventProcessor = createEventProcessor;
      InquiryEventProcessor = inquiryEventProcessor;
      UpdateEventProcessor = updateEventProcessor;
      InquiryAllEventsProcessor = allEventProcessor;
      DeleteEventProcessor = deleteEventProcessor;
    }

        public ICreateEventProcessor CreateEventProcessor { get; private set; }
    public IInquiryEventProcessor InquiryEventProcessor { get; private set; }
    public IUpdateEventProcessor UpdateEventProcessor { get; private set; }
    public IInquiryAllEventsProcessor InquiryAllEventsProcessor { get; private set; }
    public IDeleteEventProcessor DeleteEventProcessor { get; private set; }
  }
}