﻿using System;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Bases;

namespace horizonsb.commons.vm.Dtos.Odds
{
    public class OddForModificationUiModel : IUiModel
    {
        [Key]
        public Guid Id { get; set; }
        [Editable(true)]
        public string Message { get; set; }

        [Editable(true)]
        public string Name { get; set; }
    }
}
