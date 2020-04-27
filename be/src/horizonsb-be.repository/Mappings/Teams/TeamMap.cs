using FluentNHibernate.Mapping;
using horizonsb.be.model.Events;
using horizonsb.be.model.Teams;

namespace horizonsb.be.repository.Mappings.Teams
{
  public class TeamMap : ClassMap<Team>
  {
    public TeamMap()
    {
      Table(@"teams");

      Id(x => x.Id)
        .Column("ID")
        .CustomType("Guid")
        .Access.Property()
        .CustomSqlType("uuid")
        .Not.Nullable()
        .GeneratedBy
        .GuidComb()
        ;

      Map(x => x.Name)
        .Column("name")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Not.Nullable()
        .Length(255)
        ;

      Map(x => x.IsHome)
        .Column("ishome")
        .CustomType("boolean")
        .Access.Property()
        .Generated.Never()
        .Default(@"false").CustomSqlType("boolean")
        .Not.Nullable()
        ;

      References(x => x.Match)
        .Class<Match>()
        .Access.Property()
        .Cascade.SaveUpdate()
        .LazyLoad()
        .Columns("event_id");
    }
  }
}
