namespace horizonsb.common.infrastructure.PropertyMappings.TypeHelpers
{
  public interface ITypeHelperService
  {
    bool TypeHasProperties<T>(string fields);
  }
}
