using System;
using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Categories
{
  public class CategoryForCreationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public virtual string CategoryId { get; set; }

    [Editable(true)] public virtual string LongName { get; set; }
    [Editable(true)] public virtual string ShortName { get; set; }
    [Editable(true)] public virtual string VeryShortName { get; set; }
    [Editable(true)] public virtual long NumEvents { get; set; }
    [Editable(true)] public virtual long NumInPlayEvents { get; set; }
    [Editable(true)] public virtual double Weighting { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public virtual string ParentSportId { get; set; }
  }
}
