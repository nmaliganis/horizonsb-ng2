namespace horizonsb.common.infrastructure.Helpers.ResourceParameters
{
  public class RolesResourceParameters : BaseResourceParameters
  {
    /// <summary>
    /// <param name="OrderColumn">Filter in Field
    /// (id, name e.t.c.)</param>
    /// </summary>
    public override string OrderColumn { get; set; }
    /// <summary>
    /// <param name="SearchQuery">Search into Fields
    /// (id, name e.t.c.)</param>
    /// </summary> 
    public override string SearchQuery { get; set; }

    /// <summary>
    /// <param name="OrderBy">Order by specific field 
    /// (id, name, default: name)</param>
    /// </summary> 
    public override string SearchColumn { get; set; } = "name";
  }
}