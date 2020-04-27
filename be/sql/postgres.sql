create table sports
(
    id                uuid                  not null
        constraint sports_pk
            primary key,
    name              varchar(255)          not null,
    priority          integer default 0,
    sportid           varchar(128)          not null,
    highlight         boolean default false not null,
    num_events        integer default 0     not null,
    num_inplay_events integer default 0     not null
);

alter table sports
    owner to postdbgeneral;

create table categories
(
    id                uuid                         not null
        constraint categories_pk
            primary key,
    name              varchar(255)                 not null,
    priority          integer          default 0,
    categoryid        varchar(128)                 not null,
    long_name         varchar(128),
    short_name        varchar(128),
    very_short_name   varchar(128),
    num_events        integer          default 0   not null,
    num_inplay_events integer          default 0   not null,
    weighting         double precision default 0.0 not null,
    sport_id          uuid                         not null
        constraint categories_sports_id_fk
            references sports
            on update cascade on delete cascade
);

alter table categories
    owner to postdbgeneral;

create unique index categories_categoryid_uindex
    on categories (categoryid);

create unique index sports_sportid_uindex
    on sports (sportid);

create table tournaments
(
    id                  uuid                           not null
        constraint tournaments_pk
            primary key,
    name                varchar(255)                   not null,
    priority            integer          default 0     not null,
    tournamentid        varchar(128)                   not null,
    highlight           boolean          default false not null,
    num_events          integer          default 0     not null,
    num_outright_events integer          default 0     not null,
    "order"             double precision default 0.0   not null,
    category_id         uuid                           not null
        constraint tournaments_categories_id_fk
            references categories
            on update cascade on delete cascade,
    short_name          varchar(255)
);

alter table tournaments
    owner to postdbgeneral;

create table events
(
    id                  uuid                    not null
        constraint "Events_pkey"
            primary key,
    tournament_id       uuid                    not null
        constraint events_tournaments_id_fk
            references tournaments
            on update cascade on delete cascade,
    antepost            boolean   default false not null,
    antepost_event_url  varchar(255),
    available_markets   varchar(255),
    bet_builder         boolean   default false not null,
    code                varchar(128),
    current_period      varchar(128),
    current_period_name varchar(128),
    stored_date         timestamp default now() not null,
    live                boolean   default false not null,
    matchid             varchar(128)            not null,
    name                varchar(255)            not null,
    neutral             boolean   default false not null,
    path                varchar(255),
    popular_event_url   varchar(128),
    possession          varchar(128),
    resulted            boolean   default false not null,
    status              varchar(128),
    time                varchar(128),
    timestamp           integer,
    today_event_url     varchar(255),
    upcoming_live       boolean   default false not null,
    winning_legs_bonus  boolean   default false not null,
    version             varchar(128),
    priority            integer   default 0     not null,
    date_event          timestamp default now() not null
);

alter table events
    owner to postdbgeneral;

create unique index events_match_id_uindex
    on events (matchid);

create unique index events_name_uindex
    on events (name);

create table markets
(
    id                 uuid                  not null
        constraint markets_pk
            primary key,
    event_id           uuid                  not null
        constraint markets_events_id_fk
            references events
            on update cascade on delete cascade,
    antepost           boolean default false not null,
    status             varchar(128),
    min_restriction    integer,
    max_restriction    integer,
    ischanged          boolean default false not null,
    balanced           boolean default false not null,
    displayed          boolean default true  not null,
    legacy_market      varchar(128),
    type               varchar(128)          not null,
    description        varchar(255),
    name               varchar(255)          not null,
    winning_legs_bonus boolean default false not null,
    marketid           varchar(128)          not null,
    lines              varchar(8)
);

alter table markets
    owner to postdbgeneral;

create table odds
(
    id        uuid         not null
        constraint odds_pk
            primary key,
    market_id uuid         not null
        constraint odds_markets_id_fk
            references markets
            on update cascade on delete cascade,
    short     varchar(128),
    clean     varchar(128),
    status    varchar(128),
    odd       varchar(5),
    handicap  varchar(128),
    displayed boolean,
    code      varchar(128),
    row       integer,
    col       integer,
    name      varchar(128) not null,
    oddid     varchar(128) not null
);

alter table odds
    owner to postdbgeneral;

create unique index odds_oddid_uindex
    on odds (oddid);

create table teams
(
    id       uuid                  not null
        constraint teams_pk
            primary key,
    name     varchar(255)          not null,
    event_id uuid                  not null
        constraint teams_events_id_fk
            references events
            on update cascade on delete cascade,
    ishome   boolean default false not null
);

alter table teams
    owner to postdbgeneral;

create unique index tournaments_tournamentid_uindex
    on tournaments (tournamentid);

create table configurations
(
    id          uuid                    not null
        constraint configurations_pk
            primary key,
    sport_id    uuid                    not null
        constraint configurations_sports_id_fk
            references sports
            on update cascade on delete cascade,
    config      varchar(255)            not null,
    isactive    boolean   default false not null,
    stored_date timestamp default now()
);

alter table configurations
    owner to postdbgeneral;

create table users
(
    id       uuid                 not null
        constraint users_pk
            primary key,
    username varchar(255)         not null,
    password varchar(255)         not null,
    isactive boolean default true not null
);

alter table users
    owner to postdbgeneral;

create unique index users_username_uindex
    on users (username);
