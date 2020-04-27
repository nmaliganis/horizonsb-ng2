using System;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Events;
using horizonsb.be.model.Events;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Exceptions.Domain.Events;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Events;
using Serilog;

namespace horizonsb.be.services.Events
{
    public class UpdateEventProcessor : IUpdateEventProcessor
    {
        private readonly IUnitOfWork _uOf;
        private readonly IEventRepository _eventRepository;
        private readonly IAutoMapper _autoMapper;
        public UpdateEventProcessor(IUnitOfWork uOf, IAutoMapper autoMapper, IEventRepository eventRepository)
        {
            _uOf = uOf;
            _eventRepository = eventRepository;
            _autoMapper = autoMapper;
        }

        public Task<EventUiModel> UpdateEventAsync(Guid eventIdToBeUpdated, EventForModificationUiModel updatedEvent)
        {
          var response =
            new EventUiModel();

          if (updatedEvent == null)
          {
            return Task.Run(() => response);
          }

          try
          {
            var eventToBeUpdated = _eventRepository.FindBy(eventIdToBeUpdated);

            eventToBeUpdated.ModifyPriorityWith(updatedEvent.NewPriority);
            eventToBeUpdated.ModifyFavoriteWith(updatedEvent.Favorite);

            ThrowExcIfEventCannotBeUpdated(eventToBeUpdated);

            Log.Information(
              $"Update Event: {eventToBeUpdated.Name}" +
              "--UpdateEvent--  @NotComplete@ [UpdateEventProcessor]. " +
              "Message: Just Before MakeItPersistence");

            MakeEventPersistent(eventToBeUpdated);

            Log.Information(
              $"Update Event: {eventToBeUpdated.Name}" +
              "--UpdateEvent--  @NotComplete@ [UpdateEventProcessor]. " +
              "Message: Just After MakeItPersistence");
          }
          catch (Exception e)
          {
            Log.Error(
              $"Update Event" +
              $"Error Message:{e.Message}" +
              $"--UpdateEvent--  @fail@ [UpdateEventProcessor]. " +
              $"@innerfault:{e.InnerException}");
          }

          return Task.Run(() => response);
        }

        public Task<EventUiModel> UpdateEventWithlivePriorityAsync(Guid eventIdToBeUpdated, EventForModificationWithLivePriorityUiModel updatedEvent)
        {
            var response =
                new EventUiModel();

            if (updatedEvent == null)
            {
                return Task.Run(() => response);
            }

            try
            {
                var eventToBeUpdated = _eventRepository.FindBy(eventIdToBeUpdated);

                eventToBeUpdated.ModifyLivePriorityWith(updatedEvent.NewLivePriority);

                ThrowExcIfEventCannotBeUpdated(eventToBeUpdated);

                Log.Information(
                    $"Update Event: {eventToBeUpdated.Name}" +
                    "--UpdateEventWithlivePriorityAsync--  @NotComplete@ [UpdateEventProcessor]. " +
                    "Message: Just Before MakeItPersistence");

                MakeEventPersistent(eventToBeUpdated);

                Log.Information(
                    $"Update Event: {eventToBeUpdated.Name}" +
                    "--UpdateEventWithlivePriorityAsync--  @NotComplete@ [UpdateEventProcessor]. " +
                    "Message: Just After MakeItPersistence");
            }
            catch (Exception e)
            {
                Log.Error(
                    $"Update Event" +
                    $"Error Message:{e.Message}" +
                    $"--UpdateEventWithlivePriorityAsync--  @fail@ [UpdateEventProcessor]. " +
                    $"@innerfault:{e.InnerException}");
            }

            return Task.Run(() => response);
        }

        public Task<EventUiModel> UpdateEventWithFavoriteAsync(Guid eventIdToBeUpdated,
          EventForModificationFavoritesUiModel updatedEvent)
        {
          var response =
            new EventUiModel();

          if (updatedEvent == null)
          {
            return Task.Run(() => response);
          }

          try
          {
            var eventToBeUpdated = _eventRepository.FindBy(eventIdToBeUpdated);

            eventToBeUpdated.ModifyFavoriteWith(updatedEvent.Favorite);

            ThrowExcIfEventCannotBeUpdated(eventToBeUpdated);

            Log.Information(
              $"Update Event: {eventToBeUpdated.Name}" +
              "--UpdateEventWithFavoriteAsync--  @NotComplete@ [UpdateEventProcessor]. " +
              "Message: Just Before MakeItPersistence");

            MakeEventPersistent(eventToBeUpdated);

            Log.Information(
              $"Update Event: {eventToBeUpdated.Name}" +
              "--UpdateEventWithFavoriteAsync--  @NotComplete@ [UpdateEventProcessor]. " +
              "Message: Just After MakeItPersistence");
          }
          catch (Exception e)
          {
            Log.Error(
              $"Update Event" +
              $"Error Message:{e.Message}" +
              $"--UpdateEventWithFavoriteAsync--  @fail@ [UpdateEventProcessor]. " +
              $"@innerfault:{e.InnerException}");
          }

          return Task.Run(() => response);
        }

        public Task<EventUiModel> UpdateEventWithLiveApiAsync(string eventId, bool liveApiUpcomingLive,
          bool liveApiLive)
        {
          var response =
            new EventUiModel();
          try
          {
            var eventToBeUpdated = _eventRepository.FindOneByEventId(eventId);

            if (eventToBeUpdated == null)
            {
              response.Message = "EVENT_NOT_EXISTS";
              return Task.Run(() => response);
            }

            eventToBeUpdated.UpcomingLive = liveApiUpcomingLive;
            eventToBeUpdated.Live = liveApiLive;

            MakeEventPersistent(eventToBeUpdated);

            response.Message = "EVENT_UPDATED";
          }
          catch (Exception e)
          {
            Log.Error(
              $"Update Event" +
              $"Error Message:{e.Message}" +
              $"--UpdateEventWithLiveApiAsync--  @fail@ [UpdateEventProcessor]. " +
              $"@innerfault:{e.InnerException}");
          }

          return Task.Run(() => response);
        }

        private void ThrowExcIfEventCannotBeUpdated(Match eventDated)
        {
          bool canBeUpdated = !eventDated.GetBrokenRules().Any();
          if (!canBeUpdated)
            throw new InvalidEventException(eventDated.GetBrokenRulesAsString());
        }

        private void MakeEventPersistent(Match matchToBeMadePersistence)
        {
          _eventRepository.Save(matchToBeMadePersistence);
          _uOf.Commit();
        }
  }
}