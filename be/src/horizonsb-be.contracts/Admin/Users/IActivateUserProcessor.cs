using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Admin.Accounts;

namespace horizonsb.be.contracts.Admin.Users
{
  public interface IActivateUserProcessor
  {
    Task<UserActivationUiModel> UpdateUserActivatioAnync(Guid userIdToBeActivated, Guid accountIdToActivateThisUser, AccountForActivationModification activationAccount);
  }
}