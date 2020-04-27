using System.Collections.Generic;

namespace horizonsb.api.Models.ForSports
{
  public class CategoryApi
  {
    public string Id { get; set; }
    public string Name { get; set; }
    public object Names { get; set; }
    public long NumEvents { get; set; }
    public long NumInplayEvents { get; set; }
    public List<TournamentApi> SubCategories { get; set; }
    public double Weighting { get; set; }
  }
}