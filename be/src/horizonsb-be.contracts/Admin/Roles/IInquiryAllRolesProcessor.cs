using System.Threading.Tasks;
using horizonsb.be.model.Admin.Roles;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;

namespace horizonsb.be.contracts.Admin.Roles
{
  public interface IInquiryAllRolesProcessor
  {
    Task<PagedList<Role>> GetRolesAsync(RolesResourceParameters rolesResourceParameters);
    Task<int> GetTotalCountRolesAsync();
  }
}