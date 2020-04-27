using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Teams;

namespace horizonsb.commons.vm.Dtos.Events
{
  public class EventForCreationUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string EventId { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Id { get; set; }

    [Editable(true)] public bool Live { get; set; }
    [Editable(true)] public bool UpcomingLive { get; set; }

    [Editable(true)] public bool Antepost { get; set; }
    [Editable(true)] public string AntepostEventUrl { get; set; }
    [Editable(true)] public bool AmericanGround { get; set; }
    [Editable(true)] public string Code { get; set; }
    [Editable(true)] public string CurrentPeriod { get; set; }
    [Editable(true)] public string CurrentPeriodName { get; set; }
    [Editable(true)] public bool Neutral { get; set; }
    [Editable(true)] public string PopularEventUrl { get; set; }
    [Editable(true)] public string Possession { get; set; }
    [Editable(true)] public string Path { get; set; }
    [Editable(true)] public string Time { get; set; }
    [Editable(true)] public string TodayEventUrl { get; set; }
    [Editable(true)] public string Version { get; set; }
    [Editable(true)] public int Timestamp { get; set; }
    [Editable(true)] public bool Resulted { get; set; }
    [Editable(true)] public string Status { get; set; }
    [Editable(true)] public List<TeamForCreationUiModel> Teams { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string ParentTournamentId { get; set; }
    [Required]
    [Editable(true)]
    public DateTime Date { get; set; }

    [Editable(true)]
    public string AvailableMarkets { get; set; }

    [Editable(true)]
    public bool BetBuilder { get; set; }

  }
}
