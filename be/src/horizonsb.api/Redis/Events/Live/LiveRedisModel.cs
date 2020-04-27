using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace horizonsb.api.Redis.Events.Live
{
    public class NextTeamToScoreRedisModel
    {
        public string Home { get; set; }
        public string None { get; set; }
        public string Visitor { get; set; }
    }

    public class StageGameRedisModel
    {
        public StageGameRedisModel()
        {
            this.Q = "";
            this.AwayScore = "";
            this.HomeScore = "";
        }

        public string Q { get; set; }
        public string Q_AwayScore { get; set; }
        public string Q_HomeScore { get; set; }
        public string Q_Id { get; set; }
        public string HomeScore { get; set; }
        public string AwayScore { get; set; }
    }

    public class SpreadsGameRedisModel
    {
        public string Home { get; set; }
        public string Away { get; set; }
    }

    public class LiveGameRedisModel
    {
        public LiveGameRedisModel()
        {
            this.Score = "";
            this.TeamName = "";

        }

        public string Score { get; set; }
        public string TeamName { get; set; }
    }

    public class LiveRedisModel
    {
      public string SportName { get; set; }
      public bool? EventCompleted { get; set; }
      public string Status { get; set; }
      public string CurrentPeriod { get; set; }
      public bool? Live { get; set; }
      public bool? EventStarted { get; set; }
      public string kickoff_date { get; set; }
      public int? timestamp { get; set; }
      public bool? IsUsa { get; set; }
      public string Code { get; set; }
      public string League { get; set; }
      public string LiveTimeOfEvent { get; set; }
      public List<LiveGameRedisModel> Games { get; set; }
      public string Under { get; set; }
      public string Totals { get; set; }
      public string Possession { get; set; }
      public string Over { get; set; }
      public string UnderFinal { get; set; }
      public string TotalsFinal { get; set; }
      public string OverFinal { get; set; }
    }


    public class LiveMoneyLineRedisModel : LiveRedisModel
    {
        public LiveMoneyLineRedisModel()
        {
            this.IsUsa = true;
            this.MoneyLinesFinal = new List<string>();
            this.MoneyLinesFinal = new List<string>();
            this.Spreads = new List<SpreadsGameRedisModel>();
            this.SpreadsFinal = new List<SpreadsGameRedisModel>();
        }

        public List<string> MoneyLines { get; set; }
        public List<SpreadsGameRedisModel> Spreads { get; set; }
        public List<string> MoneyLinesFinal { get; set; }
        public List<SpreadsGameRedisModel> SpreadsFinal { get; set; }
        public StageGameRedisModel Stage { get; set; }
        public string StatusValue { get; set; }
    }

    public class LiveAxbRedisModel : LiveRedisModel
    {
        public LiveAxbRedisModel()
        {
            this.IsUsa = false;
            this.NextTeamToScore = new NextTeamToScoreRedisModel();
            this.Stage = new StageGameRedisModel();
        }

        public string A { get; set; }
        public string X { get; set; }
        public string B { get; set; }
        public string AFinal { get; set; }
        public string XFinal { get; set; }
        public string BFinal { get; set; }
        public NextTeamToScoreRedisModel NextTeamToScore { get; set; }
        public StageGameRedisModel Stage { get; set; }
    }
}
