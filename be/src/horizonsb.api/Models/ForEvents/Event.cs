using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace horizonsb.api.Models.ForEvents
{

  public class EventError
  {
    public bool error { get; set; }
    public string message { get; set; }
  }
  public class Event
  {
    public string Id { get; set; }
    public bool AntePost { get; set; }
    public string AntePostEventUrl { get; set; }
    public int AvailableMarkets { get; set; }
    public AwayTeam AwayTeam { get; set; }
    public bool BetBuilder { get; set; }
    public Category Category { get; set; }
    public string Code { get; set; }
    public string CurrentPeriod { get; set; }
    public string CurrentPeriodName { get; set; }
    public DateTime Date { get; set; }
    public bool Displayed { get; set; }
    public string EventUrl { get; set; }
    public List<object> GameScore { get; set; }
    public HomeTeam HomeTeam { get; set; }
    public List<object> Lexicon { get; set; }
    public bool live { get; set; }
    public List<Market> Markets { get; set; }
    public string MatchId { get; set; }
    public string Name { get; set; }
    public bool Neutral { get; set; }
    public string Path { get; set; }
    public List<object> Periods { get; set; }
    public string PopularEventUrl { get; set; }
    public string Possession { get; set; }
    public bool Resulted { get; set; }
    public List<object> Score { get; set; }
    public List<object> SetScore { get; set; }
    public Sport Sport { get; set; }
    public string Status { get; set; }
    public string Time { get; set; }
    public int Timestamp { get; set; }
    public string TodayEventUrl { get; set; }
    public bool AmericanGround { get; set; }
    public Tournament Tournament { get; set; }
    [JsonProperty("upcomingLive")]
    public bool upcomingLive { get; set; }
    public string Version { get; set; }
    public bool WinningLegsBonus { get; set; }
    public object PeriodTime { get; set; }
  }
}

