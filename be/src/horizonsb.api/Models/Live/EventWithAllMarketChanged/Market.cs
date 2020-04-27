using System.Collections.Generic;

public class MarketEvent
{
  public string id { get; set; }
  public string name { get; set; }
  public string shortName { get; set; }
  public string veryshortName { get; set; }
  public string status { get; set; }
  public bool statusUpdated { get; set; }
  public string subGroupId { get; set; }
  public string fixedId { get; set; }
  public string legacyMarketId { get; set; }
  public string type { get; set; }
  public string description { get; set; }
  public string marketTypeName { get; set; }
  public int marketGroupId { get; set; }
  public List<int> marketGroupIds { get; set; }
  public int order { get; set; }
  public int minimumRestriction { get; set; }
  public int maximumRestriction { get; set; }
  public int cols { get; set; }
  public int rows { get; set; }
  public bool antepost { get; set; }
  public bool isChanged { get; set; }
  public bool balanced { get; set; }
  public bool displayed { get; set; }
  public bool winningLegsBonus { get; set; }
  public bool betBuilder { get; set; }
  public bool grouped { get; set; }
  public List<Odd> odds { get; set; }
  public List<object> lines { get; set; }
  public bool isHandicap { get; set; }
}