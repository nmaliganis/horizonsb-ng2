using System;
using horizonsb.common.infrastructure.Domain;

namespace horizonsb.be.model.Admin
{
  public class UserToken : EntityBase<Guid>, IAggregateRoot
  {
    public UserToken()
    {
      this.Expired = false;
      this.IsActive = true;
      this.RefreshToken = Guid.NewGuid();
      this.CreatedDate = DateTime.UtcNow;
      this.ModifiedDate = DateTime.UtcNow;
    }

    public virtual Guid RefreshToken { get; set; }
    public virtual DateTime CreatedDate { get; set; }
    public virtual DateTime ModifiedDate { get; set; }
    public virtual bool Expired { get; set; }
    public virtual bool IsActive { get; set; }

    public virtual User User { get; set; }

    protected override void Validate()
    {
    }

    public virtual void ModifyWithExpired()
    {
      this.Expired = true;
      this.ModifiedDate = DateTime.UtcNow;
    }
  }
}