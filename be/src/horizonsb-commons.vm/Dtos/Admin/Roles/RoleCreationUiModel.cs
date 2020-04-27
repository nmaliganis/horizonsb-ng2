using System;
using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Roles
{
  public class RoleCreationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Message { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }
    [Required]
    [Editable(true)]
    public DateTime CreatedDate { get; set; }
    [Required]
    [Editable(true)]
    public DateTime ModifiedDate { get; set; }
    [Required]
    [Editable(true)]
    public bool Active { get; set; }
    [Editable(true)]
    public Guid Id { get; set; }
  }
}