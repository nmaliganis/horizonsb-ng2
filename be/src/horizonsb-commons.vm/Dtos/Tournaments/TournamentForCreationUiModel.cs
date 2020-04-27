using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Tournaments
{
  public class TournamentForCreationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string TournamentId { get; set; }

    [Editable(true)] public virtual bool Highlight { get; set; }
    [Editable(true)] public virtual string LongName { get; set; }
    [Editable(true)] public virtual string ShortName { get; set; }
    [Editable(true)] public virtual string VeryShortName { get; set; }
    [Editable(true)] public virtual long NumEvents { get; set; }
    [Editable(true)] public virtual long NumOutrightEvents { get; set; }
    [Editable(true)] public virtual double Order { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string ParentCategoryId { get; set; }
  }
}
