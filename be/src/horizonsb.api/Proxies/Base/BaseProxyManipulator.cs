using System.Threading.Tasks;
using horizonsb.be.contracts.Events;
using horizonsb.commons.vm.Dtos.Events;
using Microsoft.Extensions.DependencyInjection;

namespace horizonsb.api.Proxies.Base
{
  public abstract class BaseProxyManipulator
  {
    private IServiceScopeFactory _scopeFactory;

    protected BaseProxyManipulator(IServiceScopeFactory scopeFactory)
    {
      _scopeFactory = scopeFactory;
    }
    protected string ValidateOddStringChar(string odd)
    {
      int lengthAfterDot = odd.Length - odd.IndexOf(".") - 1;

      if (!odd.Contains("."))
        return $"{odd}.00";

      switch (lengthAfterDot)
      {
        case 1:
          return $"{odd}0";
        default:
          return odd;
      }
    }

    protected async Task<EventUiModel> DoScopedWorkByLegacyMarket(string legacyMarketId)
    {
      using (var scope = _scopeFactory.CreateScope())
      {
        var inquiryEventProcessor = scope.ServiceProvider.GetRequiredService<IInquiryEventProcessor>();
        return await inquiryEventProcessor.GetEventByMarketLegacyMarketIdAsync(legacyMarketId);
      }
    }

    protected async Task<EventUiModel> DoScopedWorkByCode(string eventCode)
    {
      using (var scope = _scopeFactory.CreateScope())
      {
        var inquiryEventProcessor = scope.ServiceProvider.GetRequiredService<IInquiryEventProcessor>();
        return await inquiryEventProcessor.GetEventByCodeAsync(eventCode);
      }
    }

    protected async Task<EventUiModel> DoScopedWorkByEventId(string eventId)
    {
      using (var scope = _scopeFactory.CreateScope())
      {
        var inquiryEventProcessor = scope.ServiceProvider.GetRequiredService<IInquiryEventProcessor>();
        return await inquiryEventProcessor.GetEventByEventIdAsync(eventId);
      }
    }

    protected async Task<EventUiModel> DoScopedWorkUpdateByUpcomingLive(string eventId)
    {
      using (var scope = _scopeFactory.CreateScope())
      {
        var updateEventProcessor = scope.ServiceProvider.GetRequiredService<IUpdateEventProcessor>();
        return await updateEventProcessor.UpdateEventWithLiveApiAsync(eventId, true, true);
      }
    }
  }
}
