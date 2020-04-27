using System;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Bases;

namespace horizonsb.commons.vm.Dtos.Events
{
  public class EventForModificationUiModel
  {
    [Required] [Editable(true)] public int NewPriority { get; set; }
    [Required] [Editable(true)] public bool Favorite { get; set; }
  }

  public class EventForModificationFavoritesUiModel
    {
      [Editable(true)]
      public bool Favorite { get; set; }
    }
}
