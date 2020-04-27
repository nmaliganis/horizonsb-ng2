using System;
using System.Collections.Generic;
using horizonsb.be.model.Categories;
using horizonsb.be.model.CustomTypes;
using horizonsb.be.model.Sports;
using horizonsb.common.infrastructure.Domain;

namespace horizonsb.be.model.MarketTypes
{
  public class MarketType : EntityBase<Guid>, IAggregateRoot
  {
    public MarketType()
    {
      OnCreated();
    }

    private void OnCreated()
    {
    }

    public virtual string SportId { get; set; }
    public virtual JsonbType Type { get; set; }
    public virtual Sport Sport { get; set; }

    public virtual void InjectWithInitialAttributes(string sportId, string marketTypes)
    {
      this.SportId = sportId;
      this.Type = new JsonbType()
      {
        Jsonb = marketTypes
      };
    }
    protected override void Validate()
    {

    }
  }
}

