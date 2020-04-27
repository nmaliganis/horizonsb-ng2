using System;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Bases;

namespace horizonsb.commons.vm.Dtos.Tournaments
{
    public class TournamentUiModel
    {
        [Editable(true)]
        public Guid id { get; set; }
        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public string name { get; set; }

        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public virtual string shortName { get; set; }
        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public virtual int priority { get; set; }
        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public virtual string tournamentId { get; set; }

        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public virtual bool highlight { get; set; }
        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public virtual int numEvents { get; set; }
        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public virtual long numOutrightEvents { get; set; }
        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public virtual double order { get; set; }
    }
}
