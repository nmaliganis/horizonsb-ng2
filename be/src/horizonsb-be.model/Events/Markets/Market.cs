using System;
using System.Collections.Generic;
using System.Text;
using horizonsb.be.model.Events.Markets.Odds;
using horizonsb.common.infrastructure.Domain;
using horizonsb.commons.vm.Dtos.Markets;

namespace horizonsb.be.model.Events.Markets
{
    public class Market : EntityBase<Guid>, IAggregateRoot
    {
        public Market()
        {
            OnCreated();
        }

        private void OnCreated()
        {
            this.Antepost = false;
            this.IsChanged = false;
            this.Balanced = false;
            this.Displayed = false;
            this.Odds = new HashSet<Odd>();
        }

        public virtual bool Antepost { get; set; }
        public virtual string Status { get; set; }
        public virtual string FixedId { get; set; }

        public virtual int MinRestriction { get; set; }
        public virtual int MaxRestriction { get; set; }
        public virtual bool IsChanged { get; set; }
        public virtual bool Balanced { get; set; }
        public virtual bool Displayed { get; set; }
        public virtual string LegacyMarket { get; set; }
        public virtual string Type { get; set; }
        public virtual string Description { get; set; }
        public virtual string Name { get; set; }
        public virtual string Lines { get; set; }
        public virtual bool WinningLegsBonus { get; set; }
        public virtual string MarketId { get; set; }

        public virtual Match Match { get; set; }
        public virtual ISet<Odd> Odds { get; set; }

        protected override void Validate()
        {

        }

        public virtual void InjectWithInitialAttributes(MarketForCreationUiModel newMarketUiModel)
        {
            this.Name = newMarketUiModel.Name;
            this.MarketId = newMarketUiModel.MarketId;
            this.Antepost = newMarketUiModel.Antepost;
            this.LegacyMarket = newMarketUiModel.LegacyMarket;
            this.FixedId = newMarketUiModel.MarketFixedId;
            this.Status = newMarketUiModel.Status;
            this.MinRestriction = newMarketUiModel.MinimumRestriction;
            this.MaxRestriction = newMarketUiModel.MaximumRestriction;
            this.Type = newMarketUiModel.Type;
            this.Description = newMarketUiModel.Description;
            this.IsChanged = newMarketUiModel.IsChanged;
            this.Balanced = newMarketUiModel.Balanced;
            this.Displayed = newMarketUiModel.Displayed;
            this.WinningLegsBonus = newMarketUiModel.WinningLegsBonus;
            if (newMarketUiModel.Lines != null)
            {
                foreach (var line in newMarketUiModel.Lines)
                {
                    Lines = line.ToString();
                }
            }
        }


        public virtual void InjectWithEvent(Match eventToBeInjected)
        {
            this.Match = eventToBeInjected;
            eventToBeInjected.Markets.Add(this);
        }
    }
}

