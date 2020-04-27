using System;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Odds;
using horizonsb.be.model.Events.Markets.Odds;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Exceptions.Domain.Odds;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Odds;
using Serilog;

namespace horizonsb.be.services.Odds
{
  public class CreateOddProcessor : ICreateOddProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly IOddRepository _oddRepository;
    private readonly IMarketRepository _marketRepository;
    private readonly IAutoMapper _autoMapper;

    public CreateOddProcessor(IUnitOfWork uOf, IAutoMapper autoMapper,
      IOddRepository oddRepository, IMarketRepository marketRepository)
    {
      _uOf = uOf;
      _oddRepository = oddRepository;
      _marketRepository = marketRepository;
      _autoMapper = autoMapper;
    }

    public Task<OddUiModel> CreateOddAsync(
      OddForCreationUiModel newOddUiModel)
    {
      var response =
        new OddUiModel()
        {
          Message = "START_CREATION"
        };

      if (newOddUiModel == null)
      {
        response.Message = "ERROR_INVALID_SPORT_MODEL";
        return Task.Run(() => response);
      }

      try
      {
        var oddToBeCreated = new Odd();

        oddToBeCreated.InjectWithInitialAttributes(newOddUiModel);

        var marketToBeInjected = _marketRepository.FindByMarketIdAndEventId(newOddUiModel.ParentMarketId, newOddUiModel.ParentEventId);

        if (marketToBeInjected == null)
        {
          response.Message = "ERROR_MARKET_DOES_NOT_EXIST";
          return Task.Run(() => response);
        }
        //throw new MarketDoesNotExistException(newOddUiModel.ParentMarketId);

        oddToBeCreated.InjectWithMarket(marketToBeInjected);
        ThrowExcIfOddCannotBeCreated(oddToBeCreated);
        ThrowExcIfThisOddAlreadyExist(oddToBeCreated);

        Log.Information(
          $"Create Odd: {newOddUiModel.Name}" +
          "--CreateOdd--  @NotComplete@ [CreateOddProcessor]. " +
          "Message: Just Before MakeItPersistence");

        MakeOddPersistent(oddToBeCreated);

        Log.Information(
          $"Create Odd: {newOddUiModel.Name}" +
          "--CreateOdd--  @NotComplete@ [CreateOddProcessor]. " +
          "Message: Just After MakeItPersistence");
        response.Message = "SUCCESS_CREATION";
      }
      catch (InvalidOddException e)
      {
        response.Message = "ERROR_INVALID_ODD_MODEL";
        Log.Error(
          $"Create Odd: {newOddUiModel.Name}" +
          $"Error Message:{response.Message}" +
          "--CreateOdd--  @NotComplete@ [CreateOddProcessor]. " +
          $"Broken rules: {e.BrokenRules}");
      }
      catch (OddAlreadyExistsException ex)
      {
        response.Message = "ERROR_ODD_ALREADY_EXISTS";
        Log.Error(
          $"Create Odd: {newOddUiModel.Name}" +
          $"Error Message:{response.Message}" +
          "--CreateOdd--  @fail@ [CreateOddProcessor]. " +
          $"@innerfault:{ex?.Message} and {ex?.InnerException}");
      }
      catch (OddDoesNotExistAfterMadePersistentException exx)
      {
        response.Message = "ERROR_ODD_NOT_MADE_PERSISTENT";
        Log.Error(
          $"Create Odd: {newOddUiModel.Name}" +
          $"Error Message:{response.Message}" +
          "--CreateOdd--  @fail@ [CreateOddProcessor]." +
          $" @innerfault:{exx?.Message} and {exx?.InnerException}");
      }
      catch (Exception exxx)
      {
        response.Message = "UNKNOWN_ERROR";
        Log.Error(
          $"Create Odd: {newOddUiModel.Name}" +
          $"Error Message:{response.Message}" +
          $"--CreateOdd--  @fail@ [CreateOddProcessor]. " +
          $"@innerfault:{exxx.Message} and {exxx.InnerException}");
      }

      return Task.Run(() => response);
    }

    private void ThrowExcIfThisOddAlreadyExist(Odd oddToBeCreated)
    {
      var oddRetrieved = _oddRepository.FindByNameAndOddId(oddToBeCreated.Name, oddToBeCreated.OddId);
      if (oddRetrieved.Count >= 1)
      {
        throw new OddAlreadyExistsException(oddToBeCreated.Name,
          oddToBeCreated.GetBrokenRulesAsString());
      }
    }
    private void ThrowExcIfOddCannotBeCreated(Odd oddToBeCreated)
    {
      bool canBeCreated = !oddToBeCreated.GetBrokenRules().Any();
      if (!canBeCreated)
        throw new InvalidOddException(oddToBeCreated.GetBrokenRulesAsString());
    }

    private void MakeOddPersistent(Odd oddToBeMadePersistence)
    {
      _oddRepository.Save(oddToBeMadePersistence);
      _uOf.Commit();
    }
  }
}
