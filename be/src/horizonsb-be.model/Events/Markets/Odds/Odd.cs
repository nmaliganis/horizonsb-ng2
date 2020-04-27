using System;
using horizonsb.common.infrastructure.Domain;
using horizonsb.commons.vm.Dtos.Odds;

namespace horizonsb.be.model.Events.Markets.Odds
{
  public class Odd : EntityBase<Guid>, IAggregateRoot
  {
    public Odd()
    {
      OnCreated();
    }

    private void OnCreated()
    {
    }

    public virtual string Short { get; set; }
    public virtual string Clean { get; set; }
    public virtual string Status { get; set; }
    public virtual string OddNum { get; set; }
    public virtual string Handicap { get; set; }
    public virtual bool Displayed { get; set; }
    public virtual string Code { get; set; }
    public virtual int Row { get; set; }
    public virtual int Col { get; set; }
    public virtual string Name { get; set; }
    public virtual string OddId { get; set; }

    public virtual Market Market { get; set; }

    protected override void Validate()
    {

    }

    public virtual void InjectWithInitialAttributes(OddForCreationUiModel newOddUiModel)
    {
      this.Name = newOddUiModel.Name;
      this.OddId = newOddUiModel.OddId;
      this.Short = newOddUiModel.Short;
      this.Clean = newOddUiModel.Clean;
      this.Status = newOddUiModel.Status;
      this.OddNum = newOddUiModel.OddNum.ToString();
      this.Col = newOddUiModel.Col;
      this.Row = newOddUiModel.Row;
      this.Code = newOddUiModel.Code;
      this.Handicap = newOddUiModel.Handicap;
      this.Displayed = newOddUiModel.Displayed;
    }

    public virtual void InjectWithMarket(Market marketToBeInjected)
    {
      this.Market = marketToBeInjected;
      marketToBeInjected.Odds.Add(this);
    }
  }
}

