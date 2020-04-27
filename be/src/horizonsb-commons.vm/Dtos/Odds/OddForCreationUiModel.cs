using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Odds
{
  public class OddForCreationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string OddId { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)] public string Type { get; set; }

    [Editable(true)] public string Status { get; set; }
    [Editable(true)] public bool Antepost { get; set; }
    [Editable(true)] public long OddGroupId { get; set; }
    [Editable(true)] public string SubGroupId { get; set; }
    [Editable(true)] public string ParentEventId { get; set; }
    [Editable(true)] public string ParentMarketId { get; set; }
    [Editable(true)] public string Description { get; set; }
    [Editable(true)] public bool IsChanged { get; set; }
    [Editable(true)] public bool Balanced { get; set; }
    [Editable(true)] public bool Displayed { get; set; }
    [Editable(true)] public bool WinningLegsBonus { get; set; }
    [Editable(true)] public string Code { get; set; }
    [Editable(true)] public double OddNum { get; set; }
    [Editable(true)] public string Short { get; set; }
    [Editable(true)] public string Clean { get; set; }
    [Editable(true)] public string Handicap { get; set; }
    [Editable(true)] public int Col { get; set; }
    [Editable(true)] public int Row { get; set; }
  }
}
