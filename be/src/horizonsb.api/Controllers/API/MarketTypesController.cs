using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using horizonsb.be.contracts.MarketTypes;
using horizonsb.be.contracts.V1;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using horizonsb.commons.vm.Dtos.Markets;
using horizonsb.commons.vm.Dtos.MarketTypes;
using Microsoft.AspNetCore.Mvc;

namespace horizonsb.api.Controllers.API
{
  [Produces("application/json")]
  [ResponseCache(Duration = 0, NoStore = true, VaryByHeader = "*")]
  [Route("api/[controller]")]
  [ApiController]
  public class MarketTypesController : ControllerBase
  {
    private readonly IUrlHelper _urlHelper;
    private readonly ITypeHelperService _typeHelperService;
    private readonly IPropertyMappingService _propertyMappingService;

    private readonly IInquiryMarketTypeProcessor _inquiryMarketTypeProcessor;
    private readonly ICreateMarketTypeProcessor _createMarketTypeProcessor;
    private readonly IDeleteMarketTypeProcessor _deleteMarketTypeProcessor;

    public MarketTypesController(IUrlHelper urlHelper,
        ITypeHelperService typeHelperService, IPropertyMappingService propertyMappingService, IMarketTypesControllerDependencyBlock blockMarketType)
    {
      _urlHelper = urlHelper;
      _typeHelperService = typeHelperService;
      _propertyMappingService = propertyMappingService;

      _inquiryMarketTypeProcessor = blockMarketType.InquiryMarketTypeProcessor;
      _createMarketTypeProcessor = blockMarketType.CreateMarketTypeProcessor;
      _deleteMarketTypeProcessor = blockMarketType.DeleteMarketTypeProcessor;
    }

    /// <summary>
    /// Get - Retrieve Stored Market Type providing Market Type Id
    /// </summary>
    /// <param name="id">Market Type Id the Request Index for Retrieval</param>
    /// <param name="fields">Fiends to be filtered with for the returned Market Type</param>
    /// <remarks>Retrieve MarketType providing Id and [Optional] fields</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpPost("init", Name = "PostMarketTypeInitRoot")]
    public async Task<IActionResult> PostMarketTypeInitAync()
    {
      IList<MarketTypeDto> marketInit = new List<MarketTypeDto>()
      {
        new MarketTypeDto()
        {
          Name = "s-SOCCER",
          Types = new List<string>()
          {
            "SOCCER:FT:ML",
            "SOCCER:FT:AXB",
            "SOCCER:FT:OU",
            "SOCCER:FT:3HCP",
          },
        },
        new MarketTypeDto()
        {
          Name = "s-BASKETBALL",
          Types = new List<string>()
          {
            "BASKETBALL:FT:ML",
            "BASKETBALL:FT:OU3WAY",
            "BASKETBALL:FT:AHCP",
            "BASKETBALL:FT:3HCP",
          },
        },
        new MarketTypeDto()
        {
          Name = "s-VOLLEYBALL",
          Types = new List<string>()
          {
            "VOLLEYBALL:FT:ML",
            "VOLLEYBALL:FT:OU3WAY",
            "VOLLEYBALL:FT:3HCP",
          },
        },
        new MarketTypeDto()
        {
          Name = "s-AMERICAN_FOOTBALL",
          Types = new List<string>()
          {
            "AMERICAN_FOOTBALL:FT:ML",
            "AMERICAN_FOOTBALL:FT:OU3WAY",
            "AMERICAN_FOOTBALL:OT:PSPRD",
          },
        },
        new MarketTypeDto()
        {
          Name = "s-FUTSAL",
          Types = new List<string>()
          {
            "FUTSAL:FT:AXB",
            "FUTSAL:FT:OU",
            "FUTSAL:FT:3HCP",
          },
        },
        new MarketTypeDto()
        {
          Name = "s-RUGBY",
          Types = new List<string>()
          {
            "RUGBY:FT:AXB",
            "RUGBY:FT:OU",
            "RUGBY:FT:2HCP",
          },
        },
        new MarketTypeDto()
        {
          Name = "s-HANDBALL",
          Types = new List<string>()
          {
            "HANDBALL:FT:AXB",
            "HANDBALL:FT:OU",
            "HANDBALL:FT:AHCP",
          },
        },
        new MarketTypeDto()
        {
          Name = "s-BASEBALL",
          Types = new List<string>()
          {
            "BASEBALL:FT:ML",
            "BASEBALL:FT:OU",
            "BASEBALL:OT:PSPRD",
          },
        },
        new MarketTypeDto()
        {
          Name = "s-MMA",
          Types = new List<string>()
          {
            "MMA:FT:ML",
            "MMA:FT:OU",
            "MMA:FT:3HCP",
          },
        },
        new MarketTypeDto()
        {
          Name = "s-ICE_HOCKEY",
          Types = new List<string>()
          {
            "ICE_HOCKEY:FT:AXB",
            "ICE_HOCKEY:FT:OU",
          },
        },       
        new MarketTypeDto()
        {
          Name = "s-TENNIS",
          Types = new List<string>()
          {
            "TENNIS:FT:ML",
            "TENNIS:FT:OU",
            "TENNIS:FT:AHCP",
          },
        },
      };

      await _createMarketTypeProcessor.CreateMarketTypeAsync(new MarketTypeForCreationUiModel()
      {
        MarketTypes = marketInit
      });

      return Ok();
    }

    /// <summary>
    /// Get - Retrieve Stored Market Type providing Market Type Id
    /// </summary>
    /// <param name="id">Market Type Id the Request Index for Retrieval</param>
    /// <param name="fields">Fiends to be filtered with for the returned Market Type</param>
    /// <remarks>Retrieve MarketType providing Id and [Optional] fields</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>

    [HttpGet("{id}", Name = "GetMarketType")]
    public async Task<IActionResult> GetMarketAsync(Guid id, [FromQuery] string fields)
    {
      if (!_typeHelperService.TypeHasProperties<MarketUiModel>
          (fields))
      {
        return BadRequest();
      }

      var marketTypeFromRepo = await _inquiryMarketTypeProcessor.GetMarketTypeAsync(id);

      if (marketTypeFromRepo == null)
      {
        return NotFound();
      }

      var marketType = Mapper.Map<MarketTypeUiModel>(marketTypeFromRepo);

      return Ok(marketType);
    }

    /// <summary>
    /// Get - Retrieve All/or Partial Paged Stored Markets By SportId
    /// </summary>
    /// <remarks>Retrieve paged Markets providing Paging Query and sportId </remarks>
    /// <param name="sportId">Sport Id the Request Index for Retrieval</param>
    /// <param name="fields">Fiends to be filtered with for the returned Market Type</param>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("by-sport/{sportId}", Name = "GetMarketsBySportId")]
    public async Task<IActionResult> GetMarketsBySportIdAsync(string sportId, [FromQuery] string fields)
    {
      if (!_typeHelperService.TypeHasProperties<MarketUiModel>
        (fields))
      {
        return BadRequest();
      }

      var marketTypeFromRepo = await _inquiryMarketTypeProcessor.GetMarketTypeBySportIdAsync(sportId);

      if (marketTypeFromRepo == null)
      {
        return NotFound();
      }

      var marketType = Mapper.Map<MarketTypeUiModel>(marketTypeFromRepo);

      return Ok(marketType);
    }


    /// <summary>
    /// Delete - Remove Market Type providing sportId
    /// </summary>
    /// <remarks>Delete all Events </remarks>
    /// <param name="sportId">Sport Id the Request Index for Deletion</param>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="200">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpDelete(Name = "DeleteMarketTypeRoot")]
    public async Task<IActionResult> DeleteMarketTypeAsync(string sportId)
    {
      await _deleteMarketTypeProcessor.DeleteMarketTypeWithSportIdAsync(sportId);

      return Ok();
    }
  }
}
