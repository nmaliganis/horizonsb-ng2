using System;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Bases;

namespace horizonsb.commons.vm.Dtos.MarketTypes
{
    public class MarketTypeUiModel : IUiModel
    {
        [Key]
        public Guid Id { get; set; }
        [Editable(true)]
        public string Message { get; set; }

        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public string MarketTypes { get; set; }
        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public string SportId { get; set; }
  }
}
