namespace horizonsb.api.Redis.Sports
{
  public class SportRedis
  {
    public string SportId { get; set; }
    public int Priority { get; set; }

    public SportRedis(string sportId, int priority)
    {
      SportId = sportId;
      Priority = priority;
    }
  }
}
