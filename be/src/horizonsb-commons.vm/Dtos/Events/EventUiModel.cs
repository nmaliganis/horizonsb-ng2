using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Bases;
using horizonsb.commons.vm.Dtos.Markets;

namespace horizonsb.commons.vm.Dtos.Events
{
  public class EventUiModel : IUiModel
  {

    [Key] public Guid Id { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string EventId { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Event_Id { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Code { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public bool Favorite { get; set; }  
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public bool UpcomingLive { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public int Priority { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public int LivePriority { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public int NumberOfMarkets { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Description { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string DateEvent { get; set; }
    [Required]
    [Editable(true)]
    public int Timestamp { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string KickoffDate { get; set; }
    [Editable(true)]
    public string EventTeamHome { get; set; }
    [Editable(true)]
    public string EventTeamAway { get; set; }
    [Editable(true)]
    public string AmericanGround { get; set; }
    [Editable(true)]
    public string EventTournamentName{ get; set; }
    [Editable(true)]
    public string EventTournamentShortName{ get; set; }
    [Editable(true)]
    public string EventSportName{ get; set; }
    [Editable(true)]
    public int EventSportConfiguration{ get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public List<MarketUiModel> Markets { get; set; }

    [Editable(false)]
    public string Message { get; set; }
    public bool Status { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string StatusValue { get; set; }
  }
}
