using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using horizonsb.api.Redis.Tournaments;
using horizonsb.api.Validators;
using horizonsb.be.contracts.Tournaments;
using horizonsb.be.contracts.V1;
using horizonsb.be.model.Tournaments;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using horizonsb.commons.vm.Dtos.Tournaments;
using horizonsb.commons.vm.Links;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace horizonsb.api.Controllers.API
{
  [Produces("application/json")]
  [ResponseCache(Duration = 0, NoStore = true, VaryByHeader = "*")]
  [Route("api/[controller]")]
  [ApiController]
  public class TournamentsController : ControllerBase
  {
    private readonly IUrlHelper _urlHelper;
    private readonly ITypeHelperService _typeHelperService;
    private readonly IPropertyMappingService _propertyMappingService;
    private readonly ITournamentRedisRepository _tournamentRedisRepository;

    private readonly IInquiryAllTournamentsProcessor _inquiryAllTournamentsProcessor;
    private readonly IInquiryTournamentProcessor _inquiryTournamentProcessor;
    private readonly IUpdateTournamentProcessor _updateTournamentProcessor;

    public TournamentsController(IUrlHelper urlHelper,
      ITypeHelperService typeHelperService, IPropertyMappingService propertyMappingService,
      ITournamentsControllerDependencyBlock blockTournament, ITournamentRedisRepository tournamentRedisRepository)
    {
      _urlHelper = urlHelper;
      _typeHelperService = typeHelperService;
      _propertyMappingService = propertyMappingService;
      _tournamentRedisRepository = tournamentRedisRepository;

      _inquiryAllTournamentsProcessor = blockTournament.InquiryAllTournamentsProcessor;
      _inquiryTournamentProcessor = blockTournament.InquiryTournamentProcessor;
      _updateTournamentProcessor = blockTournament.UpdateTournamentProcessor;
    }



    /// <summary>
    /// Get - Retrieve Stored Tournaments providing Priority Number and Equation
    /// </summary>
    /// <param name="priority">Priority Number the Request Index for Retrieval</param>
    /// <param name="equation">If = 0 = equal, = 1 = min, = 2 = max</param>
    /// <remarks>Retrieve Tournaments providing Priority and Equation</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("priority/{priority}/equation/{equation}", Name = "GetTournamentsByPriority")]
    public async Task<IActionResult> GetTournamentsByPriorityAsync(int priority, int equation)
    {
      return Ok();
    }

    /// <summary>
    /// Get - Retrieve Stored Tournaments Count All
    /// </summary>
    /// <remarks>Retrieve Stored Tournaments Count All</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-all", Name = "GetTournamentsCountAll")]
    public async Task<IActionResult> GetTournamentsCountAllAsync()
    {
      return Ok(await _inquiryAllTournamentsProcessor.GetTotalCountTournamentsAsync());
    }

    /// <summary>
    /// Get - Retrieve Stored Tournaments Count Prioritized
    /// </summary>
    /// <remarks>Retrieve Stored Tournaments Count Prioritized</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-prioritized", Name = "GetTournamentsCountPrioritized")]
    public async Task<IActionResult> GetTournamentsCountPrioritizedAsync()
    {
      return Ok(await _inquiryTournamentProcessor.GetTournamentCountPrioritizedAsync());
    }

    /// <summary>
    /// Update Tournament with New Priority
    /// </summary>
    /// <param name="id">Tournament Id the Request Index for Retrieval</param>
    /// <param name="updatedTournament">TournamentForModification the Request Model with New Priority</param>
    /// <remarks>Change Tournament providing TournamentForModificationUiModel with Modified Priority</remarks>
    /// <response code="200">Resource updated correctly.</response>
    /// <response code="400">The model is not in valid state.</response>
    /// <response code="403">You have not access for this action.</response>
    /// <response code="404">Wrong attributes provided.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpPut("{id}", Name = "UpdateTournamentWithModifiedPriority")]
    [ValidateModel]
    public async Task<IActionResult> UpdateTournamentWithModifiedPriorityAsync(Guid id,
      [FromBody] TournamentForModificationUiModel updatedTournament)
    {
      if (id == Guid.Empty || updatedTournament.NewPriority < 0)
        return BadRequest();

      await _updateTournamentProcessor.UpdateTournamentAsync(id, updatedTournament);

      var tournamentFromRepo = await _inquiryTournamentProcessor.GetTournamentAsync(id);

      if (tournamentFromRepo == null)
        return BadRequest();

      var sportFromRedis = await _tournamentRedisRepository.UpdateTournamentAsync(new TournamentRedis(tournamentFromRepo.tournamentId, tournamentFromRepo.priority));

      if (sportFromRedis == null)
        return BadRequest();


      return Ok(Mapper.Map<TournamentUiModel>(tournamentFromRepo));
    }

    /// <summary>
    /// Get - Retrieve Stored Tournament providing Tournament Id
    /// </summary>
    /// <param name="id">Tournament Id the Request Index for Retrieval</param>
    /// <param name="fields">Fiends to be filtered with for the returned Tournament</param>
    /// <remarks>Retrieve Tournament providing Id and [Optional] fields</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("{id}", Name = "GetTournament")]
    public async Task<IActionResult> GetTournamentAsync(Guid id, [FromQuery] string fields)
    {
      if (!_typeHelperService.TypeHasProperties<TournamentUiModel>
        (fields))
      {
        return BadRequest();
      }

      var tournamentFromRepo = await _inquiryTournamentProcessor.GetTournamentAsync(id);

      if (tournamentFromRepo == null)
      {
        return NotFound();
      }

      var tournament = Mapper.Map<TournamentUiModel>(tournamentFromRepo);

      var linkedResourceToReturn = tournament.ShapeData(fields)
        as IDictionary<string, object>;


      if (fields == null)
      {
        var links = CreateLinksForTournament(id, fields);
        linkedResourceToReturn.Add("links", links);
      }

      return Ok(linkedResourceToReturn);
    }

    /// <summary>
    /// Get - Retrieve All/or Partial Paged Stored Tournaments By SportId
    /// </summary>
    /// <remarks>Retrieve paged Tournaments providing Paging Query and sportId </remarks>
    /// <param name="sportId">Sport Id the Request Index for Retrieval</param>
    /// <param name="tournamentsResourceParameters"></param>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("sport/{sportId}", Name = "GetTournamentsBySportId")]
    public async Task<IActionResult> GetTournamentsBySportIdAsync(Guid sportId,
      [FromQuery] TournamentsResourceParameters tournamentsResourceParameters)
    {
      if (!_propertyMappingService.ValidMappingExistsFor<TournamentUiModel, Tournament>
        (tournamentsResourceParameters.OrderDirection))
      {
        return BadRequest();
      }

      if (sportId == Guid.Empty)
        return BadRequest();

      var tournamentsQueryable =
        await _inquiryAllTournamentsProcessor.GetTournamentsAsync(sportId, tournamentsResourceParameters);

      var tournaments = Mapper.Map<IEnumerable<TournamentUiModel>>(tournamentsQueryable);

      var previousPageLink = tournamentsQueryable.HasPrevious
        ? CreateTournamentsResourceUri(tournamentsResourceParameters,
          ResourceUriType.PreviousPage)
        : null;

      var nextPageLink = tournamentsQueryable.HasNext
        ? CreateTournamentsResourceUri(tournamentsResourceParameters,
          ResourceUriType.NextPage)
        : null;

      var paginationMetadata = new
      {
        previousPageLink = previousPageLink,
        nextPageLink = nextPageLink,
        totalCount = tournamentsQueryable.TotalCount,
        pageSize = tournamentsQueryable.PageSize,
        currentPage = tournamentsQueryable.CurrentPage,
        totalPages = tournamentsQueryable.TotalPages
      };

      Response.Headers.Add("X-Pagination",
        JsonConvert.SerializeObject(paginationMetadata));

      if (!string.IsNullOrEmpty(tournamentsResourceParameters.SearchColumn) &&
          !string.IsNullOrEmpty(tournamentsResourceParameters.SearchQuery))
      {

        var searchQueryForWhereClauseFilterFields = tournamentsResourceParameters.SearchColumn
          .Trim().ToLowerInvariant();

        var searchQueryForWhereClauseFilterSearchQuery = tournamentsResourceParameters.SearchQuery
          .Trim().ToLowerInvariant();

        tournaments = tournaments.FilterData(searchQueryForWhereClauseFilterFields,
          searchQueryForWhereClauseFilterSearchQuery);
      }

      return Ok(tournaments);
    }

    /// <summary>
    /// Get - Retrieve All/or Partial Paged Stored Tournaments
    /// </summary>
    /// <remarks>Retrieve paged Tournaments providing Paging Query</remarks>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet(Name = "GetTournaments")]
    public async Task<IActionResult> GetTournamentsAsync(
      [FromQuery] TournamentsResourceParameters tournamentsResourceParameters)
    {
      if (!_propertyMappingService.ValidMappingExistsFor<TournamentUiModel, Tournament>
        (tournamentsResourceParameters.OrderColumn))
      {
        return BadRequest();
      }

      var tournamentsQueryable =
        await _inquiryAllTournamentsProcessor.GetTournamentsAsync(tournamentsResourceParameters);

      var tournaments = Mapper.Map<IEnumerable<TournamentUiModel>>(tournamentsQueryable);

      var previousPageLink = tournamentsQueryable.HasPrevious
        ? CreateTournamentsResourceUri(tournamentsResourceParameters,
          ResourceUriType.PreviousPage)
        : null;

      var nextPageLink = tournamentsQueryable.HasNext
        ? CreateTournamentsResourceUri(tournamentsResourceParameters,
          ResourceUriType.NextPage)
        : null;

      var paginationMetadata = new
      {
        previousPageLink = previousPageLink,
        nextPageLink = nextPageLink,
        totalCount = tournamentsQueryable.TotalCount,
        pageSize = tournamentsQueryable.PageSize,
        currentPage = tournamentsQueryable.CurrentPage,
        totalPages = tournamentsQueryable.TotalPages
      };

      Response.Headers.Add("X-Pagination",
        JsonConvert.SerializeObject(paginationMetadata));

      if (!string.IsNullOrEmpty(tournamentsResourceParameters.SearchColumn) &&
          !string.IsNullOrEmpty(tournamentsResourceParameters.SearchQuery))
      {

        var searchQueryForWhereClauseFilterFields = tournamentsResourceParameters.SearchColumn
          .Trim().ToLowerInvariant();

        var searchQueryForWhereClauseFilterSearchQuery = tournamentsResourceParameters.SearchQuery
          .Trim().ToLowerInvariant();

        tournaments = tournaments.FilterData(searchQueryForWhereClauseFilterFields,
          searchQueryForWhereClauseFilterSearchQuery);
      }

      return Ok(tournaments);
    }

    #region Link Builder

    private IEnumerable<LinkDto> CreateLinksForTournament(Guid id, string fields)
    {
      var links = new List<LinkDto>();

      if (String.IsNullOrWhiteSpace(fields))
      {
        links.Add(
          new LinkDto(_urlHelper.Link("GetTournament", new {id = id}),
            "self",
            "GET"));
      }
      else
      {
        links.Add(
          new LinkDto(_urlHelper.Link("GetTournament", new {id = id, fields = fields}),
            "self",
            "GET"));
      }

      return links;
    }


    private IEnumerable<LinkDto> CreateLinksForTournaments(TournamentsResourceParameters tournamentsResourceParameters,
      bool hasNext, bool hasPrevious)
    {
      var links = new List<LinkDto>
      {
        new LinkDto(CreateTournamentsResourceUri(tournamentsResourceParameters,
            ResourceUriType.Current)
          , "self", "GET")
      };

      if (hasNext)
      {
        links.Add(
          new LinkDto(CreateTournamentsResourceUri(tournamentsResourceParameters,
              ResourceUriType.NextPage),
            "nextPage", "GET"));
      }

      if (hasPrevious)
      {
        links.Add(
          new LinkDto(CreateTournamentsResourceUri(tournamentsResourceParameters,
              ResourceUriType.PreviousPage),
            "previousPage", "GET"));
      }

      return links;
    }

    private string CreateTournamentsResourceUri(TournamentsResourceParameters tournamentsResourceParameters,
      ResourceUriType type)
    {
      switch (type)
      {
        case ResourceUriType.PreviousPage:
          return _urlHelper.Link("GetTournaments",
            new
            {
              orderBy = tournamentsResourceParameters.OrderDirection,
              searchQuery = tournamentsResourceParameters.SearchQuery,
              pageNumber = tournamentsResourceParameters.Offset - 1,
              pageSize = tournamentsResourceParameters.Limit
            });
        case ResourceUriType.NextPage:
          return _urlHelper.Link("GetTournaments",
            new
            {
              orderBy = tournamentsResourceParameters.OrderDirection,
              searchQuery = tournamentsResourceParameters.SearchQuery,
              pageNumber = tournamentsResourceParameters.Offset + 1,
              pageSize = tournamentsResourceParameters.Limit
            });
        case ResourceUriType.Current:
        default:
          return _urlHelper.Link("GetTournaments",
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
