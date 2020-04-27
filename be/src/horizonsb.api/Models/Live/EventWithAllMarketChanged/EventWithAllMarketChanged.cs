using System.Collections.Generic;

public class EventWithAllMarketChanged
{
  public string id { get; set; }
  public string code { get; set; }
  public string status { get; set; }
  public bool displayed { get; set; }
  public bool statusUpdated { get; set; }
  public bool eventStarted { get; set; }
  public bool eventCompleted { get; set; }
  public List<MarketEvent> markets { get; set; }
  public int timestamp { get; set; }
  public string possession { get; set; }
  public string time { get; set; }
  public string currentPeriod { get; set; }
  public string currentPeriodName { get; set; }
  public List<Period> periods { get; set; }
  public List<object> gameScore { get; set; }
  public List<object> setScore { get; set; }
  public List<int> score { get; set; }
  public bool winningLegBonus { get; set; }
  public int availableMarkets { get; set; }
  public bool setBased { get; set; }
  public object redCards { get; set; }
  public bool americanGround { get; set; }
}