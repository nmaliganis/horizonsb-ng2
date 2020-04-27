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
    public class CreateSportProcessor : ICreateSportProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly ISportRepository _sportRepository;
        private readonly IAutoMapper _autoMapper;

        public CreateSportProcessor(IUnitOfWork uOf, IAutoMapper autoMapper,
            ISportRepository sportRepository)
        {
            _uOf = uOf;
            _sportRepository = sportRepository;
            _autoMapper = autoMapper;
        }

        public Task<SportUiModel> CreateSportAsync(
            SportForCreationUiModel newSportUiModel)
        {
            var response =
                new SportUiModel()
                {
                    Message = "START_CREATION"
                };

            if (newSportUiModel == null)
            {
                response.Message = "ERROR_INVALID_SPORT_MODEL";
                return Task.Run(() => response);
            }

            try
            {
                var sportToBeCreated = new Sport();

                sportToBeCreated.InjectWithInitialAttributes(newSportUiModel);

                ThrowExcIfSportCannotBeCreated(sportToBeCreated);
                ThrowExcIfThisSportAlreadyExist(sportToBeCreated);

                Log.Information(
                    $"Create Sport: {newSportUiModel.Name}" +
                    "--CreateSport--  @NotComplete@ [CreateSportProcessor]. " +
                    "Message: Just Before MakeItPersistence");

                MakeSportPersistent(sportToBeCreated);

                Log.Information(
                    $"Create Sport: {newSportUiModel.Name}" +
                    "--CreateSport--  @NotComplete@ [CreateSportProcessor]. " +
                    "Message: Just After MakeItPersistence");
                response.Message = "SUCCESS_CREATION";
            }
            catch (InvalidSportException e)
            {
                response.Message = "ERROR_INVALID_SPORT_MODEL";
                Log.Error(
                    $"Create Sport: {newSportUiModel.Name}" +
                    $"Error Message:{response.Message}" +
                    "--CreateSport--  @NotComplete@ [CreateSportProcessor]. " +
                    $"Broken rules: {e.BrokenRules}");
            }
            catch (SportAlreadyExistsException ex)
            {
                response.Message = "ERROR_SPORT_ALREADY_EXISTS";
                Log.Error(
                    $"Create Sport: {newSportUiModel.Name}" +
                    $"Error Message:{response.Message}" +
                    "--CreateSport--  @fail@ [CreateSportProcessor]. " +
                    $"@innerfault:{ex?.Message} and {ex?.InnerException}");
            }
            catch (SportDoesNotExistAfterMadePersistentException exx)
            {
                response.Message = "ERROR_SPORT_NOT_MADE_PERSISTENT";
                Log.Error(
                    $"Create Sport: {newSportUiModel.Name}" +
                    $"Error Message:{response.Message}" +
                    "--CreateSport--  @fail@ [CreateSportProcessor]." +
                    $" @innerfault:{exx?.Message} and {exx?.InnerException}");
            }
            catch (Exception exxx)
            {
                response.Message = "UNKNOWN_ERROR";
                Log.Error(
                    $"Create Sport: {newSportUiModel.Name}" +
                    $"Error Message:{response.Message}" +
                    $"--CreateSport--  @fail@ [CreateSportProcessor]. " +
                    $"@innerfault:{exxx.Message} and {exxx.InnerException}");
            }

            return Task.Run(() => response);
        }

        private void ThrowExcIfThisSportAlreadyExist(Sport sportToBeCreated)
        {
            var sportRetrieved = _sportRepository.FindBySportId(sportToBeCreated.SportId);
            if (sportRetrieved != null)
            {
                throw new SportAlreadyExistsException(sportToBeCreated.Name,
                    sportToBeCreated.GetBrokenRulesAsString());
            }
        }

        private SportUiModel ThrowExcIfSportWasNotBeMadePersistent(Sport sportToBeCreated)
        {
            var retrievedSport = _sportRepository.FindByName(sportToBeCreated.Name);
            if (retrievedSport  != null)
                return _autoMapper.Map<SportUiModel>(retrievedSport);
            throw new SportDoesNotExistAfterMadePersistentException(sportToBeCreated.Name);
        }

        private void ThrowExcIfSportCannotBeCreated(Sport sportToBeCreated)
        {
            bool canBeCreated = !sportToBeCreated.GetBrokenRules().Any();
            if (!canBeCreated)
                throw new InvalidSportException(sportToBeCreated.GetBrokenRulesAsString());
        }

        private void MakeSportPersistent(Sport sportToBeMadePersistence)
        {
            _sportRepository.Save(sportToBeMadePersistence);
            _uOf.Commit();
        }
    }
}
