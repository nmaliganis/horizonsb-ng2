using System;
using System.Collections.Generic;
using horizonsb.be.model.Sports;
using horizonsb.be.model.Tournaments;
using horizonsb.common.infrastructure.Domain;
using horizonsb.commons.vm.Dtos.Categories;

namespace horizonsb.be.model.Categories
{
  public class Category : EntityBase<Guid>, IAggregateRoot
  {
    public Category()
    {
      OnCreated();
    }

    private void OnCreated()
    {
      this.Priority = 1;
      this.Tournaments = new HashSet<Tournament>();
    }

    public virtual string Name { get; set; }
    public virtual int Priority { get; set; }
    public virtual string CategoryId { get; set; }
    public virtual string LongName { get; set; }
    public virtual string ShortName { get; set; }
    public virtual string VeryShortName { get; set; }
    public virtual long NumEvents { get; set; }
    public virtual long NumInPlayEvents { get; set; }
    public virtual double Weighting { get; set; }
    public virtual Sport Sport { get; set; }
    public virtual ISet<Tournament> Tournaments { get; set; }


    protected override void Validate()
    {

    }

    public virtual void InjectWithInitialAttributes(CategoryForCreationUiModel newCategoryUiModel)
    {
      this.Name = newCategoryUiModel.Name;
      this.CategoryId = newCategoryUiModel.CategoryId;
      this.LongName = newCategoryUiModel.LongName;
      this.ShortName = newCategoryUiModel.ShortName;
      this.VeryShortName = newCategoryUiModel.VeryShortName;
      this.NumEvents = newCategoryUiModel.NumEvents;
      this.NumInPlayEvents = newCategoryUiModel.NumInPlayEvents;
      this.Weighting = newCategoryUiModel.Weighting;
    }

    public virtual void InjectWithSport(Sport sportToBeInjected)
    {
      this.Sport = sportToBeInjected;
      sportToBeInjected.Categories.Add(this);
    }
  }
}

