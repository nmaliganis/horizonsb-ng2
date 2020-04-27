using System;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Sports;
using horizonsb.be.model.Sports;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Exceptions.Domain.Sports;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Sports;
using Serilog;

namespace horizonsb.be.services.Sports
{
  public class UpdateSportProcessor : IUpdateSportProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly ISportRepository _sportRepository;
    private readonly IAutoMapper _autoMapper;

    public UpdateSportProcessor(IUnitOfWork uOf, IAutoMapper autoMapper, ISportRepository sportRepository)
    {
      _uOf = uOf;
      _sportRepository = sportRepository;
      _autoMapper = autoMapper;
    }

    public Task<SportUiModel> UpdateSportAsync(Guid sportIdToBeUpdated, SportForModificationUiModel updatedSport)
    {
      var response =
        new SportUiModel()
        {
          Message = "START_MODIFICATION"
        };

      if (updatedSport == null)
      {
        response.Message = "ERROR_INVALID_SPORT_MODEL";
        return Task.Run(() => response);
      }

      try
      {
        var sportToBeUpdated = _sportRepository.FindBy(sportIdToBeUpdated);

        sportToBeUpdated.ModifyPriorityWith(updatedSport.NewPriority);

        ThrowExcIfSportCannotBeUpdated(sportToBeUpdated);

        Log.Information(
          $"Update Sport: {sportToBeUpdated.Name}" +
          "--UpdateSport--  @NotComplete@ [UpdateSportProcessor]. " +
          "Message: Just Before MakeItPersistence");

        MakeSportPersistent(sportToBeUpdated);

        Log.Information(
          $"Update Sport: {sportToBeUpdated.Name}" +
          "--UpdateSport--  @NotComplete@ [UpdateSportProcessor]. " +
          "Message: Just After MakeItPersistence");
        response.Message = "SUCCESS_CREATION";
      }
      catch (Exception exxx)
      {
        response.Message = "UNKNOWN_ERROR";
        Log.Error(
          $"Update Sport" +
          $"Error Message:{response.Message}" +
          $"--UpdateSport--  @fail@ [UpdateSportProcessor]. " +
          $"@innerfault:{exxx.Message} and {exxx.InnerException}");
      }

      return Task.Run(() => response);
    }

    public Task<SportUiModel> UpdateConfigurationSportAsync(string sportIdToBeUpdated, SportForModificationConfigurationUiModel updatedSport)
    {
      var response =
        new SportUiModel()
        {
          Message = "START_MODIFICATION"
        };

      if (updatedSport == null)
      {
        response.Message = "ERROR_INVALID_SPORT_MODEL";
        return Task.Run(() => response);
      }

      try
      {
        var sportToBeUpdated = _sportRepository.FindBySportId(sportIdToBeUpdated);

        sportToBeUpdated.ModifyConfigurationWith((int)updatedSport.ModifiedConfiguration);

        ThrowExcIfSportCannotBeUpdated(sportToBeUpdated);

        Log.Information(
          $"Update Sport: {sportToBeUpdated.Name}" +
          "--UpdateSport--  @NotComplete@ [UpdateSportProcessor]. " +
          "Message: Just Before MakeItPersistence");

        MakeSportPersistent(sportToBeUpdated);

        Log.Information(
          $"Update Sport: {sportToBeUpdated.Name}" +
          "--UpdateSport--  @NotComplete@ [UpdateSportProcessor]. " +
          "Message: Just After MakeItPersistence");
        response.Message = "SUCCESS_CREATION";
      }
      catch (Exception exxx)
      {
        response.Message = "UNKNOWN_ERROR";
        Log.Error(
          $"Update Sport" +
          $"Error Message:{response.Message}" +
          $"--UpdateSport--  @fail@ [UpdateSportProcessor]. " +
          $"@innerfault:{exxx.Message} and {exxx.InnerException}");
      }

      return Task.Run(() => response);
    }


    private void ThrowExcIfSportCannotBeUpdated(Sport sportToBeUpdated)
    {
      bool canBeUpdated = !sportToBeUpdated.GetBrokenRules().Any();
      if (!canBeUpdated)
        throw new InvalidSportException(sportToBeUpdated.GetBrokenRulesAsString());
    }

    private void MakeSportPersistent(Sport sportToBeMadePersistence)
    {
      _sportRepository.Save(sportToBeMadePersistence);
      _uOf.Commit();
    }
  }
}