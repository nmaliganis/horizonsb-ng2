using System;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Tournaments;
using horizonsb.be.model.Tournaments;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Exceptions.Domain.Tournaments;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Tournaments;
using Serilog;

namespace horizonsb.be.services.Tournaments
{
  public class UpdateTournamentProcessor : IUpdateTournamentProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly ITournamentRepository _tournamentRepository;
    private readonly IAutoMapper _autoMapper;

    public UpdateTournamentProcessor(IUnitOfWork uOf, IAutoMapper autoMapper, ITournamentRepository tournamentRepository)
    {
      _uOf = uOf;
      _tournamentRepository = tournamentRepository;
      _autoMapper = autoMapper;
    }

    public Task<TournamentUiModel> UpdateTournamentAsync(Guid tournamentIdToBeUpdated, TournamentForModificationUiModel updatedTournament)
    {
      var response =
        new TournamentUiModel()
        {
        };

      if (updatedTournament == null)
      {
        return Task.Run(() => response);
      }

      try
      {
        var tournamentToBeUpdated = _tournamentRepository.FindBy(tournamentIdToBeUpdated);

        tournamentToBeUpdated.ModifyPriorityWith(updatedTournament.NewPriority);

        ThrowExcIfTournamentCannotBeUpdated(tournamentToBeUpdated);

        Log.Information(
          $"Update Tournament: {tournamentToBeUpdated.Name}" +
          "--UpdateTournament--  @NotComplete@ [UpdateTournamentProcessor]. " +
          "Message: Just Before MakeItPersistence");

        MakeTournamentPersistent(tournamentToBeUpdated);

        Log.Information(
          $"Update Tournament: {tournamentToBeUpdated.Name}" +
          "--UpdateTournament--  @NotComplete@ [UpdateTournamentProcessor]. " +
          "Message: Just After MakeItPersistence");
      }
      catch (Exception e)
      {
        Log.Error(
          $"Update Tournament" +
          $"Error Message:{e.Message}" +
          $"--UpdateTournament--  @fail@ [UpdateTournamentProcessor]. " +
          $"@innerfault:{e.Message} and {e.InnerException}");
      }

      return Task.Run(() => response);
    }


    private void ThrowExcIfTournamentCannotBeUpdated(Tournament tournamentToBeUpdated)
    {
      bool canBeUpdated = !tournamentToBeUpdated.GetBrokenRules().Any();
      if (!canBeUpdated)
        throw new InvalidTournamentException(tournamentToBeUpdated.GetBrokenRulesAsString());
    }

    private void MakeTournamentPersistent(Tournament tournamentToBeMadePersistence)
    {
      _tournamentRepository.Save(tournamentToBeMadePersistence);
      _uOf.Commit();
    }
  }
}