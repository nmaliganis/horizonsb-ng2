﻿using Newtonsoft.Json;

namespace horizonsb.api.Helpers.Json
{
  public class JsonSerializer : IJsonSerializer
  {
    public T DeserializeObject<T>(string json)
    {
      return JsonConvert.DeserializeObject<T>(json, new JsonSerializerSettings
      {
        TypeNameAssemblyFormat = System.Runtime.Serialization.Formatters.FormatterAssemblyStyle.Simple
      });
    }

    public string SerializeObject(object item)
    {
      return JsonConvert.SerializeObject(item, Formatting.Indented, new JsonSerializerSettings
      {
        TypeNameAssemblyFormat = System.Runtime.Serialization.Formatters.FormatterAssemblyStyle.Simple
      });
    }
  }
}