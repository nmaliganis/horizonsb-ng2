using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using horizonsb.be.contracts.Markets;
using horizonsb.be.contracts.V1;
using horizonsb.be.model.Events.Markets;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using horizonsb.commons.vm.Dtos.Markets;
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
  public class MarketsController : ControllerBase
  {
    private readonly IUrlHelper _urlHelper;
    private readonly ITypeHelperService _typeHelperService;
    private readonly IPropertyMappingService _propertyMappingService;

    private readonly IInquiryAllMarketsProcessor _inquiryAllMarketsProcessor;
    private readonly IInquiryMarketProcessor _inquiryMarketProcessor;

    public MarketsController(IUrlHelper urlHelper,
        ITypeHelperService typeHelperService, IPropertyMappingService propertyMappingService,
        IMarketsControllerDependencyBlock blockMarket)
    {
      _urlHelper = urlHelper;
      _typeHelperService = typeHelperService;
      _propertyMappingService = propertyMappingService;

      _inquiryAllMarketsProcessor = blockMarket.InquiryAllMarketsProcessor;
      _inquiryMarketProcessor = blockMarket.InquiryMarketProcessor;
    }


    /// <summary>
    /// Get - Retrieve Stored Markets Count All
    /// </summary>
    /// <remarks>Retrieve Stored Markets Count All</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-all", Name = "GetMarketsCountAll")]
    public async Task<IActionResult> GetMarketsCountAllAsync()
    {
      return Ok(await _inquiryMarketProcessor.GetMarketCountAllAsync());
    }

    /// <summary>
    /// Get - Retrieve Stored Odds Count Prioritized
    /// </summary>
    /// <remarks>Retrieve Stored Odds Count Prioritized</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-odds", Name = "GetOddsCountPrioritized")]
    public async Task<IActionResult> GetOddsCountPrioritizedAsync()
    {
      return Ok(await _inquiryMarketProcessor.GetOddCountAllAsync());
    }

    /// <summary>
    /// Get - Retrieve Stored Market providing Market Id
    /// </summary>
    /// <param name="id">Market Id the Request Index for Retrieval</param>
    /// <param name="fields">Fiends to be filtered with for the returned Market</param>
    /// <remarks>Retrieve Market providing Id and [Optional] fields</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("{id}", Name = "GetMarket")]
    public async Task<IActionResult> GetMarketAsync(Guid id, [FromQuery] string fields)
    {
      if (!_typeHelperService.TypeHasProperties<MarketUiModel>
          (fields))
      {
        return BadRequest();
      }

      var sportFromRepo = await _inquiryMarketProcessor.GetMarketAsync(id);

      if (sportFromRepo == null)
      {
        return NotFound();
      }

      var sport = Mapper.Map<MarketUiModel>(sportFromRepo);

      var links = CreateLinksForMarket(id, fields);

      var linkedResourceToReturn = sport.ShapeData(fields)
          as IDictionary<string, object>;

      linkedResourceToReturn.Add("links", links);

      return Ok(linkedResourceToReturn);
    }
    
    /// <summary>
    /// Get - Retrieve All/or Partial Paged Stored Markets By EventId
    /// </summary>
    /// <remarks>Retrieve paged Markets providing Paging Query and eventId </remarks>
    /// <param name="eventId">Event Id the Request Index for Retrieval</param>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("{eventId}", Name = "GetMarketsByEventId")]
    public async Task<IActionResult> GetMarketsByEventIdAsync(Guid eventId,
      [FromQuery] MarketsResourceParameters marketsResourceParameters)
    {
      return Ok();
    }

    /// <summary>
    /// Get - Retrieve All/or Partial Paged Stored Markets
    /// </summary>
    /// <remarks>Retrieve paged Markets providing Paging Query</remarks>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet(Name = "GetMarkets")]
    public async Task<IActionResult> GetMarketsAsync([FromQuery] MarketsResourceParameters sportsResourceParameters)
    {
      if (!_propertyMappingService.ValidMappingExistsFor<MarketUiModel, Market>
        (sportsResourceParameters.OrderDirection))
      {
        return BadRequest();
      }

      var sportsQueryable = await _inquiryAllMarketsProcessor.GetMarketsAsync(sportsResourceParameters);

      var markets = Mapper.Map<IEnumerable<MarketUiModel>>(sportsQueryable);

      var previousPageLink = sportsQueryable.HasPrevious
        ? CreateMarketsResourceUri(sportsResourceParameters,
          ResourceUriType.PreviousPage)
        : null;

      var nextPageLink = sportsQueryable.HasNext
        ? CreateMarketsResourceUri(sportsResourceParameters,
          ResourceUriType.NextPage)
        : null;

      var paginationMetadata = new
      {
        previousPageLink = previousPageLink,
        nextPageLink = nextPageLink,
        totalCount = sportsQueryable.TotalCount,
        pageSize = sportsQueryable.PageSize,
        currentPage = sportsQueryable.CurrentPage,
        totalPages = sportsQueryable.TotalPages
      };

      Response.Headers.Add("X-Pagination",
        JsonConvert.SerializeObject(paginationMetadata));

      if (!string.IsNullOrEmpty(sportsResourceParameters.SearchColumn) &&
          !string.IsNullOrEmpty(sportsResourceParameters.SearchQuery))
      {

        var searchQueryForWhereClauseFilterFields = sportsResourceParameters.SearchColumn
          .Trim().ToLowerInvariant();

        var searchQueryForWhereClauseFilterSearchQuery = sportsResourceParameters.SearchQuery
          .Trim().ToLowerInvariant();

        markets = markets.FilterData(searchQueryForWhereClauseFilterFields, searchQueryForWhereClauseFilterSearchQuery);
      }

      return Ok(markets);
    }

    #region Link Builder

    private IEnumerable<LinkDto> CreateLinksForMarket(Guid id, string fields)
    {
      var links = new List<LinkDto>();

      if (String.IsNullOrWhiteSpace(fields))
      {
        links.Add(
            new LinkDto(_urlHelper.Link("GetMarket", new { id = id }),
                "self",
                "GET"));
      }
      else
      {
        links.Add(
            new LinkDto(_urlHelper.Link("GetMarket", new { id = id, fields = fields }),
                "self",
                "GET"));
      }

      return links;
    }


    private IEnumerable<LinkDto> CreateLinksForMarkets(MarketsResourceParameters sportsResourceParameters,
        bool hasNext, bool hasPrevious)
    {
      var links = new List<LinkDto>
            {
                new LinkDto(CreateMarketsResourceUri(sportsResourceParameters,
                        ResourceUriType.Current)
                    , "self", "GET")
            };

      if (hasNext)
      {
        links.Add(
            new LinkDto(CreateMarketsResourceUri(sportsResourceParameters,
                    ResourceUriType.NextPage),
                "nextPage", "GET"));
      }

      if (hasPrevious)
      {
        links.Add(
            new LinkDto(CreateMarketsResourceUri(sportsResourceParameters,
                    ResourceUriType.PreviousPage),
                "previousPage", "GET"));
      }

      return links;
    }

    private string CreateMarketsResourceUri(MarketsResourceParameters sportsResourceParameters,
        ResourceUriType type)
    {
      switch (type)
      {
        case ResourceUriType.PreviousPage:
          return _urlHelper.Link("GetMarkets",
              new
              {
                orderBy = sportsResourceParameters.OrderDirection,
                searchQuery = sportsResourceParameters.SearchQuery,
                pageNumber = sportsResourceParameters.Offset - 1,
                pageSize = sportsResourceParameters.Limit 
              });
        case ResourceUriType.NextPage:
          return _urlHelper.Link("GetMarkets",
              new
              {
                orderBy = sportsResourceParameters.OrderDirection,
                searchQuery = sportsResourceParameters.SearchQuery,
                pageNumber = sportsResourceParameters.Offset + 1,
                pageSize = sportsResourceParameters.Limit
              });
        case ResourceUriType.Current:
        default:
          return _urlHelper.Link("GetMarkets",
              new
              {
                orderBy = sportsResourceParameters.OrderDirection,
                searchQuery = sportsResourceParameters.SearchQuery,
                pageNumber = sportsResourceParameters.Offset,
                pageSize = sportsResourceParameters.Limit
              });
      }
    }

    #endregion
  }
}
