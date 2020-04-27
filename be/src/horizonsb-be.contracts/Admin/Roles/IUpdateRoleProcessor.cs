using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Admin.Roles;

namespace horizonsb.be.contracts.Admin.Roles
{
  public interface IUpdateRoleProcessor
  {
    Task<RoleUiModel> UpdateRoleAsync(Guid roleIdToBeUpdated, Guid accountIdToBeUpdatedThisRole, RoleForModificationUiModel updatedRole);
  }
}
