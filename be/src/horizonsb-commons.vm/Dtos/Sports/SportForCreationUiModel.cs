using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Sports
{
  public class SportForCreationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string SportId { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string LongName { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string ShortName { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string VeryShortName { get; set; }

    [Editable(true)] public bool Highlight { get; set; }
    [Editable(true)] public long NumEvents { get; set; }
    [Editable(true)] public long NumInPlayEvents { get; set; }
  }
}
