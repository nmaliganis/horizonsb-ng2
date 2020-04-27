using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Markets
{
  public class MarketForCreationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string MarketId { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)] public string Type { get; set; }

    [Editable(true)] public string Status { get; set; }
    [Editable(true)] public bool Antepost { get; set; }
    [Editable(true)] public long MarketGroupId { get; set; }
    [Editable(true)] public string SubGroupId { get; set; }
    [Editable(true)] public string ParentEventId { get; set; }
    [Editable(true)] public string Description { get; set; }
    [Editable(true)] public bool IsChanged { get; set; }
    [Editable(true)] public bool Balanced { get; set; }
    [Editable(true)] public bool Displayed { get; set; }
    [Editable(true)] public bool WinningLegsBonus { get; set; }
    [Editable(true)] public List<double> Lines { get; set; }
    [Editable(true)] public int MinimumRestriction { get; set; }
    [Editable(true)] public int MaximumRestriction { get; set; }
    [Editable(true)] public string LegacyMarket { get; set; }
    [Editable(true)] public string MarketFixedId { get; set; }
  }
}
