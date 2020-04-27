using System;
using horizonsb.be.model.Admin;
using horizonsb.common.infrastructure.Domain;
using horizonsb.common.infrastructure.Domain.Queries;

namespace horizonsb.be.repository.ContractRepositories.Admin
{
  public interface IUserRepository : IRepository<User, Guid>
  {
    QueryResult<User> GetUsersPagedAsync(int? pageNum, int? pageSize);

    User FindUserByLoginAndEmail(string login, string email);
    User FindUserByLogin(string login);

    User FindUserByLoginAndPasswordAsync(string login, string password);

    User FindByUserIdAndActivationKey(Guid userIdToBeActivated, Guid activationKey);
    User FindUserByRefreshTokenAsync(Guid refreshToken);
  }
}