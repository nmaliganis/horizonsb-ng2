namespace horizonsb.api.Helpers.Json
{
  public interface IJsonSerializer
  {
    T DeserializeObject<T>(string json);
    string SerializeObject(object item);
  }
}