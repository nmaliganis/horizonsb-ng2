using System;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Bases;

namespace horizonsb.commons.vm.Dtos.Tournaments
{
    public class TournamentForModificationUiModel
    {
        [Editable(true)]
        public int NewPriority { get; set; }
    }
}
