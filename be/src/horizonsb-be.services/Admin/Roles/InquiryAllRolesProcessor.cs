using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Admin.Roles;
using horizonsb.be.model.Admin.Roles;
using horizonsb.be.repository.ContractRepositories.Admin;
using horizonsb.common.infrastructure.Extensions;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Admin.Roles;

namespace horizonsb.be.services.Admin.Roles
{
  public class InquiryAllRolesProcessor : IInquiryAllRolesProcessor
  {
    private readonly IAutoMapper _autoMapper;
    private readonly IRoleRepository _roleRepository;
    private readonly IPropertyMappingService _propertyMappingService;

    public InquiryAllRolesProcessor(IAutoMapper autoMapper,
                        IRoleRepository roleRepository, IPropertyMappingService propertyMappingService)
    {
      _autoMapper = autoMapper;
      _roleRepository = roleRepository;
      _propertyMappingService = propertyMappingService;
    }

    public Task<PagedList<Role>> GetRolesAsync(RolesResourceParameters rolesResourceParameters)
    {
      var collectionBeforePaging =
          QueryableExtensions.ApplySort(_roleRepository.FindAllActiveRolesPagedOf(rolesResourceParameters.Offset,
                      rolesResourceParameters.Limit),
              rolesResourceParameters.OrderColumn + " " + rolesResourceParameters.OrderDirection,
              _propertyMappingService.GetPropertyMapping<RoleUiModel, Role>());

      return Task.Run(() => PagedList<Role>.Create(collectionBeforePaging,
          rolesResourceParameters.Offset,
          rolesResourceParameters.Limit));
    }

    public Task<int> GetTotalCountRolesAsync()
    {
      return Task.Run(() => _roleRepository.FindCountAllActiveRoles());
    }
  }
}