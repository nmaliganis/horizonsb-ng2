using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Admin.Users;
using horizonsb.be.model.Admin;
using horizonsb.be.repository.ContractRepositories.Admin;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Admin.Users;

namespace horizonsb.be.services.Admin.Users
{
  public class InquiryAllUsersProcessor : IInquiryAllUsersProcessor
  {
    private readonly IAutoMapper _autoMapper;
    private readonly IUserRepository _personRepository;
    private readonly IPropertyMappingService _propertyMappingService;

    public InquiryAllUsersProcessor(IAutoMapper autoMapper,
        IUserRepository personRepository, IPropertyMappingService propertyMappingService)
    {
      _autoMapper = autoMapper;
      _personRepository = personRepository;
      _propertyMappingService = propertyMappingService;
    }

    public Task<PagedList<User>> GetUsersAsync(UsersResourceParameters personsResourceParameters)
    {
      var collectionBeforePaging =
          QueryableExtensions.ApplySort(_personRepository
                  .GetUsersPagedAsync(personsResourceParameters.Offset,
                      personsResourceParameters.Limit),
              personsResourceParameters.OrderColumn,
              _propertyMappingService.GetPropertyMapping<UserUiModel, User>());


      if (!string.IsNullOrEmpty(personsResourceParameters.SearchQuery))
      {
        // trim & ignore casing
        var searchQueryForWhereClause = personsResourceParameters.SearchQuery
            .Trim().ToLowerInvariant();

        collectionBeforePaging.QueriedItems = collectionBeforePaging.QueriedItems
            .Where(a => a.Login.ToLowerInvariant().Contains(searchQueryForWhereClause));
      }

      return Task.Run(() => PagedList<User>.Create(collectionBeforePaging,
          personsResourceParameters.Offset,
          personsResourceParameters.Limit));
    }
  }
}