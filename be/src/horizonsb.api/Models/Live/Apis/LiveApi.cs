using System;
using System.Collections.Generic;

namespace horizonsb.api.Models.Live.Apis
{
  public class LiveApi
  {
    public bool americanGround { get; set; }
    public bool antepost { get; set; }
    public string antepostEventUrl { get; set; }
    public int availableMarkets { get; set; }
    public AwayTeamLive awayTeam { get; set; }
    public bool betBuilder { get; set; }
    public string betradarStreamId { get; set; }
    public CategoryLive category { get; set; }
    public string code { get; set; }
    public string currentPeriod { get; set; }
    public string currentPeriodName { get; set; }
    public DateTime date { get; set; }
    public bool displayed { get; set; }
    public string eventUrl { get; set; }
    public List<object> gameScore { get; set; }
    public bool hasLiveStream { get; set; }
    public HomeTeamLive homeTeam { get; set; }
    public string id { get; set; }
    public List<object> lexicon { get; set; }
    public bool live { get; set; }
    public List<MarketLive> markets { get; set; }
    public string matchId { get; set; }
    public string name { get; set; }
    public bool neutral { get; set; }
    public string path { get; set; }
    public string performId { get; set; }
    public List<Period> periods { get; set; }
    public string popularEventUrl { get; set; }
    public string possession { get; set; }
    public List<object> redCards { get; set; }
    public bool resulted { get; set; }
    public List<int> score { get; set; }
    public bool setBased { get; set; }
    public List<object> setScore { get; set; }
    public SportLive sport { get; set; }
    public string status { get; set; }
    public string time { get; set; }
    public int timestamp { get; set; }
    public string todayEventUrl { get; set; }
    public TournamentLive tournament { get; set; }
    public bool upcomingLive { get; set; }
    public long version { get; set; }
    public bool winningLegsBonus { get; set; }
  }
}