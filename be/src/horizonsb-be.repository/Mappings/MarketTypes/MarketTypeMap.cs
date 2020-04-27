using FluentNHibernate.Mapping;
using horizonsb.be.model.CustomTypes;
using horizonsb.be.model.MarketTypes;
using horizonsb.be.model.Sports;
using nhibernate.postgresql.json;

namespace horizonsb.be.repository.Mappings.MarketTypes
{
  public class MarketTypeMap : ClassMap<MarketType>
  {
    public MarketTypeMap()
    {
      Table(@"markettypes");

      Id(x => x.Id)
        .Column("ID")
        .CustomType("Guid")
        .Access.Property()
        .CustomSqlType("uuid")
        .Not.Nullable()
        .GeneratedBy
        .GuidComb()
        ;

      Map(x => x.Type).CustomSqlType("jsonb")
        .CustomType<JsonType<JsonbType>>()
        .Column("type")
        .Not.Nullable();

      Map(x => x.SportId)
        .Column("sportid")
        .CustomType("String")
        .Unique()
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Not.Nullable()
        .Length(128)
        ;

      References(x => x.Sport)
        .Class<Sport>()
        .Access.Property()
        .Cascade.None()
        .LazyLoad()
        .Columns("sport_id");
    }
  }
}
