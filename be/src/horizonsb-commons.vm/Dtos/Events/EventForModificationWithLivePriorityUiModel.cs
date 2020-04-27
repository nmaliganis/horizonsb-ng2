using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Events
{
    public class EventForModificationWithLivePriorityUiModel
    {
        [Editable(true)]
        public int NewLivePriority { get; set; }
    }
}