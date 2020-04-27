using System.Collections.Generic;

namespace horizonsb.api.Models.Live.Apis
{
  public class MarketLive
  {
    public bool antepost { get; set; }
    public bool balanced { get; set; }
    public bool betBuilder { get; set; }
    public int cols { get; set; }
    public string description { get; set; }
    public bool displayed { get; set; }
    public string fixedId { get; set; }
    public bool grouped { get; set; }
    public string id { get; set; }
    public bool isChanged { get; set; }
    public bool isHandicap { get; set; }
    public string legacyMarketId { get; set; }
    public List<object> lines { get; set; }
    public int marketGroupId { get; set; }
    public List<int> marketGroupIds { get; set; }
    public string marketTypeName { get; set; }
    public int maximumRestriction { get; set; }
    public int minimumRestriction { get; set; }
    public string name { get; set; }
    public List<OddLive> odds { get; set; }
    public int order { get; set; }
    public int rows { get; set; }
    public List<object> scores { get; set; }
    public string shortName { get; set; }
    public string status { get; set; }
    public string subGroupId { get; set; }
    public string type { get; set; }
    public string veryshortName { get; set; }
    public bool winningLegsBonus { get; set; }
  }
}