using System;
using horizonsb.be.model.Admin.Roles;
using horizonsb.common.infrastructure.Domain;
using horizonsb.common.infrastructure.Domain.Queries;

namespace horizonsb.be.repository.ContractRepositories.Admin
{
  public interface IRoleRepository : IRepository<Role, Guid>
  {
    QueryResult<Role> FindAllActiveRolesPagedOf(int? pageNum, int? pageSize);
    int FindCountAllActiveRoles();

    Role FindRoleByName(string name);
  }
}