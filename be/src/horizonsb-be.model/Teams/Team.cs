using System;
using System.Collections.Generic;
using horizonsb.be.model.Events;
using horizonsb.common.infrastructure.Domain;

namespace horizonsb.be.model.Teams
{
    public class Team : EntityBase<Guid>, IAggregateRoot
    {
        public Team()
        {
            OnCreated();
        }

        private void OnCreated()
        {
          this.IsHome = false;
        }

        public virtual string Name { get; set; }
        public virtual bool IsHome { get; set; }
        public virtual Match Match { get; set; }

        protected override void Validate()
        {

        }
    }
}

