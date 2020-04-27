using horizonsb.be.contracts.Admin.Roles;
using horizonsb.be.contracts.V1.Admin;

namespace horizonsb.be.services.V1.Admin
{
  public class RolesControllerDependencyBlock : IRolesControllerDependencyBlock
  {
    public RolesControllerDependencyBlock(ICreateRoleProcessor createRoleProcessor
      , IInquiryRoleProcessor inquiryRoleProcessor
      , IUpdateRoleProcessor updateRoleProcessor
      , IInquiryAllRolesProcessor allRoleProcessor
      , IDeleteRoleProcessor deleteRoleProcessor
    )

    {
      CreateRoleProcessor = createRoleProcessor;
      InquiryRoleProcessor = inquiryRoleProcessor;
      UpdateRoleProcessor = updateRoleProcessor;
      InquiryAllRolesProcessor = allRoleProcessor;
      DeleteRoleProcessor = deleteRoleProcessor;
    }

    public ICreateRoleProcessor CreateRoleProcessor { get; private set; }
    public IInquiryRoleProcessor InquiryRoleProcessor { get; private set; }
    public IUpdateRoleProcessor UpdateRoleProcessor { get; private set; }
    public IInquiryAllRolesProcessor InquiryAllRolesProcessor { get; private set; }
    public IDeleteRoleProcessor DeleteRoleProcessor { get; private set; }
  }
}