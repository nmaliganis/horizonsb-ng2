using System;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Bases;

namespace horizonsb.commons.vm.Dtos.Sports
{
    public class SportForModificationUiModel
    {
        [Editable(true)]
        public int NewPriority { get; set; }
    }


    public class SportForModificationConfigurationUiModel
    {
      [Editable(true)]
      public ConfigurationType ModifiedConfiguration { get; set; }
    }

    public enum ConfigurationType
    {
      USA = 1,
      EUR
    }
}
