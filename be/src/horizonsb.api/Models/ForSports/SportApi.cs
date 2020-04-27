using System.Collections.Generic;

namespace horizonsb.api.Models.ForSports
{
  public class SportApi
  {
    public bool Highlight { get; set; }
    public string Id { get; set; }
    public string Name { get; set; }
    public NamesApi Names { get; set; }
    public long NumEvents { get; set; }
    public long NumInplayEvents { get; set; }
    public List<CategoryApi> SubCategories { get; set; }
  }
}