using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.MarketTypes;
using horizonsb.be.model.MarketTypes;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.MarketTypes;
using Newtonsoft.Json;
using Serilog;

namespace horizonsb.be.services.MarketTypes
{
  public class CreateMarketTypeProcessor : ICreateMarketTypeProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly IMarketTypeRepository _marketTypeRepository;
    private readonly IEventRepository _eventRepository;
    private readonly IAutoMapper _autoMapper;

    public CreateMarketTypeProcessor(IUnitOfWork uOf, IAutoMapper autoMapper,
      IMarketTypeRepository marketTypeRepository, IEventRepository eventRepository)
    {
      _uOf = uOf;
      _marketTypeRepository = marketTypeRepository;
      _eventRepository = eventRepository;
      _autoMapper = autoMapper;
    }

    public Task<MarketTypeUiModel> CreateMarketTypeAsync(MarketTypeForCreationUiModel newMarketTypeUiModel)
    {
      var response =
        new MarketTypeUiModel()
        {
          Message = "START_CREATION"
        };

      if (newMarketTypeUiModel == null)
      {
        response.Message = "ERROR_INVALID_MARKET_TYPES_MODEL";
        return Task.Run(() => response);
      }

      try
      {

        foreach (var marketTypeDto in newMarketTypeUiModel.MarketTypes)
        {
          var marketTypeToBeStored = _marketTypeRepository.FindBySportId(marketTypeDto.Name);
          if (marketTypeToBeStored == null)
          {
            MarketType marketTypeToBeCreated = new MarketType();

            string marketTypesToBeInjected = JsonConvert.SerializeObject(marketTypeDto.Types);

            marketTypeToBeCreated.InjectWithInitialAttributes(marketTypeDto.Name, marketTypesToBeInjected);

            Log.Information(
              $"Create Market Tpe: {marketTypeDto.Name}" +
              "--CreateMarketType--  @NotComplete@ [CreateMarketTypeProcessor]. " +
              "Message: Just Before MakeItPersistence");

            MakeEventPersistent(marketTypeToBeCreated);

            Log.Information(
              $"Create Market Tpe: {marketTypeDto.Name}" +
              "--CreateMarketType--  @NotComplete@ [CreateMarketTypeProcessor]. " +
              "Message: Just After MakeItPersistence");

            response.Message = "CREATE_SUCCESS";
          }
        }
      }
      catch (Exception e)
      {
        response.Message = "UNKNOWN_ERROR";
        Log.Error(
          $"Create Market Types" +
          $"Error Message:{response.Message}" +
          $"--CreateMarketTypes--  @fail@ [CreateMarketTypeProcessor]. " +
          $"@innerfault:{e.Message} and {e.InnerException}");
      }

      return Task.Run(() => response);
    }

    private void MakeEventPersistent(MarketType marketTypeToBeMadePersistence)
    {
      _marketTypeRepository.Save(marketTypeToBeMadePersistence);
      _uOf.Commit();
    }
  }
}
