using FluentNHibernate.Mapping;
using horizonsb.be.model.Categories;
using horizonsb.be.model.Events;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.model.Events.Markets.Odds;
using horizonsb.be.model.Sports;
using horizonsb.be.model.Tournaments;

namespace horizonsb.be.repository.Mappings.Markets
{
  public class OddMap : ClassMap<Odd>
  {
    public OddMap()
    {
      Table(@"odds");

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

      Map(x => x.OddId)
        .Column("oddid")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Not.Nullable()
        .Length(128)
        ;

      Map(x => x.Short)
        .Column("short")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(128)
        ;

      Map(x => x.Clean)
        .Column("clean")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(128)
        ;

      Map(x => x.Status)
        .Column("status")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(128)
        ;

      Map(x => x.OddNum)
        .Column("odd")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(5)
        ;

      Map(x => x.Handicap)
        .Column("handicap")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(128)
        ;


      Map(x => x.Code)
        .Column("code")
        .CustomType("String")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("varchar")
        .Nullable()
        .Length(128)
        ;

      Map(x => x.Col)
        .Column("col")
        .CustomType("int")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("integer")
        .Nullable()
        ;

      Map(x => x.Row)
        .Column("row")
        .CustomType("int")
        .Access.Property()
        .Generated.Never()
        .CustomSqlType("integer")
        .Nullable()
        ;


      References(x => x.Market)
        .Class<Market>()
        .Access.Property()
        .Cascade.None()
        .LazyLoad()
        .Columns("market_id");
    }
  }
}
