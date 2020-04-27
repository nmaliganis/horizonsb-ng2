using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using horizonsb.api.Redis.Events;
using horizonsb.api.Redis.Events.Live;
using horizonsb.api.Validators;
using horizonsb.be.contracts.Events;
using horizonsb.be.contracts.V1;
using horizonsb.be.model.Events;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using horizonsb.commons.vm.Dtos.Events;
using horizonsb.commons.vm.Links;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Serilog;

namespace horizonsb.api.Controllers.API
{
  [Produces("application/json")]
  [ResponseCache(Duration = 0, NoStore = true, VaryByHeader = "*")]
  [Route("api/[controller]")]
  [ApiController]
  public class EventsController : ControllerBase
  {
    private readonly IUrlHelper _urlHelper;
    private readonly ITypeHelperService _typeHelperService;
    private readonly IPropertyMappingService _propertyMappingService;
    private readonly IEventRedisRepository _eventRedisRepository;
    private readonly ILiveRedisRepository _liveRedisRepository;

    private readonly IInquiryAllEventsProcessor _inquiryAllEventsProcessor;
    private readonly IInquiryEventProcessor _inquiryEventProcessor;
    private readonly IUpdateEventProcessor _updateEventProcessor;
    private readonly IDeleteEventProcessor _deleteEventProcessor;


    public EventsController(IUrlHelper urlHelper,
      ITypeHelperService typeHelperService, IPropertyMappingService propertyMappingService,
      IEventsControllerDependencyBlock blockEvent, IEventRedisRepository eventRedisRepository,
      ILiveRedisRepository liveRedisRepository)
    {
      _urlHelper = urlHelper;
      _typeHelperService = typeHelperService;
      _propertyMappingService = propertyMappingService;
      _eventRedisRepository = eventRedisRepository;
      _liveRedisRepository = liveRedisRepository;

      _inquiryAllEventsProcessor = blockEvent.InquiryAllEventsProcessor;
      _inquiryEventProcessor = blockEvent.InquiryEventProcessor;
      _updateEventProcessor = blockEvent.UpdateEventProcessor;
      _deleteEventProcessor = blockEvent.DeleteEventProcessor;
    }

    /// <summary>
    /// Get - Retrieve Stored Events providing Priority Number and Equation
    /// </summary>
    /// <param name="priority">Priority Number the Request Index for Retrieval</param>
    /// <param name="equation">If = 0 = equal, = 1 = min, = 2 = max</param>
    /// <remarks>Retrieve Events providing Priority and Equation</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("priority/{priority}/equation/{equation}", Name = "GetEventsByPriority")]
    public async Task<IActionResult> GetEventsByPriorityAsync(int priority, int equation)
    {
      return Ok();
    }

    /// <summary>
    /// Delete - Batch Delete 
    /// </summary>
    /// <remarks>Delete all Events </remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpDelete(Name = "DeleteBatchEventsRoot")]
    public async Task<IActionResult> DeleteBatchEventsRoot()
    {
      _deleteEventProcessor.DeleteBatchEventAsync();

      return Ok();
    }

    /// <summary>
    /// Get - Retrieve Stored Events Count All
    /// </summary>
    /// <remarks>Retrieve Stored Events Count All</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-all", Name = "GetEventsCountAll")]
    public async Task<IActionResult> GetEventsCountAllAsync()
    {
      return Ok(await _inquiryAllEventsProcessor.GetTotalCountEventsAsync());
    }

    /// <summary>
    /// Get - Retrieve Stored Events Count Prioritized
    /// </summary>
    /// <remarks>Retrieve Stored Events Count Prioritized</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-prioritized", Name = "GetEventsCountPrioritized")]
    public async Task<IActionResult> GetEventsCountPrioritizedAsync()
    {
      return Ok(await _inquiryEventProcessor.GetEventCountPrioritizedAsync());
    }

    /// <summary>
    /// Get - Retrieve Stored Live Events Count Prioritized
    /// </summary>
    /// <remarks>Retrieve Stored Live Events Count Prioritized</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count--live-prioritized", Name = "GetEventsCountLivePrioritized")]
    public async Task<IActionResult> GetEventsCountLivePrioritizedAsync()
    {
      return Ok(await _inquiryEventProcessor.GetEventCountLivePrioritizedAsync());
    }

    /// <summary>
    /// Get - Retrieve Stored Events Count Upcoming Live
    /// </summary>
    /// <remarks>Retrieve Stored Events Count Upcoming Live</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-upcominglive", Name = "GetEventsCountUpcomingLive")]
    public async Task<IActionResult> GetEventsCountUpcomingLiveAsync()
    {
      return Ok(await _inquiryEventProcessor.GetEventCountUpcomingLiveAsync());
    }

    /// <summary>
    /// Get - Retrieve Stored Events Count Live
    /// </summary>
    /// <remarks>Retrieve Stored Events Count Live</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-live", Name = "GetEventsCountLive")]
    public async Task<IActionResult> GetEventsCountLiveAsync()
    {
      return Ok(await _inquiryEventProcessor.GetEventCountLiveAsync());
    }

    /// <summary>
    /// Get - Retrieve Stored Events Count Favorites
    /// </summary>
    /// <remarks>Retrieve Stored Events Count Favorites</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-favorite", Name = "GetEventsCountFavorite")]
    public async Task<IActionResult> GetEventsCountFavoriteAsync()
    {
      return Ok(await _inquiryEventProcessor.GetEventCountFavoriteAsync());
    }

    /// <summary>
    /// Update Event with New Priority And Favorite status
    /// </summary>
    /// <param name="id">Event Id the Request Index for Retrieval</param>
    /// <param name="updatedEvent">EventForModification the Request Model with New Priority And Favorite</param>
    /// <remarks>Change Event providing EventForModificationUiModel with Modified Priority and Favorite</remarks>
    /// <response code="200">Resource updated correctly.</response>
    /// <response code="400">The model is not in valid state.</response>
    /// <response code="403">You have not access for this action.</response>
    /// <response code="404">Wrong attributes provided.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpPut("{id}", Name = "UpdateEventWithModifiedEventModel")]
    [ValidateModel]
    public async Task<IActionResult> UpdateEventWithModifiedEventModelAsync(Guid id,
      [FromBody] EventForModificationUiModel updatedEvent)
    {
      if (id == Guid.Empty || updatedEvent.NewPriority < 0)
        return BadRequest();

      await _updateEventProcessor.UpdateEventAsync(id, updatedEvent);

      var eventFromRepo = await _inquiryEventProcessor.GetEventByIdAsync(id);
      if (eventFromRepo == null)
        return BadRequest();

      var eventFromRedis =
        await _eventRedisRepository.UpdateEventAsync(new EventRedis(eventFromRepo.EventId,
          eventFromRepo.Priority));

      if (eventFromRedis == null)
        return BadRequest();


      return Ok(Mapper.Map<EventUiModel>(eventFromRepo));
    }

    /// <summary>
    /// Update Event to favorites
    /// </summary>
    /// <param name="id">Event Id the Request Index for Retrieval</param>
    /// <param name="updatedEvent">EventForModificationFavoritesUiModel the Request Model with New Favorite Status</param>
    /// <remarks>Change Event providing EventForModificationFavoritesUiModel with Modified Favorite Status</remarks>
    /// <response code="200">Resource updated correctly.</response>
    /// <response code="400">The model is not in valid state.</response>
    /// <response code="403">You have not access for this action.</response>
    /// <response code="404">Wrong attributes provided.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpPut("favorites/{id}", Name = "UpdateEventToBeInFavoritesRoot")]
    [ValidateModel]
    public async Task<IActionResult> UpdateEventToBeInFavoritesAsync(Guid id, [FromBody] EventForModificationFavoritesUiModel updatedEvent)
    {
      if (id == Guid.Empty)
        return BadRequest();

      await _updateEventProcessor.UpdateEventWithFavoriteAsync(id, updatedEvent);

      var eventFromRepo = await _inquiryEventProcessor.GetEventByIdAsync(id);
      if (eventFromRepo == null)
        return BadRequest();

      return Ok(Mapper.Map<EventUiModel>(eventFromRepo));
    }

    /// <summary>
    /// Update Event with New Live Priority
    /// </summary>
    /// <param name="id">Event Id the Request Index for Retrieval</param>
    /// <param name="updatedEvent">EventForModificationWithLivePriorityUiModel the Request Model with New Priority</param>
    /// <remarks>Change Event providing EventForModificationWithLivePriorityUiModel with Modified Live Priority</remarks>
    /// <response code="200">Resource updated correctly.</response>
    /// <response code="400">The model is not in valid state.</response>
    /// <response code="403">You have not access for this action.</response>
    /// <response code="404">Wrong attributes provided.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpPut("priority-live/{id}", Name = "UpdateEventWithModifiedLivePriority")]
    [ValidateModel]
    public async Task<IActionResult> UpdateEventWithModifiedLivePriorityAsync(Guid id,
      [FromBody] EventForModificationWithLivePriorityUiModel updatedEvent)
    {
      if (id == Guid.Empty || updatedEvent.NewLivePriority < 0)
        return BadRequest();

      await _updateEventProcessor.UpdateEventWithlivePriorityAsync(id, updatedEvent);

      var eventFromRepo = await _inquiryEventProcessor.GetEventByIdAsync(id);
      if (eventFromRepo == null)
        return BadRequest();

      if (updatedEvent.NewLivePriority == 1)
      {
        var deleteFromPreview = await _liveRedisRepository.DeleteLiveEventFromPreviewAsync(eventFromRepo.Code);
        if (deleteFromPreview)
        {
          return Ok(Mapper.Map<EventUiModel>(eventFromRepo));
        }
      }

      if (eventFromRepo.EventSportConfiguration == 1) //USA
      {
        var liveEvent = _liveRedisRepository.GetLiveUsaEventAsync(eventFromRepo.Code).Result;

        var liveMoneyLineRedisModel = new LiveMoneyLineRedisModel()
        {
          Code = eventFromRepo?.Code,
          LiveTimeOfEvent = liveEvent?.LiveTimeOfEvent,
          IsUsa = liveEvent?.IsUsa,
          League = eventFromRepo?.EventTournamentShortName,
          SportName = eventFromRepo?.EventSportName,
          EventCompleted = liveEvent?.EventCompleted ?? false,
          Status = eventFromRepo?.StatusValue,
          EventStarted = liveEvent?.EventStarted ?? false,
          Live = liveEvent?.Live ?? false,
          CurrentPeriod = liveEvent?.CurrentPeriod,
          Possession = liveEvent?.Possession,
          kickoff_date = eventFromRepo?.DateEvent,
          timestamp = eventFromRepo?.Timestamp,
          MoneyLinesFinal = liveEvent?.MoneyLinesFinal,
          MoneyLines = liveEvent?.MoneyLines,
          SpreadsFinal = liveEvent?.SpreadsFinal,
          Spreads = liveEvent?.Spreads,
          Stage = new StageGameRedisModel()
          {
            HomeScore = liveEvent?.Stage.HomeScore,
            AwayScore = liveEvent?.Stage.AwayScore,
            Q = liveEvent?.Stage.Q,
            Q_AwayScore = liveEvent?.Stage.Q_AwayScore,
            Q_HomeScore = liveEvent?.Stage.Q_HomeScore,
            Q_Id = liveEvent?.Stage.Q_Id,
          },
          Games = new List<LiveGameRedisModel>()
          {
            new LiveGameRedisModel()
            {
              TeamName = eventFromRepo?.EventTeamHome,
              Score = liveEvent?.Games[0]?.Score,
            },
            new LiveGameRedisModel()
            {
              TeamName = eventFromRepo?.EventTeamAway,
              Score = liveEvent?.Games[1]?.Score,
            },
          },
          OverFinal = liveEvent?.OverFinal,
          TotalsFinal = liveEvent?.TotalsFinal,
          UnderFinal = liveEvent?.UnderFinal,
        };

        var liveRedisModel = await _liveRedisRepository.UpdateUsaLiveEventAsync(liveMoneyLineRedisModel, true);

        if (liveRedisModel == null)
          return BadRequest();
      }
      else if (eventFromRepo.EventSportConfiguration == 2) //EUR
      {
        var liveEvent = _liveRedisRepository.GetLiveEuropeEventAsync(eventFromRepo.Code).Result;

        LiveAxbRedisModel liveAxbRedisModel = new LiveAxbRedisModel()
        {
          Code = eventFromRepo?.Code,
          LiveTimeOfEvent = liveEvent?.LiveTimeOfEvent,
          IsUsa = liveEvent?.IsUsa,
          League = eventFromRepo?.EventTournamentName,
          SportName = eventFromRepo?.EventSportName,
          EventCompleted = liveEvent != null && (bool) liveEvent?.EventCompleted,
          Status = eventFromRepo?.StatusValue,
          EventStarted = liveEvent != null && (bool) liveEvent?.EventStarted,
          Live = liveEvent != null && (bool) liveEvent?.Live,
          CurrentPeriod = liveEvent?.CurrentPeriod,
          kickoff_date = eventFromRepo?.DateEvent,
          timestamp = eventFromRepo.Timestamp,
          Stage = new StageGameRedisModel()
          {
            HomeScore = liveEvent?.Stage.HomeScore,
            AwayScore = liveEvent?.Stage.AwayScore,
            Q = liveEvent?.Stage.Q,
            Q_AwayScore = liveEvent?.Stage.Q_AwayScore,
            Q_HomeScore = liveEvent?.Stage.Q_HomeScore,
            Q_Id = liveEvent?.Stage.Q_Id,
          },
          Games = new List<LiveGameRedisModel>()
          {
            new LiveGameRedisModel()
            {
              TeamName = eventFromRepo.EventTeamHome,
              Score = liveEvent?.Games[0].Score ?? "",
            },
            new LiveGameRedisModel()
            {
              TeamName = eventFromRepo.EventTeamAway,
              Score = liveEvent?.Games[1].Score ?? "",
            },
          },

          A = liveEvent?.A,
          X = liveEvent?.X,
          B = liveEvent?.B,
          AFinal = liveEvent?.AFinal,
          XFinal = liveEvent?.XFinal,
          BFinal = liveEvent?.BFinal,
        };

        var liveRedisModel = await _liveRedisRepository.UpdateEuropeLiveEventAsync(liveAxbRedisModel, true);

        if (liveRedisModel == null)
          return BadRequest();
      }

      return Ok(Mapper.Map<EventUiModel>(eventFromRepo));
    }

    /// <summary>
    /// Get - Retrieve Stored Event providing Event Id
    /// </summary>
    /// <param name="id">Event Id the Request Index for Retrieval</param>
    /// <param name="fields">Fiends to be filtered with for the returned Event</param>
    /// <remarks>Retrieve Event providing Id and [Optional] fields</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("{id}", Name = "GetEvent")]
    public async Task<IActionResult> GetEventAsync(Guid id, [FromQuery] string fields)
    {
      if (!_typeHelperService.TypeHasProperties<EventUiModel>
        (fields))
      {
        return BadRequest();
      }

      var eventFromRepo = await _inquiryEventProcessor.GetEventByIdAsync(id);

      if (eventFromRepo == null)
      {
        return NotFound();
      }

      var @event = Mapper.Map<EventUiModel>(eventFromRepo);


      var linkedResourceToReturn = @event.ShapeData(fields)
        as IDictionary<string, object>;

      if (fields == null)
      {
        var links = CreateLinksForEvent(id, fields);
        linkedResourceToReturn.Add("links", links);
      }

      return Ok(linkedResourceToReturn);
    }

    /// <summary>
    /// Get - Retrieve Stored Event providingMarket Legacy Id
    /// </summary>
    /// <param name="legacyId">Event Id the Request Index for Retrieval</param>
    /// <param name="fields">Fiends to be filtered with for the returned Event</param>
    /// <remarks>Retrieve Event providing Id and [Optional] fields</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("market_legacy/{legacyId}", Name = "GetEventByMarketLegacyIdAsync")]
    public async Task<IActionResult> GetEventByMarketLegacyIdRoot(string legacyId, [FromQuery] string fields)
    {
      if (!_typeHelperService.TypeHasProperties<EventUiModel>
        (fields))
      {
        return BadRequest();
      }

      var eventFromRepo = await _inquiryEventProcessor.GetEventByMarketLegacyMarketIdAsync(legacyId);

      if (eventFromRepo == null)
      {
        return NotFound();
      }

      var @event = Mapper.Map<EventUiModel>(eventFromRepo);

      var linkedResourceToReturn = @event.ShapeData(fields)
        as IDictionary<string, object>;

      return Ok(linkedResourceToReturn);
    }

    ///// <summary>
    ///// Get - Retrieve Stored Favorite Event
    ///// </summary>
    ///// <remarks>Retrieve Event providing Id and [Optional] fields</remarks>
    ///// <response code="200">Resource retrieved correctly</response>
    ///// <response code="200">Resource Not Found</response>
    ///// <response code="500">Internal Server Error.</response>

    //[HttpGet("favorites", Name = "GetEventsFavoritesAsync")]
    //public async Task<IActionResult> GetEventsFavoritesRoot()
    //{
    //  var eventsFromRepo = await _inquiryEventProcessor.GetEventsFavorite();

    //  return Ok(eventsFromRepo);
    //}

    /// <summary>
    /// Get - Retrieve All/or Partial Paged Stored Events
    /// </summary>
    /// <remarks>Retrieve paged Events providing Paging Query</remarks>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet(Name = "GetEvents")]
    public async Task<IActionResult> GetEventsAsync([FromQuery] EventsResourceParameters eventsResourceParameters)
    {
      if (!_propertyMappingService.ValidMappingExistsFor<EventUiModel, Match>
        (eventsResourceParameters.OrderColumn))
      {
        return BadRequest();
      }

      var eventsQueryable = await _inquiryAllEventsProcessor.GetEventsAsync(eventsResourceParameters);

      var events = Mapper.Map<IEnumerable<EventUiModel>>(eventsQueryable);

      events = ColectionLinkAndFiltering(eventsResourceParameters, eventsQueryable, events);

      return Ok(events);
    }

    /// <summary>
    /// Get - Retrieve All/or Partial Paged Stored Favorite Events
    /// </summary>
    /// <remarks>Retrieve paged Events providing Paging Query</remarks>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("favorite", Name = "GetFavoriteEvents")]
    public async Task<IActionResult> GetFavoriteEventsAsync([FromQuery] EventsResourceParameters eventsResourceParameters)
    {
      if (!_propertyMappingService.ValidMappingExistsFor<EventUiModel, Match>
        (eventsResourceParameters.OrderColumn))
      {
        return BadRequest();
      }

      var eventsQueryable = await _inquiryAllEventsProcessor.GetFavoriteEventsAsync(eventsResourceParameters);

      var events = Mapper.Map<IEnumerable<EventUiModel>>(eventsQueryable);

      events = ColectionLinkAndFiltering(eventsResourceParameters, eventsQueryable, events);

      return Ok(events);
    }

    private IEnumerable<EventUiModel> ColectionLinkAndFiltering(EventsResourceParameters eventsResourceParameters,
      PagedList<Match> eventsQueryable, IEnumerable<EventUiModel> events)
    {
      var previousPageLink = eventsQueryable.HasPrevious
        ? CreateEventsResourceUri(eventsResourceParameters,
          ResourceUriType.PreviousPage)
        : null;

      var nextPageLink = eventsQueryable.HasNext
        ? CreateEventsResourceUri(eventsResourceParameters,
          ResourceUriType.NextPage)
        : null;

      var paginationMetadata = new
      {
        totalCount = eventsQueryable.TotalCount,
        pageSize = eventsQueryable.PageSize,
        currentPage = eventsQueryable.CurrentPage,
        totalPages = eventsQueryable.TotalPages
      };

      Response.Headers.Add("X-Pagination",
        JsonConvert.SerializeObject(paginationMetadata));

      if (!string.IsNullOrEmpty(eventsResourceParameters.SearchColumn) &&
          !string.IsNullOrEmpty(eventsResourceParameters.SearchQuery))
      {
        var searchQueryForWhereClauseFilterFields = eventsResourceParameters.SearchColumn
          .Trim().ToLowerInvariant();

        var searchQueryForWhereClauseFilterSearchQuery = eventsResourceParameters.SearchQuery
          .Trim().ToLowerInvariant();

        events = events.FilterData(searchQueryForWhereClauseFilterFields,
          searchQueryForWhereClauseFilterSearchQuery);
      }

      return events;
    }

    #region Link Builder

    private IEnumerable<LinkDto> CreateLinksForEvent(Guid id, string fields)
    {
      var links = new List<LinkDto>();

      if (String.IsNullOrWhiteSpace(fields))
      {
        links.Add(
          new LinkDto(_urlHelper.Link("GetEvent", new {id = id}),
            "self",
            "GET"));
      }
      else
      {
        links.Add(
          new LinkDto(_urlHelper.Link("GetEvent", new {id = id, fields = fields}),
            "self",
            "GET"));
      }

      return links;
    }


    private IEnumerable<LinkDto> CreateLinksForEvents(EventsResourceParameters tournamentsResourceParameters,
      bool hasNext, bool hasPrevious)
    {
      var links = new List<LinkDto>
      {
        new LinkDto(CreateEventsResourceUri(tournamentsResourceParameters,
            ResourceUriType.Current)
          , "self", "GET")
      };

      if (hasNext)
      {
        links.Add(
          new LinkDto(CreateEventsResourceUri(tournamentsResourceParameters,
              ResourceUriType.NextPage),
            "nextPage", "GET"));
      }

      if (hasPrevious)
      {
        links.Add(
          new LinkDto(CreateEventsResourceUri(tournamentsResourceParameters,
              ResourceUriType.PreviousPage),
            "previousPage", "GET"));
      }

      return links;
    }

    private string CreateEventsResourceUri(EventsResourceParameters tournamentsResourceParameters,
      ResourceUriType type)
    {
      switch (type)
      {
        case ResourceUriType.PreviousPage:
          return _urlHelper.Link("GetEvents",
            new
            {
              orderBy = tournamentsResourceParameters.OrderDirection,
              searchQuery = tournamentsResourceParameters.SearchQuery,
              pageNumber = tournamentsResourceParameters.Offset - 1,
              pageSize = tournamentsResourceParameters.Limit
            });
        case ResourceUriType.NextPage:
          return _urlHelper.Link("GetEvents",
            new
            {
              orderBy = tournamentsResourceParameters.OrderDirection,
              searchQuery = tournamentsResourceParameters.SearchQuery,
              pageNumber = tournamentsResourceParameters.Offset + 1,
              pageSize = tournamentsResourceParameters.Limit
            });
        case ResourceUriType.Current:
        default:
          return _urlHelper.Link("GetEvents",
            new
            {
              orderBy = tournamentsResourceParameters.OrderDirection,
              searchQuery = tournamentsResourceParameters.SearchQuery,
              pageNumber = tournamentsResourceParameters.Offset,
              pageSize = tournamentsResourceParameters.Limit
            });
      }
    }

    #endregion
  }
}
