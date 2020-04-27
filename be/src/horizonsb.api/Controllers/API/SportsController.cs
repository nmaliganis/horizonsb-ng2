using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using horizonsb.api.Redis.Sports;
using horizonsb.api.Validators;
using horizonsb.be.contracts.Sports;
using horizonsb.be.contracts.V1;
using horizonsb.be.model.Sports;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using horizonsb.commons.vm.Dtos.Sports;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Serilog;

namespace horizonsb.api.Controllers.API
{
  [Produces("application/json")]
  [ResponseCache(Duration = 0, NoStore = true, VaryByHeader = "*")]
  [Route("api/[controller]")]
  [ApiController]
  public class SportsController : ControllerBase
  {

    private const string GROUP = "Sports management";

    private readonly IUrlHelper _urlHelper;
    private readonly ITypeHelperService _typeHelperService;
    private readonly IPropertyMappingService _propertyMappingService;
    private readonly ISportRedisRepository _sportRedisRepository;

    private readonly IInquiryAllSportsProcessor _inquiryAllSportsProcessor;
    private readonly IInquirySportProcessor _inquirySportProcessor;
    private readonly IUpdateSportProcessor _updateSportProcessor;
    private readonly IDeleteSportProcessor _deleteSportProcessor;

    public SportsController(IUrlHelper urlHelper,
        ITypeHelperService typeHelperService, IPropertyMappingService propertyMappingService,
        ISportsControllerDependencyBlock blockSport, ISportRedisRepository sportRedisRepository)
    {
      _urlHelper = urlHelper;
      _typeHelperService = typeHelperService;
      _propertyMappingService = propertyMappingService;
      _sportRedisRepository = sportRedisRepository;

      _inquiryAllSportsProcessor = blockSport.InquiryAllSportsProcessor;
      _inquirySportProcessor = blockSport.InquirySportProcessor;
      _updateSportProcessor = blockSport.UpdateSportProcessor;
      _deleteSportProcessor = blockSport.DeleteSportProcessor;
    }

    /// <summary>
    /// Delete - Batch Delete 
    /// </summary>
    /// <remarks>Retrieve Sports providing Priority and Equation</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpDelete(Name = "DeleteBatchEvents")]
    public async Task<IActionResult> DeleteBatchSports()
    {
      _deleteSportProcessor.DeleteBatchSportAsync();

      return Ok();
    }


    /// <summary>
    /// Get - Retrieve Stored Sports Count All
    /// </summary>
    /// <remarks>Retrieve Stored Sports Count All</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-all", Name = "GetSportsCountAll")]
    public async Task<IActionResult> GetSportsCountAllAsync()
    {
      return Ok(await _inquiryAllSportsProcessor.GetTotalCountSportsAsync());
    }

    /// <summary>
    /// Get - Retrieve Stored Sports Count Prioritized
    /// </summary>
    /// <remarks>Retrieve Stored Sports Count Prioritized</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("count-prioritized", Name = "GetSportsCountPrioritized")]
    public async Task<IActionResult> GetSportsCountPrioritizedAsync()
    {
      return Ok(await _inquirySportProcessor.GetSportCountPrioritizedAsync());
    }


    /// <summary>
    /// Get - Retrieve Stored Sports providing Priority Number and Equation
    /// </summary>
    /// <param name="priority">Priority Number the Request Index for Retrieval</param>
    /// <param name="equation">If = 0 = equal, = 1 = min, = 2 = max</param>
    /// <remarks>Retrieve Sports providing Priority and Equation</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="400">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("priority/{priority}/equation/{equation}", Name = "GetSportsByPriority")]
    public async Task<IActionResult> GetSportsByPriorityAsync(int priority, int equation)
    {
      return Ok();
    }


    /// <summary>
    /// Get - Retrieve Stored Sports providing Sport Id
    /// </summary>
    /// <param name="id">Sport Id the Request Index for Retrieval</param>
    /// <param name="fields">Fiends to be filtered with for the returned Sports</param>
    /// <remarks>Retrieve Sports providing Id and [Optional] fields</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="400">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("{id}", Name = "GetSport")]
    public async Task<IActionResult> GetSportAsync(Guid id, [FromQuery] string fields)
    {
      if (!_typeHelperService.TypeHasProperties<SportUiModel>
          (fields))
      {
        return BadRequest();
      }

      var sportFromRepo = await _inquirySportProcessor.GetSportByIdAsync(id);

      if (sportFromRepo == null)
      {
        return NotFound();
      }

      return Ok(Mapper.Map<SportUiModel>(sportFromRepo));
    }


    /// <summary>
    /// Update Sport with New Priority
    /// </summary>
    /// <param name="id">Sport Id the Request Index for Retrieval</param>
    /// <param name="updatedSport">SportForModification the Request Model with New Priority</param>
    /// <remarks>Change Sport providing SportForModificationUiModel with Modified Priority</remarks>
    /// <response code="200">Resource updated correctly.</response>
    /// <response code="400">The model is not in valid state.</response>
    /// <response code="403">You have not access for this action.</response>
    /// <response code="404">Wrong attributes provided.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpPut("{id}", Name = "UpdateSportWithModifiedPriority")]
    [ValidateModel]
    public async Task<IActionResult> UpdateSportWithModifiedPriorityAsync(Guid id,
      [FromBody] SportForModificationUiModel updatedSport)
    {
      if (id == Guid.Empty || updatedSport.NewPriority < 0)
        return BadRequest();

      await _updateSportProcessor.UpdateSportAsync(id, updatedSport);

      var sportFromRepo = await _inquirySportProcessor.GetSportByIdAsync(id);
      if (sportFromRepo == null)
        return BadRequest();

      var sportFromRedis = await _sportRedisRepository.UpdateSportAsync(new SportRedis(sportFromRepo.SportId, sportFromRepo.Priority));

      if (sportFromRedis == null)
        return BadRequest();
      return Ok(Mapper.Map<SportUiModel>(sportFromRepo));
    }

    /// <summary>
    /// Update Sport with New Configuration
    /// </summary>
    /// <param name="sportid">Sport Id the Request Index for Retrieval</param>
    /// <param name="updatedSport">SportForModification the Request Model with New Configuration - Valid Values: 'USA' - 'EUR' </param>
    /// <remarks>Change Sport providing SportForModificationConfigurationUiModel with Modified Configuration</remarks>
    /// <response code="200">Resource updated correctly.</response>
    /// <response code="400">The model is not in valid state.</response>
    /// <response code="403">You have not access for this action.</response>
    /// <response code="404">Wrong attributes provided.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpPut("configuration/{sportid}", Name = "UpdateSportWithModifiedConfigurationRoot")]
    [ValidateModel]
    public async Task<IActionResult> UpdateSportWithModifiedConfigurationAsync(string sportid,
      [FromBody] SportForModificationConfigurationUiModel updatedSport)
    {
      if (string.IsNullOrEmpty(sportid) || updatedSport.ModifiedConfiguration < 0)
        return BadRequest("ERROR_MODIFIED_CONFIGURATION");

      await _updateSportProcessor.UpdateConfigurationSportAsync(sportid, updatedSport);

      var sportFromRepo = await _inquirySportProcessor.GetSportBySportIdAsync(sportid);
      if (sportFromRepo == null)
        return BadRequest();

      return Ok(Mapper.Map<SportUiModel>(sportFromRepo));
    }

    /// <summary>
    /// Get - Retrieve All/or Partial Paged Stored Sports
    /// </summary>
    /// <remarks>Retrieve paged Sports providing Paging Query</remarks>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet(Name = "GetSports")]
    public async Task<IActionResult> GetSportsAsync([FromQuery] SportsResourceParameters sportsResourceParameters)
    {
      if (!_propertyMappingService.ValidMappingExistsFor<SportUiModel, Sport>
        (sportsResourceParameters.OrderColumn))
      {
        return BadRequest();
      }

      PagedList<Sport> sportsQueryable = null;

      try
      {
        sportsQueryable = await _inquiryAllSportsProcessor.GetSportsAsync(sportsResourceParameters);
      }
      catch (Exception e)
      {
        BadRequest(e.Message);
      }

      var sports = Mapper.Map<IEnumerable<SportUiModel>>(sportsQueryable);

      var previousPageLink = sportsQueryable.HasPrevious
        ? CreateSportsResourceUri(sportsResourceParameters,
          ResourceUriType.PreviousPage)
        : null;

      var nextPageLink = sportsQueryable.HasNext
        ? CreateSportsResourceUri(sportsResourceParameters,
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

        sports = sports.FilterData(searchQueryForWhereClauseFilterFields, searchQueryForWhereClauseFilterSearchQuery);
      }

      return Ok(new {items = sports, totalCount = paginationMetadata.totalCount});
    }

    #region Link Builder


    private string CreateSportsResourceUri(SportsResourceParameters sportsResourceParameters,
        ResourceUriType type)
    {
      switch (type)
      {
        case ResourceUriType.PreviousPage:
          return _urlHelper.Link("GetSports",
              new
              {
                orderBy = sportsResourceParameters.OrderDirection,
                searchQuery = sportsResourceParameters.SearchQuery,
                pageNumber = sportsResourceParameters.Offset - 1,
                pageSize = sportsResourceParameters.Limit
              });
        case ResourceUriType.NextPage:
          return _urlHelper.Link("GetSports",
              new
              {
                orderBy = sportsResourceParameters.OrderDirection,
                searchQuery = sportsResourceParameters.SearchQuery,
                pageNumber = sportsResourceParameters.Offset + 1,
                pageSize = sportsResourceParameters.Limit
              });
        case ResourceUriType.Current:
        default:
          return _urlHelper.Link("GetSports",
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
