using System;
using System.Collections.Generic;
using horizonsb.be.model.Categories;
using horizonsb.common.infrastructure.Domain;
using horizonsb.commons.vm.Dtos.Tournaments;
using Match = horizonsb.be.model.Events.Match;

namespace horizonsb.be.model.Tournaments
{
  public class Tournament : EntityBase<Guid>, IAggregateRoot
  {
    public Tournament()
    {
      OnCreated();
    }

    private void OnCreated()
    {
      this.Matches = new HashSet<Match>();
      this.Priority = 1;
    }

    public virtual string Name { get; set; }
    public virtual string ShortName { get; set; }
    public virtual int Priority { get; set; }
    public virtual string TournamentId { get; set; }

    public virtual bool Highlight { get; set; }
    public virtual long NumEvents { get; set; }
    public virtual long NumOutrightEvents { get; set; }
    public virtual double Order { get; set; }
    public virtual Category Category { get; set; }
    public virtual ISet<Match> Matches { get; set; }

    protected override void Validate()
    {

    }

    public virtual void InjectWithInitialAttributes(TournamentForCreationUiModel newTournamentUiModel)
    {
      this.Name = newTournamentUiModel.Name;
      this.ShortName = newTournamentUiModel.ShortName;
      this.TournamentId = newTournamentUiModel.TournamentId;
      this.Highlight = newTournamentUiModel.Highlight;
      this.NumEvents = newTournamentUiModel.NumEvents;
      this.NumOutrightEvents = newTournamentUiModel.NumOutrightEvents;
      this.Order = newTournamentUiModel.Order;
    }

    public virtual void InjectWithCategory(Category categoryToBeInjected)
    {
      this.Category = categoryToBeInjected;
      categoryToBeInjected.Tournaments.Add(this);
    }

    public virtual void ModifyPriorityWith(int updatedTournamentNewPriority)
    {
      this.Priority = updatedTournamentNewPriority;
    }
  }
}

