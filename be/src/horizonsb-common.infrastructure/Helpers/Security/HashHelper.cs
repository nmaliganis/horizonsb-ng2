﻿using System;
using System.Security.Cryptography;
using System.Text;

namespace horizonsb.common.infrastructure.Helpers.Security
{
  public class HashHelper
  {
    public static string Sha512(string input)
    {

      using (var sha = SHA512.Create())
      {
        var bytes = Encoding.UTF8.GetBytes(input);
        var hash = sha.ComputeHash(bytes);

        return Convert.ToBase64String(hash);
      }
    }
  }
}