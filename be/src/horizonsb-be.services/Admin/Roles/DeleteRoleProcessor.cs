using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Admin.Roles;
using horizonsb.be.repository.ContractRepositories.Admin;
using horizonsb.common.infrastructure.UnitOfWorks;

namespace horizonsb.be.services.Admin.Roles
{
  public class DeleteRoleProcessor : IDeleteRoleProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly IRoleRepository _roleRepository;

    public DeleteRoleProcessor(IUnitOfWork uOf,
        IRoleRepository roleRepository)
    {
      _uOf = uOf;
      _roleRepository = roleRepository;
    }

    public Task DeleteRoleAsync(Guid roleToBeDeletedId, Guid accountIdToDeleteThisRole)
    {
      throw new NotImplementedException();
    }
  }
}