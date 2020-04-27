using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Admin.Roles;

namespace horizonsb.be.contracts.Admin.Roles
{
  public interface IInquiryRoleProcessor
  {
    Task<RoleUiModel> GetRoleByIdAsync(Guid id);
  }
}