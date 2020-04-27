using horizonsb.be.contracts.Events;

namespace horizonsb.be.contracts.V1
{
  public interface IEventsControllerDependencyBlock
  {
    ICreateEventProcessor CreateEventProcessor { get; }
    IInquiryEventProcessor InquiryEventProcessor { get; }
    IUpdateEventProcessor UpdateEventProcessor { get; }
    IInquiryAllEventsProcessor InquiryAllEventsProcessor { get; }
    IDeleteEventProcessor DeleteEventProcessor { get; }
  }
}