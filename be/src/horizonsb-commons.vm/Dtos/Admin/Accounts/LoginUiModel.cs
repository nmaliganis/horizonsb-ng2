using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Accounts
{
  public class LoginUiModel
  {
    [Editable(true)]
    [Required(AllowEmptyStrings = false)]
    public string Login { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Password { get; set; }
  }
}