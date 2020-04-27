using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Admin.Roles;

namespace horizonsb.be.contracts.Admin.Roles
{
  public interface ICreateRoleProcessor
  {
    Task<RoleCreationUiModel> CreateRoleAsync(Guid accountIdToCreateThisRole, RoleForCreationUiModel newRoleUiModel);
  }
}