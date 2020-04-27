using System;
using System.Threading.Tasks;
using horizonsb.be.contracts.Admin.Roles;
using horizonsb.be.repository.ContractRepositories.Admin;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.commons.vm.Dtos.Admin.Roles;

namespace horizonsb.be.services.Admin.Roles
{
  public class InquiryRoleProcessor : IInquiryRoleProcessor
  {
    private readonly IAutoMapper _autoMapper;
    private readonly IRoleRepository _roleRepository;
    public InquiryRoleProcessor(IRoleRepository roleRepository, IAutoMapper autoMapper)
    {
      _roleRepository = roleRepository;
      _autoMapper = autoMapper;
    }

    public Task<RoleUiModel> GetRoleByIdAsync(Guid id)
    {
      return Task.Run(() => _autoMapper.Map<RoleUiModel>(_roleRepository.FindBy(id)));
    }
  }
}