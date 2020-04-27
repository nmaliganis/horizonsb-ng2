using System;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Tournaments;
using horizonsb.be.model.Tournaments;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Exceptions.Domain.Categories;
using horizonsb.common.infrastructure.Exceptions.Domain.Tournaments;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Tournaments;
using Serilog;

namespace horizonsb.be.services.Tournaments
{
  public class CreateTournamentProcessor : ICreateTournamentProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly ICategoryRepository _categoryRepository;
    private readonly ITournamentRepository _tournamentRepository;
    private readonly IAutoMapper _autoMapper;

    public CreateTournamentProcessor(IUnitOfWork uOf, IAutoMapper autoMapper,
        ITournamentRepository tournamentRepository, ICategoryRepository categoryRepository)
    {
      _uOf = uOf;
      _tournamentRepository = tournamentRepository;
      _categoryRepository = categoryRepository;
      _autoMapper = autoMapper;
    }

    public Task<TournamentUiModel> CreateTournamentAsync(
        TournamentForCreationUiModel newTournamentUiModel)
    {
        var response =
            new TournamentUiModel();

      if (newTournamentUiModel == null)
      {
        return Task.Run(() => response);
      }

      try
      {
        var tournamentToBeCreated = new Tournament();

        tournamentToBeCreated.InjectWithInitialAttributes(newTournamentUiModel);

        var categoryToBeInjected = _categoryRepository.FindByCategoryId(newTournamentUiModel.ParentCategoryId);

        if (categoryToBeInjected == null)
          throw new CategoryDoesNotExistException(newTournamentUiModel.ParentCategoryId);

        tournamentToBeCreated.InjectWithCategory(categoryToBeInjected);

        ThrowExcIfTournamentCannotBeCreated(tournamentToBeCreated);
        ThrowExcIfThisTournamentAlreadyExist(tournamentToBeCreated);

        Log.Information(
            $"Create Tournament: {newTournamentUiModel.Name}" +
            "--CreateTournament--  @NotComplete@ [CreateTournamentProcessor]. " +
            "Message: Just Before MakeItPersistence");

        MakeTournamentPersistent(tournamentToBeCreated);

        Log.Information(
            $"Create Tournament: {newTournamentUiModel.Name}" +
            "--CreateTournament--  @NotComplete@ [CreateTournamentProcessor]. " +
            "Message: Just After MakeItPersistence");
      }
      catch (InvalidTournamentException e)
      {
        Log.Error(
            $"Create Tournament: {newTournamentUiModel.Name}" +
            $"Error Message:{e.Message}" +
            "--CreateTournament--  @NotComplete@ [CreateTournamentProcessor]. " +
            $"Broken rules: {e.BrokenRules}");
      }
      catch (TournamentAlreadyExistsException ex)
      {
        Log.Error(
            $"Create Tournament: {newTournamentUiModel.Name}" +
            $"Error Message:{ex.Message}" +
            "--CreateTournament--  @fail@ [CreateTournamentProcessor]. " +
            $"@innerfault:{ex?.Message} and {ex?.InnerException}");
      }
      catch (TournamentDoesNotExistAfterMadePersistentException exx)
      {
        Log.Error(
            $"Create Tournament: {newTournamentUiModel.Name}" +
            $"Error Message:{exx.Message}" +
            "--CreateTournament--  @fail@ [CreateTournamentProcessor]." +
            $" @innerfault:{exx?.Message} and {exx?.InnerException}");
      }
      catch (Exception exxx)
      {
        Log.Error(
            $"Create Tournament: {newTournamentUiModel.Name}" +
            $"Error Message:{exxx.Message}" +
            $"--CreateTournament--  @fail@ [CreateTournamentProcessor]. " +
            $"@innerfault:{exxx.Message} and {exxx.InnerException}");
      }

      return Task.Run(() => response);
    }

    private void ThrowExcIfThisTournamentAlreadyExist(Tournament tournamentToBeCreated)
    {
      var tournamentRetrieved = _tournamentRepository.FindByName(tournamentToBeCreated.Name);
      if (tournamentRetrieved != null)
      {
        throw new TournamentAlreadyExistsException(tournamentToBeCreated.Name,
            tournamentToBeCreated.GetBrokenRulesAsString());
      }
    }

    private TournamentUiModel ThrowExcIfTournamentWasNotBeMadePersistent(Tournament tournamentToBeCreated)
    {
      var retrievedTournament = _tournamentRepository.FindByName(tournamentToBeCreated.Name);
      if (retrievedTournament != null)
        return _autoMapper.Map<TournamentUiModel>(retrievedTournament);
      throw new TournamentDoesNotExistAfterMadePersistentException(tournamentToBeCreated.Name);
    }

    private void ThrowExcIfTournamentCannotBeCreated(Tournament tournamentToBeCreated)
    {
      bool canBeCreated = !tournamentToBeCreated.GetBrokenRules().Any();
      if (!canBeCreated)
        throw new InvalidTournamentException(tournamentToBeCreated.GetBrokenRulesAsString());
    }

    private void MakeTournamentPersistent(Tournament tournamentToBeMadePersistence)
    {
      _tournamentRepository.Save(tournamentToBeMadePersistence);
      _uOf.Commit();
    }
  }
}
