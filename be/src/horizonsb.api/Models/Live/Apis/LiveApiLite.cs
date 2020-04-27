using System;
using System.Collections.Generic;

namespace horizonsb.api.Models.Live.Apis
{
  public class LiveApiLite
  {
    public string code { get; set; }
    public DateTime date { get; set; }
    public string eventUrl { get; set; }
    public HomeTeamLive homeTeam { get; set; }
    public string id { get; set; }
    public bool live { get; set; }
    public string matchId { get; set; }
    public string name { get; set; }
    public SportLive sport { get; set; }
    public string status { get; set; }
    public string time { get; set; }
    public int timestamp { get; set; }
    public TournamentLive tournament { get; set; }
    public bool upcomingLive { get; set; }
  }

  public class LiveApiLite2
  {
    public string code { get; set; }
    public DateTime date { get; set; }
    public HomeTeamLive homeTeam { get; set; }
    public bool live { get; set; }
    public string name { get; set; }
    public bool upcomingLive { get; set; }
  }
}