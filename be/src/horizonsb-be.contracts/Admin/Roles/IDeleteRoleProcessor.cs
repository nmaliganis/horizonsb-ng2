using System;
using System.Threading.Tasks;

namespace horizonsb.be.contracts.Admin.Roles
{
  public interface IDeleteRoleProcessor
  {
    Task DeleteRoleAsync(Guid roleToBeDeletedId, Guid accountIdToDeleteThisRole);
  }
}