using System.Collections.Generic;

namespace horizonsb.api.Models.ForEvents
{
  public class Market
  {
    public string Status { get; set; }
    public bool Antepost { get; set; }
    public int MarketGroupId { get; set; }
    public string SubGroupId { get; set; }
    public string FixedId { get; set; }
    public int Order { get; set; }
    public List<Odd> Odds { get; set; }
    public int MinimumRestriction { get; set; }
    public int MaximumRestriction { get; set; }
    public bool IsChanged { get; set; }
    public bool Balanced { get; set; }
    public bool Displayed { get; set; }
    public string LegacyMarketId { get; set; }
    public string Type { get; set; }
    public string Description { get; set; }
    public List<object> Scores { get; set; }
    public List<double> Lines { get; set; }
    public object Event { get; set; }
    public string ShortName { get; set; }
    public string MarketTypeName { get; set; }
    public object Priority { get; set; }
    public int Rows { get; set; }
    public int Cols { get; set; }
    public bool WinningLegsBonus { get; set; }
    public string Id { get; set; }
    public string Name { get; set; }
  }
}