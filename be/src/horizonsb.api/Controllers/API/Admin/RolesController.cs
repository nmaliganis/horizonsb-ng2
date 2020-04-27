using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using horizonsb.api.Controllers.API.Base;
using horizonsb.api.Validators;
using horizonsb.be.contracts.Admin.Roles;
using horizonsb.be.contracts.Admin.Users;
using horizonsb.be.contracts.V1.Admin;
using horizonsb.be.model.Admin.Roles;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using horizonsb.commons.vm.Dtos.Admin.Roles;
using horizonsb.commons.vm.Links;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Serilog;

namespace horizonsb.api.Controllers.API.Admin
{
  [Produces("application/json")]
  [ResponseCache(Duration = 0, NoStore = true, VaryByHeader = "*")]
  [Route("admin/api/[controller]")]
  [ApiController]
  [Authorize(Roles = "SU")]
  public class RolesController : BaseController
  {
    private readonly IUrlHelper _urlHelper;
    private readonly ITypeHelperService _typeHelperService;
    private readonly IPropertyMappingService _propertyMappingService;

    private readonly IInquiryAllRolesProcessor _inquiryAllRolesProcessor;
    private readonly IInquiryRoleProcessor _inquiryRoleProcessor;
    private readonly ICreateRoleProcessor _createRoleProcessor;
    private readonly IUpdateRoleProcessor _updateRoleProcessor;

    private readonly IInquiryUserProcessor _inquiryUserProcessor;

    public RolesController(IUrlHelper urlHelper,
        ITypeHelperService typeHelperService, IPropertyMappingService propertyMappingService,
        IRolesControllerDependencyBlock blockRole, IUsersControllerDependencyBlock blockUser)
    {
      _urlHelper = urlHelper;
      _typeHelperService = typeHelperService;
      _propertyMappingService = propertyMappingService;

      _inquiryAllRolesProcessor = blockRole.InquiryAllRolesProcessor;
      _inquiryRoleProcessor = blockRole.InquiryRoleProcessor;
      _createRoleProcessor = blockRole.CreateRoleProcessor;
      _updateRoleProcessor = blockRole.UpdateRoleProcessor;

      _inquiryUserProcessor = blockUser.InquiryUserProcessor;
    }

    /// <summary>
    /// POST : Create a New Role.
    /// </summary>
    /// <param name="roleForCreationUiModel">RoleForCreationUiModel the Request Model for Creation</param>
    /// <remarks> return a ResponseEntity with status 201 (Created) if the new Role is created, 400 (Bad Request), 500 (Server Error) </remarks>
    /// <response code="201">Created (if the role is created)</response>
    /// <response code="400">Bad Request</response>
    /// <response code="500">Internal Server Error</response>
    [HttpPost(Name = "PostRoleRoute")]
    [ValidateModel]
    public async Task<IActionResult> PostRoleRouteAsync([FromBody] RoleForCreationUiModel roleForCreationUiModel)
    {
      var userAudit = await _inquiryUserProcessor.GetUserByLoginAsync(GetEmailFromClaims());

      if (userAudit == null)
        return BadRequest();

      var newCreatedRole = await _createRoleProcessor.CreateRoleAsync(userAudit.Id, roleForCreationUiModel);

      switch (newCreatedRole.Message)
      {
        case ("SUCCESS_CREATION"):
          {
            Log.Information(
                $"--Method:PostRoleRouteAsync -- Message:ROLE_CREATION_SUCCESFULLY -- Datetime:{DateTime.Now} -- RoleInfo:{roleForCreationUiModel.Name}");
            return Created(nameof(PostRoleRouteAsync), newCreatedRole);
          }
        case ("ERRR_ERROR_ALREADY_EXISTS"):
          {
            Log.Error(
                $"--Method:PostRoleRouteAsync -- Message:ERROR_ROLE_ALREADY_EXISTS -- Datetime:{DateTime.UtcNow} -- RoleInfo:{roleForCreationUiModel.Name}");
            return BadRequest(new { errorMessage = "ROLE_ALREADY_EXISTS" });
          }
        case ("ERROR_ROLE_NOT_MADE_PERSISTENT"):
          {
            Log.Error(
                $"--Method:PostRoleRouteAsync -- Message:ERROR_ROLE_NOT_MADE_PERSISTENT -- Datetime:{DateTime.UtcNow} -- RoleInfo:{roleForCreationUiModel.Name}");
            return BadRequest(new { errorMessage = "ERROR_CREATION_NEW_ROLE" });
          }
        case ("UNKNOWN_ERROR"):
          {
            Log.Error(
                $"--Method:PostRoleRouteAsync -- Message:ERROR_CREATION_NEW_ROLE -- Datetime:{DateTime.UtcNow} -- RoleInfo:{roleForCreationUiModel.Name}");
            return BadRequest(new { errorMessage = "ERROR_CREATION_NEW_ROLE" });
          }
      }
      return NotFound();
    }

    /// <summary>
    /// PUT : Update Role with New Role Name
    /// </summary>
    /// <param name="id">Role Id the Request Index for Retrieval</param>
    /// <param name="updatedRole">RoleForModification the Request Model with New Role Name</param>
    /// <remarks>Change Role providing RoleForModificationUiModel with Modified Role Name</remarks>
    /// <response code="200">Resource updated correctly.</response>
    /// <response code="400">The model is not in valid state.</response>
    /// <response code="403">You have not access for this action.</response>
    /// <response code="404">Wrong attributes provided.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpPut("{id}", Name = "UpdateRoleRoot")]
    [ValidateModel]
    public async Task<IActionResult> UpdateRoleAsync(Guid id, [FromBody] RoleForModificationUiModel updatedRole)
    {
      if (id == Guid.Empty || String.IsNullOrEmpty(updatedRole.ModifiedName))
        return BadRequest();

      var userAudit = await _inquiryUserProcessor.GetUserByLoginAsync(GetEmailFromClaims());

      if (userAudit == null)
        return BadRequest();

      await _updateRoleProcessor.UpdateRoleAsync(id, userAudit.Id, updatedRole);

      return Ok(await _inquiryRoleProcessor.GetRoleByIdAsync(id));
    }


    /// <summary>
    /// Get : Retrieve Stored Role providing Role Id
    /// </summary>
    /// <param name="id">Role Id the Request Index for Retrieval</param>
    /// <param name="fields">Fiends to be filtered with for the returned Role</param>
    /// <remarks>Retrieve Role providing Id and [Optional] fields</remarks>
    /// <response code="200">Resource retrieved correctly</response>
    /// <response code="404">Resource Not Found</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet("{id}", Name = "GetRole")]
    public async Task<IActionResult> GetRoleAsync(Guid id, [FromQuery] string fields)
    {
      if (!_typeHelperService.TypeHasProperties<RoleUiModel>
          (fields))
      {
        return BadRequest();
      }

      var roleFromRepo = await _inquiryRoleProcessor.GetRoleByIdAsync(id);

      if (roleFromRepo == null)
      {
        return NotFound();
      }

      var role = Mapper.Map<RoleUiModel>(roleFromRepo);

      var links = CreateLinksForRole(id, fields);

      var linkedResourceToReturn = role.ShapeData(fields)
          as IDictionary<string, object>;

      linkedResourceToReturn.Add("links", links);

      return Ok(linkedResourceToReturn);
    }

    /// <summary>
    /// Get : Retrieve All/or Partial Paged Stored Roles
    /// </summary>
    /// <remarks>Retrieve paged Roles providing Paging Query</remarks>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet(Name = "GetRoles")]
    public async Task<IActionResult> GetRolesAsync([FromQuery] RolesResourceParameters rolesResourceParameters,
        [FromHeader(Name = "Accept")] string mediaType)
    {
      if (!_propertyMappingService.ValidMappingExistsFor<RoleUiModel, Role>
          (rolesResourceParameters.OrderColumn))
      {
        return BadRequest();
      }

      var rolesQueryable = await _inquiryAllRolesProcessor.GetRolesAsync(rolesResourceParameters);

      var roles = Mapper.Map<IEnumerable<RoleUiModel>>(rolesQueryable);

        var previousPageLink = rolesQueryable.HasPrevious
            ? CreateRolesResourceUri(rolesResourceParameters,
                ResourceUriType.PreviousPage)
            : null;

        var nextPageLink = rolesQueryable.HasNext
            ? CreateRolesResourceUri(rolesResourceParameters,
                ResourceUriType.NextPage)
            : null;

        var paginationMetadata = new
        {
          previousPageLink = previousPageLink,
          nextPageLink = nextPageLink,
          totalCount = rolesQueryable.TotalCount,
          pageSize = rolesQueryable.PageSize,
          currentPage = rolesQueryable.CurrentPage,
          totalPages = rolesQueryable.TotalPages
        };

        Response.Headers.Add("X-Pagination",
            JsonConvert.SerializeObject(paginationMetadata));

        if (!string.IsNullOrEmpty(rolesResourceParameters.SearchColumn) &&
            !string.IsNullOrEmpty(rolesResourceParameters.SearchQuery))
        {

          var searchQueryForWhereClauseFilterFields = rolesResourceParameters.SearchColumn
            .Trim().ToLowerInvariant();

          var searchQueryForWhereClauseFilterSearchQuery = rolesResourceParameters.SearchQuery
            .Trim().ToLowerInvariant();

          roles = roles.FilterData(searchQueryForWhereClauseFilterFields,
            searchQueryForWhereClauseFilterSearchQuery);
        }

      return Ok(roles);
    }

    #region Link Builder

    private IEnumerable<LinkDto> CreateLinksForRole(Guid id, string fields)
    {
      var links = new List<LinkDto>();

      if (String.IsNullOrWhiteSpace(fields))
      {
        links.Add(
            new LinkDto(_urlHelper.Link("GetRole", new { id = id }),
                "self",
                "GET"));
      }
      else
      {
        links.Add(
            new LinkDto(_urlHelper.Link("GetRole", new { id = id, fields = fields }),
                "self",
                "GET"));
      }

      return links;
    }


    private IEnumerable<LinkDto> CreateLinksForRoles(RolesResourceParameters rolesResourceParameters,
        bool hasNext, bool hasPrevious)
    {
      var links = new List<LinkDto>
            {
                new LinkDto(CreateRolesResourceUri(rolesResourceParameters,
                        ResourceUriType.Current)
                    , "self", "GET")
            };

      if (hasNext)
      {
        links.Add(
            new LinkDto(CreateRolesResourceUri(rolesResourceParameters,
                    ResourceUriType.NextPage),
                "nextPage", "GET"));
      }

      if (hasPrevious)
      {
        links.Add(
            new LinkDto(CreateRolesResourceUri(rolesResourceParameters,
                    ResourceUriType.PreviousPage),
                "previousPage", "GET"));
      }

      return links;
    }

    private string CreateRolesResourceUri(RolesResourceParameters RolesResourceParameters,
        ResourceUriType type)
    {
      switch (type)
      {
        case ResourceUriType.PreviousPage:
          return _urlHelper.Link("GetRoles",
              new
              {
                orderBy = RolesResourceParameters.OrderColumn,
                searchQuery = RolesResourceParameters.SearchQuery,
                pageNumber = RolesResourceParameters.Offset - 1,
                pageSize = RolesResourceParameters.Limit
              });
        case ResourceUriType.NextPage:
          return _urlHelper.Link("GetRoles",
              new
              {
                orderBy = RolesResourceParameters.OrderColumn,
                searchQuery = RolesResourceParameters.SearchQuery,
                pageNumber = RolesResourceParameters.Offset + 1,
                pageSize = RolesResourceParameters.Limit
              });
        case ResourceUriType.Current:
        default:
          return _urlHelper.Link("GetRoles",
              new
              {
                orderBy = RolesResourceParameters.OrderColumn,
                searchQuery = RolesResourceParameters.SearchQuery,
                pageNumber = RolesResourceParameters.Offset,
                pageSize = RolesResourceParameters.Limit
              });
      }
    }

    #endregion
  }
}
