using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Accounts
{
  public class AccountWithNewPasswordModification
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Password { get; set; }
  }
}