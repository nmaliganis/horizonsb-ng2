using System;

namespace horizonsb.common.infrastructure.Exceptions.Domain.Users
{
  public class UserEmailOrLoginAlreadyExistsException : Exception
  {
    public string Login { get; }
    public string BrokenRules { get; }

    public UserEmailOrLoginAlreadyExistsException(string login, string brokenRules)
    {
      Login = login;
      BrokenRules = brokenRules;
    }

    public override string Message => $" User with login:{Login} already Exists!\n Additional info:{BrokenRules}";
  }
}