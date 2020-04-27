using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Teams
{
  public class TeamForCreationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public bool IsHome { get; set; }
  }
}
