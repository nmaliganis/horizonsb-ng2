using System;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Events;
using horizonsb.be.model.Events;
using horizonsb.be.model.Teams;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Exceptions.Domain.Events;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Events;
using Serilog;

namespace horizonsb.be.services.Events
{
  public class CreateEventProcessor : ICreateEventProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly IEventRepository _eventRepository;
    private readonly ITournamentRepository _tournamentRepository;
    private readonly IAutoMapper _autoMapper;

    public CreateEventProcessor(IUnitOfWork uOf, IAutoMapper autoMapper,
      IEventRepository eventRepository, ITournamentRepository tournamentRepository)
    {
      _uOf = uOf;
      _eventRepository = eventRepository;
      _tournamentRepository = tournamentRepository;
      _autoMapper = autoMapper;
    }

    public Task<EventUiModel> CreateEventAsync(EventForCreationUiModel newEventUiModel, int priority = 1)
    {
      var response = new EventUiModel();

      var eventToBeCreated = new Match();

      if (newEventUiModel == null)
      {
        return Task.Run(() => response);
      }

      if (newEventUiModel.UpcomingLive)
      {
        Log.Information(
          $"Event Name: {newEventUiModel.Name} Event Id: {newEventUiModel.EventId} UpComingLive: {newEventUiModel.UpcomingLive} ");
      }

      try
      {
        eventToBeCreated.InjectWithInitialAttributes(newEventUiModel, priority);
        
        var tournamentToBeInjected = _tournamentRepository.FindByTournamentId(newEventUiModel.ParentTournamentId);

        if (tournamentToBeInjected == null)
        {
          return Task.Run(() => response);
        }

        eventToBeCreated.InjectWithTournament(tournamentToBeInjected);

        if(newEventUiModel.Teams != null)
        {

          foreach (var teamForCreationUiModel in newEventUiModel.Teams)
          {
            var teamToBeAdded = new Team()
            {
              Name = teamForCreationUiModel.Name,
              IsHome = teamForCreationUiModel.IsHome,
            };
            eventToBeCreated.InjectWithNewTeam(teamToBeAdded);
          }
        }

        ThrowExcIfEventCannotBeCreated(eventToBeCreated);

        var eventRetrieved = _eventRepository.FindByEventIdAndCode(eventToBeCreated.MatchId, eventToBeCreated.Code).FirstOrDefault();

        Log.Information(
          $"Create Event: {newEventUiModel.Name}" +
          "--CreateEvent--  @NotComplete@ [CreateEventProcessor]. " +
          "Message: Just Before MakeItPersistence");


        if (eventRetrieved != null)
        {
          MappingForUpdate(eventRetrieved, eventToBeCreated);
          MakeEventPersistent(eventRetrieved);
        }
        else
        {
          MakeEventPersistent(eventToBeCreated);
        }

        response.Status = true;

        Log.Information(
          $"Create Event: {newEventUiModel.Name}" +
          "--CreateEvent--  @NotComplete@ [CreateEventProcessor]. " +
          "Message: Just After MakeItPersistence");
      }
      catch (InvalidEventException e)
      {
        response.Status = false;
        Log.Error(
          $"Create Event: {newEventUiModel.Name}" +
          $"Error Message:{e.Message}" +
          "--CreateEvent--  @NotComplete@ [CreateEventProcessor]. " +
          $"Broken rules: {e.BrokenRules}");
      }
      catch (EventAlreadyExistsException ex)
      {
        response.Status = false;
        Log.Error(
          $"Create Event: {newEventUiModel.Name}" +
          $"Error Message:{ex.Message}" +
          "--CreateEvent--  @fail@ [CreateEventProcessor]. " +
          $"@innerfault:{ex?.Message} and {ex?.InnerException}");
      }
      catch (EventDoesNotExistAfterMadePersistentException exx)
      {
        response.Status = false;
        Log.Error(
          $"Create Event: {newEventUiModel.Name}" +
          $"Error Message:{exx.Message}" +
          "--CreateEvent--  @fail@ [CreateEventProcessor]." +
          $" @innerfault:{exx?.Message} and {exx?.InnerException}");
      }
      catch (Exception exxx)
      {
        response.Status = false;
        response.Message = "UNKNOWN_ERROR";
        Log.Error(
          $"Create Event: {newEventUiModel.Name}" +
          $"Error Message:{exxx.Message}" +
          $"--CreateEvent--  @fail@ [CreateEventProcessor]. " +
          $"@innerfault:{exxx.Message} and {exxx.InnerException}");
      }

      return Task.Run(() => response);
    }

    private void MappingForUpdate(Match eventRetrieved, Match eventToBeCreated)
    {
      eventRetrieved.Name = eventToBeCreated.Name;
      eventRetrieved.Live = eventToBeCreated.Live;
      eventRetrieved.UpcomingLive = eventToBeCreated.UpcomingLive;
      eventRetrieved.Antepost = eventToBeCreated.Antepost;
      eventRetrieved.AntepostEventUrl = eventToBeCreated.AntepostEventUrl;
      eventRetrieved.BetBuilder = eventToBeCreated.BetBuilder;
      eventRetrieved.CurrentPeriod = eventToBeCreated.CurrentPeriod;
      eventRetrieved.CurrentPeriodName = eventToBeCreated.CurrentPeriodName;
      eventRetrieved.Neutral = eventToBeCreated.Neutral;
      eventRetrieved.PopularEventUrl = eventToBeCreated.PopularEventUrl;
      eventRetrieved.Possession = eventToBeCreated.Possession;
      eventRetrieved.Path = eventToBeCreated.Path;
      eventRetrieved.Time = eventToBeCreated.Time;
      eventRetrieved.TodayEventUrl = eventToBeCreated.TodayEventUrl;
      eventRetrieved.Version = eventToBeCreated.Version;
      eventRetrieved.Timestamp = eventToBeCreated.Timestamp;
      eventRetrieved.WinningLegsBonus = eventToBeCreated.WinningLegsBonus;
      eventRetrieved.Status = eventToBeCreated.Status;
      eventRetrieved.Resulted = eventToBeCreated.Resulted;
      eventRetrieved.DateEvent = eventToBeCreated.DateEvent;
      eventRetrieved.StoredDate = DateTime.UtcNow;
    }

    private void ThrowExcIfThisEventAlreadyExist(Match eventToBeCreated)
    {
      var eventRetrieved = _eventRepository.FindByEventIdAndCode(eventToBeCreated.MatchId, eventToBeCreated.Code);
      if (eventRetrieved.Count >= 1)
      {
        throw new EventAlreadyExistsException(eventToBeCreated.Name,
          eventToBeCreated.GetBrokenRulesAsString());
      }
    }

    private EventUiModel ThrowExcIfEventWasNotBeMadePersistent(Match eventToBeCreated)
    {
      var retrievedEvent = _eventRepository.FindByName(eventToBeCreated.Name);
      if (retrievedEvent != null)
        return _autoMapper.Map<EventUiModel>(retrievedEvent);
      throw new EventDoesNotExistAfterMadePersistentException(eventToBeCreated.Name);
    }

    private void ThrowExcIfEventCannotBeCreated(Match eventToBeCreated)
    {
      bool canBeCreated = !eventToBeCreated.GetBrokenRules().Any();
      if (!canBeCreated)
        throw new InvalidEventException(eventToBeCreated.GetBrokenRulesAsString());
    }

    private void AddDetailsToEvent(Match eventToBeAddedDetails)
    {
      _eventRepository.Add(eventToBeAddedDetails);
    }

    private void MakeEventPersistent(Match eventToBeMadePersistence)
    {
      _eventRepository.Save(eventToBeMadePersistence);
      _uOf.Commit();
    }
  }
}
