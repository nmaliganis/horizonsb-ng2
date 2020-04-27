using System;
using System.Collections.Generic;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.model.Teams;
using horizonsb.be.model.Tournaments;
using horizonsb.common.infrastructure.Domain;
using horizonsb.commons.vm.Dtos.Events;

namespace horizonsb.be.model.Events
{
  public class Match : EntityBase<Guid>, IAggregateRoot
  {
    public Match()
    {
      OnCreated();
    }

    private void OnCreated()
    {
      this.IsFavorite = false;
      this.LivePriority = 1;
      this.Antepost = false;
      this.BetBuilder = false;
      this.Live = false;
      this.Neutral = false;
      this.Resulted = false;
      this.UpcomingLive = false;
      this.WinningLegsBonus = false;
      this.StoredDate = DateTime.UtcNow;
      this.Markets = new HashSet<Market>();
      this.Teams = new List<Team>();
    }

    public virtual bool Antepost { get; set; }
    public virtual string AntepostEventUrl { get; set; }
    public virtual bool AmericanGround { get; set; }
    public virtual string AvailableMarkets { get; set; }
    public virtual bool BetBuilder { get; set; }
    public virtual string Code { get; set; }
    public virtual string CurrentPeriod { get; set; }
    public virtual string CurrentPeriodName { get; set; }
    public virtual DateTime StoredDate { get; set; }
    public virtual DateTime DateEvent { get; set; }
    public virtual bool Live { get; set; }
    public virtual string MatchId { get; set; }
    public virtual string EventId { get; set; }
    public virtual string Name { get; set; }
    public virtual bool Neutral { get; set; }
    public virtual string Path { get; set; }
    public virtual string PopularEventUrl { get; set; }
    public virtual string Possession { get; set; }
    public virtual bool Resulted { get; set; }
    public virtual string Status { get; set; }
    public virtual string Time { get; set; }
    public virtual int Timestamp { get; set; }
    public virtual string TodayEventUrl { get; set; }
    public virtual bool UpcomingLive { get; set; }
    public virtual bool WinningLegsBonus { get; set; }
    public virtual string Version { get; set; }
    public virtual int Priority { get; set; }
    public virtual bool IsFavorite { get; set; }
    public virtual int LivePriority { get; set; }

    public virtual Tournament Tournament { get; set; }
    public virtual IList<Team> Teams { get; set; }
    public virtual ISet<Market> Markets { get; set; }

    protected override void Validate()
    {
    }

    public virtual void InjectWithInitialAttributes(EventForCreationUiModel newEventUiModel, int priority)
    {
      this.Priority = priority;

      this.Name = newEventUiModel.Name;
      this.MatchId = newEventUiModel.EventId;
      this.EventId = newEventUiModel.Id;
      this.Live = newEventUiModel.Live;
      this.AmericanGround = newEventUiModel.AmericanGround;
      this.UpcomingLive = newEventUiModel.UpcomingLive;
      this.Antepost = newEventUiModel.Antepost;
      this.AntepostEventUrl = newEventUiModel.AntepostEventUrl;
      this.AvailableMarkets = newEventUiModel.AvailableMarkets;
      this.BetBuilder = newEventUiModel.BetBuilder;
      this.Code = newEventUiModel.Code;
      this.CurrentPeriod = newEventUiModel.CurrentPeriod;
      this.CurrentPeriodName = newEventUiModel.CurrentPeriodName;
      this.Neutral = newEventUiModel.Neutral;
      this.PopularEventUrl = newEventUiModel.PopularEventUrl;
      this.Possession = newEventUiModel.Possession;
      this.Path = newEventUiModel.Path;
      this.Time = newEventUiModel.Time;
      this.TodayEventUrl = newEventUiModel.TodayEventUrl;
      this.Version = newEventUiModel.Version;
      this.Timestamp = newEventUiModel.Timestamp;
      this.Resulted = newEventUiModel.Resulted;
      this.Status = newEventUiModel.Status;
      this.DateEvent = newEventUiModel.Date;
    }



    public virtual void InjectWithTournament(Tournament tournamentToBeInjected)
    {
      this.Tournament = tournamentToBeInjected;
      tournamentToBeInjected.Matches.Add(this);
    }

    public virtual void InjectWithNewTeam(Team teamToBeAdded)
    {
      teamToBeAdded.Match = this;
      this.Teams.Add(teamToBeAdded);
    }

    public virtual void ModifyPriorityWith(int updatedEventNewPriority)
    {
      this.Priority = updatedEventNewPriority;
    }

    public virtual void ModifyLivePriorityWith(int updatedEventWithNewLivePriority)
    {
      this.LivePriority = updatedEventWithNewLivePriority;
    }

    public virtual void ModifyFavoriteWith(bool updatedEventWithFavorite)
    {
      this.IsFavorite = updatedEventWithFavorite;
    }
  }
}

