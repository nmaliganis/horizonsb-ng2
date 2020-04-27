using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.MarketTypes
{
  public class MarketTypeForCreationUiModel
  {
    [Required]
    [Editable(true)]
    public IList<MarketTypeDto> MarketTypes { get; set; }
  }
}
