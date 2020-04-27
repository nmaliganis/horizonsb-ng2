using System;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Markets;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Exceptions.Domain.Markets;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Markets;
using Serilog;

namespace horizonsb.be.services.Markets
{
  public class CreateMarketProcessor : ICreateMarketProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly IMarketRepository _marketRepository;
    private readonly IEventRepository _eventRepository;
    private readonly IAutoMapper _autoMapper;

    public CreateMarketProcessor(IUnitOfWork uOf, IAutoMapper autoMapper,
      IMarketRepository marketRepository, IEventRepository eventRepository)
    {
      _uOf = uOf;
      _marketRepository = marketRepository;
      _eventRepository = eventRepository;
      _autoMapper = autoMapper;
    }

    public Task<MarketUiModel> CreateMarketAsync(
      MarketForCreationUiModel newMarketUiModel)
    {
      var response =
        new MarketUiModel()
        {
          Status = true,
          Message = "START_CREATION"
        };

      if (newMarketUiModel == null)
      {
        response.Message = "ERROR_INVALID_SPORT_MODEL";
        return Task.Run(() => response);
      }

      try
      {
        var marketToBeCreated = new Market();

        marketToBeCreated.InjectWithInitialAttributes(newMarketUiModel);

        var eventToBeInjected = _eventRepository.FindByEventId(newMarketUiModel.ParentEventId);

        if (eventToBeInjected.Count == 0)
        {
          response.Message = "ERROR_EVENT_DOES_NOT_EXIST";
          return Task.Run(() => response);
        }
        //throw new EventDoesNotExistException(newMarketUiModel.ParentEventId);

        if (eventToBeInjected.Count != 0)
        {
          marketToBeCreated.InjectWithEvent(eventToBeInjected[0]);

          ThrowExcIfMarketCannotBeCreated(marketToBeCreated);
          ThrowExcIfThisMarketAlreadyExist(marketToBeCreated, eventToBeInjected[0].Id);
        }

        Log.Information(
          $"Create Market: {newMarketUiModel.Name}" +
          "--CreateMarket--  @NotComplete@ [CreateMarketProcessor]. " +
          "Message: Just Before MakeItPersistence");

        MakeMarketPersistent(marketToBeCreated);

        response.Status = true;

        Log.Information(
          $"Create Market: {newMarketUiModel.Name}" +
          "--CreateMarket--  @NotComplete@ [CreateMarketProcessor]. " +
          "Message: Just After MakeItPersistence");
        response.Message = "SUCCESS_CREATION";
      }
      catch (InvalidMarketException e)
      {
        response.Message = "ERROR_INVALID_SPORT_MODEL";
        response.Status = false;

        Log.Error(
          $"Create Market: {newMarketUiModel.Name}" +
          $"Error Message:{response.Message}" +
          "--CreateMarket--  @NotComplete@ [CreateMarketProcessor]. " +
          $"Broken rules: {e.BrokenRules}");
      }
      catch (MarketAlreadyExistsException ex)
      {
        response.Message = "ERROR_SPORT_ALREADY_EXISTS";
        response.Status = false;
        Log.Error(
          $"Create Market: {newMarketUiModel.Name}" +
          $"Error Message:{response.Message}" +
          "--CreateMarket--  @fail@ [CreateMarketProcessor]. " +
          $"@innerfault:{ex?.Message} and {ex?.InnerException}");
      }
      catch (MarketDoesNotExistAfterMadePersistentException exx)
      {
        response.Message = "ERROR_SPORT_NOT_MADE_PERSISTENT";
        response.Status = false;
        Log.Error(
          $"Create Market: {newMarketUiModel.Name}" +
          $"Error Message:{response.Message}" +
          "--CreateMarket--  @fail@ [CreateMarketProcessor]." +
          $" @innerfault:{exx?.Message} and {exx?.InnerException}");
      }
      catch (Exception exxx)
      {
        response.Message = "UNKNOWN_ERROR";
        response.Status = false;
        Log.Error(
          $"Create Market: {newMarketUiModel.Name}" +
          $"Error Message:{response.Message}" +
          $"--CreateMarket--  @fail@ [CreateMarketProcessor]. " +
          $"@innerfault:{exxx.Message} and {exxx.InnerException}");
      }

      return Task.Run(() => response);
    }

    private void ThrowExcIfThisMarketAlreadyExist(Market marketToBeCreated, Guid eventId)
    {
      var marketRetrieved = _marketRepository.FindByMarketAllIdAndEventId(marketToBeCreated.MarketId, eventId);

      //var marketRetrieved = _marketRepository.FindByNameAndMarketIdAndTypeAndParentEventId(marketToBeCreated.Name, marketToBeCreated.MarketId, marketToBeCreated.Type, eventId);
      if (marketRetrieved.Count >= 1)
      {
        throw new MarketAlreadyExistsException(marketToBeCreated.Name,
          marketToBeCreated.GetBrokenRulesAsString());
      }
    }

    private MarketUiModel ThrowExcIfMarketWasNotBeMadePersistent(Market sportToBeCreated)
    {
      var retrievedMarket = _marketRepository.FindByName(sportToBeCreated.Name);
      if (retrievedMarket != null)
        return _autoMapper.Map<MarketUiModel>(retrievedMarket);
      throw new MarketDoesNotExistAfterMadePersistentException(sportToBeCreated.Name);
    }

    private void ThrowExcIfMarketCannotBeCreated(Market sportToBeCreated)
    {
      bool canBeCreated = !sportToBeCreated.GetBrokenRules().Any();
      if (!canBeCreated)
        throw new InvalidMarketException(sportToBeCreated.GetBrokenRulesAsString());
    }

    private void MakeMarketPersistent(Market sportToBeMadePersistence)
    {
      _marketRepository.Save(sportToBeMadePersistence);
      _uOf.Commit();
    }
  }
}
