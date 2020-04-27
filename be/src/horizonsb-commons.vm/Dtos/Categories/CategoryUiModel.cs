using System;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Bases;

namespace horizonsb.commons.vm.Dtos.Categories
{
    public class CategoryUiModel : IUiModel
    {
        [Key]
        public Guid Id { get; set; }
        [Editable(true)]
        public string Message { get; set; }

        [Required(AllowEmptyStrings = false)]
        [Editable(true)]
        public string Name { get; set; }
    }
}
