﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using horizonsb.commons.vm.Dtos.Admin.Roles;

namespace horizonsb.commons.vm.Dtos.Admin.Users
{
  public class UserForAllRetrievalUiModel
  {
    [Required]
    [Editable(true)]
    public Guid Id { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public string Login { get; set; }
    [Required(AllowEmptyStrings = false)]
    [Editable(true)]
    public List<RoleUiModel> Roles { get; set; }
    [Required]
    [Editable(true)]
    public string ActivationKey { get; set; }
    [Required]
    [Editable(true)]
    public bool IsActivated { get; set; }
    [Required]
    [Editable(false)]
    public string CreatedBy { get; set; }
    [Required]
    [Editable(false)]
    public string ModifiedBy { get; set; }
    [Required]
    [Editable(false)]
    public DateTime CreateDate { get; set; }
    [Required]
    [Editable(false)]
    public string ResetKey { get; set; }
    [Required]
    [Editable(false)]
    public string ResetDate { get; set; }
    [Editable(false)]
    public string LastModifiedBy { get; set; }
    [Required]
    [Editable(false)]
    public DateTime LastModifiedDate { get; set; }
  }
}