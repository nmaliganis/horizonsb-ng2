using FluentNHibernate.Mapping;
using horizonsb.be.model.Categories;
using horizonsb.be.model.MarketTypes;
using horizonsb.be.model.Sports;

namespace horizonsb.be.repository.Mappings.Sports
{
  public class SportMap : ClassMap<Sport>
  {
    public SportMap()
    {
      Table(@"sports");

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

      Map(x => x.Priority)
        .Column("priority")
        .CustomType("int")
        .Access.Property()
        .Generated.Never()
        .Default("1")
        .CustomSqlType("integer")
        .Not.Nullable()
        ;

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

      Map(x => x.Highlight)
        .Column("highlight")
        .CustomType("bool")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("boolean")
        .Nullable()
        ;

      Map(x => x.Configuration)
        .Column("configuration_type")
        .CustomType<ConfigurationType>()
        .Access.Property()
        .Generated.Never()
        .Default(@"1")
        .CustomSqlType("integer")
        .Not.Nullable()
        ;

      Map(x => x.NumEvents)
        .Column("num_events")
        .CustomType("long")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("integer")
        .Nullable()
        ;

      Map(x => x.NumInPlayEvents)
        .Column("num_inplay_events")
        .CustomType("long")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("integer")
        .Nullable()
        ;

      HasMany<MarketType>(x => x.MarketTypes)
        .Access.Property()
        .AsSet()
        .Cascade.None()
        .LazyLoad()
        .Inverse()
        .Generic()
        .KeyColumns.Add("sport_id", mapping => mapping.Name("sport_id")
          .SqlType("uuid")
          .Nullable());

      HasMany<Category>(x => x.Categories)
        .Access.Property()
        .AsSet()
        .Cascade.None()
        .LazyLoad()
        .Inverse()
        .Generic()
        .KeyColumns.Add("sport_id", mapping => mapping.Name("sport_id")
          .SqlType("uuid")
          .Not.Nullable());
    }
  }
}
