using System;
using System.Collections.Generic;
using horizonsb.be.model.Categories;
using horizonsb.be.model.MarketTypes;
using horizonsb.common.infrastructure.Domain;
using horizonsb.commons.vm.Dtos.Sports;

namespace horizonsb.be.model.Sports
{
  public class Sport : EntityBase<Guid>, IAggregateRoot
  {
    public Sport()
    {
      OnCreated();
    }

    private void OnCreated()
    {
      this.Categories = new HashSet<Category>();
      this.Priority = 1;
      this.Configuration = ConfigurationType.USA;
      this.MarketTypes = new HashSet<MarketType>();
    }

    public virtual string Name { get; set; }
    public virtual int Priority { get; set; }
    public virtual string SportId { get; set; }
    public virtual bool Highlight { get; set; }
    public virtual ConfigurationType Configuration { get; set; }
    public virtual long NumEvents { get; set; }
    public virtual long NumInPlayEvents { get; set; }
    public virtual ISet<MarketType> MarketTypes { get; set; }
    public virtual ISet<Category> Categories { get; set; }

    protected override void Validate()
    {

    }

    public virtual void InjectWithInitialAttributes(SportForCreationUiModel newSportUiModel)
    {
      this.Name = newSportUiModel.Name;
      this.SportId = newSportUiModel.SportId;
      this.Highlight = newSportUiModel.Highlight;
      this.NumEvents = newSportUiModel.NumEvents;
      this.NumInPlayEvents = newSportUiModel.NumInPlayEvents;
      if (newSportUiModel.SportId == "s-SOCCER" || newSportUiModel.SportId == "s-HANDBALL" ||
          newSportUiModel.SportId == "s-ICE_HOCKEY")
      {
        this.Configuration = ConfigurationType.EUR;
      }
    }

    public virtual void ModifyPriorityWith(int updatedSportNewPriority)
    {
      this.Priority = updatedSportNewPriority;
    }

    public virtual void ModifyConfigurationWith(int updatedSportConfiguration)
    {
      this.Configuration = (ConfigurationType) updatedSportConfiguration;
    }
  }

  public enum ConfigurationType
  {
    USA = 1,
    EUR
  }
}

