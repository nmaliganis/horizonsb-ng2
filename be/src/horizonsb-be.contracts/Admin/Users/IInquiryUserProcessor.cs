using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Admin.Accounts;
using horizonsb.commons.vm.Dtos.Admin.Users;

namespace horizonsb.be.contracts.Admin.Users
{
  public interface IInquiryUserProcessor
  {
    Task<UserForRetrievalUiModel> GetUserAuthJwtTokenByRefreshTokenAsync(Guid refreshToken);
    Task<UserForRetrievalUiModel> GetUserAuthJwtTokenByLoginAndPasswordAsync(string login, string password);
    Task<UserUiModel> GetUserByLoginAsync(string login);
    Task<UserForRetrievalUiModel> GetAuthUserByLoginAsync(string login);
    Task<UserActivationUiModel> GetUserByIdAsync(Guid userId);
  }
}