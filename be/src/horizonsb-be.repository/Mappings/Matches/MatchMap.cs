using FluentNHibernate.Mapping;
using horizonsb.be.model.Events;
using horizonsb.be.model.Events.Markets;
using horizonsb.be.model.Teams;
using horizonsb.be.model.Tournaments;

namespace horizonsb.be.repository.Mappings.Matches
{
    public class MatchMap : ClassMap<Match>
    {
      public MatchMap()
      {
        Table(@"events");

        Id(x => x.Id)
          .Column("ID")
          .CustomType("Guid")
          .Access.Property()
          .CustomSqlType("uuid")
          .Not.Nullable()
          .GeneratedBy
          .GuidComb()
          ;

        Map(x => x.AmericanGround)
          .Column("american_ground")
          .CustomType("boolean")
          .Access.Property()
          .Generated.Never()
          .Default("false")
          .CustomSqlType("boolean")
          .Not.Nullable()
          ;
      
      Map(x => x.IsFavorite)
          .Column("favorite")
          .CustomType("boolean")
          .Access.Property()
          .Generated.Never()
          .Default("false")
          .CustomSqlType("boolean")
          .Not.Nullable()
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

        Map(x => x.LivePriority)
          .Column("live_priority")
          .CustomType("int")
          .Access.Property()
          .Generated.Never()
          .Default("1")
          .CustomSqlType("integer")
          .Not.Nullable()
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

        Map(x => x.DateEvent)
          .Column("date_event")
          .CustomType("DateTime")
          .Access.Property()
          .Generated.Never().CustomSqlType("timestamp")
          .Not.Nullable();

        Map(x => x.StoredDate)
          .Column("stored_date")
          .CustomType("DateTime")
          .Access.Property()
          .Generated.Never().CustomSqlType("timestamp")
          .Not.Nullable();

      Map(x => x.MatchId)
          .Column("matchid")
          .CustomType("String")
          .Unique()
          .Access.Property()
          .Generated.Never()
          .Unique()
          .CustomSqlType("varchar")
          .Not.Nullable()
          .Length(128)
          ;

      Map(x => x.EventId)
          .Column("eventid")
          .CustomType("String")
          .Unique()
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Not.Nullable()
          .Length(128)
          ;

      Map(x => x.Live)
        .Column("live")
        .CustomType("boolean")
        .Access.Property()
        .Generated.Never()
        .Default("false")
        .CustomSqlType("boolean")
        .Not.Nullable()
        ;

      Map(x => x.UpcomingLive)
        .Column("upcoming_live")
        .CustomType("boolean")
        .Access.Property()
        .Generated.Never()
        .Default("false")
        .CustomSqlType("boolean")
        .Not.Nullable()
        ;


      Map(x => x.Antepost)
          .Column("antepost")
          .CustomType("boolean")
          .Access.Property()
          .Generated.Never()
          .Default("false")
          .CustomSqlType("boolean")
          .Not.Nullable()
          ;

        Map(x => x.AntepostEventUrl)
          .Column("antepost_event_url")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Nullable()
          .Length(255)
          ;

        Map(x => x.AvailableMarkets)
          .Column("available_markets")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Nullable()
          .Length(255)
          ;

        Map(x => x.BetBuilder)
          .Column("bet_builder")
          .CustomType("boolean")
          .Access.Property()
          .Generated.Never()
          .Default("false")
          .CustomSqlType("boolean")
          .Not.Nullable()
          ;

        Map(x => x.Code)
          .Column("code")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Unique()
          .Not.Nullable()
          .Length(128)
          ;

        Map(x => x.CurrentPeriod)
          .Column("current_period")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Nullable()
          .Length(128)
          ;

        Map(x => x.CurrentPeriodName)
          .Column("current_period_name")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Nullable()
          .Length(128)
          ;

        Map(x => x.Neutral)
          .Column("neutral")
          .CustomType("boolean")
          .Access.Property()
          .Generated.Never()
          .Default("false")
          .CustomSqlType("boolean")
          .Not.Nullable()
          ;

        Map(x => x.Path)
          .Column("path")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Nullable()
          .Length(255)
          ;

        Map(x => x.PopularEventUrl)
          .Column("popular_event_url")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Nullable()
          .Length(128)
          ;

        Map(x => x.Possession)
          .Column("possession")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Nullable()
          .Length(128)
          ;

        Map(x => x.Time)
          .Column("time")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Nullable()
          .Length(128)
          ;

        Map(x => x.TodayEventUrl)
          .Column("today_event_url")
          .CustomType("String")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("varchar")
          .Nullable()
          .Length(255)
          ;

        Map(x => x.Version)
          .Column("version")
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

        Map(x => x.Resulted)
          .Column("resulted")
          .CustomType("boolean")
          .Access.Property()
          .Generated.Never()
          .Default("false")
          .CustomSqlType("boolean")
          .Not.Nullable()
          ;

        Map(x => x.Timestamp)
          .Column("timestamp")
          .CustomType("int")
          .Access.Property()
          .Generated.Never()
          .CustomSqlType("intger")
          .Nullable()
          ;

      References(x => x.Tournament)
          .Class<Tournament>()
          .Access.Property()
          .Cascade.None()
          .LazyLoad()
          .Columns("tournament_id");

      HasMany<Market>(x => x.Markets)
        .Access.Property()
        .AsSet()
        .Cascade.None()
        .LazyLoad()
        .Inverse()
        .Generic()
        .KeyColumns.Add("event_id", mapping => mapping.Name("event_id")
          .SqlType("uuid")
          .Not.Nullable());

      HasMany<Team>(x => x.Teams)
        .Access.Property()
        //.AsSet()
        .Cascade.SaveUpdate()
        .LazyLoad()
        .Inverse()
        .Generic()
        .KeyColumns.Add("event_id", mapping => mapping.Name("event_id")
          .SqlType("uuid")
          .Not.Nullable());

    }
  }
}
