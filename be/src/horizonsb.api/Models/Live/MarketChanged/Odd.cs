namespace horizonsb.api.Models.Live.MarketChanged
{
  public class Odd
  {
    public string id { get; set; }
    public string name { get; set; }
    public string @short { get; set; }
    public string clean { get; set; }
    public string status { get; set; }
    public string code { get; set; }
    public string marketId { get; set; }
    public string handicap { get; set; }
    public double odd { get; set; }
    public bool displayed { get; set; }
    public int row { get; set; }
    public int col { get; set; }
    public bool updated { get; set; }
  }
}