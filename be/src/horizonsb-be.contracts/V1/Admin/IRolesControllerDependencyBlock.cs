using horizonsb.be.contracts.Admin.Roles;

namespace horizonsb.be.contracts.V1.Admin
{
  public interface IRolesControllerDependencyBlock
  {
    ICreateRoleProcessor CreateRoleProcessor { get; }
    IInquiryRoleProcessor InquiryRoleProcessor { get; }
    IUpdateRoleProcessor UpdateRoleProcessor { get; }
    IInquiryAllRolesProcessor InquiryAllRolesProcessor { get; }
    IDeleteRoleProcessor DeleteRoleProcessor { get; }
  }
}