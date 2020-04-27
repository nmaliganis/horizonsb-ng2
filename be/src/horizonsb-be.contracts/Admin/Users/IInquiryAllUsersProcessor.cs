using System.Threading.Tasks;
using horizonsb.be.model.Admin;
using horizonsb.common.infrastructure.Helpers.ResourceParameters;
using horizonsb.common.infrastructure.Paging;

namespace horizonsb.be.contracts.Admin.Users
{
  public interface IInquiryAllUsersProcessor
  {
    Task<PagedList<User>> GetUsersAsync(UsersResourceParameters usersResourceParameters);
  }
}