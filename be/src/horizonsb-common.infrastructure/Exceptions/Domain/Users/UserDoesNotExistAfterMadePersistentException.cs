using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Users
{
  public class UserDoesNotExistAfterMadePersistentException : Exception
  {
    public string Login { get; private set; }

    public UserDoesNotExistAfterMadePersistentException(string login)
    {
      Login = login;
    }

    public override string Message => $" User with Login:{Login} was not made Persistent!";
  }
}