using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Accounts
{
  public class UserForRefreshTokenModificationUiModel
  {
    [Editable(true)]
    [Required(AllowEmptyStrings = false)]
    public string RefreshToken { get; set; }
  }
}