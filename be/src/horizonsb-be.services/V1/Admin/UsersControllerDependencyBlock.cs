using horizonsb.be.contracts.Admin.Users;
using horizonsb.be.contracts.V1.Admin;

namespace horizonsb.be.services.V1.Admin
{
  public class UsersControllerDependencyBlock : IUsersControllerDependencyBlock
  {
    public UsersControllerDependencyBlock(ICreateUserProcessor createUserProcessor, IUpdateUserProcessor updateUserProcessor, IActivateUserProcessor activateUserProcessor
        , IInquiryUserProcessor inquiryUserProcessor
        , IInquiryAllUsersProcessor allUserProcessor
    )

    {
      CreateUserProcessor = createUserProcessor;
      UpdateUserProcessor = updateUserProcessor;
      ActivateUserProcessor = activateUserProcessor;
      InquiryUserProcessor = inquiryUserProcessor;
      InquiryAllUsersProcessor = allUserProcessor;
    }

    public ICreateUserProcessor CreateUserProcessor { get; private set; }
    public IActivateUserProcessor ActivateUserProcessor { get; private set; }
    public IInquiryUserProcessor InquiryUserProcessor { get; private set; }
    public IInquiryAllUsersProcessor InquiryAllUsersProcessor { get; private set; }
    public IUpdateUserProcessor UpdateUserProcessor { get; }
  }
}