using System;
using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Bases
{
    public interface IUiModel
    {
        [Key]
        Guid Id { get; set; }
        [Editable(false)]
        string Message { get; set; }
    }
}
