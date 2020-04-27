using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json.Linq;

namespace horizonsb.common.infrastructure.Helpers
{
  public static class DynamicExpando
  {
    public static bool IsPropertyExist(dynamic settings, string name)
    {
      bool exist = false;
      try
      {
        IDictionary<string, object> properties = ((JObject)settings).ToDictionary();
        exist = properties.ContainsKey(name);
      }
      catch (Exception e)
      {
        return exist;
      }

      return exist;
    }

    private static IDictionary<string, object> ToDictionary(this JObject @object)
    {
      var result = @object.ToObject<Dictionary<string, object>>();

      var JObjectKeys = (from r in result
        let key = r.Key
        let value = r.Value
        where value.GetType() == typeof(JObject)
        select key).ToList();

      var JArrayKeys = (from r in result
        let key = r.Key
        let value = r.Value
        where value.GetType() == typeof(JArray)
        select key).ToList();

      JArrayKeys.ForEach(key => result[key] = ((JArray)result[key]).Values().Select(x => ((JValue)x).Value).ToArray());
      JObjectKeys.ForEach(key => result[key] = ToDictionary(result[key] as JObject));

      return result;
    }
  }
}
