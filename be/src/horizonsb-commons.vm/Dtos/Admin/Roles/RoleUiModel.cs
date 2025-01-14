﻿using System;
using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Roles
{
  public class RoleUiModel
  {
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Name { get; set; }
    [Editable(true)]
    public Guid Id { get; set; }
    [Required]
    [Editable(true)]
    public DateTime CreatedDate { get; set; }
    [Required]
    [Editable(true)]
    public DateTime ModifiedDate { get; set; }
    [Required]
    [Editable(true)]
    public bool Active { get; set; }

  }
}