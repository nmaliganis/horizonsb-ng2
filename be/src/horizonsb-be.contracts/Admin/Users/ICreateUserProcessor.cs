using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Admin.Roles;
using horizonsb.commons.vm.Dtos.Admin.Users;

namespace horizonsb.be.contracts.Admin.Users
{
  public interface ICreateUserProcessor
  {
    Task<UserUiModel> CreateUserAsync(Guid accountIdToCreateThisRole, UserForRegistrationUiModel newUserForRegistration);
  }
}