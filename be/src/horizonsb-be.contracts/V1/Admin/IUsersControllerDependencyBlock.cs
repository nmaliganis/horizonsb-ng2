using horizonsb.be.contracts.Admin.Users;

namespace horizonsb.be.contracts.V1.Admin
{
  public interface IUsersControllerDependencyBlock
  {
    ICreateUserProcessor CreateUserProcessor { get; }
    IActivateUserProcessor ActivateUserProcessor { get; }
    IInquiryUserProcessor InquiryUserProcessor { get; }
    IInquiryAllUsersProcessor InquiryAllUsersProcessor { get; }
    IUpdateUserProcessor UpdateUserProcessor { get; }
  }
}