using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Admin.Users;

namespace horizonsb.be.contracts.Admin.Users
{
  public interface IUpdateUserProcessor
  {
    Task<bool> UpdateUserRefreshTokenExpiredAsync(Guid refreshToken);
    Task<UserForRetrievalUiModel> UpdateUserRefreshTokenAsync(Guid refreshToken);
    Task<UserForRetrievalUiModel> UpdateUserWithNewRefreshTokenAsync(UserForRetrievalUiModel registeredUser, Guid refreshToken);
  }
}