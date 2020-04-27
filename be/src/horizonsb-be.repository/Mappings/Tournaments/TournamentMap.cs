using FluentNHibernate.Mapping;
using horizonsb.be.model.Categories;
using horizonsb.be.model.Events;
using horizonsb.be.model.Tournaments;

namespace horizonsb.be.repository.Mappings.Tournaments
{
  public class TournamentMap : ClassMap<Tournament>
  {
    public TournamentMap()
    {
      Table(@"tournaments");

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

      Map(x => x.ShortName)
        .Column("short_name")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(255)
        ;

      Map(x => x.Priority)
        .Column("priority")
        .CustomType("int")
        .Access.Property()
        .Default("1")
        .Generated.Never()
        .CustomSqlType("integer")
        .Not.Nullable()
        ;

      Map(x => x.TournamentId)
        .Column("tournamentid")
        .CustomType("String")
        .Unique()
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Not.Nullable()
        .Length(128)
        ;

      Map(x => x.Highlight)
        .Column("highlight")
        .CustomType("bool")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("boolean")
        .Nullable()
        ;

      Map(x => x.NumEvents)
        .Column("num_events")
        .CustomType("long")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("integer")
        .Nullable()
        ;

      Map(x => x.NumOutrightEvents)
        .Column("num_outright_events")
        .CustomType("long")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("integer")
        .Nullable()
        ;

      References(x => x.Category)
        .Class<Category>()
        .Access.Property()
        .Cascade.None()
        .LazyLoad()
        .Columns("category_id");

      HasMany<Match>(x => x.Matches)
        .Access.Property()
        .AsSet()
        .Cascade.None()
        .LazyLoad()
        .Inverse()
        .Generic()
        .KeyColumns.Add("tournament_id", mapping => mapping.Name("tournament_id")
          .SqlType("uuid")
          .Not.Nullable());
    }
  }
}
