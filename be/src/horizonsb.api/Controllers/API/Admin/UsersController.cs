using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using horizonsb.api.Controllers.API.Base;
using horizonsb.be.contracts.Admin.Users;
using horizonsb.be.contracts.V1.Admin;
using horizonsb.be.model.Admin;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using horizonsb.commons.vm.Dtos.Admin.Users;
using horizonsb.commons.vm.Links;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace horizonsb.api.Controllers.API.Admin
{
  [Produces("application/json")]
  [ResponseCache(Duration = 0, NoStore = true, VaryByHeader = "*")]
  [Route("admin/api/[controller]")]
  [ApiController]
  [Authorize(Roles = "SU, ADMIN")]
  public class UsersController : BaseController
  {
    private readonly IUrlHelper _urlHelper;
    private readonly ITypeHelperService _typeHelperService;
    private readonly IPropertyMappingService _propertyMappingService;

    private readonly IInquiryAllUsersProcessor _inquiryAllUsersProcessor;

    public UsersController(IUrlHelper urlHelper, ITypeHelperService typeHelperService, IPropertyMappingService propertyMappingService, IUsersControllerDependencyBlock blockUser)
    {
      _urlHelper = urlHelper;
      _typeHelperService = typeHelperService;
      _propertyMappingService = propertyMappingService;

      _inquiryAllUsersProcessor = blockUser.InquiryAllUsersProcessor;
    }

    /// <summary>
    /// Get - Retrieve All/or Partial Paged Stored Persons
    /// </summary>
    /// <remarks>Retrieve paged Persons providing Paging Query</remarks>
    /// <param name="usersResourceParameters"></param>
    /// <param name="mediaType">Header - use: "application/vnd.marvin.hateoas+json" for custom links response </param>
    /// <response code="200">Resource retrieved correctly.</response>
    /// <response code="500">Internal Server Error.</response>
    [HttpGet(Name = "GetUsers")]
    public async Task<IActionResult> GetUsersAsync([FromQuery] UsersResourceParameters usersResourceParameters,
        [FromHeader(Name = "Accept")] string mediaType)
    {
      if (!_propertyMappingService.ValidMappingExistsFor<UserUiModel, User>
          (usersResourceParameters.OrderColumn))
      {
        return BadRequest();
      }

      var usersQueryable = await _inquiryAllUsersProcessor.GetUsersAsync(usersResourceParameters);

      var users = Mapper.Map<IEnumerable<UserForAllRetrievalUiModel>>(usersQueryable);

        var previousPageLink = usersQueryable.HasPrevious
            ? CreateUsersResourceUri(usersResourceParameters,
                ResourceUriType.PreviousPage)
            : null;

        var nextPageLink = usersQueryable.HasNext
            ? CreateUsersResourceUri(usersResourceParameters,
                ResourceUriType.NextPage)
            : null;

        var paginationMetadata = new
        {
          previousPageLink = previousPageLink,
          nextPageLink = nextPageLink,
          totalCount = usersQueryable.TotalCount,
          pageSize = usersQueryable.PageSize,
          currentPage = usersQueryable.CurrentPage,
          totalPages = usersQueryable.TotalPages
        };

        Response.Headers.Add("X-Pagination",
            JsonConvert.SerializeObject(paginationMetadata));

        if (!string.IsNullOrEmpty(usersResourceParameters.SearchColumn) &&
            !string.IsNullOrEmpty(usersResourceParameters.SearchQuery))
        {

          var searchQueryForWhereClauseFilterFields = usersResourceParameters.SearchColumn
            .Trim().ToLowerInvariant();

          var searchQueryForWhereClauseFilterSearchQuery = usersResourceParameters.SearchQuery
            .Trim().ToLowerInvariant();

          users = users.FilterData(searchQueryForWhereClauseFilterFields,
            searchQueryForWhereClauseFilterSearchQuery);
        }

      return Ok(users);
    }

    #region Link Builder

    private IEnumerable<LinkDto> CreateLinksForUser(int id, string fields)
    {
      var links = new List<LinkDto>();

      if (String.IsNullOrWhiteSpace(fields))
      {
        links.Add(
            new LinkDto(_urlHelper.Link("GetUser", new { id = id }),
                "self",
                "GET"));
      }
      else
      {
        links.Add(
            new LinkDto(_urlHelper.Link("GetUser", new { id = id, fields = fields }),
                "self",
                "GET"));
      }

      return links;
    }


    private IEnumerable<LinkDto> CreateLinksForUsers(UsersResourceParameters usersResourceParameters,
        bool hasNext, bool hasPrevious)
    {
      var links = new List<LinkDto>
            {
                new LinkDto(CreateUsersResourceUri(usersResourceParameters,
                        ResourceUriType.Current)
                    , "self", "GET")
            };

      if (hasNext)
      {
        links.Add(
            new LinkDto(CreateUsersResourceUri(usersResourceParameters,
                    ResourceUriType.NextPage),
                "nextPage", "GET"));
      }

      if (hasPrevious)
      {
        links.Add(
            new LinkDto(CreateUsersResourceUri(usersResourceParameters,
                    ResourceUriType.PreviousPage),
                "previousPage", "GET"));
      }

      return links;
    }

    private string CreateUsersResourceUri(UsersResourceParameters usersResourceParameters,
        ResourceUriType type)
    {
      switch (type)
      {
        case ResourceUriType.PreviousPage:
          return _urlHelper.Link("GetUsers",
              new
              {
                orderBy = usersResourceParameters.OrderColumn,
                searchQuery = usersResourceParameters.SearchQuery,
                pageNumber = usersResourceParameters.Offset - 1,
                pageSize = usersResourceParameters.Limit
              });
        case ResourceUriType.NextPage:
          return _urlHelper.Link("GetUsers",
              new
              {
                orderBy = usersResourceParameters.OrderColumn,
                searchQuery = usersResourceParameters.SearchQuery,
                pageNumber = usersResourceParameters.Offset + 1,
                pageSize = usersResourceParameters.Limit
              });
        case ResourceUriType.Current:
        default:
          return _urlHelper.Link("GetUsers",
              new
              {
                orderBy = usersResourceParameters.OrderColumn,
                searchQuery = usersResourceParameters.SearchQuery,
                pageNumber = usersResourceParameters.Offset,
                pageSize = usersResourceParameters.Limit
              });
      }
    }

    #endregion
  }
}
