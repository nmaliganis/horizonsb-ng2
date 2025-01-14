﻿using System;
using System.ComponentModel.DataAnnotations;

namespace horizonsb.commons.vm.Dtos.Admin.Accounts
{
  public class UserActivationUiModel
  {
    [Required]
    [Editable(true)]
    public Guid Id { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Login { get; set; }
    [Required]
    [Editable(true)]
    public bool IsActivated { get; set; }
    [Editable(false)]
    public DateTime CreateDate { get; set; }
    [Editable(true)]
    public string Message { get; set; }
  }
}