using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Admin.Roles;
using horizonsb.be.repository.ContractRepositories.Admin;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Admin.Roles;

namespace horizonsb.be.services.Admin.Roles
{
  public class UpdateRoleProcessor : IUpdateRoleProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly IRoleRepository _roleRepository;
    private readonly IAutoMapper _autoMapper;
    public UpdateRoleProcessor(IUnitOfWork uOf, IAutoMapper autoMapper, IRoleRepository roleRepository)
    {
      _uOf = uOf;
      _roleRepository = roleRepository;
      _autoMapper = autoMapper;
    }

    public Task<RoleUiModel> UpdateRoleAsync(Guid roleIdToBeUpdated, Guid accountIdToBeUpdatedThisRole, RoleForModificationUiModel updatedRole)
    {
      throw new NotImplementedException();
    }
  }
}