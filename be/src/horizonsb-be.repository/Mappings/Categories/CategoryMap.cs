using FluentNHibernate.Mapping;
using horizonsb.be.model.Categories;
using horizonsb.be.model.Events;
using horizonsb.be.model.Sports;
using horizonsb.be.model.Tournaments;

namespace horizonsb.be.repository.Mappings.Categories
{
  public class CategoryMap : ClassMap<Category>
  {
    public CategoryMap()
    {
      Table(@"categories");

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
        .Default("1")
        .Generated.Never()
        .CustomSqlType("integer")
        .Not.Nullable()
        ;

      Map(x => x.CategoryId)
        .Column("categoryid")
        .CustomType("String")
        .Unique()
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Not.Nullable()
        .Length(128)
        ;

      Map(x => x.LongName)
        .Column("long_name")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(128)
        ;

      Map(x => x.ShortName)
        .Column("short_name")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(128)
        ;

      Map(x => x.VeryShortName)
        .Column("very_short_name")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(128)
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

      Map(x => x.Weighting)
        .Column("weighting")
        .CustomType("double")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("double precision")
        .Nullable()
        ;

      References(x => x.Sport)
        .Class<Sport>()
        .Access.Property()
        .Cascade.None()
        .LazyLoad()
        .Columns("sport_id");


      HasMany<Tournament>(x => x.Tournaments)
        .Access.Property()
        .AsSet()
        .Cascade.None()
        .LazyLoad()
        .Inverse()
        .Generic()
        .KeyColumns.Add("category_id", mapping => mapping.Name("category_id")
          .SqlType("uuid")
          .Not.Nullable());
    }
  }
}
