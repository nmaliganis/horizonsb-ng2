using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Admin.Roles;

namespace horizonsb.commons.vm.Dtos.Admin.Users
{
  public class UserForRetrievalUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Login { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public List<RoleUiModel> Roles { get; set; }
    [Required]
    [Editable(true)]
    public bool IsActivated { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string RefreshToken { get; set; }
    [Editable(true)]
    public string Message { get; set; }
  }
}