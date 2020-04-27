using System;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Bases;

namespace horizonsb.commons.vm.Dtos.Sports
{
  public class SportUiModel : IUiModel
  {
    [Key] public Guid Id { get; set; }
    [Editable(true)] public string Message { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }


    [Required]
    [Editable(true)]
    public virtual int Priority { get; set; }

    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public virtual string SportId { get; set; }
    [Required]
    [Editable(true)]
    public virtual bool Highlight { get; set; }
    [Required]
    [Editable(true)]
    public virtual long NumEvents { get; set; }
    [Required]
    [Editable(true)]
    public virtual long NumInPlayEvents { get; set; }
    [Required]
    [Editable(true)]
    public virtual string ConfigurationValue { get; set; }
    [Required]
    [Editable(true)]
    public virtual int Configuration { get; set; }
  }
}
