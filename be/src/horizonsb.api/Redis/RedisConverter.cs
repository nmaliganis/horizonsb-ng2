using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using StackExchange.Redis;

namespace horizonsb.api.Redis
{
  public static class RedisConverter
  {
    static readonly string[] InitialStringArray = new string[0];
    /// <summary>
    /// Create an array of strings from an array of values
    /// </summary>
    public static string[] ToStringArray(this RedisValue[] values)
    {
      if (values == null) return null;
      if (values.Length == 0) return InitialStringArray;
      return Array.ConvertAll(values, x => (string)x);
    }
  }
}
