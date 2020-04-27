using System;
using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Accounts
{
  public class AccountForActivationModification
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public Guid ActivationKey { get; set; }
  }
}