using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Accounts
{
  public class AuthUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(false)]
    public string Token { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(false)]
    public string RefreshToken { get; set; }
  }
}