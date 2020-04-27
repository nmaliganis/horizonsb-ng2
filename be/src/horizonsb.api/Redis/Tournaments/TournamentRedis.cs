namespace horizonsb.api.Redis.Tournaments
{
  public class TournamentRedis
  {
    public string TournamentId { get; set; }
    public int Priority { get; set; }

    public TournamentRedis(string tournamentId, int priority)
    {
      TournamentId = tournamentId;
      Priority = priority;
    }
  }
}
