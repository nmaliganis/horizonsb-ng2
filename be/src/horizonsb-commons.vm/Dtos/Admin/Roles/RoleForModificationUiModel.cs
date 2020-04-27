using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Roles
{
  public class RoleForModificationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string ModifiedName { get; set; }
  }
}
