using System;
using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Roles
{
  public class UserForRegistrationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Login { get; set; }
    [MinLength(8)]
    [MaxLength(16)]
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Password { get; set; }
    [Required]
    [Editable(true)]
    public Guid UserRoleId { get; set; }
  }
}
