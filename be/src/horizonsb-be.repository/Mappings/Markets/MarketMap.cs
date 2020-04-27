using FluentNHibernate.Mapping;
using horizonsb.be.model.Events;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.model.Events.Markets.Odds;

namespace horizonsb.be.repository.Mappings.Markets
{
    public class MarketMap : ClassMap<Market>
    {
        public MarketMap()
        {
            Table(@"markets");

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

            Map(x => x.Lines)
                .Column("lines")
                .CustomType("String")
                .Access.Property()
                .Generated.Never()
                .CustomSqlType("varchar")
                .Nullable()
                .Length(8)
                ;

            Map(x => x.Description)
                .Column("description")
                .CustomType("String")
                .Access.Property()
                .Generated.Never()
                .CustomSqlType("varchar")
                .Nullable()
                .Length(255)
                ;

            Map(x => x.MarketId)
                .Column("marketid")
                .CustomType("String")
                .Access.Property()
                .Generated.Never()
                .CustomSqlType("varchar")
                .Not.Nullable()
                .Length(128)
                ;

            Map(x => x.Antepost)
                .Column("antepost")
                .CustomType("boolean")
                .Access.Property()
                .Generated.Never()
                .Default("false").CustomSqlType("boolean")
                .Not.Nullable()
                ;

            Map(x => x.IsChanged)
                .Column("ischanged")
                .CustomType("boolean")
                .Access.Property()
                .Generated.Never()
                .Default("false").CustomSqlType("boolean")
                .Not.Nullable()
                ;

            Map(x => x.Displayed)
                .Column("displayed")
                .CustomType("boolean")
                .Access.Property()
                .Generated.Never()
                .Default("false").CustomSqlType("boolean")
                .Not.Nullable()
                ;

            Map(x => x.MinRestriction)
                .Column("min_restriction")
                .CustomType("int")
                .Access.Property()
                .Generated.Never()
                .CustomSqlType("integer")
                .Nullable()
                ;

            Map(x => x.MaxRestriction)
                .Column("max_restriction")
                .CustomType("int")
                .Access.Property()
                .Generated.Never()
                .CustomSqlType("integer")
                .Nullable()
                ;


            Map(x => x.LegacyMarket)
                .Column("legacy_market")
                .CustomType("String")
                .Access.Property()
                .Generated.Never()
                .CustomSqlType("varchar")
                .Nullable()
                .Length(128)
                ;

            Map(x => x.FixedId)
                .Column("fixed_id")
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

            Map(x => x.Balanced)
                .Column("balanced")
                .CustomType("boolean")
                .Access.Property()
                .Generated.Never()
                .Default("false").CustomSqlType("boolean")
                .Not.Nullable()
                ;

            Map(x => x.Type)
                .Column("type")
                .CustomType("String")
                .Access.Property()
                .Generated.Never()
                .CustomSqlType("varchar")
                .Not.Nullable()
                .Length(128)
                ;

            References(x => x.Match)
                .Class<Match>()
                .Access.Property()
                .Cascade.None()
                .LazyLoad()
                .Columns("event_id");

            HasMany<Odd>(x => x.Odds)
                .Access.Property()
                .AsSet()
                .Cascade.None()
                .LazyLoad()
                .Inverse()
                .Generic()
                .KeyColumns.Add("market_id", mapping => mapping.Name("market_id")
                    .SqlType("uuid")
                    .Not.Nullable());
        }
    }
}
