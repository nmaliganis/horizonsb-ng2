--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.13
-- Dumped by pg_dump version 9.6.0

-- Started on 2019-06-18 14:45:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 13311)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3136 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 185 (class 1259 OID 16627)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categories (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    priority integer DEFAULT 0,
    categoryid character varying(128) NOT NULL,
    long_name character varying(128),
    short_name character varying(128),
    very_short_name character varying(128),
    num_events integer DEFAULT 0 NOT NULL,
    num_inplay_events integer DEFAULT 0 NOT NULL,
    weighting double precision DEFAULT 0.0 NOT NULL,
    sport_id uuid NOT NULL
);


ALTER TABLE categories OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 16649)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE events (
    id uuid NOT NULL,
    tournament_id uuid NOT NULL,
    antepost boolean DEFAULT false NOT NULL,
    antepost_event_url character varying(255),
    available_markets character varying(255),
    bet_builder boolean DEFAULT false NOT NULL,
    code character varying(128),
    current_period character varying(128),
    current_period_name character varying(128),
    stored_date timestamp without time zone DEFAULT now() NOT NULL,
    live boolean DEFAULT false NOT NULL,
    matchid character varying(128) NOT NULL,
    name character varying(255) NOT NULL,
    neutral boolean DEFAULT false NOT NULL,
    path character varying(255),
    popular_event_url character varying(128),
    possession character varying(128),
    resulted boolean DEFAULT false NOT NULL,
    status character varying(128),
    "time" character varying(128),
    "timestamp" integer,
    today_event_url character varying(255),
    upcoming_live boolean DEFAULT false NOT NULL,
    winning_legs_bonus boolean DEFAULT false NOT NULL,
    version character varying(128),
    priority integer DEFAULT 0 NOT NULL,
    date_event timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE events OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 16682)
-- Name: markets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE markets (
    id uuid NOT NULL,
    event_id uuid NOT NULL,
    antepost boolean DEFAULT false NOT NULL,
    status character varying(128),
    fixed character varying(128),
    "order" integer,
    min_restriction integer,
    max_restriction integer,
    ischanged boolean DEFAULT false NOT NULL,
    balanced boolean DEFAULT false NOT NULL,
    displayed boolean DEFAULT true NOT NULL,
    legacy_market character varying(128),
    type character varying(128) NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL,
    short_name character varying(128),
    priority character varying(64),
    winning_legs_bonus boolean DEFAULT false NOT NULL,
    marketid character varying(128) NOT NULL
);


ALTER TABLE markets OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 16700)
-- Name: odds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE odds (
    id uuid NOT NULL,
    market_id uuid NOT NULL,
    short character varying(128),
    clean character varying(128),
    status character varying(128),
    odd character varying(5),
    handicap character varying(128),
    displayed boolean,
    code character varying(128),
    "row" integer,
    col integer,
    name character varying(128) NOT NULL,
    oddid character varying(128) NOT NULL
);


ALTER TABLE odds OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 16635)
-- Name: sports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sports (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    priority integer DEFAULT 0,
    sportid character varying(128) NOT NULL,
    highlight boolean DEFAULT false NOT NULL,
    long_name character varying(128),
    short_name character varying(128),
    very_short_name character varying(128),
    num_events integer DEFAULT 0 NOT NULL,
    num_inplay_events integer DEFAULT 0 NOT NULL
);


ALTER TABLE sports OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 16715)
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE teams (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    event_id uuid NOT NULL,
    ishome boolean DEFAULT false NOT NULL
);


ALTER TABLE teams OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16643)
-- Name: tournaments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tournaments (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    tournamentid character varying(128) NOT NULL,
    highlight boolean DEFAULT false NOT NULL,
    long_name character varying(128),
    short_name character varying(128),
    very_short_name character varying(128),
    num_events integer DEFAULT 0 NOT NULL,
    num_outright_events integer DEFAULT 0 NOT NULL,
    "order" double precision DEFAULT 0.0 NOT NULL,
    category_id uuid NOT NULL
);


ALTER TABLE tournaments OWNER TO postgres;

--
-- TOC entry 3123 (class 0 OID 16627)
-- Dependencies: 185
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categories (id, name, priority, categoryid, long_name, short_name, very_short_name, num_events, num_inplay_events, weighting, sport_id) FROM stdin;
907fb203-10ae-489f-a16c-aa7000830521	Australia	0	c-4240626	\N	\N	\N	2	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
477beb9f-f300-4b27-8903-aa700083054a	Brazil	0	c-4238758	\N	\N	\N	1	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
df19dc38-aacb-40a4-8a71-aa700083055c	China	0	c-4289793	\N	\N	\N	1	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
95c01573-f7ca-427f-8f55-aa7000830579	Denmark	0	c-4238765	\N	\N	\N	0	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
3bb5fbf6-cfd0-4069-a2c6-aa700083058c	England	0	c-4216063	\N	\N	\N	0	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
7fee2e5e-ad5f-45bf-8dbc-aa70008305bf	Germany	0	c-4216076	\N	\N	\N	0	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
fb937c98-7b67-418c-8809-aa70008305d3	Iceland	0	c-4238736	\N	\N	\N	1	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
ac65b8ee-f0fb-46c5-9fde-aa70008305e7	International	0	c-4216092	\N	\N	\N	32	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
75efbf55-60a1-4528-ab2f-aa7000830800	International Clubs	0	c-4216090	\N	\N	\N	8	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
60ef3406-95f3-46e9-a54b-aa700083083a	International Youth	0	c-4239922	\N	\N	\N	3	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
1c25a799-f3ff-4609-88a4-aa7000830865	Italy	0	c-4216078	\N	\N	\N	0	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
d8d52412-b357-4d4d-a6d5-aa7000830882	Japan	0	c-4238761	\N	\N	\N	0	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
90010aff-50f3-4f32-b8b3-aa70008308a1	Netherlands	0	c-4216032	\N	\N	\N	0	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
6aca7813-d1c2-4644-8bb7-aa70008308b3	Norway	0	c-4216067	\N	\N	\N	15	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
fa0f1ef9-4527-42a5-a065-aa70008308f0	Poland	0	c-4216088	\N	\N	\N	5	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
a1cb2657-2463-46d4-9ca3-aa7000830919	Scotland	0	c-4216077	\N	\N	\N	0	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
8687a299-8e67-4d94-a2a3-aa700083093c	Spain	0	c-4216081	\N	\N	\N	1	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
bd3c1623-8748-41b6-b92d-aa7000830958	Sweden	0	c-4238757	\N	\N	\N	21	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
17fbf622-9d54-4608-b94d-aa70008309b3	Sweden Amateur	0	c-4517700	\N	\N	\N	1	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
1360ce31-c053-47d5-b944-aa70008309c4	USA	0	c-4238796	\N	\N	\N	4	0	0.5	a11acee2-1213-4435-8e2e-aa70008304a2
9a18d433-271a-46ac-a433-aa7000830a04	Speedway	0	c-4654459	\N	\N	\N	0	0	0.5	16778d3f-b38b-4238-a735-aa70008309f8
6038440e-b254-45e1-bc5c-aa7000830a21	Bikes	0	c-4289774	\N	\N	\N	0	0	0.5	bfc73eee-6fd7-4fca-90ff-aa7000830a17
879dcb38-0f9e-42e0-8242-aa7000830a3c	Australia	0	c-4365386	\N	\N	\N	0	0	0.5	28b1b040-fbd9-4f9b-b1b4-aa7000830a32
53f18181-121b-4265-8801-aa7000830a51	France	0	c-4216101	\N	\N	\N	1	0	0.5	28b1b040-fbd9-4f9b-b1b4-aa7000830a32
7febb20e-84e7-44d4-bd5a-aa7000830a75	Germany	0	c-4216106	\N	\N	\N	1	0	0.5	28b1b040-fbd9-4f9b-b1b4-aa7000830a32
306d159a-d15f-43c2-a73c-aa7000830ab2	International	0	c-4216096	\N	\N	\N	0	0	0.5	28b1b040-fbd9-4f9b-b1b4-aa7000830a32
bcf61580-18ea-47a0-8a3c-aa7000830afc	Italy	0	c-4238737	\N	\N	\N	1	0	0.5	28b1b040-fbd9-4f9b-b1b4-aa7000830a32
77227329-c4ae-42cd-908c-aa7000830b0d	USA	0	c-4216095	\N	\N	\N	1	0	0.5	28b1b040-fbd9-4f9b-b1b4-aa7000830a32
cf934873-24e2-4316-a32b-aa7000830b36	Japan	0	c-4238809	\N	\N	\N	5	0	0.5	ee013ec2-2f30-4f5d-bb57-aa7000830b28
c911874e-b2ac-48e3-9d0d-aa7000830b52	Republic of Korea	0	c-4238810	\N	\N	\N	2	0	0.5	ee013ec2-2f30-4f5d-bb57-aa7000830b28
19e6a30a-d573-4b8c-b550-aa7000830b68	USA	0	c-4216114	\N	\N	\N	9	0	0.5	ee013ec2-2f30-4f5d-bb57-aa7000830b28
853189f2-c179-435d-aca1-aa7000830b81	Australia	0	c-4711788	\N	\N	\N	3	0	0.5	73b1ba5a-d825-4b17-9bd4-aa7000830b79
79885aa6-e24f-4489-80a2-aa7000830ba5	International	0	c-4639550	\N	\N	\N	2	0	0.5	dd57cf5d-fbdf-4d4d-ba36-aa7000830b9c
62906227-01dd-43c5-b612-aa7000830bbd	International	0	c-4216137	\N	\N	\N	0	0	0.5	9436ab37-fd10-418a-865c-aa7000830bb4
027e3db1-7b07-44c6-b249-aa7000830bff	International	0	c-4453961	\N	\N	\N	5	0	0.5	2bc46c68-1cd1-41fa-b371-aa7000830bf6
3938ed5c-d64b-41b1-a558-aa7000830c34	International	0	c-4381152	\N	\N	\N	0	0	0.5	0098ac51-2fe8-4cb0-9fe3-aa7000830c2b
303cea4f-606e-4d82-a85e-aa7000830c55	Rugby League	0	c-2692999	\N	\N	\N	2	0	0.5	68f3f8e7-0645-4e43-bf0b-aa7000830c4c
f1ed2ec2-c35d-4d7d-a457-aa7000830c92	Men	0	c-4216118	\N	\N	\N	0	0	0.5	fdad9769-fc6d-45ed-b978-aa7000830c83
84143249-f7c0-405f-846b-aa7000830cc4	International	0	c-4216113	\N	\N	\N	0	0	0.5	51c7f35e-5e0a-4653-8675-aa7000830cba
98c15501-f093-43c5-be7d-aa7000830cdd	International	0	c-4216125	\N	\N	\N	0	0	0.5	1b0c27bc-72fd-4719-a01d-aa7000830cd5
3a4ae80a-3892-486e-9316-aa7000830cef	USA	0	c-4216121	\N	\N	\N	0	0	0.5	1b0c27bc-72fd-4719-a01d-aa7000830cd5
160c9ab0-de52-4734-bef0-aa7000830d0d	Rugby Union	0	c-268225	\N	\N	\N	2	0	0.5	4babc53b-c7c2-4383-8453-aa7000830d03
d6eca926-c325-4438-8ce0-aa7000830d8d	International	0	c-4289776	\N	\N	\N	0	0	0.5	c2dc0253-bb6b-400a-8a99-aa7000830d83
882bba70-3dd3-45a5-b047-aa7000830da5	ATP	0	c-4216057	\N	\N	\N	14	0	0.5	9ccb0da6-9ae6-4775-a7ad-aa7000830d9e
78e2a03d-f356-4f8e-be15-aa7000830de4	Challenger	0	c-4452809	\N	\N	\N	14	0	0.5	9ccb0da6-9ae6-4775-a7ad-aa7000830d9e
10fbf687-c687-467e-895f-aa7000830e2b	ITF Men	0	c-4216061	\N	\N	\N	5	0	0.5	9ccb0da6-9ae6-4775-a7ad-aa7000830d9e
96bda641-4528-48b7-a714-aa7000830e5d	ITF Women	0	c-4216058	\N	\N	\N	2	0	0.5	9ccb0da6-9ae6-4775-a7ad-aa7000830d9e
d025688d-8366-4fc3-a9af-aa7000830e7a	WTA	0	c-4216056	\N	\N	\N	17	0	0.5	9ccb0da6-9ae6-4775-a7ad-aa7000830d9e
7026671d-6fd8-4f59-a0fd-aa7000830eef	International	0	c-4761081	\N	\N	\N	4	0	0.5	47b7a86b-c57e-4b14-9f70-aa7000830ee6
60a3729a-5064-4ce6-8445-aa7000830f0a	International	0	c-4216131	\N	\N	\N	5	0	0.5	2781c87e-3d05-4b9e-8593-aa7000830f00
3a9e9e58-5ca0-48ce-b147-aa7000830f27	Formula 1	0	c-269818	\N	\N	\N	0	0	0.5	a3dfb978-54a7-4557-8ef0-aa7000830f1d
a622b246-d147-40a3-bec9-aa7000830f42	International	0	c-4283759	\N	\N	\N	0	0	0.5	bafb88af-79e2-4cdd-a6ec-aa7000830f38
a4844c11-ac71-4b4f-8ce1-aa7000830f75	USA	0	c-4289796	\N	\N	\N	0	0	0.5	35322432-d1c2-49eb-b577-aa7000830f6a
af56c0d2-7145-4f7c-bb72-aa7000830fa0	Bellator	0	c-4421427	\N	\N	\N	2	0	0.5	f255645d-5b83-41f5-9b75-aa7000830f97
2bb32c06-8664-4c3c-8698-aa7000830fb3	UFC	0	c-4415033	\N	\N	\N	7	0	0.5	f255645d-5b83-41f5-9b75-aa7000830f97
3855b454-c2c5-49e5-bc95-aa7000830fd4	Overall	0	c-4743953	\N	\N	\N	0	0	0.5	0487ad9b-8369-43c7-a06a-aa7000830fc8
bf4abfd2-f461-4be6-b804-aa7000830fe7	Overall Women	0	c-4878734	\N	\N	\N	0	0	0.5	0487ad9b-8369-43c7-a06a-aa7000830fc8
f7b42754-02c5-43f4-8bbc-aa700083102f	International	0	c-5084874	\N	\N	\N	1	0	0.5	a2b0a504-c77d-450f-9a97-aa7000831023
a3c0e0cc-46ae-41ea-a0eb-aa700083104b	International	0	c-4761363	\N	\N	\N	1	0	0.5	3cad8ff6-0223-4f62-a478-aa7000831041
\.


--
-- TOC entry 3126 (class 0 OID 16649)
-- Dependencies: 188
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY events (id, tournament_id, antepost, antepost_event_url, available_markets, bet_builder, code, current_period, current_period_name, stored_date, live, matchid, name, neutral, path, popular_event_url, possession, resulted, status, "time", "timestamp", today_event_url, upcoming_live, winning_legs_bonus, version, priority, date_event) FROM stdin;
4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	29f682e6-45e0-43da-bdd1-aa700083094f	f	/en/antepost/football/laliga-2-promotion-playoffs/deportivo-la-korunia-rkd-maiorka	113	f				2019-06-18 08:38:16.747744	f	18452678	Депортиво Ла Коруня - РКД Майорка	f	166661:4216081:4275780:5110223			f	active		1561057200		f	f	1560839824875	0	2019-06-20 22:00:00
37cffcfe-7e06-47a5-8664-aa7000a76cb9	c0421675-3f01-440c-946e-aa7000830986	f		2	f				2019-06-18 10:09:33.685122	f	17277545	Gottne IF - IFK Umea	f	166661:4238757:4419510:5026340			f	active		1560963600		f	f	1560852060937	0	2019-06-19 20:00:00
d07c331d-b8c9-45aa-9dfd-aa7000a76dae	c0421675-3f01-440c-946e-aa7000830986	f	/en/antepost/football/division-2-norrland/sandviks-ik-anundsjo-if	2	f				2019-06-18 10:09:35.292313	f	17277547	Sandviks Ik - Anundsjo If	f	166661:4238757:4419510:5026342			f	active		1560963600		f	f	1560839760857	0	2019-06-19 20:00:00
2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	c0421675-3f01-440c-946e-aa7000830986	f		102	f				2019-06-18 10:09:35.500088	f	17277549	ИФК Йостерсунд - Kramfors-alliansen	f	166661:4238757:4419510:5026356			f	active		1560965400		f	f	1560852096532	0	2019-06-19 20:30:00
6522de53-ee92-4402-8e31-aa7000a79482	c0421675-3f01-440c-946e-aa7000830986	f	/en/antepost/football/division-2-norrland/ifk-lulea-piteaa-if	3	f				2019-06-18 10:10:08.425185	f	17277551	ИФК Лулеа - Питеаа ИФ	f	166661:4238757:4419510:5029992			f	active		1561050000		f	f	1560852081825	0	2019-06-20 20:00:00
5ad382fc-576b-4e90-a686-aa7000a81301	92513671-ee93-43c1-9e01-aa700083098f	f		106	f				2019-06-18 10:11:55.707016	f	17279053	Ifk Hassleholm - Носаби ИФ	f	166661:4238757:4419509:5026344			f	active		1560963600		f	f	1560852672555	0	2019-06-19 20:00:00
8b713c8a-cc4c-44fa-84e8-aa7000a83053	92513671-ee93-43c1-9e01-aa700083098f	f		105	f				2019-06-18 10:12:21.308284	f	17279055	IFO Bromolla IF - IFK Berga	f	166661:4238757:4419509:5026346			f	active		1560963600		f	f	1560852666661	0	2019-06-19 20:00:00
aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	92513671-ee93-43c1-9e01-aa700083098f	f		102	f				2019-06-18 10:12:57.240309	f	17279057	ФК Карлскрона - Хеслехолм ИФ	f	166661:4238757:4419509:5026360			f	active		1560965400		f	f	1560852692556	0	2019-06-19 20:30:00
b1047e8a-811e-4116-a030-aa7000a899e1	92513671-ee93-43c1-9e01-aa700083098f	f		3	f				2019-06-18 10:13:51.461231	f	17279061	Асарумс ИФ ФК - Dalstorps If	f	166661:4238757:4419509:5029984			f	active		1561050000		f	f	1560852692741	0	2019-06-20 20:00:00
7d2b2470-78af-4d07-8d1b-aa7000a89b25	92513671-ee93-43c1-9e01-aa700083098f	f	/en/antepost/football/division-2-ostra-gotaland/raslatts-sk-rappe-goif	3	f				2019-06-18 10:13:52.540735	f	17279059	Raslatts Sk - Rappe Goif	f	166661:4238757:4419509:5029982			f	active		1561050000		f	f	1560839818861	0	2019-06-20 20:00:00
\.


--
-- TOC entry 3127 (class 0 OID 16682)
-- Dependencies: 189
-- Data for Name: markets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY markets (id, event_id, antepost, status, fixed, "order", min_restriction, max_restriction, ischanged, balanced, displayed, legacy_market, type, description, name, short_name, priority, winning_legs_bonus, marketid) FROM stdin;
9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_4	Correct Score Aams	Correct Score AAMS	\N	\N	f	SOCCER:FT:£CS_4_M
d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+3.5
f2276898-ddaa-4b2e-a4a5-aa70008e7b06	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+2.5
a9264bef-dcb6-446e-98c8-aa70008e7bb4	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+1.5
0f3305b9-22ef-4e9c-b987-aa70008e7c2d	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+4.5
21d9db7a-ea41-43ba-a31b-aa70008e7cc9	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_2_H1		1st Half - Total Goals 2	\N	\N	f	SOCCER:P:£OUR_2_H1
6d7be262-b7aa-41d9-94b6-aa70008e7d16	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:B:CLS_H2		2nd Half Clean Sheet Rcd Mallorca	\N	\N	f	SOCCER:P:B:CLS_H2
8ef3a8be-b878-4802-8111-aa70008e7d2d	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+0.5
b1c44b89-d10e-454a-8d9d-aa70008e7d47	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-0.5
d83ff120-60c3-4ac5-a9a6-aa70008e7d6c	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-0.25
b67d1774-754a-4e39-9bba-aa70008e7d87	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-0.75
e53c0f5c-be68-4550-8f9c-aa70008e7da3	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#+0
4db3d418-b7e5-4850-aadf-aa70008e7dbb	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-1
862f4806-cadc-4ec0-b1a1-aa70008e7dd3	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTSH	Both Teams To Score 1st Half / 2nd Half	Both Teams To Score 1st Half / 2nd Half	\N	\N	f	SOCCER:FT:BTSH_M
9c35c6dc-40c2-45e6-a2dd-aa70008e7df9	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:A:CLS_H1		1st Half Clean Sheet Rc Deportivo La Coruna	\N	\N	f	SOCCER:P:A:CLS_H1
b825dc79-387c-4787-be4b-aa70008e7e11	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+0.75
68cf1f44-b13a-4c76-8e84-aa70008e7e2b	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1
8cedba29-cc25-4a60-84ff-aa70008e7e63	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+3.5
c0f5bcc8-f882-4322-8229-aa70008e7e7d	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+2.5
5e95c7e2-babe-458c-b5d6-aa70008e7e97	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+1.5
54433b52-5d23-482b-95cc-aa70008e7eb1	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+0.5
209576c0-5ab6-4789-b92f-aa70008e7ec8	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+4.5
ea86ef21-78cc-44a5-8178-aa70008e7ee0	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+5.5
79713c4d-c4ae-4be8-b26e-aa70008e7ef9	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
02220054-9961-47c1-93ff-aa70008e7f1c	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB	Match Result	Match Result	\N	\N	f	SOCCER:FT:AXB_M
62462a7b-e865-444a-a616-aa70008e7f3d	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS	Both Teams to Score	Both Teams to Score	\N	\N	f	SOCCER:FT:BTS_M
9569d076-2108-4836-b9c4-aa70008e7f54	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:SPRD	Handicap {2}	Handicap {2}	\N	\N	f	SOCCER:FT:SPRD_M#-1.0
eaccb105-f144-434c-a5ab-aa70008e7f74	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#+2.0
4eb95220-893f-4945-bba5-aa70008e7f92	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#+1.0
b09340f0-cf25-44a0-95f9-aa70008e7fd7	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-1.0
b5bc9032-956d-4d9c-b9be-aa70008e7ff6	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-2.0
5eb276b2-6184-4809-ac01-aa70008e8019	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_1	Correct Score	Correct Score	\N	\N	f	SOCCER:FT:£CS_1_M
93f9f024-4d10-4ccb-bd1d-aa70008e8138	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H1		1st Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H1#+0.5
d7d7379e-8379-4f57-b6f5-aa70008e8155	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H1		1st Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H1#+0.5
4f87bc6b-0110-400f-adc5-aa70008e816e	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H2		Second Half Correct Score	\N	\N	f	SOCCER:P:£CS_1_H2
3c381fab-f85c-4837-bcf6-aa70008e81ce	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H1		1st Half - Correct Score	\N	\N	f	SOCCER:P:£CS_1_H1
522163d6-761b-4b28-9516-aa70008e822a	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT	Halftime/Fulltime	Halftime/Fulltime	\N	\N	f	SOCCER:FT:HTFT_M
207ab2ce-eb6a-4152-9501-aa70008e82a7	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H1		1st Half - 1X2	\N	\N	f	SOCCER:P:AXB_H1
9768b7e0-e7eb-4b6a-9f22-aa70008e82c9	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H1		1st Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H1
662090c5-b8cd-45c5-9a0f-aa70008e82ea	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H2		2nd Half - 1X2	\N	\N	f	SOCCER:P:AXB_H2
6b64d022-7e8e-489f-8b7c-aa70008e8313	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H2		2nd Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H2
6ff4218f-7435-4986-b3a3-aa70008e8334	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:NB	Away No Bet	Away No Bet	\N	\N	f	SOCCER:FT:B:NB_M
2888aba4-4903-4f97-814e-aa70008e834d	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:NB	Home No Bet	Home No Bet	\N	\N	f	SOCCER:FT:A:NB_M
cd3975b5-b836-4545-9dcf-aa70008e8366	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H2		2nd Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H2#+0.5
5074e09f-07ff-4152-ba78-aa70008e8380	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H2		2nd Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H2#+0.5
78473ae1-8f69-4bff-b467-aa70008e839a	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
40cd50e7-9e88-4c7c-b88f-aa70008e83b6	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:CLS	Clean sheet away team	Clean sheet away team	\N	\N	f	SOCCER:FT:B:CLS_M
06250fb4-7c20-4ee4-899b-aa70008e83e8	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:CLS	Clean sheet home team	Clean sheet home team	\N	\N	f	SOCCER:FT:A:CLS_M
0c6a3419-0e09-4cae-b8be-aa70008e8403	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BWN	Away Win to Nil	Away Win to Nil	\N	\N	f	SOCCER:FT:BWN_M
1d70d4c3-32fe-41ea-8142-aa70008e8424	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AWN	Home Win to Nil	Home Win to Nil	\N	\N	f	SOCCER:FT:AWN_M
bbe7d4dd-537e-4649-9e2c-aa70008e8441	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H1		First Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H1
acc791fd-2c45-4408-b209-aa70008e845d	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+2.5
d4109273-ef34-42a5-be88-aa70008e8477	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+1.5
48923d12-5234-4231-89da-aa70008e8492	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+0.5
42858998-db90-45b9-a2b8-aa70008e84ae	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H2		Second Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H2
6dc8cffd-0bef-42e9-b2b7-aa70008e84c7	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+2.5
c1b4fe2e-2edf-45b1-94ab-aa70008e84e2	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+1.5
11908e04-d1fa-448a-9831-aa70008e84fe	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+0.5
6f554f89-199e-4e1b-9e33-aa70008e851d	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_1	Total Goals (exact)	Total Goals (exact)	\N	\N	f	SOCCER:FT:£OUR_1_M
f46041e1-0dcb-4648-9750-aa70008e858f	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H1		1st Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H1
12f2bdae-df47-4035-8343-aa70008e85ae	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H2		2nd Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H2
0f1f71d5-759f-4272-bf05-aa70008e85d2	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OE	Odd/Even goals	Odd/Even goals	\N	\N	f	SOCCER:FT:OE_M
150d261f-238a-41aa-917a-aa70008e85f1	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H1		1st Half - Odd/Even Goals	\N	\N	f	SOCCER:P:OE_H1
67971bd9-972b-4683-8323-aa70008e860a	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H2		Second Half Total Goals Odd/Even	\N	\N	f	SOCCER:P:OE_H2
8bd49ef5-7565-4e01-8ee7-aa70008e8628	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:FTSC	First Team to score	First Team to score	\N	\N	f	SOCCER:FT:FTSC_M
b069ea12-7a17-4106-9122-aa70008e8653	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:LTS	Last team to score	Last team to score	\N	\N	f	SOCCER:FT:LTS_M
92d4a034-12e8-4059-87e1-aa70008e8684	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:TTS2H	Away to score in both halves?	Away to score in both halves?	\N	\N	f	SOCCER:FT:B:TTS2H_M
b917a7e6-b6f9-4df4-a659-aa70008e86c9	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:TTS2H	Home to score in both halves?	Home to score in both halves?	\N	\N	f	SOCCER:FT:A:TTS2H_M
ba0b56b9-5b98-4920-b1ad-aa70008e86ee	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:B:OU	Total Goals {1} {2}	Total Goals {1} {2}	\N	\N	f	SOCCER:FT:B:OU_M#+0.5
20783f45-bc1d-4559-a5f8-aa70008e8712	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:A:OU	Total Goals %1% %line%	Total Goals Депортиво Ла Коруня 1.5	\N	\N	f	SOCCER:FT:A:OU_M#+1.5
89ceba9a-dda4-4677-9df2-aa70008e872f	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:£OUR_1	Goals away team	Goals away team	\N	\N	f	SOCCER:FT:B:£OUR_1_M
9cd124b4-dcf4-42c2-b267-aa70008e875f	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:£OUR_1	Goals home team	Goals home team	\N	\N	f	SOCCER:FT:A:£OUR_1_M
06d86463-8cf4-4af5-a478-aa70008e878e	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_2	Total Goals (aggregated)	Total Goals (aggregated)	\N	\N	f	SOCCER:FT:£OUR_2_M
05df363b-83db-4da4-ae76-aa70008e87bc	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HSH	Highest scoring half	Highest scoring half	\N	\N	f	SOCCER:FT:HSH_M
91ed3195-900e-46cf-b11e-aa70008e87f1	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:3HCP_H1		1st Half - European Handicap {2}	\N	\N	f	SOCCER:P:3HCP_H1#-1.0
cca293a8-7e79-4983-9496-aa70008e882a	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:BH	Home to win both halves?	Home to win both halves?	\N	\N	f	SOCCER:FT:A:BH_M
90f7c026-2a31-46d7-8429-aa70008e884b	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:1HFTSC_H2		2nd Half - First Team to score	\N	\N	f	SOCCER:P:1HFTSC_H2
e3bf7815-2c98-4c29-9768-aa70008e8871	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:1HFTSC_H1		1st Half - First team to score	\N	\N	f	SOCCER:P:1HFTSC_H1
a01a7e69-c28f-4ef3-9f07-aa70008e8895	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHU	Both halves under 1.5?	Both halves under 1.5?	\N	\N	f	SOCCER:FT:BHU_M
ad4e60fe-f98c-4a4e-9f6a-aa70008e88b1	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHO	Both halves over 1.5?	Both halves over 1.5?	\N	\N	f	SOCCER:FT:BHO_M
054b1bfe-0f29-4cb4-9e76-aa70008e88d0	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+3.5
1e4541e5-268a-414b-a4eb-aa70008e8919	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+2.5
e91dfee4-440f-4f18-b5eb-aa70008e8980	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+1.5
a8e2b49d-0400-4267-b0f3-aa70008e89cc	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+4.5
17dacff0-9a10-41a9-a5f2-aa70008e8a14	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:HSH	Highest scoring half home team	Highest scoring half home team	\N	\N	f	SOCCER:FT:A:HSH_M
95ce9768-9921-437a-8f56-aa70008e8a3c	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:EH	Home to win either half?	Home to win either half?	\N	\N	f	SOCCER:FT:A:EH_M
530fc7e5-e704-4a5e-a167-aa70008e8a5a	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WTTS	Which team to score	Which team to score	\N	\N	f	SOCCER:FT:WTTS_M
42f28b78-bf1c-49ea-bb06-aa70008e8a91	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WM	Winning margins	Winning margins	\N	\N	f	SOCCER:FT:WM_M
eb901427-b683-4412-9468-aa70008e8b02	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MBTSC	Matchbet + Both Teams Score	Matchbet + Both Teams Score	\N	\N	f	SOCCER:FT:MBTSC_M
89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£HTFTCS_1	Halftime/Fulltime Correct Score	Halftime/Fulltime Correct Score	\N	\N	f	SOCCER:FT:£HTFTCS_1_M
2bbd1475-67ec-4c45-b10e-aa70008e8d7e	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$2HBTS	Double Chance (match) and 2nd Half Both Teams to Score	Double Chance (match) and 2nd Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$2HBTS_M
9ed93ad2-a76e-46b3-b748-aa70008e8de3	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$1HBTS	Double Chance (match) and 1st Half Both Teams to Score	Double Chance (match) and 1st Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$1HBTS_M
d39e068c-7415-4e0c-8260-aa70008e8e24	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS$OU	Both Teams to Score + Totals {2}	Both Teams to Score + Totals {2}	\N	\N	f	SOCCER:FT:BTS$OU_M#+2.5
a828abd7-78eb-4352-81db-aa70008e8e61	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:MLTG	Multigoals Awayteam	Multigoals Awayteam	\N	\N	f	SOCCER:FT:B:MLTG_M
4187c488-d96b-4fcd-9597-aa70008e8ea7	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H1		1st Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H1
d621f7e7-beea-4351-b0d0-aa70008e8f00	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H2		2nd Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H2
936699cb-e1e1-46ca-acb4-aa70008e8f40	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:OE	Odd / Even Away Team	Odd / Even Away Team	\N	\N	f	SOCCER:FT:B:OE_M
30a9ce48-444c-48d0-9f00-aa70008e8f70	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:OE	Odd / Even Home Team	Odd / Even Home Team	\N	\N	f	SOCCER:FT:A:OE_M
7d1e261a-9f54-452b-88a0-aa70008e8f9c	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MLTG	Multigoals	Multigoals	\N	\N	f	SOCCER:FT:MLTG_M
4ab562ca-2126-40bb-916f-aa70008e908a	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:HSH	Highest scoring half away team	Highest scoring half away team	\N	\N	f	SOCCER:FT:B:HSH_M
07d7c7cb-ef4e-4836-b484-aa70008e90cf	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC$BTS_H1		1st Half - Double Chance and Both Teams to Score	\N	\N	f	SOCCER:P:DBLC$BTS_H1
6ab816f6-64fa-4274-9321-aa70008e9121	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$BTS	Double Chance and Both Teams to Score	Double Chance and Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$BTS_M
c21d408d-3d6c-43a8-9979-aa70008e916e	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MTFL	Matchflow	Matchflow	\N	\N	f	SOCCER:FT:MTFL_M
c61a4e7d-291a-4f9c-99fd-aa70008e91ea	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+3.5
6034fcaf-a4b6-4bd3-a54e-aa70008e9260	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+2.5
0becdfd0-7335-4e96-9068-aa70008e92bf	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+1.5
3de3d5d3-a2df-4683-92c3-aa70008e932a	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+4.5
5136512f-14bb-4673-9ccd-aa70008e93a5	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:TOFG15	First goal interval 15 min	First goal interval 15 min	\N	\N	f	SOCCER:FT:TOFG15_M
231fd7cb-4301-4aae-a16a-aa70008e9420	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H2		2nd Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H2
6f636c87-92ed-4077-a28f-aa70008e9493	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:TOFG10	First goal interval 10 min	First goal interval 10 min	\N	\N	f	SOCCER:FT:TOFG10_M
b5c3a5a5-34f4-49ca-b909-aa70008e9536	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H1		1st Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H1
eb10947f-716a-411a-8a6a-aa70008e955e	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:EH	Away to win either half?	Away to win either half?	\N	\N	f	SOCCER:FT:B:EH_M
6773ee70-6537-416c-a433-aa70008e9584	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:BH	Away to win both halves?	Away to win both halves?	\N	\N	f	SOCCER:FT:B:BH_M
6900a0d8-3807-40a5-852c-aa7000a76d4d	37cffcfe-7e06-47a5-8664-aa7000a76cb9	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
6414b0d3-d260-48ac-bed3-aa7000a76d95	37cffcfe-7e06-47a5-8664-aa7000a76cb9	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
08d476c0-31ef-40bf-a561-aa7000a76dba	d07c331d-b8c9-45aa-9dfd-aa7000a76dae	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
22759bdc-8b66-4784-8b0e-aa7000a76dd8	d07c331d-b8c9-45aa-9dfd-aa7000a76dae	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
f1033fee-ec21-44eb-93a1-aa7000a76dfb	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_4	Correct Score Aams	Correct Score AAMS	\N	\N	f	SOCCER:FT:£CS_4_M
5c92bff6-5076-4b09-847a-aa7000a76ef3	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:B:CLS_H2		2nd Half Clean Sheet Kramfors-alliansen	\N	\N	f	SOCCER:P:B:CLS_H2
4b7e0f53-417d-4c7f-bc16-aa7000a76f46	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_2_H1		1st Half - Total Goals 2	\N	\N	f	SOCCER:P:£OUR_2_H1
99d697d8-ed44-487d-8339-aa7000a76f9c	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+4.5
21b31e6d-7968-4716-8d79-aa7000a77063	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+3.5
88411be4-8f9a-4276-912d-aa7000a7710d	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-2.75
c4c5b107-16d4-458b-ac73-aa7000a77124	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+2.5
52ea676c-3ff2-4883-a704-aa7000a771e2	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+1.5
aefe765a-bc63-4058-99e3-aa7000a7727a	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.25
d6efc55a-ad38-4eff-918b-aa7000a77294	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.5
c90fb92e-87a7-4618-8a0b-aa7000a772af	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.75
b2643003-454b-4b01-b36e-aa7000a772c8	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-2.25
00670801-2cf8-44e4-b376-aa7000a772fc	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-2.5
cc73bf82-de4f-4b95-8a22-aa7000a7732e	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-1.75
41630da4-b796-4fb8-842c-aa7000a77372	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-2
e0ea15fe-322d-49c3-9a26-aa7000a773b7	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTSH	Both Teams To Score 1st Half / 2nd Half	Both Teams To Score 1st Half / 2nd Half	\N	\N	f	SOCCER:FT:BTSH_M
b1f06cb7-e7f5-4500-a651-aa7000a773e8	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:A:CLS_H1		1st Half Clean Sheet Ifk Ostersund	\N	\N	f	SOCCER:P:A:CLS_H1
9ef27af0-a814-4ad9-95b3-aa7000a77403	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+3.5
347b900b-7199-49f3-9947-aa7000a7741e	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+2.5
3a7b39b2-aba0-44ca-85fa-aa7000a77438	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+1.5
948e74f4-52b6-4a07-ac2c-aa7000a7745a	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+5.5
3f10d3eb-cc22-4519-9439-aa7000a77484	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+4.5
d0576bfe-7ca7-4949-8df0-aa7000a774ab	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
65ec8936-e9a1-4e28-97cd-aa7000a774d0	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB	Match Result	Match Result	\N	\N	f	SOCCER:FT:AXB_M
23e36f62-38fa-42bc-a33e-aa7000a774f3	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS	Both Teams to Score	Both Teams to Score	\N	\N	f	SOCCER:FT:BTS_M
620143d8-1b9e-4354-b415-aa7000a77513	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:SPRD	Handicap {2}	Handicap {2}	\N	\N	f	SOCCER:FT:SPRD_M#-1.0
24eca9f5-307e-4d18-80f4-aa7000a77534	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#+1.0
de2c7fdd-7e8b-46d8-88c1-aa7000a77553	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-1.0
2e118b83-9c52-4745-bdd9-aa7000a77570	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-2.0
90a0b6d1-12d5-44ab-a13b-aa7000a7758c	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_1	Correct Score	Correct Score	\N	\N	f	SOCCER:FT:£CS_1_M
c73ed3b9-02ee-4ab4-8097-aa7000a776ad	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H1		1st Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H1#+0.5
c5e1d233-b261-4d94-a1eb-aa7000a776c9	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H1		1st Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H1#+1.5
6c752021-8c08-45c3-b3a5-aa7000a776e6	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H2		Second Half Correct Score	\N	\N	f	SOCCER:P:£CS_1_H2
68455abb-3b0b-4408-ad79-aa7000a7795c	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H1		1st Half - Correct Score	\N	\N	f	SOCCER:P:£CS_1_H1
0c41a310-f584-4377-98f7-aa7000a779bc	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT	Halftime/Fulltime	Halftime/Fulltime	\N	\N	f	SOCCER:FT:HTFT_M
5407ae60-9710-480c-a904-aa7000a77a2c	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H1		1st Half - 1X2	\N	\N	f	SOCCER:P:AXB_H1
e6c17a58-3424-4d1a-8240-aa7000a77a5a	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H1		1st Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H1
1159a180-93df-4c3a-a168-aa7000a77a8c	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H2		2nd Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H2
034b5e64-46cc-4ab1-92c1-aa7000a77ab8	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H2		2nd Half - 1X2	\N	\N	f	SOCCER:P:AXB_H2
e1ff82ef-094b-449e-97ba-aa7000a77af9	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:NB	Away No Bet	Away No Bet	\N	\N	f	SOCCER:FT:B:NB_M
de3bd68c-1310-461e-b78e-aa7000a77b15	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:NB	Home No Bet	Home No Bet	\N	\N	f	SOCCER:FT:A:NB_M
12903df0-96b0-4bfc-8a28-aa7000a77b31	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H2		2nd Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H2#+0.5
6ec1bd84-9b6c-4d02-bd53-aa7000a77b4f	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H2		2nd Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H2#+1.5
57eb4b3e-ec19-4ca2-a1f7-aa7000a77b70	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
fad5dc27-b181-43fa-891e-aa7000a77bae	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:CLS	Clean sheet home team	Clean sheet home team	\N	\N	f	SOCCER:FT:A:CLS_M
df953838-2202-42a1-80d4-aa7000a77bf7	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:CLS	Clean sheet away team	Clean sheet away team	\N	\N	f	SOCCER:FT:B:CLS_M
3fa0f052-6ba8-45de-b854-aa7000a77c16	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AWN	Home Win to Nil	Home Win to Nil	\N	\N	f	SOCCER:FT:AWN_M
0f26b37e-764a-45d4-81cc-aa7000a77c37	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H1		First Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H1
3cadc86b-9455-4a42-8abe-aa7000a77c5a	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+2.5
bcac2687-4fa0-486f-9b54-aa7000a77c88	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+1.5
ca71741a-540b-4486-9b1f-aa7000a77cb7	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+0.5
0917fbc9-1015-4343-8fec-aa7000a77d11	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H2		Second Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H2
420dd87c-e9a0-4302-bc25-aa7000a77d5f	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+2.5
9dd0fcaf-da1b-455d-a631-aa7000a77d81	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+1.5
d6224ae4-fb76-4c2f-bd13-aa7000a77da4	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+0.5
711a9fe1-d735-436c-be11-aa7000a77dc4	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_1	Total Goals (exact)	Total Goals (exact)	\N	\N	f	SOCCER:FT:£OUR_1_M
ca607a59-5763-49a0-85c8-aa7000a77e23	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H1		1st Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H1
a1f685c9-040f-4fec-b7a1-aa7000a77eda	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H2		2nd Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H2
ea5ac99b-f21f-4b30-a145-aa7000a77f20	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OE	Odd/Even goals	Odd/Even goals	\N	\N	f	SOCCER:FT:OE_M
6e3918e1-eccc-4ac8-b4dc-aa7000a77f4e	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H1		1st Half - Odd/Even Goals	\N	\N	f	SOCCER:P:OE_H1
d3aa7dcc-6ee0-48d2-9f03-aa7000a77f71	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H2		Second Half Total Goals Odd/Even	\N	\N	f	SOCCER:P:OE_H2
2416b64b-d35e-4c07-b5d3-aa7000a77fc3	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:TTS2H	Away to score in both halves?	Away to score in both halves?	\N	\N	f	SOCCER:FT:B:TTS2H_M
c92dcdf9-1afd-4286-b945-aa7000a77fe3	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:TTS2H	Home to score in both halves?	Home to score in both halves?	\N	\N	f	SOCCER:FT:A:TTS2H_M
7535ed83-1662-4ef8-901b-aa7000a7802b	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:A:OU	Total Goals %1% %line%	Total Goals ИФК Йостерсунд 3.5	\N	\N	f	SOCCER:FT:A:OU_M#+3.5
de0eee17-29ef-4abd-880e-aa7000a7804f	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:B:OU	Total Goals {1} {2}	Total Goals {1} {2}	\N	\N	f	SOCCER:FT:B:OU_M#+0.5
70ee7d8c-69cd-4747-8e86-aa7000a78070	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:£OUR_1	Goals away team	Goals away team	\N	\N	f	SOCCER:FT:B:£OUR_1_M
0337e930-d7a5-4852-9081-aa7000a780b3	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:£OUR_1	Goals home team	Goals home team	\N	\N	f	SOCCER:FT:A:£OUR_1_M
bfd51abc-80f1-4224-a1a2-aa7000a7812a	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_2	Total Goals (aggregated)	Total Goals (aggregated)	\N	\N	f	SOCCER:FT:£OUR_2_M
3c3ef620-82e7-4afb-8f69-aa7000a781e9	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HSH	Highest scoring half	Highest scoring half	\N	\N	f	SOCCER:FT:HSH_M
c4848078-2114-40d2-9f61-aa7000a7821c	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:3HCP_H1		1st Half - European Handicap {2}	\N	\N	f	SOCCER:P:3HCP_H1#-1.0
9a2b1c26-b35c-458f-a449-aa7000a78249	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:BH	Home to win both halves?	Home to win both halves?	\N	\N	f	SOCCER:FT:A:BH_M
d8840a5a-d1ca-4938-a7b1-aa7000a78294	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHU	Both halves under 1.5?	Both halves under 1.5?	\N	\N	f	SOCCER:FT:BHU_M
e8887610-af69-46cc-8044-aa7000a782ca	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHO	Both halves over 1.5?	Both halves over 1.5?	\N	\N	f	SOCCER:FT:BHO_M
ef8642ec-d81f-453e-a3f9-aa7000a782ed	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+3.5
575cd28f-3fd9-42e6-bb43-aa7000a78339	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+2.5
54daaa10-d28a-48e0-8587-aa7000a78384	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+1.5
9e50ee7e-aef1-4114-811b-aa7000a783fd	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+4.5
04782eea-5582-469f-9d2e-aa7000a7845f	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:HSH	Highest scoring half home team	Highest scoring half home team	\N	\N	f	SOCCER:FT:A:HSH_M
6eed4a42-efe4-4d1d-a98b-aa7000a7848c	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:EH	Home to win either half?	Home to win either half?	\N	\N	f	SOCCER:FT:A:EH_M
da5e2f48-2a83-46a3-b59b-aa7000a784ab	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+4.5
ef05af45-4a70-4c95-9ba2-aa7000a78545	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£HTFTCS_1	Halftime/Fulltime Correct Score	Halftime/Fulltime Correct Score	\N	\N	f	SOCCER:FT:£HTFTCS_1_M
7abe1e2b-658c-4e56-9838-aa7000a78894	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MBTSC	Matchbet + Both Teams Score	Matchbet + Both Teams Score	\N	\N	f	SOCCER:FT:MBTSC_M
2ea3e628-4b79-4303-83d9-aa7000a788e5	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WM	Winning margins	Winning margins	\N	\N	f	SOCCER:FT:WM_M
a44f7ddc-4adf-44ab-a696-aa7000a789ae	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WTTS	Which team to score	Which team to score	\N	\N	f	SOCCER:FT:WTTS_M
dcf10c10-41eb-4602-8988-aa7000a78bc0	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$2HBTS	Double Chance (match) and 2nd Half Both Teams to Score	Double Chance (match) and 2nd Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$2HBTS_M
1f7b5949-0d6b-4487-a221-aa7000a78c4b	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS$OU	Both Teams to Score + Totals {2}	Both Teams to Score + Totals {2}	\N	\N	f	SOCCER:FT:BTS$OU_M#+2.5
67dcc314-86ac-4a28-a685-aa7000a78cf8	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$1HBTS	Double Chance (match) and 1st Half Both Teams to Score	Double Chance (match) and 1st Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$1HBTS_M
8e387bca-e222-4b61-b5e8-aa7000a78de6	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:MLTG	Multigoals Awayteam	Multigoals Awayteam	\N	\N	f	SOCCER:FT:B:MLTG_M
bdfc015d-9aea-4861-abef-aa7000a78e96	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H1		1st Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H1
58ba0a63-b7da-4ae9-8f1b-aa7000a78f00	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H2		2nd Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H2
16ff504c-d390-49e7-ad30-aa7000a78f2c	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:OE	Odd / Even Away Team	Odd / Even Away Team	\N	\N	f	SOCCER:FT:B:OE_M
ab283011-81c3-4fe2-bbd1-aa7000a78f52	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:OE	Odd / Even Home Team	Odd / Even Home Team	\N	\N	f	SOCCER:FT:A:OE_M
7e3f97ad-42be-417c-abb9-aa7000a78fac	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MLTG	Multigoals	Multigoals	\N	\N	f	SOCCER:FT:MLTG_M
8eb7507e-4de0-46cc-aeb6-aa7000a79131	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:HSH	Highest scoring half away team	Highest scoring half away team	\N	\N	f	SOCCER:FT:B:HSH_M
0f62f261-ac51-455a-8067-aa7000a79172	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC$BTS_H1		1st Half - Double Chance and Both Teams to Score	\N	\N	f	SOCCER:P:DBLC$BTS_H1
382a4a8e-15cf-4216-ba20-aa7000a791ca	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$BTS	Double Chance and Both Teams to Score	Double Chance and Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$BTS_M
34ee1de8-ec49-4874-9bbd-aa7000a7921d	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+3.5
e9448147-e994-49af-9cde-aa7000a79318	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+2.5
322d2e07-7fc1-4133-bcae-aa7000a7937e	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+1.5
ce3a7628-5456-41d6-8f1d-aa7000a793f3	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H2		2nd Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H2
534de11e-8bb9-48b6-9d6b-aa7000a79446	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H1		1st Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H1
02f30d5d-ee1c-4e20-94a0-aa7000a79469	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:EH	Away to win either half?	Away to win either half?	\N	\N	f	SOCCER:FT:B:EH_M
a85ad4bc-550b-4b6c-b9cf-aa7000a79490	6522de53-ee92-4402-8e31-aa7000a79482	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB	Match Result	Match Result	\N	\N	f	SOCCER:FT:AXB_M
511408fa-8462-49eb-a1d8-aa7000a794c0	6522de53-ee92-4402-8e31-aa7000a79482	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
1d2cef4a-7d4d-4b4b-9d49-aa7000a794f8	6522de53-ee92-4402-8e31-aa7000a79482	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
3e1ad458-4c80-4333-9e4a-aa7000a8139c	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_4	Correct Score Aams	Correct Score AAMS	\N	\N	f	SOCCER:FT:£CS_4_M
6777ee9d-d69a-483b-a351-aa7000a814c0	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+4.5
f4cb2ae7-9757-4c90-ac84-aa7000a81567	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#+0.5
fea163b1-99d5-4a4e-b6e0-aa7000a81584	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-0.25
a600a21d-1bdc-4260-9757-aa7000a8159e	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1
b6a6f54c-5082-451d-939b-aa7000a815bb	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.5
fa9c0ee5-7af0-49f6-b826-aa7000a815de	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+3.5
acf7824d-c5c0-4129-9a59-aa7000a81698	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+2.5
4fdd9403-fb96-416a-8695-aa7000a81724	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+1.5
92569274-edec-49a5-8ad8-aa7000a817c1	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_2_H1		1st Half - Total Goals 2	\N	\N	f	SOCCER:P:£OUR_2_H1
ff0c0dbf-89e4-4349-8384-aa7000a817e8	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:B:CLS_H2		2nd Half Clean Sheet Nosaby If	\N	\N	f	SOCCER:P:B:CLS_H2
0d8a7659-5c43-48b2-8851-aa7000a81801	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.25
5dee0f3b-9068-4875-a20e-aa7000a8181a	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-0.5
d1b28612-2062-449e-88ad-aa7000a81834	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#+0.25
b2ff814f-f921-42a6-a5d1-aa7000a8185a	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#+0
d589dd5d-502a-4ecd-8b98-aa7000a81875	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:A:CLS_H1		1st Half Clean Sheet Ifk Hassleholm	\N	\N	f	SOCCER:P:A:CLS_H1
a71d2bd3-2cc3-445b-9c8e-aa7000a81890	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTSH	Both Teams To Score 1st Half / 2nd Half	Both Teams To Score 1st Half / 2nd Half	\N	\N	f	SOCCER:FT:BTSH_M
79336adf-f18b-4ae7-8624-aa7000a818d8	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+3.5
315596df-3e1e-4399-9bcd-aa7000a818f7	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+2.5
22424e69-99b6-4760-a9a9-aa7000a81913	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+1.5
847b2fe9-2d3d-419f-a40c-aa7000a81930	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+0.5
c270e763-e37d-45ff-9c67-aa7000a8194a	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+5.5
ff5941ec-91ca-4b87-bf42-aa7000a81966	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+4.5
43b33637-b2e6-4f39-98f3-aa7000a8197f	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB	Match Result	Match Result	\N	\N	f	SOCCER:FT:AXB_M
b9edd2a3-0d4f-4d46-b80f-aa7000a819a8	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
c4c94e32-11c0-452c-9784-aa7000a819d1	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS	Both Teams to Score	Both Teams to Score	\N	\N	f	SOCCER:FT:BTS_M
657a276c-419a-4ffd-b0b4-aa7000a819eb	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-1.0
4ecf0193-654a-4d34-ab88-aa7000a81a11	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#+1.0
162a1688-fd17-4530-b1d3-aa7000a81a53	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#+2.0
cfebeb86-147e-4286-b390-aa7000a81a77	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:SPRD	Handicap {2}	Handicap {2}	\N	\N	f	SOCCER:FT:SPRD_M#+1.0
ac66fe2d-2e99-42e4-93d3-aa7000a81a9b	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-2.0
6c0ca19a-aac2-405f-8534-aa7000a81abf	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_1	Correct Score	Correct Score	\N	\N	f	SOCCER:FT:£CS_1_M
94908ff8-ac1e-4c19-93ca-aa7000a81c19	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H1		1st Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H1#+0.5
b73e7f27-18ca-4ac7-b6fc-aa7000a81c34	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H1		1st Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H1#+0.5
2691af49-f553-469b-ba06-aa7000a81c4e	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H2		Second Half Correct Score	\N	\N	f	SOCCER:P:£CS_1_H2
242af76a-2fc9-49e9-8d94-aa7000a81cbf	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H1		1st Half - Correct Score	\N	\N	f	SOCCER:P:£CS_1_H1
ea5c99c2-c664-4db3-aadb-aa7000a81d57	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT	Halftime/Fulltime	Halftime/Fulltime	\N	\N	f	SOCCER:FT:HTFT_M
2fa2f3d8-35cd-4368-b923-aa7000a81dc6	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H1		1st Half - 1X2	\N	\N	f	SOCCER:P:AXB_H1
7996264e-c74c-41d1-b3ca-aa7000a81df9	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H1		1st Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H1
29229fb1-a26a-422a-80a1-aa7000a81e1f	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H2		2nd Half - 1X2	\N	\N	f	SOCCER:P:AXB_H2
e3dd6670-b374-4c3e-99c7-aa7000a81e81	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H2		2nd Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H2
418e7e95-4375-4a70-aa37-aa7000a81eaa	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:NB	Away No Bet	Away No Bet	\N	\N	f	SOCCER:FT:B:NB_M
b8da9b76-6063-4fe1-9a3a-aa7000a81ecd	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:NB	Home No Bet	Home No Bet	\N	\N	f	SOCCER:FT:A:NB_M
e350b3cd-ea9d-4d52-b603-aa7000a81eee	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H2		2nd Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H2#+0.5
6bf37ba8-e058-4fbc-9009-aa7000a81f0d	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H2		2nd Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H2#+0.5
39d86ebd-b898-49b0-8767-aa7000a81f29	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
1d23938b-961b-4725-8de0-aa7000a81f63	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:CLS	Clean sheet away team	Clean sheet away team	\N	\N	f	SOCCER:FT:B:CLS_M
189ae426-c1ca-440c-96fe-aa7000a81f8d	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:CLS	Clean sheet home team	Clean sheet home team	\N	\N	f	SOCCER:FT:A:CLS_M
1f095e4e-ab18-4f08-8f5b-aa7000a81fc9	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BWN	Away Win to Nil	Away Win to Nil	\N	\N	f	SOCCER:FT:BWN_M
b8cb1eb9-f950-4a0c-ac24-aa7000a81ffa	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AWN	Home Win to Nil	Home Win to Nil	\N	\N	f	SOCCER:FT:AWN_M
7aecdc29-93a1-4c2b-97be-aa7000a82018	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H1		First Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H1
d9c76bc9-a187-4686-aa8c-aa7000a8203f	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+2.5
35d1995e-14ff-4b40-9eb5-aa7000a8205e	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+1.5
701c8310-8296-4bf8-9a76-aa7000a82081	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+0.5
9642d8ad-487e-4c07-8385-aa7000a820a4	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H2		Second Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H2
94ad081d-a04c-48c8-890f-aa7000a820ca	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+2.5
a4319102-daf5-4905-a672-aa7000a820e7	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+1.5
ff628114-e78c-462d-a9a4-aa7000a8210e	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+0.5
5e3f1524-be16-4dcc-88fe-aa7000a8214b	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_1	Total Goals (exact)	Total Goals (exact)	\N	\N	f	SOCCER:FT:£OUR_1_M
5b0ce817-8360-4e0b-9fa0-aa7000a8219d	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H1		1st Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H1
cf5975a4-4cca-45a6-bb38-aa7000a821ca	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H2		2nd Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H2
8854278e-fc59-424c-b7fe-aa7000a821f5	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OE	Odd/Even goals	Odd/Even goals	\N	\N	f	SOCCER:FT:OE_M
62f8c060-4318-41e4-9f3b-aa7000a8222a	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H1		1st Half - Odd/Even Goals	\N	\N	f	SOCCER:P:OE_H1
2ed67447-f050-49dc-9a9a-aa7000a8224a	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H2		Second Half Total Goals Odd/Even	\N	\N	f	SOCCER:P:OE_H2
7f754238-fe8f-4d64-ab38-aa7000a82289	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:TTS2H	Home to score in both halves?	Home to score in both halves?	\N	\N	f	SOCCER:FT:A:TTS2H_M
d70287d0-981e-4905-9e5a-aa7000a822c4	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:TTS2H	Away to score in both halves?	Away to score in both halves?	\N	\N	f	SOCCER:FT:B:TTS2H_M
ebdebe8f-dd95-451e-933d-aa7000a822e4	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:A:OU	Total Goals %1% %line%	Total Goals Ifk Hassleholm 1.5	\N	\N	f	SOCCER:FT:A:OU_M#+1.5
ec3fee5a-4e07-416c-8783-aa7000a822ff	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:B:OU	Total Goals {1} {2}	Total Goals {1} {2}	\N	\N	f	SOCCER:FT:B:OU_M#+1.5
49cf0b80-81ce-4028-9e9e-aa7000a82318	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:£OUR_1	Goals away team	Goals away team	\N	\N	f	SOCCER:FT:B:£OUR_1_M
644b0ebb-67c0-44b0-aac5-aa7000a8234b	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:£OUR_1	Goals home team	Goals home team	\N	\N	f	SOCCER:FT:A:£OUR_1_M
8e2d3713-6fdc-4885-9a7b-aa7000a82380	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_2	Total Goals (aggregated)	Total Goals (aggregated)	\N	\N	f	SOCCER:FT:£OUR_2_M
c6f1fcae-7d30-4212-9901-aa7000a823b7	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HSH	Highest scoring half	Highest scoring half	\N	\N	f	SOCCER:FT:HSH_M
e2a5a10d-8a01-47cf-aef8-aa7000a8240d	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:3HCP_H1		1st Half - European Handicap {2}	\N	\N	f	SOCCER:P:3HCP_H1#+1.0
a79ef1df-7a9e-49d3-8b40-aa7000a82439	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:BH	Home to win both halves?	Home to win both halves?	\N	\N	f	SOCCER:FT:A:BH_M
d785fdb4-89d9-4781-80c8-aa7000a82455	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHO	Both halves over 1.5?	Both halves over 1.5?	\N	\N	f	SOCCER:FT:BHO_M
21280eb5-ad53-4ee1-869d-aa7000a82471	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHU	Both halves under 1.5?	Both halves under 1.5?	\N	\N	f	SOCCER:FT:BHU_M
3f991c02-6e95-401d-9538-aa7000a8248e	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+4.5
cccc9c48-3779-4180-9130-aa7000a824d3	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+1.5
0bc4f1b7-d2cf-4dd9-bc0e-aa7000a82521	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+3.5
4da53022-3cc8-4568-add6-aa7000a8258a	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+2.5
49d01b92-c277-48d8-884b-aa7000a825d0	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:EH	Home to win either half?	Home to win either half?	\N	\N	f	SOCCER:FT:A:EH_M
d803cfb6-cc48-4885-9110-aa7000a825f1	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:HSH	Highest scoring half home team	Highest scoring half home team	\N	\N	f	SOCCER:FT:A:HSH_M
31dee395-67c3-4b84-a865-aa7000a8261e	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$2HBTS	Double Chance (match) and 2nd Half Both Teams to Score	Double Chance (match) and 2nd Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$2HBTS_M
2cb01cb2-5587-45b9-a7cf-aa7000a82662	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H1		1st Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H1
a6499c8e-7f2f-4747-bf4d-aa7000a826d8	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:EH	Away to win either half?	Away to win either half?	\N	\N	f	SOCCER:FT:B:EH_M
dd372b73-b3c5-4321-ba8f-aa7000a826f6	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC$BTS_H1		1st Half - Double Chance and Both Teams to Score	\N	\N	f	SOCCER:P:DBLC$BTS_H1
1c9f968e-ae11-4def-a152-aa7000a82745	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:HSH	Highest scoring half away team	Highest scoring half away team	\N	\N	f	SOCCER:FT:B:HSH_M
f6133ee7-2a95-4371-bc5c-aa7000a82771	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$1HBTS	Double Chance (match) and 1st Half Both Teams to Score	Double Chance (match) and 1st Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$1HBTS_M
5dd54104-c1b4-4268-bc53-aa7000a827b8	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WTTS	Which team to score	Which team to score	\N	\N	f	SOCCER:FT:WTTS_M
6943b526-0e2c-4ea4-bd6a-aa7000a827f7	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WM	Winning margins	Winning margins	\N	\N	f	SOCCER:FT:WM_M
aa9a599c-46ca-4a20-a0bc-aa7000a82873	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MBTSC	Matchbet + Both Teams Score	Matchbet + Both Teams Score	\N	\N	f	SOCCER:FT:MBTSC_M
22f5756e-2797-45b8-b3ea-aa7000a828c4	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£HTFTCS_1	Halftime/Fulltime Correct Score	Halftime/Fulltime Correct Score	\N	\N	f	SOCCER:FT:£HTFTCS_1_M
57e29679-0f04-493a-a839-aa7000a82b5b	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS$OU	Both Teams to Score + Totals {2}	Both Teams to Score + Totals {2}	\N	\N	f	SOCCER:FT:BTS$OU_M#+2.5
c15c1ecf-f7b5-4ebb-afb0-aa7000a82bab	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:MLTG	Multigoals Awayteam	Multigoals Awayteam	\N	\N	f	SOCCER:FT:B:MLTG_M
7dd568d9-33e4-4174-a0bb-aa7000a82c01	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H2		2nd Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H2
183ff77d-6086-479b-8d8a-aa7000a82c34	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:OE	Odd / Even Away Team	Odd / Even Away Team	\N	\N	f	SOCCER:FT:B:OE_M
8beaa90f-cf34-4f54-a580-aa7000a84197	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:NB	Home No Bet	Home No Bet	\N	\N	f	SOCCER:FT:A:NB_M
a477dcaf-56a1-4267-a36e-aa7000a82c68	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:OE	Odd / Even Home Team	Odd / Even Home Team	\N	\N	f	SOCCER:FT:A:OE_M
aa6b0035-c07d-433c-beff-aa7000a82c93	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MLTG	Multigoals	Multigoals	\N	\N	f	SOCCER:FT:MLTG_M
707166b2-0302-4b67-a698-aa7000a82d80	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$BTS	Double Chance and Both Teams to Score	Double Chance and Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$BTS_M
e2ea1f40-a7b7-4f88-b582-aa7000a82df7	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+3.5
235695e1-d767-4fa6-8482-aa7000a82e56	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+2.5
c4bc847c-16d5-4e7f-babb-aa7000a82eae	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+1.5
a481d8ef-51f5-452e-ae1c-aa7000a82f25	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+4.5
352a4048-3347-4488-87ef-aa7000a82f83	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H2		2nd Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H2
d859bba3-977f-4435-b78e-aa7000a82fe6	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H1		1st Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H1
0f6ec7be-57cf-48ba-8659-aa7000a8300b	5ad382fc-576b-4e90-a686-aa7000a81301	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:BH	Away to win both halves?	Away to win both halves?	\N	\N	f	SOCCER:FT:B:BH_M
9351e30a-a68f-4ffb-8a34-aa7000a83074	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_4	Correct Score Aams	Correct Score AAMS	\N	\N	f	SOCCER:FT:£CS_4_M
26e67321-f784-4d71-97f4-aa7000a83241	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+4.5
4c2962c2-1894-4dba-b0b0-aa7000a83365	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#+0.75
a9e8e4ea-32ba-49db-a0fd-aa7000a83395	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#+0
023f3db0-a0b7-46ca-8c9c-aa7000a833bb	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#+1
88c0d4cf-49a9-4e0b-a68b-aa7000a833e4	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#+0.25
f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+3.5
e0a8c651-37ec-4302-b93a-aa7000a83550	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+2.5
67a7cf25-6ddd-46f1-bf88-aa7000a83661	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+1.5
012481e5-9b5e-497d-b614-aa7000a83736	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_2_H1		1st Half - Total Goals 2	\N	\N	f	SOCCER:P:£OUR_2_H1
21437e86-3dc4-4572-9be6-aa7000a83790	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:B:CLS_H2		2nd Half Clean Sheet Ifk Berga	\N	\N	f	SOCCER:P:B:CLS_H2
7223aa87-6bbd-4886-bd37-aa7000a837b1	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.25
36f49148-bbbc-4dc1-9c3f-aa7000a837d6	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.5
7aabee49-3818-4184-9b09-aa7000a837fd	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1
1c114036-50f5-495c-912d-aa7000a83829	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#+0.5
3d3ab6ff-8367-4d3b-8fcd-aa7000a83853	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTSH	Both Teams To Score 1st Half / 2nd Half	Both Teams To Score 1st Half / 2nd Half	\N	\N	f	SOCCER:FT:BTSH_M
482c67c0-111f-4596-971f-aa7000a838a6	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:A:CLS_H1		1st Half Clean Sheet Ifo Bromolla If	\N	\N	f	SOCCER:P:A:CLS_H1
7bca39d7-79dc-4e68-9f13-aa7000a838f3	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+3.5
3d664944-a237-45b9-a658-aa7000a83917	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+2.5
3a45aa7b-2c67-488e-bbf5-aa7000a83941	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+1.5
b9481739-17e4-4e71-ab2c-aa7000a83978	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+0.5
d149a1aa-eefd-4b75-87cc-aa7000a839a4	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+5.5
f744431b-14a7-4d58-8bd3-aa7000a839d3	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+4.5
2426ad85-170f-476e-8c99-aa7000a83a08	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB	Match Result	Match Result	\N	\N	f	SOCCER:FT:AXB_M
3203e28d-47d1-4fc4-9ea5-aa7000a83a59	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
1aaf010c-b3ff-44f6-9a56-aa7000a83a8d	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS	Both Teams to Score	Both Teams to Score	\N	\N	f	SOCCER:FT:BTS_M
b0838e65-7761-47c5-a4b3-aa7000a83ab5	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:SPRD	Handicap {2}	Handicap {2}	\N	\N	f	SOCCER:FT:SPRD_M#+1.0
d00015b9-e610-4813-9318-aa7000a83aec	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#+2.0
b270e6b3-7cbf-4063-ae76-aa7000a83b2b	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#+1.0
ea815e8b-cff9-49b0-b0a4-aa7000a83b67	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-1.0
8e89bdd8-0cd7-4758-9e44-aa7000a83bad	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-2.0
10691b06-f504-448a-a514-aa7000a83be2	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_1	Correct Score	Correct Score	\N	\N	f	SOCCER:FT:£CS_1_M
e316910c-598e-4de3-8c2c-aa7000a83dc3	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H1		1st Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H1#+0.5
b61c58e6-d62b-4afc-86eb-aa7000a83df3	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H1		1st Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H1#+0.5
c366da1b-903a-4688-ad4c-aa7000a83e2b	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H2		Second Half Correct Score	\N	\N	f	SOCCER:P:£CS_1_H2
b49086b5-2ef2-4950-a2d9-aa7000a83ee9	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H1		1st Half - Correct Score	\N	\N	f	SOCCER:P:£CS_1_H1
10d81ac1-175f-4ede-9d32-aa7000a83fa8	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT	Halftime/Fulltime	Halftime/Fulltime	\N	\N	f	SOCCER:FT:HTFT_M
f2a7764a-c0e3-4e4b-92d6-aa7000a84044	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H1		1st Half - 1X2	\N	\N	f	SOCCER:P:AXB_H1
feac09d6-844b-4432-b522-aa7000a84078	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H1		1st Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H1
f5a46194-a5e9-4fa5-bde9-aa7000a840b3	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H2		2nd Half - 1X2	\N	\N	f	SOCCER:P:AXB_H2
3de36dd4-cbea-46a8-be3b-aa7000a840ee	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H2		2nd Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H2
43efaa49-af8f-4370-8343-aa7000a8413e	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H2		2nd Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H2#+0.5
8950c041-59a2-4147-93f3-aa7000a8416b	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:NB	Away No Bet	Away No Bet	\N	\N	f	SOCCER:FT:B:NB_M
d9638888-4e56-496f-857c-aa7000a841c7	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H2		2nd Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H2#+0.5
ca07abcb-c5f6-4f91-877c-aa7000a841ef	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
bbfd89ad-3dde-4d98-9670-aa7000a84237	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:CLS	Clean sheet away team	Clean sheet away team	\N	\N	f	SOCCER:FT:B:CLS_M
7a6659f8-e448-47bc-860f-aa7000a84260	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:CLS	Clean sheet home team	Clean sheet home team	\N	\N	f	SOCCER:FT:A:CLS_M
864bc62f-9ca9-472f-8679-aa7000a842a2	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BWN	Away Win to Nil	Away Win to Nil	\N	\N	f	SOCCER:FT:BWN_M
78a8eff1-1748-4b9e-9144-aa7000a842cf	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AWN	Home Win to Nil	Home Win to Nil	\N	\N	f	SOCCER:FT:AWN_M
bc19d5c5-8315-4501-9b62-aa7000a842f7	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H1		First Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H1
3f587055-37ba-4e77-8861-aa7000a8431e	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+2.5
ab3f2e12-9bd0-43bb-a56e-aa7000a8434c	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+1.5
2bccceb8-e66e-4220-bd97-aa7000a84378	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+0.5
1b714eff-3ecc-4b34-bb28-aa7000a843b7	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H2		Second Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H2
35082bfb-583c-441c-932f-aa7000a84402	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+2.5
ada6e91c-2714-45f2-8ec5-aa7000a8442b	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+1.5
e63175d8-f332-4294-b06c-aa7000a8445b	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+0.5
c2284a44-bee7-4239-bc16-aa7000a8448b	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_1	Total Goals (exact)	Total Goals (exact)	\N	\N	f	SOCCER:FT:£OUR_1_M
aaaee55c-a0f2-45c4-b2fd-aa7000a84514	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H1		1st Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H1
5a568c5a-7b6d-4ee8-b43b-aa7000a84585	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H2		2nd Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H2
3a2bfbcd-7b66-4a74-9329-aa7000a845cf	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OE	Odd/Even goals	Odd/Even goals	\N	\N	f	SOCCER:FT:OE_M
08c9fe47-1b58-4c9d-86c4-aa7000a845fd	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H1		1st Half - Odd/Even Goals	\N	\N	f	SOCCER:P:OE_H1
b9f0af0d-2d48-4578-87b3-aa7000a84626	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H2		Second Half Total Goals Odd/Even	\N	\N	f	SOCCER:P:OE_H2
6073b6fb-4f86-4aa1-af6b-aa7000a84669	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:TTS2H	Home to score in both halves?	Home to score in both halves?	\N	\N	f	SOCCER:FT:A:TTS2H_M
ac87ced2-a0b2-44a1-b5be-aa7000a846a1	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:TTS2H	Away to score in both halves?	Away to score in both halves?	\N	\N	f	SOCCER:FT:B:TTS2H_M
8ef0ade3-0c16-43c2-ae64-aa7000a846cf	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:B:OU	Total Goals {1} {2}	Total Goals {1} {2}	\N	\N	f	SOCCER:FT:B:OU_M#+1.5
fca4c349-3a05-463e-8dcf-aa7000a846fc	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:A:OU	Total Goals %1% %line%	Total Goals IFO Bromolla IF 1.5	\N	\N	f	SOCCER:FT:A:OU_M#+1.5
45a65a93-b802-4320-8fcc-aa7000a84731	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:£OUR_1	Goals away team	Goals away team	\N	\N	f	SOCCER:FT:B:£OUR_1_M
0a486951-b543-4043-a75c-aa7000a8477c	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:£OUR_1	Goals home team	Goals home team	\N	\N	f	SOCCER:FT:A:£OUR_1_M
1558ff2f-703e-4ea1-a2bb-aa7000a847d2	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_2	Total Goals (aggregated)	Total Goals (aggregated)	\N	\N	f	SOCCER:FT:£OUR_2_M
e419db2a-0952-4b15-ba7b-aa7000a8483b	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HSH	Highest scoring half	Highest scoring half	\N	\N	f	SOCCER:FT:HSH_M
e6cba78f-9f15-404d-88bd-aa7000a84874	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:3HCP_H1		1st Half - European Handicap {2}	\N	\N	f	SOCCER:P:3HCP_H1#+1.0
504ea9c1-894b-4460-aa7c-aa7000a848b6	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:BH	Home to win both halves?	Home to win both halves?	\N	\N	f	SOCCER:FT:A:BH_M
a04c557e-a3ba-4628-af65-aa7000a848e6	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHU	Both halves under 1.5?	Both halves under 1.5?	\N	\N	f	SOCCER:FT:BHU_M
29fa23d7-8d2a-470d-aaba-aa7000a84914	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHO	Both halves over 1.5?	Both halves over 1.5?	\N	\N	f	SOCCER:FT:BHO_M
c359fc7c-7e50-4f9a-a3d6-aa7000a8495c	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+4.5
2a5d3316-5aca-4322-b221-aa7000a849d8	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+2.5
b1cca54a-17a2-4496-ad18-aa7000a84a52	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+3.5
9222f643-daf2-4ccb-8f87-aa7000a84b22	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+1.5
72bc4dfe-8d83-4861-a9ba-aa7000a84b94	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:HSH	Highest scoring half home team	Highest scoring half home team	\N	\N	f	SOCCER:FT:A:HSH_M
6c382bc3-7569-4e94-bfd3-aa7000a84bd1	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:EH	Home to win either half?	Home to win either half?	\N	\N	f	SOCCER:FT:A:EH_M
b1bfa6be-999f-47d8-9f17-aa7000a84c0b	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MBTSC	Matchbet + Both Teams Score	Matchbet + Both Teams Score	\N	\N	f	SOCCER:FT:MBTSC_M
26317c99-113c-4a7a-84d7-aa7000a84c91	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WM	Winning margins	Winning margins	\N	\N	f	SOCCER:FT:WM_M
8defc450-86c7-4d63-8169-aa7000a84d11	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:EH	Away to win either half?	Away to win either half?	\N	\N	f	SOCCER:FT:B:EH_M
1ee20b8c-78a8-4701-ac26-aa7000a84d4c	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+3.5
05924d5f-3f5c-43d3-bd15-aa7000a84de0	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MLTG	Multigoals	Multigoals	\N	\N	f	SOCCER:FT:MLTG_M
21c26772-6738-4d39-b7c1-aa7000a84f63	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H2		2nd Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H2
ca1eb805-93d4-4dae-8949-aa7000a84f94	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$1HBTS	Double Chance (match) and 1st Half Both Teams to Score	Double Chance (match) and 1st Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$1HBTS_M
9b686565-3f24-4585-83cc-aa7000a84ffc	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$2HBTS	Double Chance (match) and 2nd Half Both Teams to Score	Double Chance (match) and 2nd Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$2HBTS_M
d7644492-504a-47c6-91c7-aa7000a8507a	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WTTS	Which team to score	Which team to score	\N	\N	f	SOCCER:FT:WTTS_M
974185d5-8fec-4349-bec0-aa7000a850d8	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£HTFTCS_1	Halftime/Fulltime Correct Score	Halftime/Fulltime Correct Score	\N	\N	f	SOCCER:FT:£HTFTCS_1_M
068c1fa5-00ff-46ea-982e-aa7000a85456	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS$OU	Both Teams to Score + Totals {2}	Both Teams to Score + Totals {2}	\N	\N	f	SOCCER:FT:BTS$OU_M#+2.5
5f493e60-9677-4261-b54f-aa7000a854ba	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H1		1st Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H1
63805347-fbd2-45f1-bbe0-aa7000a85537	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:MLTG	Multigoals Awayteam	Multigoals Awayteam	\N	\N	f	SOCCER:FT:B:MLTG_M
05773e36-4423-4e8f-963f-aa7000a855aa	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:OE	Odd / Even Away Team	Odd / Even Away Team	\N	\N	f	SOCCER:FT:B:OE_M
87e8e790-3fe9-495c-a540-aa7000a855f6	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:OE	Odd / Even Home Team	Odd / Even Home Team	\N	\N	f	SOCCER:FT:A:OE_M
1b1bc5ad-2e74-4436-9003-aa7000a8562c	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:HSH	Highest scoring half away team	Highest scoring half away team	\N	\N	f	SOCCER:FT:B:HSH_M
a75def2c-8df0-43e7-86de-aa7000a85671	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC$BTS_H1		1st Half - Double Chance and Both Teams to Score	\N	\N	f	SOCCER:P:DBLC$BTS_H1
832e35b0-b393-49cf-bcb6-aa7000a85706	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$BTS	Double Chance and Both Teams to Score	Double Chance and Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$BTS_M
855811b2-337f-485d-957a-aa7000a857a0	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+2.5
1ae79100-0359-4169-b26d-aa7000a8581d	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+1.5
9f599a46-e2ec-477f-bb9a-aa7000a858bc	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+4.5
247dad56-0f0a-4507-97df-aa7000a8593f	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H2		2nd Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H2
50086a70-c9b3-422f-a349-aa7000a859d3	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H1		1st Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H1
9c318995-42cd-41cb-82d9-aa7000a85a1c	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:BH	Away to win both halves?	Away to win both halves?	\N	\N	f	SOCCER:FT:B:BH_M
e89f9010-8864-4f36-aed7-aa7000a85a70	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_4	Correct Score Aams	Correct Score AAMS	\N	\N	f	SOCCER:FT:£CS_4_M
4426a461-22dc-4a08-a502-aa7000a85ca3	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+4.5
60e46020-8224-4994-8481-aa7000a85e2d	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+1.5
23578c77-7b22-482e-8e0b-aa7000a85f34	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-2.5
ef21ce7d-ceac-4396-bc90-aa7000a85f69	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+3.5
7614df88-2ca9-46e6-b797-aa7000a860ed	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT$OU	Halftime/fulltime & total	Halftime/fulltime & total	\N	\N	f	SOCCER:FT:HTFT$OU_M#+2.5
dfd45dec-f9e3-4632-89d6-aa7000a86280	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_2_H1		1st Half - Total Goals 2	\N	\N	f	SOCCER:P:£OUR_2_H1
3c7cdb20-80af-431f-85cd-aa7000a862dd	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:B:CLS_H2		2nd Half Clean Sheet Hassleholms If	\N	\N	f	SOCCER:P:B:CLS_H2
d922abfb-8820-4a26-8277-aa7000a86317	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.25
51b2382b-dc60-4f59-b1c5-aa7000a8635a	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.5
7e6f2ea5-51ea-44dc-92f5-aa7000a863d7	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:ATG_H1		1st Half - Asian Total {2}	\N	\N	f	SOCCER:P:ATG_H1#+1.75
461d14b6-22ef-493d-b841-aa7000a8642d	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-1.5
d2b7e28e-7180-4816-897b-aa7000a86472	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-2.25
8967dd59-5047-4377-82f0-aa7000a864bf	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-1.75
2c9d5c87-795f-40b6-89cb-aa7000a8653a	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AHCP	Asian Handicap {2}	Asian Handicap {2}	\N	\N	f	SOCCER:FT:AHCP_M#-2
0120e5cf-93e2-45e0-8af0-aa7000a86577	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTSH	Both Teams To Score 1st Half / 2nd Half	Both Teams To Score 1st Half / 2nd Half	\N	\N	f	SOCCER:FT:BTSH_M
ca818b51-3da5-4fad-888e-aa7000a865f5	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:A:CLS_H1		1st Half Clean Sheet Fk Karlskrona	\N	\N	f	SOCCER:P:A:CLS_H1
94cf73ab-7248-4f8d-9d66-aa7000a8663f	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+3.5
29a700ff-74a5-4304-bc15-aa7000a8669a	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+2.5
9a9eb947-b6e8-4eff-8bd1-aa7000a866d2	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+1.5
1cc2c7d8-6d42-4702-8c59-aa7000a8670a	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+5.5
22095b3e-7b5d-480e-a0b7-aa7000a86746	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OU	Total Goals Over/Under	Total Goals	\N	\N	f	SOCCER:FT:OU_M#+4.5
8e4a2826-6c05-4804-92a7-aa7000a8678b	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB	Match Result	Match Result	\N	\N	f	SOCCER:FT:AXB_M
ddc5e58f-69af-478b-9c7b-aa7000a867f0	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
91ba917d-de45-41de-ad33-aa7000a8683d	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS	Both Teams to Score	Both Teams to Score	\N	\N	f	SOCCER:FT:BTS_M
c5a09bd2-6350-4d4d-82aa-aa7000a8687a	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:SPRD	Handicap {2}	Handicap {2}	\N	\N	f	SOCCER:FT:SPRD_M#-1.0
34ecd8bf-6739-4067-bd56-aa7000a868d1	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#+1.0
dae0d61c-d26d-4c4b-b6ca-aa7000a8693c	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-1.0
161b45df-6db9-4d70-8f66-aa7000a86991	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:3HCP	European Handicap {2}	European Handicap {2}	\N	\N	f	SOCCER:FT:3HCP_M#-2.0
d89e8d79-efe0-4523-b98d-aa7000a869e5	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£CS_1	Correct Score	Correct Score	\N	\N	f	SOCCER:FT:£CS_1_M
e6ea93f8-1677-4c34-9e8a-aa7000a86c73	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H1		1st Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H1#+0.5
dc5c63fd-4ff4-47dc-8c05-aa7000a86ca6	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H1		1st Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H1#+1.5
840c6df7-ca66-4d07-ba88-aa7000a86cdf	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H2		Second Half Correct Score	\N	\N	f	SOCCER:P:£CS_1_H2
ebae7078-67fe-4209-8d22-aa7000a86dd6	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£CS_1_H1		1st Half - Correct Score	\N	\N	f	SOCCER:P:£CS_1_H1
48b69a9b-dda5-4b4b-8742-aa7000a86ecf	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HTFT	Halftime/Fulltime	Halftime/Fulltime	\N	\N	f	SOCCER:FT:HTFT_M
12f3bc16-0ec9-4db5-9262-aa7000a86f9f	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H1		1st Half - 1X2	\N	\N	f	SOCCER:P:AXB_H1
6e7614ac-babf-4602-9b9e-aa7000a87006	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H1		1st Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H1
9a2a2c3b-3e0d-4f0f-a58f-aa7000a87076	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB_H2		2nd Half - 1X2	\N	\N	f	SOCCER:P:AXB_H2
0aeb8842-40c6-4443-b1ee-aa7000a870cc	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC_H2		2nd Half Double Chance	\N	\N	f	SOCCER:P:DBLC_H2
d44a6ca8-cfe0-4731-88aa-aa7000a8711f	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:NB	Away No Bet	Away No Bet	\N	\N	f	SOCCER:FT:B:NB_M
9ea57d12-4b05-4385-8712-aa7000a87163	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:NB	Home No Bet	Home No Bet	\N	\N	f	SOCCER:FT:A:NB_M
de79b621-17c9-4dd7-a034-aa7000a871b9	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:B:OU_H2		2nd Half Away Team - Over Under {0}	\N	\N	f	SOCCER:P:B:OU_H2#+0.5
9e6b8ca0-8b65-4898-8c24-aa7000a871f3	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:A:OU_H2		2nd Half Home Team - Over Under {0}	\N	\N	f	SOCCER:P:A:OU_H2#+1.5
4ec59b53-7516-4186-ab37-aa7000a87233	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
2bcf8872-5afb-4202-98c7-aa7000a87277	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:CLS	Clean sheet home team	Clean sheet home team	\N	\N	f	SOCCER:FT:A:CLS_M
60dbbe43-d89d-4cd8-a71e-aa7000a872be	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:CLS	Clean sheet away team	Clean sheet away team	\N	\N	f	SOCCER:FT:B:CLS_M
5ae56285-8384-443e-a223-aa7000a87314	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AWN	Home Win to Nil	Home Win to Nil	\N	\N	f	SOCCER:FT:AWN_M
c929da6e-ffe1-4c40-a7c4-aa7000a87353	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H1		First Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H1
139c16d4-cf10-4901-bb87-aa7000a87398	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+2.5
d6b4f97b-101d-42fd-8b00-aa7000a873e6	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+1.5
8c4512f0-b3df-4880-a5b2-aa7000a87429	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H1		1st Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H1#+0.5
17681076-a825-4ebd-b5eb-aa7000a8747a	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:BTS_H2		Second Half Both Teams to Score	\N	\N	f	SOCCER:P:BTS_H2
8fb0f63e-938e-47f9-aa55-aa7000a874b9	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+2.5
a8a2a438-bdbd-4fed-961f-aa7000a874f3	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+1.5
df085db6-a2ab-42bd-a9fa-aa7000a87533	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OU_H2		2nd Half - Totals {2}	\N	\N	f	SOCCER:P:OU_H2#+0.5
2ed26782-47ce-4f2b-94cf-aa7000a87575	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_1	Total Goals (exact)	Total Goals (exact)	\N	\N	f	SOCCER:FT:£OUR_1_M
c7f20ef1-a360-4657-9ea4-aa7000a87849	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H1		1st Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H1
46c4477f-3253-4838-b5c7-aa7000a8789d	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:£OUR_1_H2		2nd Half - Total Goals	\N	\N	f	SOCCER:P:£OUR_1_H2
cc6e37f9-6240-4875-b0e4-aa7000a878ef	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:OE	Odd/Even goals	Odd/Even goals	\N	\N	f	SOCCER:FT:OE_M
8bb0ecd5-2f2d-4c59-ab7e-aa7000a8795e	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H1		1st Half - Odd/Even Goals	\N	\N	f	SOCCER:P:OE_H1
3aa6206c-55ee-4607-a21c-aa7000a879a8	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:OE_H2		Second Half Total Goals Odd/Even	\N	\N	f	SOCCER:P:OE_H2
e41ecd83-88b2-4e16-9bdf-aa7000a879e7	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:TTS2H	Away to score in both halves?	Away to score in both halves?	\N	\N	f	SOCCER:FT:B:TTS2H_M
ae9ef4ab-73c9-488c-8d51-aa7000a87a27	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:TTS2H	Home to score in both halves?	Home to score in both halves?	\N	\N	f	SOCCER:FT:A:TTS2H_M
6f9a1a41-ea09-4880-bf28-aa7000a87a96	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:A:OU	Total Goals %1% %line%	Total Goals ФК Карлскрона 2.5	\N	\N	f	SOCCER:FT:A:OU_M#+2.5
f8104716-9cad-48c8-8a81-aa7000a87b13	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:FT:B:OU	Total Goals {1} {2}	Total Goals {1} {2}	\N	\N	f	SOCCER:FT:B:OU_M#+0.5
6a535827-d67e-47b2-a003-aa7000a87b7e	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:£OUR_1	Goals away team	Goals away team	\N	\N	f	SOCCER:FT:B:£OUR_1_M
e136d19f-5352-4dd2-8824-aa7000a87c2f	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:£OUR_1	Goals home team	Goals home team	\N	\N	f	SOCCER:FT:A:£OUR_1_M
5be4e386-129f-406f-b87e-aa7000a87c96	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£OUR_2	Total Goals (aggregated)	Total Goals (aggregated)	\N	\N	f	SOCCER:FT:£OUR_2_M
c3317e05-028f-44fc-8c81-aa7000a87d05	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:HSH	Highest scoring half	Highest scoring half	\N	\N	f	SOCCER:FT:HSH_M
d17bf49e-2502-419d-bcdf-aa7000a87d8d	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	t	t	\N	SOCCER:P:3HCP_H1		1st Half - European Handicap {2}	\N	\N	f	SOCCER:P:3HCP_H1#-1.0
84a42b03-e112-4c8f-a35d-aa7000a87dec	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:BH	Home to win both halves?	Home to win both halves?	\N	\N	f	SOCCER:FT:A:BH_M
fdc2461c-e8be-430a-8f38-aa7000a87e3c	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHU	Both halves under 1.5?	Both halves under 1.5?	\N	\N	f	SOCCER:FT:BHU_M
2181a23f-5805-454f-8104-aa7000a87e7a	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BHO	Both halves over 1.5?	Both halves over 1.5?	\N	\N	f	SOCCER:FT:BHO_M
d4afe5c4-877b-40ce-bf63-aa7000a87ee7	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+3.5
2cb5ad81-8405-4aeb-9e65-aa7000a87f7f	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+2.5
f2c80bfe-94ce-45f7-8b94-aa7000a88044	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+4.5
74be2285-b310-4d21-9653-aa7000a880e2	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB$OU	Matchbet + Totals {2}	Matchbet + Totals {2}	\N	\N	f	SOCCER:FT:AXB$OU_M#+1.5
83fd16ed-b9be-4e38-8146-aa7000a88213	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:HSH	Highest scoring half home team	Highest scoring half home team	\N	\N	f	SOCCER:FT:A:HSH_M
059aa3e5-ed85-40f8-aec0-aa7000a88271	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:EH	Home to win either half?	Home to win either half?	\N	\N	f	SOCCER:FT:A:EH_M
a94dc409-5caf-42a3-9728-aa7000a882ba	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:BTS$OU	Both Teams to Score + Totals {2}	Both Teams to Score + Totals {2}	\N	\N	f	SOCCER:FT:BTS$OU_M#+2.5
0e941709-e23e-4e14-af4d-aa7000a88343	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$2HBTS	Double Chance (match) and 2nd Half Both Teams to Score	Double Chance (match) and 2nd Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$2HBTS_M
c53d55c5-2fe3-4006-b634-aa7000a883de	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:£HTFTCS_1	Halftime/Fulltime Correct Score	Halftime/Fulltime Correct Score	\N	\N	f	SOCCER:FT:£HTFTCS_1_M
e92a642d-7c9f-454a-96c9-aa7000a88a22	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WTTS	Which team to score	Which team to score	\N	\N	f	SOCCER:FT:WTTS_M
26ccf8a4-95bf-48df-953e-aa7000a88a98	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:WM	Winning margins	Winning margins	\N	\N	f	SOCCER:FT:WM_M
15cc2b42-e090-46dc-8220-aa7000a88b6d	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MBTSC	Matchbet + Both Teams Score	Matchbet + Both Teams Score	\N	\N	f	SOCCER:FT:MBTSC_M
78094ba7-f7b2-4832-9c36-aa7000a88c0c	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$1HBTS	Double Chance (match) and 1st Half Both Teams to Score	Double Chance (match) and 1st Half Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$1HBTS_M
7c3c8755-f7b3-4716-9c1c-aa7000a88cc3	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H1		1st Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H1
101eef35-8e96-4730-bec8-aa7000a88d63	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:MLTG	Multigoals Awayteam	Multigoals Awayteam	\N	\N	f	SOCCER:FT:B:MLTG_M
c33a936f-b5a7-434a-9e48-aa7000a88e28	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H2		2nd Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H2
d12389a4-486d-4404-9d4e-aa7000a88e6a	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:OE	Odd / Even Away Team	Odd / Even Away Team	\N	\N	f	SOCCER:FT:B:OE_M
59b42541-a5c3-4134-9ab6-aa7000a88eaf	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:A:OE	Odd / Even Home Team	Odd / Even Home Team	\N	\N	f	SOCCER:FT:A:OE_M
f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:MLTG	Multigoals	Multigoals	\N	\N	f	SOCCER:FT:MLTG_M
fb5ca877-595d-4feb-8f05-aa7000a89384	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:HSH	Highest scoring half away team	Highest scoring half away team	\N	\N	f	SOCCER:FT:B:HSH_M
478b8d2e-6948-4775-b6eb-aa7000a893de	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DBLC$BTS_H1		1st Half - Double Chance and Both Teams to Score	\N	\N	f	SOCCER:P:DBLC$BTS_H1
e1d614a0-fa06-4836-b3ec-aa7000a894df	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$BTS	Double Chance and Both Teams to Score	Double Chance and Both Teams to Score	\N	\N	f	SOCCER:FT:DBLC$BTS_M
fa4c07fa-d08d-4a54-917f-aa7000a89599	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+3.5
e8bc3aaa-db43-4464-8030-aa7000a89656	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+2.5
514e7a2c-80e9-46e8-b16d-aa7000a89701	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+1.5
9461c0c0-8867-4834-8a0b-aa7000a897c6	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC$OU	Double Chance and Over/Under {2}	Double Chance and Over/Under {2}	\N	\N	f	SOCCER:FT:DBLC$OU_M#+4.5
80b72081-ab04-4c30-b7eb-aa7000a8988c	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:AXB$BTS_H2		2nd Half Matchbet + Both Teams Score	\N	\N	f	SOCCER:P:AXB$BTS_H2
58cae90a-3ca1-4852-98da-aa7000a89960	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:P:DNB_H1		1st Half Draw no Bet	\N	\N	f	SOCCER:P:DNB_H1
11211fa9-a0b2-427a-bcc7-aa7000a899a9	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:B:EH	Away to win either half?	Away to win either half?	\N	\N	f	SOCCER:FT:B:EH_M
31ed6a99-f86c-46a6-a682-aa7000a89a00	b1047e8a-811e-4116-a030-aa7000a899e1	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB	Match Result	Match Result	\N	\N	f	SOCCER:FT:AXB_M
545eaceb-138b-456b-b441-aa7000a89a71	b1047e8a-811e-4116-a030-aa7000a899e1	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
2e690cea-1c7a-4334-841c-aa7000a89adf	b1047e8a-811e-4116-a030-aa7000a899e1	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
8e786953-1da8-4e8f-b27f-aa7000a89b44	7d2b2470-78af-4d07-8d1b-aa7000a89b25	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DBLC	Double Chance	Double Chance	\N	\N	f	SOCCER:FT:DBLC_M
5526f50e-2d21-412a-94e0-aa7000a89bbe	7d2b2470-78af-4d07-8d1b-aa7000a89b25	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:AXB	Match Result	Match Result	\N	\N	f	SOCCER:FT:AXB_M
7541aaed-e471-4332-a2da-aa7000a89c37	7d2b2470-78af-4d07-8d1b-aa7000a89b25	f	\N	\N	\N	\N	\N	f	f	t	\N	SOCCER:FT:DNB	Draw no bet	Draw no bet	\N	\N	f	SOCCER:FT:DNB_M
\.


--
-- TOC entry 3128 (class 0 OID 16700)
-- Dependencies: 190
-- Data for Name: odds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY odds (id, market_id, short, clean, status, odd, handicap, displayed, code, "row", col, name, oddid) FROM stdin;
f37414ea-92af-4baf-8e4b-aa70008e668c	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	2-1	2-1	active	10.25		\N		1	1	2-1	5110223_12096950_46386319
2096da38-691a-4268-93e6-aa70008e79a6	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	1-0	1-0	active	6.2		\N		1	2	1-0	5110223_12096950_46386320
48121784-8847-4224-90af-aa70008e79ad	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	2-3	2-3	active	70		\N		1	3	2-3	5110223_12096950_46386321
77255db1-223f-48ee-af85-aa70008e79b4	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	1-4	1-4	active	125		\N		2	1	1-4	5110223_12096950_46386322
b056e5e7-943f-4f21-93dd-aa70008e79ba	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	2-2	2-2	active	20.5		\N		2	2	2-2	5110223_12096950_46386323
8c9a5a4a-3aa8-4f78-9ae1-aa70008e79c0	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	2-0	2-0	active	9.1		\N		2	3	2-0	5110223_12096950_46386324
2b28a1ef-dca7-45ad-a92d-aa70008e79c6	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	3-0	3-0	active	19.5		\N		3	1	3-0	5110223_12096950_46386325
33cad6d3-2eb1-4081-80e6-aa70008e79cd	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	1-2	1-2	active	15.5		\N		3	2	1-2	5110223_12096950_46386326
e6992f54-a269-4e95-861c-aa70008e79d4	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	0-4	0-4	active	150		\N		3	3	0-4	5110223_12096950_46386327
00eab7db-9729-47ee-b485-aa70008e79db	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	4-4	4-4	active	250		\N		4	1	4-4	5110223_12096950_46386328
09a8d175-f46b-408a-acbf-aa70008e79e2	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	3-4	3-4	active	250		\N		4	2	3-4	5110223_12096950_46386329
7e562d9f-2a7f-40b3-a557-aa70008e79e9	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	3-1	3-1	active	22.5		\N		4	3	3-1	5110223_12096950_46386330
696d892c-3cf0-4e60-836a-aa70008e79f1	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	3-2	3-2	active	50		\N		5	1	3-2	5110223_12096950_46386331
889c1bb7-3dee-4ef6-9e57-aa70008e79f9	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	4-0	4-0	active	55		\N		5	2	4-0	5110223_12096950_46386332
009dc24a-ff01-43ae-893d-aa70008e7a00	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	4-1	4-1	active	60		\N		5	3	4-1	5110223_12096950_46386333
aab3c983-e30a-47b5-80ff-aa70008e7a08	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	1-3	1-3	active	50		\N		6	1	1-3	5110223_12096950_46386334
e17952e2-6b76-41af-859f-aa70008e7a10	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	3-3	3-3	active	125		\N		6	2	3-3	5110223_12096950_46386335
dc1946f5-2b74-4261-a49a-aa70008e7a18	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	4-2	4-2	active	125		\N		6	3	4-2	5110223_12096950_46386336
83f6a16d-53b4-446e-9c55-aa70008e7a21	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	Any Other	M1	active	55		\N		7	1	Any Other	5110223_12096950_46386337
b4ececae-815d-4d08-abc8-aa70008e7a2d	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	0-0	0-0	active	7.35		\N		7	2	0-0	5110223_12096950_46386338
212aee7b-f385-4858-8435-aa70008e7a36	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	2-4	2-4	active	150		\N		7	3	2-4	5110223_12096950_46386339
bb04153b-97e6-411d-a68c-aa70008e7a41	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	0-3	0-3	active	70		\N		8	1	0-3	5110223_12096950_46386340
6847ff96-8cca-457f-8a26-aa70008e7a4a	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	1-1	1-1	active	6.25		\N		8	2	1-1	5110223_12096950_46386341
5175ddeb-318a-4c59-bcdc-aa70008e7a57	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	0-2	0-2	active	20.5		\N		8	3	0-2	5110223_12096950_46386342
1218edd6-b0cf-4968-b06a-aa70008e7a5f	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	4-3	4-3	active	200		\N		9	1	4-3	5110223_12096950_46386343
56aa1557-01f0-454e-8f8a-aa70008e7a66	9b90aa1c-a6d7-47cb-ba10-aa70008e5ab0	0-1	0-1	active	9.35		\N		9	2	0-1	5110223_12096950_46386344
9114d252-926c-45d4-b591-aa70008e7a75	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rc Deportivo La Coruna/Rc Deportivo La Coruna and over +3.5	A/AOver	active	11.75		\N		1	1	Rc Deportivo La Coruna/Rc Deportivo La Coruna and over +3.5	5110223_12096944_46386260
51cfce1c-4420-4aa5-976e-aa70008e7a7c	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rc Deportivo La Coruna/Rc Deportivo La Coruna and under +3.5	A/AUnder	active	4.45		\N		1	2	Rc Deportivo La Coruna/Rc Deportivo La Coruna and under +3.5	5110223_12096944_46386271
104ef9de-ee9f-431a-be6f-aa70008e7a83	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rc Deportivo La Coruna/Rcd Mallorca and over +3.5	A/BOver	active	100		\N		2	1	Rc Deportivo La Coruna/Rcd Mallorca and over +3.5	5110223_12096944_46386263
f6c4e742-128b-4ef3-a095-aa70008e7a8a	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rc Deportivo La Coruna/Rcd Mallorca and under +3.5	A/BUnder	active	90		\N		2	2	Rc Deportivo La Coruna/Rcd Mallorca and under +3.5	5110223_12096944_46386261
821cc840-e24f-4997-9e9f-aa70008e7a91	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rc Deportivo La Coruna/Draw and over +3.5	A/XOver	active	50		\N		3	1	Rc Deportivo La Coruna/Draw and over +3.5	5110223_12096944_46386262
b0dfc1e1-10d1-4ccf-847c-aa70008e7a98	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rc Deportivo La Coruna/Draw and under +3.5	A/XUnder	active	23.5		\N		3	2	Rc Deportivo La Coruna/Draw and under +3.5	5110223_12096944_46386273
53756459-879d-4ec4-9c81-aa70008e7a9f	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rcd Mallorca/Rc Deportivo La Coruna and over +3.5	B/AOver	active	90		\N		4	1	Rcd Mallorca/Rc Deportivo La Coruna and over +3.5	5110223_12096944_46386269
583e8e57-2429-4e12-ae95-aa70008e7aa6	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rcd Mallorca/Rc Deportivo La Coruna and under +3.5	B/AUnder	active	60		\N		4	2	Rcd Mallorca/Rc Deportivo La Coruna and under +3.5	5110223_12096944_46386268
93e237a0-d14a-4a94-8f0b-aa70008e7ab7	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rcd Mallorca/Rcd Mallorca and over +3.5	B/BOver	active	35		\N		5	1	Rcd Mallorca/Rcd Mallorca and over +3.5	5110223_12096944_46386270
c87eb97e-d4ef-41be-a51a-aa70008e7ac1	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rcd Mallorca/Rcd Mallorca and under +3.5	B/BUnder	active	8.55		\N		5	2	Rcd Mallorca/Rcd Mallorca and under +3.5	5110223_12096944_46386274
88f32686-a4a8-43dc-b8a9-aa70008e7aca	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rcd Mallorca/Draw and over +3.5	B/XOver	active	50		\N		6	1	Rcd Mallorca/Draw and over +3.5	5110223_12096944_46386259
39524002-b5bb-4c03-953e-aa70008e7ad3	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Rcd Mallorca/Draw and under +3.5	B/XUnder	active	24		\N		6	2	Rcd Mallorca/Draw and under +3.5	5110223_12096944_46386276
51efc240-07c4-429f-b7b1-aa70008e7adc	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Draw/{0} and over	X/AOver	active	40		\N		7	1	Draw/{0} and over	5110223_12096944_46386265
b4c3a822-3126-40cc-8ce1-aa70008e7ae3	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Draw/{0} and under	X/AUnder	active	5.55		\N		7	2	Draw/{0} and under	5110223_12096944_46386275
7baf40bd-8ece-4063-88e8-aa70008e7aeb	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Draw/Rcd Mallorca and over +3.5	X/BOver	active	80		\N		8	1	Draw/Rcd Mallorca and over +3.5	5110223_12096944_46386267
4d199002-0217-465d-b0d4-aa70008e7af2	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Draw/Rcd Mallorca and under +3.5	X/BUnder	active	9.1		\N		8	2	Draw/Rcd Mallorca and under +3.5	5110223_12096944_46386264
4e4f6f27-d269-4b85-b548-aa70008e7af9	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Draw/Draw and over	X/XOver	active	45		\N		9	1	Draw/Draw and over	5110223_12096944_46386266
749ec7cc-e2f1-4274-a806-aa70008e7b00	d1d5b2eb-bce5-4237-af2e-aa70008e7a6d	Draw/Draw and under	X/XUnder	active	4.55		\N		9	2	Draw/Draw and under	5110223_12096944_46386272
aa7c6329-1787-4004-82da-aa70008e7b0d	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rc Deportivo La Coruna/Rc Deportivo La Coruna and over +2.5	A/AOver	active	5.95		\N		1	1	Rc Deportivo La Coruna/Rc Deportivo La Coruna and over +2.5	5110223_12096942_46386226
8b4a83fa-6657-484e-8130-aa70008e7b14	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rc Deportivo La Coruna/Rc Deportivo La Coruna and under +2.5	A/AUnder	active	7.05		\N		1	2	Rc Deportivo La Coruna/Rc Deportivo La Coruna and under +2.5	5110223_12096942_46386239
2b41764a-3277-4cf0-8839-aa70008e7b1c	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rc Deportivo La Coruna/Rcd Mallorca and over +2.5	A/BOver	active	60		\N		2	1	Rc Deportivo La Coruna/Rcd Mallorca and over +2.5	5110223_12096942_46386227
8cfa9e9e-5b3d-474d-97f9-aa70008e7b23	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rc Deportivo La Coruna/Draw and under +2.5	A/XUnder	active	23.5		\N		2	2	Rc Deportivo La Coruna/Draw and under +2.5	5110223_12096942_46386240
e845f8b1-476c-4a90-abc4-aa70008e7b2a	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rc Deportivo La Coruna/Draw and over +2.5	A/XOver	active	50		\N		3	1	Rc Deportivo La Coruna/Draw and over +2.5	5110223_12096942_46386225
ba4d77bb-cacd-4fda-9fc5-aa70008e7b32	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rcd Mallorca/Rc Deportivo La Coruna and over +2.5	B/AOver	active	40		\N		4	1	Rcd Mallorca/Rc Deportivo La Coruna and over +2.5	5110223_12096942_46386235
5bdc5f23-fa07-4101-aedc-aa70008e7b3a	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rcd Mallorca/Rcd Mallorca and under +2.5	B/BUnder	active	13		\N		4	2	Rcd Mallorca/Rcd Mallorca and under +2.5	5110223_12096942_46386228
ecb93ba6-0db3-4cce-ab57-aa70008e7b41	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rcd Mallorca/Rcd Mallorca and over +2.5	B/BOver	active	14		\N		5	1	Rcd Mallorca/Rcd Mallorca and over +2.5	5110223_12096942_46386238
5fa08c1f-8a36-42cc-be28-aa70008e7b47	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rcd Mallorca/Draw and under +2.5	B/XUnder	active	24		\N		5	2	Rcd Mallorca/Draw and under +2.5	5110223_12096942_46386237
0906e43c-3f9f-47dd-9f5a-aa70008e7b4f	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Rcd Mallorca/Draw and over +2.5	B/XOver	active	50		\N		6	1	Rcd Mallorca/Draw and over +2.5	5110223_12096942_46386236
184ab0fb-1ecb-4ee4-b00b-aa70008e7b56	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Draw/{0} and under	X/AUnder	active	7.35		\N		6	2	Draw/{0} and under	5110223_12096942_46386229
1d0cf3d6-0eeb-4abf-9d60-aa70008e7b5e	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Draw/{0} and over	X/AOver	active	13.75		\N		7	1	Draw/{0} and over	5110223_12096942_46386231
a64fa1f1-1382-4ecf-9d20-aa70008e7b66	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Draw/Rcd Mallorca and under +2.5	X/BUnder	active	12		\N		7	2	Draw/Rcd Mallorca and under +2.5	5110223_12096942_46386230
cb70596d-5e0e-4c58-aaa1-aa70008e7b6e	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Draw/Rcd Mallorca and over +2.5	X/BOver	active	24.5		\N		8	1	Draw/Rcd Mallorca and over +2.5	5110223_12096942_46386233
8dee284d-54af-47ce-8a93-aa70008e7b88	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Draw/Draw and under	X/XUnder	active	4.55		\N		8	2	Draw/Draw and under	5110223_12096942_46386234
9c2c9887-60e5-46cd-b803-aa70008e7b9a	f2276898-ddaa-4b2e-a4a5-aa70008e7b06	Draw/Draw and over	X/XOver	active	45		\N		9	1	Draw/Draw and over	5110223_12096942_46386232
b750c12f-ff22-4b97-a5fc-aa70008e7bbd	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Rc Deportivo La Coruna/Rc Deportivo La Coruna and over +1.5	A/AOver	active	4.2		\N		1	1	Rc Deportivo La Coruna/Rc Deportivo La Coruna and over +1.5	5110223_12096940_46386196
7e07834c-5daf-4112-9163-aa70008e7bc4	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Rc Deportivo La Coruna/Rc Deportivo La Coruna and under +1.5	A/AUnder	active	14.25		\N		1	2	Rc Deportivo La Coruna/Rc Deportivo La Coruna and under +1.5	5110223_12096940_46386206
9013e251-ecdc-4ef9-841e-aa70008e7bcc	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Rc Deportivo La Coruna/Rcd Mallorca and over +1.5	A/BOver	active	60		\N		2	1	Rc Deportivo La Coruna/Rcd Mallorca and over +1.5	5110223_12096940_46386197
9c20be2a-8d48-4552-9929-aa70008e7bd4	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Rc Deportivo La Coruna/Draw and over +1.5	A/XOver	active	16.5		\N		3	1	Rc Deportivo La Coruna/Draw and over +1.5	5110223_12096940_46386195
5c71746e-de2b-4d9f-85a3-aa70008e7bdc	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Rcd Mallorca/Rc Deportivo La Coruna and over +1.5	B/AOver	active	40		\N		4	1	Rcd Mallorca/Rc Deportivo La Coruna and over +1.5	5110223_12096940_46386203
1dbce0b1-56bc-4a42-9ff3-aa70008e7be4	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Rcd Mallorca/Rcd Mallorca and under +1.5	B/BUnder	active	22		\N		4	2	Rcd Mallorca/Rcd Mallorca and under +1.5	5110223_12096940_46386202
baebe430-4d27-4013-abfc-aa70008e7bed	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Rcd Mallorca/Rcd Mallorca and over +1.5	B/BOver	active	9.75		\N		5	1	Rcd Mallorca/Rcd Mallorca and over +1.5	5110223_12096940_46386205
e0e11a02-3a00-4140-90ed-aa70008e7bf5	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Rcd Mallorca/Draw and over +1.5	B/XOver	active	16.75		\N		6	1	Rcd Mallorca/Draw and over +1.5	5110223_12096940_46386204
5f51a2f2-6b2f-4d92-8fcb-aa70008e7bfd	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Draw/{0} and under	X/AUnder	active	9.95		\N		6	2	Draw/{0} and under	5110223_12096940_46386208
77ccb345-5e64-4267-838c-aa70008e7c05	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Draw/{0} and over	X/AOver	active	9.15		\N		7	1	Draw/{0} and over	5110223_12096940_46386198
4a595d51-a812-4ea7-9641-aa70008e7c0d	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Draw/Rcd Mallorca and under +1.5	X/BUnder	active	14.75		\N		7	2	Draw/Rcd Mallorca and under +1.5	5110223_12096940_46386207
fcad90eb-6d2a-4cea-843c-aa70008e7c15	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Draw/Rcd Mallorca and over +1.5	X/BOver	active	17.5		\N		8	1	Draw/Rcd Mallorca and over +1.5	5110223_12096940_46386201
d944bcca-bdd2-4365-bbf7-aa70008e7c1d	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Draw/Draw and under	X/XUnder	active	7.15		\N		8	2	Draw/Draw and under	5110223_12096940_46386199
bc175e05-685d-471e-8a77-aa70008e7c24	a9264bef-dcb6-446e-98c8-aa70008e7bb4	Draw/Draw and over	X/XOver	active	9.4		\N		9	1	Draw/Draw and over	5110223_12096940_46386200
07b6cec0-87fa-47a5-8a2a-aa70008e7c35	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rc Deportivo La Coruna/Rc Deportivo La Coruna and over +4.5	A/AOver	active	24.5		\N		1	1	Rc Deportivo La Coruna/Rc Deportivo La Coruna and over +4.5	5110223_12096938_46386164
2790c94c-7d69-4418-8eda-aa70008e7c3e	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rc Deportivo La Coruna/Rc Deportivo La Coruna and under +4.5	A/AUnder	active	3.8		\N		1	2	Rc Deportivo La Coruna/Rc Deportivo La Coruna and under +4.5	5110223_12096938_46386177
cb14b30c-cb53-420a-a282-aa70008e7c46	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rc Deportivo La Coruna/Rcd Mallorca and over +4.5	A/BOver	active	125		\N		2	1	Rc Deportivo La Coruna/Rcd Mallorca and over +4.5	5110223_12096938_46386165
f8764599-a3c6-4bf2-9ced-aa70008e7c50	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rc Deportivo La Coruna/Rcd Mallorca and under +4.5	A/BUnder	active	80		\N		2	2	Rc Deportivo La Coruna/Rcd Mallorca and under +4.5	5110223_12096938_46386174
f878225b-9197-4102-b8f6-aa70008e7c58	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rc Deportivo La Coruna/Draw and over +4.5	A/XOver	active	150		\N		3	1	Rc Deportivo La Coruna/Draw and over +4.5	5110223_12096938_46386163
46e7b08d-61c9-480c-aa7f-aa70008e7c60	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rc Deportivo La Coruna/Draw and under +4.5	A/XUnder	active	17.25		\N		3	2	Rc Deportivo La Coruna/Draw and under +4.5	5110223_12096938_46386179
58b5a7d5-887f-403c-90f4-aa70008e7c68	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rcd Mallorca/Rc Deportivo La Coruna and over +4.5	B/AOver	active	90		\N		4	1	Rcd Mallorca/Rc Deportivo La Coruna and over +4.5	5110223_12096938_46386171
12a9789d-45f8-4286-8b86-aa70008e7c70	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rcd Mallorca/Rc Deportivo La Coruna and under +4.5	B/AUnder	active	50		\N		4	2	Rcd Mallorca/Rc Deportivo La Coruna and under +4.5	5110223_12096938_46386176
5eba4cf7-c26b-47f1-8edc-aa70008e7c77	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rcd Mallorca/Rcd Mallorca and over +4.5	B/BOver	active	70		\N		5	1	Rcd Mallorca/Rcd Mallorca and over +4.5	5110223_12096938_46386175
5345444c-812f-498e-ad0f-aa70008e7c7f	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rcd Mallorca/Rcd Mallorca and under +4.5	B/BUnder	active	7.65		\N		5	2	Rcd Mallorca/Rcd Mallorca and under +4.5	5110223_12096938_46386168
24e4bace-704b-43b0-bb16-aa70008e7c88	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rcd Mallorca/Draw and over +4.5	B/XOver	active	150		\N		6	1	Rcd Mallorca/Draw and over +4.5	5110223_12096938_46386172
f2afff73-4473-4798-9189-aa70008e7c8f	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Rcd Mallorca/Draw and under +4.5	B/XUnder	active	17.75		\N		6	2	Rcd Mallorca/Draw and under +4.5	5110223_12096938_46386180
1a51f223-908c-46eb-b336-aa70008e7c98	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Draw/{0} and over	X/AOver	active	80		\N		7	1	Draw/{0} and over	5110223_12096938_46386166
9e1f4f72-643d-45a5-8c06-aa70008e7ca1	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Draw/{0} and under	X/AUnder	active	5.2		\N		7	2	Draw/{0} and under	5110223_12096938_46386178
c5f037d0-3c83-435a-a5b1-aa70008e7ca9	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Draw/Rcd Mallorca and over +4.5	X/BOver	active	90		\N		8	1	Draw/Rcd Mallorca and over +4.5	5110223_12096938_46386169
0294f489-2d3d-4929-b7ef-aa70008e7cb0	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Draw/Rcd Mallorca and under +4.5	X/BUnder	active	8.75		\N		8	2	Draw/Rcd Mallorca and under +4.5	5110223_12096938_46386173
aa13b74f-0a4e-4e24-950c-aa70008e7cb9	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Draw/Draw and over	X/XOver	active	200		\N		9	1	Draw/Draw and over	5110223_12096938_46386167
a439759e-b7f0-4ab8-8197-aa70008e7cc0	0f3305b9-22ef-4e9c-b987-aa70008e7c2d	Draw/Draw and under	X/XUnder	active	4.25		\N		9	2	Draw/Draw and under	5110223_12096938_46386170
1d55fdeb-4951-4be2-b69d-aa70008e7cd1	21d9db7a-ea41-43ba-a31b-aa70008e7cc9	0	0	active	2.18		\N		1	1	0	5110223_12096934_46386135
0084ae6f-664c-47ad-a32d-aa70008e7ce7	21d9db7a-ea41-43ba-a31b-aa70008e7cc9	1	1	active	2.39		\N		1	2	1	5110223_12096934_46386136
708fc5e6-60e0-460a-95b0-aa70008e7cf2	21d9db7a-ea41-43ba-a31b-aa70008e7cc9	2	2	active	4.55		\N		1	3	2	5110223_12096934_46386137
2d37094a-a68e-4488-8263-aa70008e7d06	21d9db7a-ea41-43ba-a31b-aa70008e7cc9	3+	3+	active	9.7		\N		2	1	3+	5110223_12096934_46386138
61b93847-220e-4644-8712-aa70008e7d1e	6d7be262-b7aa-41d9-94b6-aa70008e7d16	Yes	Yes	active	1.75		\N		1	1	Yes	5110223_12096817_46385486
d2a0ca2d-e6c5-4ffe-8b38-aa70008e7d26	6d7be262-b7aa-41d9-94b6-aa70008e7d16	No	No	active	1.59		\N		1	2	No	5110223_12096817_46385488
3113ee7e-f429-4fa9-bdeb-aa70008e7d37	8ef3a8be-b878-4802-8111-aa70008e7d2d	Under 0.5	Under	active	1.99		\N		1	1	Under 0.5	5110223_12096746_46385281
e5687a96-b7f5-4527-b042-aa70008e7d3f	8ef3a8be-b878-4802-8111-aa70008e7d2d	Over 0.5	Over	active	1.44		\N		1	2	Over 0.5	5110223_12096746_46385279
a65fddbb-d63a-4fc7-b7e4-aa70008e7d4f	b1c44b89-d10e-454a-8d9d-aa70008e7d47	Депортиво Ла Коруня -0.5	AH	active	1.78		\N		1	1	Депортиво Ла Коруня -0.5	5110223_12096736_46385253
db1ab19e-4e6b-4da5-9b15-aa70008e7d62	b1c44b89-d10e-454a-8d9d-aa70008e7d47	РКД Майорка +0.5	BH	active	1.57		\N		1	2	РКД Майорка +0.5	5110223_12096736_46385254
f363a431-1564-4d3b-b3a5-aa70008e7d76	d83ff120-60c3-4ac5-a9a6-aa70008e7d6c	Депортиво Ла Коруня -0.25	AH	active	1.56		\N		1	1	Депортиво Ла Коруня -0.25	5110223_12096733_46385245
23cf8ba3-990f-4a54-8c97-aa70008e7d80	d83ff120-60c3-4ac5-a9a6-aa70008e7d6c	РКД Майорка +0.25	BH	active	1.79		\N		1	2	РКД Майорка +0.25	5110223_12096733_46385246
5193d667-7251-4d34-8a93-aa70008e7d91	b67d1774-754a-4e39-9bba-aa70008e7d87	Депортиво Ла Коруня -0.75	AH	active	2.04		\N		1	1	Депортиво Ла Коруня -0.75	5110223_12096729_46385235
30ad087a-fef4-4eab-b513-aa70008e7d9b	b67d1774-754a-4e39-9bba-aa70008e7d87	РКД Майорка +0.75	BH	active	1.41		\N		1	2	РКД Майорка +0.75	5110223_12096729_46385237
ea5cd7c5-ed36-462b-8e30-aa70008e7dab	e53c0f5c-be68-4550-8f9c-aa70008e7da3	Депортиво Ла Коруня 0	AH	active	1.32		\N		1	1	Депортиво Ла Коруня 0	5110223_12096726_46385228
ca81f4bc-d68f-4c12-ae9c-aa70008e7db3	e53c0f5c-be68-4550-8f9c-aa70008e7da3	РКД Майорка 0	BH	active	2.26		\N		1	2	РКД Майорка 0	5110223_12096726_46385230
7e2f8171-8d32-4764-98e3-aa70008e7dc2	4db3d418-b7e5-4850-aadf-aa70008e7dbb	Депортиво Ла Коруня -1	AH	active	2.53		\N		1	1	Депортиво Ла Коруня -1	5110223_12096721_46385219
42e9cb08-ab2f-4d37-9603-aa70008e7dca	4db3d418-b7e5-4850-aadf-aa70008e7dbb	РКД Майорка +1	BH	active	1.24		\N		1	2	РКД Майорка +1	5110223_12096721_46385222
108ed192-49a1-4f35-882e-aa70008e7ddb	862f4806-cadc-4ec0-b1a1-aa70008e7dd3	No/No	NN	active	1.32		\N		1	1	No/No	5110223_12096698_46385169
301d720b-bcfe-4371-afd2-aa70008e7de2	862f4806-cadc-4ec0-b1a1-aa70008e7dd3	Yes/No	YN	active	6.4		\N		1	2	Yes/No	5110223_12096698_46385170
c0a7a8aa-8c74-4626-b5f8-aa70008e7dea	862f4806-cadc-4ec0-b1a1-aa70008e7dd3	Yes/Yes	YY	active	24.5		\N		1	3	Yes/Yes	5110223_12096698_46385171
cc707585-6632-4da5-a8c0-aa70008e7df2	862f4806-cadc-4ec0-b1a1-aa70008e7dd3	No/Yes	NY	active	4.15		\N		2	1	No/Yes	5110223_12096698_46385172
8d1639c2-b1b4-4708-a97b-aa70008e7e01	9c35c6dc-40c2-45e6-a2dd-aa70008e7df9	Yes	Yes	active	1.28		\N		1	1	Yes	5110223_12096678_46385126
da8f0c4e-62c5-4e30-8226-aa70008e7e09	9c35c6dc-40c2-45e6-a2dd-aa70008e7df9	No	No	active	2.4		\N		1	2	No	5110223_12096678_46385128
4d4905fa-dd2e-4dfd-a9a1-aa70008e7e1a	b825dc79-387c-4787-be4b-aa70008e7e11	Under 0.75	Under	active	1.72		\N		1	1	Under 0.75	5110223_12096739_46385264
a5f75c5f-18b6-4cc9-826c-aa70008e7e23	b825dc79-387c-4787-be4b-aa70008e7e11	Over 0.75	Over	active	1.61		\N		1	2	Over 0.75	5110223_12096739_46385262
9ce6b942-d090-4df7-ad6d-aa70008e7e36	68cf1f44-b13a-4c76-8e84-aa70008e7e2b	Under 1	Under	active	1.43		\N		1	1	Under 1	5110223_12096743_46385272
a1ba34e5-fe2e-4cb9-bbe2-aa70008e7e4b	68cf1f44-b13a-4c76-8e84-aa70008e7e2b	Over 1	Over	active	2		\N		1	2	Over 1	5110223_12096743_46385271
b185186e-978b-4bef-8de8-aa70008e7e6d	8cedba29-cc25-4a60-84ff-aa70008e7e63	Under 3.5	Under	active	1.11		\N		1	1	Under 3.5	5110223_12096778_46385374
b34c2917-6c0a-4481-a344-aa70008e7e76	8cedba29-cc25-4a60-84ff-aa70008e7e63	Over 3.5	Over	active	3.45		\N		1	2	Over 3.5	5110223_12096778_46385373
726e25a2-2517-4f4e-923c-aa70008e7e85	c0f5bcc8-f882-4322-8229-aa70008e7e7d	Under 2.5	Under	active	1.38		\N		1	1	Under 2.5	5110223_12096774_46385365
0cd0a956-f247-40e0-9144-aa70008e7e8e	c0f5bcc8-f882-4322-8229-aa70008e7e7d	Over 2.5	Over	active	2.1		\N		1	2	Over 2.5	5110223_12096774_46385363
8abced40-39a5-4e30-8558-aa70008e7e9f	5e95c7e2-babe-458c-b5d6-aa70008e7e97	Under 1.5	Under	active	2.22		\N		1	1	Under 1.5	5110223_12096771_46385355
d09a20c3-0b3d-4d78-9692-aa70008e7ea8	5e95c7e2-babe-458c-b5d6-aa70008e7e97	Over 1.5	Over	active	1.34		\N		1	2	Over 1.5	5110223_12096771_46385354
ed24349f-72c4-481b-8d01-aa70008e7eba	54433b52-5d23-482b-95cc-aa70008e7eb1	Under 0.5	Under	active	7.35		\N		1	1	Under 0.5	5110223_12096768_46385346
e4780a57-ce4e-477d-a029-aa70008e7ec1	54433b52-5d23-482b-95cc-aa70008e7eb1	Over 0.5	Over	active	1.03		\N		1	2	Over 0.5	5110223_12096768_46385345
404ed1c5-8402-4e2f-9309-aa70008e7ed0	209576c0-5ab6-4789-b92f-aa70008e7ec8	Under 4.5	Under	active	1.01		\N		1	1	Under 4.5	5110223_12096764_46385338
1bdb1a58-4d06-4620-8c5e-aa70008e7ed8	209576c0-5ab6-4789-b92f-aa70008e7ec8	Over 4.5	Over	active	5		\N		1	2	Over 4.5	5110223_12096764_46385336
559155d6-4293-4017-bec8-aa70008e7ee8	ea86ef21-78cc-44a5-8178-aa70008e7ee0	Under 5.5	Under	active	1.01		\N		1	1	Under 5.5	5110223_12119797_46465905
1700826e-483b-4ff3-8999-aa70008e7ef1	ea86ef21-78cc-44a5-8178-aa70008e7ee0	Over 5.5	Over	active	5.5		\N		1	2	Over 5.5	5110223_12119797_46465904
e91df220-cb71-4625-8002-aa70008e7f01	79713c4d-c4ae-4be8-b26e-aa70008e7ef9	Депортиво Ла Коруня or Draw	AX	active	1.2		\N		1	1	Депортиво Ла Коруня or Draw	5110223_12096650_46385047
7b5f8a5b-aef5-463f-971e-aa70008e7f0c	79713c4d-c4ae-4be8-b26e-aa70008e7ef9	Депортиво Ла Коруня or РКД Майорка	AB	active	1.29		\N		1	2	Депортиво Ла Коруня or РКД Майорка	5110223_12096650_46385048
b94f73ef-9102-4238-a7a7-aa70008e7f14	79713c4d-c4ae-4be8-b26e-aa70008e7ef9	Draw or РКД Майорка	BX	active	1.57		\N		1	3	Draw or РКД Майорка	5110223_12096650_46385049
1468ac21-fe90-43c6-b2ed-aa70008e7f24	02220054-9961-47c1-93ff-aa70008e7f1c	Rc Deportivo La Coruna	A	active	1.87		\N		1	1	Rc Deportivo La Coruna	5110223_12091369_46365088
c4f1301d-2e9e-44cc-8e45-aa70008e7f2d	02220054-9961-47c1-93ff-aa70008e7f1c	Draw	X	active	2.7		\N		1	2	Draw	5110223_12091369_46365089
cb8a5b93-2a77-489a-9818-aa70008e7f36	02220054-9961-47c1-93ff-aa70008e7f1c	РКД Майорка	B	active	3.4		\N		1	3	РКД Майорка	5110223_12091369_46365090
c546756f-57d5-4846-b482-aa70008e7f44	62462a7b-e865-444a-a616-aa70008e7f3d	Yes	Yes	active	1.85		\N		1	1	Yes	5110223_12096964_46386389
c7cc213f-18cf-41ab-b3f9-aa70008e7f4c	62462a7b-e865-444a-a616-aa70008e7f3d	No	No	active	1.52		\N		1	2	No	5110223_12096964_46386390
7ed2a35a-a0e5-403b-813e-aa70008e7f5d	9569d076-2108-4836-b9c4-aa70008e7f54	Депортиво Ла Коруня -1	AH	active	3.6		\N		1	1	Депортиво Ла Коруня -1	5110223_12096936_46386142
73ba6ec0-fd07-47c0-8081-aa70008e7f65	9569d076-2108-4836-b9c4-aa70008e7f54	Draw sigendLine	XH	active	3.25		\N		1	2	Draw sigendLine	5110223_12096936_46386143
703a5ec8-f028-45d3-952b-aa70008e7f6d	9569d076-2108-4836-b9c4-aa70008e7f54	РКД Майорка +1	BH	active	1.62		\N		1	3	РКД Майорка +1	5110223_12096936_46386144
223ee4fe-3268-429e-b19f-aa70008e7f7b	eaccb105-f144-434c-a5ab-aa70008e7f74	Депортиво Ла Коруня +2	AH	active	1.02		\N		1	1	Депортиво Ла Коруня +2	5110223_12096761_46385325
aa247b6d-94b8-425a-a6f3-aa70008e7f82	eaccb105-f144-434c-a5ab-aa70008e7f74	Draw sigendLine	XH	active	7.25		\N		1	2	Draw sigendLine	5110223_12096761_46385328
5029ee38-f764-4677-9bbe-aa70008e7f8a	eaccb105-f144-434c-a5ab-aa70008e7f74	РКД Майорка -2	BH	active	20		\N		1	3	РКД Майорка -2	5110223_12096761_46385329
ffffa470-2785-4c4f-bf57-aa70008e7fa4	4eb95220-893f-4945-bba5-aa70008e7f92	Депортиво Ла Коруня +1	AH	active	1.19		\N		1	1	Депортиво Ла Коруня +1	5110223_12096757_46385315
a179dff8-dcb5-4071-aa17-aa70008e7fc6	4eb95220-893f-4945-bba5-aa70008e7f92	Draw sigendLine	XH	active	4.3		\N		1	2	Draw sigendLine	5110223_12096757_46385316
0b26fa81-954a-4f48-a901-aa70008e7fd0	4eb95220-893f-4945-bba5-aa70008e7f92	РКД Майорка -1	BH	active	8		\N		1	3	РКД Майорка -1	5110223_12096757_46385318
0c71d6ae-1002-4356-9d32-aa70008e7fdf	b09340f0-cf25-44a0-95f9-aa70008e7fd7	Депортиво Ла Коруня -1	AH	active	3.6		\N		1	1	Депортиво Ла Коруня -1	5110223_12096754_46385304
cc8f9f22-7ce1-4e94-bea3-aa70008e7fe6	b09340f0-cf25-44a0-95f9-aa70008e7fd7	Draw sigendLine	XH	active	3.25		\N		1	2	Draw sigendLine	5110223_12096754_46385305
823fc4f2-7919-4fdb-a2ad-aa70008e7fee	b09340f0-cf25-44a0-95f9-aa70008e7fd7	РКД Майорка +1	BH	active	1.62		\N		1	3	РКД Майорка +1	5110223_12096754_46385307
7dc68426-3cff-4c13-bbeb-aa70008e7ffe	b5bc9032-956d-4d9c-b9be-aa70008e7ff6	Депортиво Ла Коруня -2	AH	active	7.7		\N		1	1	Депортиво Ла Коруня -2	5110223_12096749_46385289
79785b96-8551-4716-9b7a-aa70008e8007	b5bc9032-956d-4d9c-b9be-aa70008e7ff6	Draw sigendLine	XH	active	4.8		\N		1	2	Draw sigendLine	5110223_12096749_46385291
a2f5630f-e7a1-4708-a0d0-aa70008e8010	b5bc9032-956d-4d9c-b9be-aa70008e7ff6	РКД Майорка +2	BH	active	1.16		\N		1	3	РКД Майорка +2	5110223_12096749_46385293
d3beddf2-5b6b-49c5-a5e0-aa70008e8020	5eb276b2-6184-4809-ac01-aa70008e8019	2-1	2-1	active	10.25		\N		1	1	2-1	5110223_12096902_46385906
538629f3-8601-43f3-b2e7-aa70008e8029	5eb276b2-6184-4809-ac01-aa70008e8019	1-0	1-0	active	6.2		\N		1	2	1-0	5110223_12096902_46385907
ebeb3a4f-2230-4508-ae32-aa70008e8030	5eb276b2-6184-4809-ac01-aa70008e8019	2-0	2-0	active	9.1		\N		1	3	2-0	5110223_12096902_46385908
462411bb-2dd2-4bca-8c68-aa70008e8038	5eb276b2-6184-4809-ac01-aa70008e8019	0-6	0-6	active	250		\N		2	1	0-6	5110223_12096902_46385909
e5ec55c3-47c7-42bb-b404-aa70008e8040	5eb276b2-6184-4809-ac01-aa70008e8019	3-0	3-0	active	20		\N		2	2	3-0	5110223_12096902_46385910
782dae58-3395-4627-880d-aa70008e8048	5eb276b2-6184-4809-ac01-aa70008e8019	3-1	3-1	active	22.5		\N		2	3	3-1	5110223_12096902_46385911
555d2d76-a4f0-4098-9c7c-aa70008e8050	5eb276b2-6184-4809-ac01-aa70008e8019	6-0	6-0	active	250		\N		3	1	6-0	5110223_12096902_46385912
215b02fb-1ab3-48d5-9945-aa70008e805a	5eb276b2-6184-4809-ac01-aa70008e8019	3-3	3-3	active	125		\N		3	2	3-3	5110223_12096902_46385913
0d009930-cc5e-49cb-80ca-aa70008e8062	5eb276b2-6184-4809-ac01-aa70008e8019	1-1	1-1	active	6.25		\N		3	3	1-1	5110223_12096902_46385914
d7f3b81b-64cb-4f47-8c46-aa70008e806a	5eb276b2-6184-4809-ac01-aa70008e8019	1-2	1-2	active	15.75		\N		4	1	1-2	5110223_12096902_46385915
a49414c6-6672-43f8-ba71-aa70008e8073	5eb276b2-6184-4809-ac01-aa70008e8019	1-3	1-3	active	50		\N		4	2	1-3	5110223_12096902_46385916
dbb1865d-6818-40f6-8371-aa70008e807c	5eb276b2-6184-4809-ac01-aa70008e8019	3-2	3-2	active	50		\N		4	3	3-2	5110223_12096902_46385917
443c35fa-dacf-4478-8b9c-aa70008e8084	5eb276b2-6184-4809-ac01-aa70008e8019	1-4	1-4	active	150		\N		5	1	1-4	5110223_12096902_46385918
22e5f1ee-c5c5-4d25-817e-aa70008e808b	5eb276b2-6184-4809-ac01-aa70008e8019	4-0	4-0	active	55		\N		5	2	4-0	5110223_12096902_46385919
0a4329b9-f787-4fed-8206-aa70008e8093	5eb276b2-6184-4809-ac01-aa70008e8019	4-1	4-1	active	70		\N		5	3	4-1	5110223_12096902_46385920
ecca9fa0-3343-44bb-a1df-aa70008e809a	5eb276b2-6184-4809-ac01-aa70008e8019	0-2	0-2	active	21		\N		6	1	0-2	5110223_12096902_46385921
790ed592-20ff-4f76-b754-aa70008e80a0	5eb276b2-6184-4809-ac01-aa70008e8019	4-2	4-2	active	125		\N		6	2	4-2	5110223_12096902_46385922
a55ad693-5acc-4ed1-a631-aa70008e80a7	5eb276b2-6184-4809-ac01-aa70008e8019	0-5	0-5	active	250		\N		6	3	0-5	5110223_12096902_46385923
4b03f9d3-8c3b-4986-b24c-aa70008e80b0	5eb276b2-6184-4809-ac01-aa70008e8019	5-0	5-0	active	150		\N		7	1	5-0	5110223_12096902_46385924
27be4c1a-e64d-48d4-924c-aa70008e80b7	5eb276b2-6184-4809-ac01-aa70008e8019	0-1	0-1	active	9.35		\N		7	2	0-1	5110223_12096902_46385925
cb5c5c5c-300b-4ab4-9a0b-aa70008e80c0	5eb276b2-6184-4809-ac01-aa70008e8019	0-3	0-3	active	70		\N		7	3	0-3	5110223_12096902_46385926
b46c883e-958b-44a1-90a0-aa70008e80c9	5eb276b2-6184-4809-ac01-aa70008e8019	2-3	2-3	active	80		\N		8	1	2-3	5110223_12096902_46385927
1649b5fc-bb4c-4a14-8be8-aa70008e80d4	5eb276b2-6184-4809-ac01-aa70008e8019	0-0	0-0	active	7.35		\N		8	2	0-0	5110223_12096902_46385928
ac8dc0a1-3070-4a86-9795-aa70008e80dd	5eb276b2-6184-4809-ac01-aa70008e8019	2-2	2-2	active	20.5		\N		8	3	2-2	5110223_12096902_46385929
8554c9b9-94a2-474b-bcc5-aa70008e80e5	5eb276b2-6184-4809-ac01-aa70008e8019	2-4	2-4	active	200		\N		9	1	2-4	5110223_12096902_46385930
586592bb-8828-4a1f-9ae2-aa70008e80f0	5eb276b2-6184-4809-ac01-aa70008e8019	1-5	1-5	active	250		\N		9	2	1-5	5110223_12096902_46385931
1e55f8bc-2f74-45b7-baaa-aa70008e8108	5eb276b2-6184-4809-ac01-aa70008e8019	Any Other	M1	active	100		\N		9	3	Any Other	5110223_12096902_46385932
acfc9c1a-fbc2-4386-b803-aa70008e8120	5eb276b2-6184-4809-ac01-aa70008e8019	0-4	0-4	active	150		\N		10	1	0-4	5110223_12096902_46385933
504f2c51-c337-461d-8125-aa70008e812c	5eb276b2-6184-4809-ac01-aa70008e8019	5-1	5-1	active	150		\N		10	2	5-1	5110223_12096902_46385934
d5f1cf61-c972-4c53-8169-aa70008e8143	93f9f024-4d10-4ccb-bd1d-aa70008e8138	Under 0.5	Under	active	1.28		\N		1	1	Under 0.5	5110223_12096672_46385115
92120eaf-1305-4d39-b3c2-aa70008e814c	93f9f024-4d10-4ccb-bd1d-aa70008e8138	Over 0.5	Over	active	2.39		\N		1	2	Over 0.5	5110223_12096672_46385113
43fafc8d-a293-404b-b836-aa70008e815d	d7d7379e-8379-4f57-b6f5-aa70008e8155	Under 0.5	Under	active	1.51		\N		1	1	Under 0.5	5110223_12096665_46385100
b3f90bfc-0d19-4777-9507-aa70008e8165	d7d7379e-8379-4f57-b6f5-aa70008e8155	Over 0.5	Over	active	1.85		\N		1	2	Over 0.5	5110223_12096665_46385099
553b45fb-0298-4d9c-935a-aa70008e8176	4f87bc6b-0110-400f-adc5-aa70008e816e	1-0	1-0	active	3.9		\N		1	1	1-0	5110223_12096842_46385591
51348543-4204-4f67-9cf6-aa70008e817e	4f87bc6b-0110-400f-adc5-aa70008e816e	2-0	2-0	active	10		\N		1	2	2-0	5110223_12096842_46385594
d494f1c0-6734-4a5f-9091-aa70008e8186	4f87bc6b-0110-400f-adc5-aa70008e816e	2-1	2-1	active	20.5		\N		1	3	2-1	5110223_12096842_46385596
ca7d05e0-5f93-4f40-af12-aa70008e8190	4f87bc6b-0110-400f-adc5-aa70008e816e	0-0	0-0	active	3		\N		2	1	0-0	5110223_12096842_46385597
050add32-3115-4e42-a7a0-aa70008e8199	4f87bc6b-0110-400f-adc5-aa70008e816e	1-1	1-1	active	7.4		\N		2	2	1-1	5110223_12096842_46385598
a1b41155-daae-4966-980b-aa70008e81a2	4f87bc6b-0110-400f-adc5-aa70008e816e	2-2	2-2	active	80		\N		2	3	2-2	5110223_12096842_46385599
7868c176-40c6-44f9-a1e5-aa70008e81aa	4f87bc6b-0110-400f-adc5-aa70008e816e	0-1	0-1	active	5.75		\N		3	1	0-1	5110223_12096842_46385601
52a32d09-9bce-46ef-9c06-aa70008e81b3	4f87bc6b-0110-400f-adc5-aa70008e816e	0-2	0-2	active	23		\N		3	2	0-2	5110223_12096842_46385603
eee64e66-04a9-4b9d-9904-aa70008e81bb	4f87bc6b-0110-400f-adc5-aa70008e816e	1-2	1-2	active	30		\N		3	3	1-2	5110223_12096842_46385605
21f6a365-6bd2-43fa-8183-aa70008e81c4	4f87bc6b-0110-400f-adc5-aa70008e816e	Any Other	M1	active	15.75		\N		4	1	Any Other	5110223_12096842_46385606
2e840bff-5600-48f9-b630-aa70008e81d7	3c381fab-f85c-4837-bcf6-aa70008e81ce	Any Other	M1	active	26.5		\N		1	1	Any Other	5110223_12096824_46385507
9c3d4b2e-fd63-4bd8-be98-aa70008e81e0	3c381fab-f85c-4837-bcf6-aa70008e81ce	1-0	1-0	active	3.9		\N		1	2	1-0	5110223_12096824_46385508
841a3fca-536f-40df-b384-aa70008e81ea	3c381fab-f85c-4837-bcf6-aa70008e81ce	2-0	2-0	active	12.25		\N		1	3	2-0	5110223_12096824_46385509
011ff434-eeae-4928-b9d0-aa70008e81f2	3c381fab-f85c-4837-bcf6-aa70008e81ce	2-1	2-1	active	30		\N		2	1	2-1	5110223_12096824_46385511
ea95e130-a55c-415b-8e08-aa70008e81fa	3c381fab-f85c-4837-bcf6-aa70008e81ce	0-0	0-0	active	2.22		\N		2	2	0-0	5110223_12096824_46385513
de54d126-fa2d-46c8-832c-aa70008e8201	3c381fab-f85c-4837-bcf6-aa70008e81ce	1-1	1-1	active	9.55		\N		2	3	1-1	5110223_12096824_46385515
61f7ffb7-cef0-43ae-9ce1-aa70008e820a	3c381fab-f85c-4837-bcf6-aa70008e81ce	2-2	2-2	active	100		\N		3	1	2-2	5110223_12096824_46385516
cc998e06-986b-427c-b267-aa70008e8212	3c381fab-f85c-4837-bcf6-aa70008e81ce	0-1	0-1	active	5.85		\N		3	2	0-1	5110223_12096824_46385517
d5016f20-5ab8-4a15-a835-aa70008e821a	3c381fab-f85c-4837-bcf6-aa70008e81ce	0-2	0-2	active	28.5		\N		3	3	0-2	5110223_12096824_46385519
cc8e1c0a-f07c-4383-bb99-aa70008e8222	3c381fab-f85c-4837-bcf6-aa70008e81ce	1-2	1-2	active	45		\N		4	1	1-2	5110223_12096824_46385520
8396cbcb-7c52-4e63-b980-aa70008e8232	522163d6-761b-4b28-9516-aa70008e822a	Депортиво Ла Коруня/Депортиво Ла Коруня	A/A	active	3.5		\N		1	1	Депортиво Ла Коруня/Депортиво Ла Коруня	5110223_12096638_46385012
771b9215-663e-4ed2-a46a-aa70008e823a	522163d6-761b-4b28-9516-aa70008e822a	Депортиво Ла Коруня/Draw	A/X	active	13.75		\N		1	2	Депортиво Ла Коруня/Draw	5110223_12096638_46385016
d62e7979-4be2-4cf3-8db9-aa70008e8242	522163d6-761b-4b28-9516-aa70008e822a	Депортиво Ла Коруня/РКД Майорка	A/B	active	35		\N		1	3	Депортиво Ла Коруня/РКД Майорка	5110223_12096638_46385022
1ec21e74-7d9d-4273-8ddf-aa70008e824a	522163d6-761b-4b28-9516-aa70008e822a	Draw/Депортиво Ла Коруня	X/A	active	4.6		\N		2	1	Draw/Депортиво Ла Коруня	5110223_12096638_46385014
274ef245-ddf0-4def-a8f6-aa70008e8256	522163d6-761b-4b28-9516-aa70008e822a	Draw/Draw	X/X	active	4.4		\N		2	2	Draw/Draw	5110223_12096638_46385018
ccc17665-3526-4b96-a148-aa70008e827e	522163d6-761b-4b28-9516-aa70008e822a	Draw/РКД Майорка	X/B	active	7.65		\N		2	3	Draw/РКД Майорка	5110223_12096638_46385023
290837b7-5580-4dd3-b5ae-aa70008e828a	522163d6-761b-4b28-9516-aa70008e822a	РКД Майорка/Депортиво Ла Коруня	B/A	active	26		\N		3	1	РКД Майорка/Депортиво Ла Коруня	5110223_12096638_46385015
bd0e0526-ad5d-4155-b0ff-aa70008e8298	522163d6-761b-4b28-9516-aa70008e822a	РКД Майорка/Draw	B/X	active	14.75		\N		3	2	РКД Майорка/Draw	5110223_12096638_46385020
9238b151-af56-482c-9de6-aa70008e829f	522163d6-761b-4b28-9516-aa70008e822a	РКД Майорка/РКД Майорка	B/B	active	7.75		\N		3	3	РКД Майорка/РКД Майорка	5110223_12096638_46385026
7fbc1c7c-3bea-41cc-ae83-aa70008e82b0	207ab2ce-eb6a-4152-9501-aa70008e82a7	Rc Deportivo La Coruna	A	active	2.52		\N		1	1	Rc Deportivo La Coruna	5110223_12096962_46386384
f9d740da-bf98-4868-b74c-aa70008e82b9	207ab2ce-eb6a-4152-9501-aa70008e82a7	Draw	X	active	1.79		\N		1	2	Draw	5110223_12096962_46386385
8386806f-d412-4695-bff4-aa70008e82c1	207ab2ce-eb6a-4152-9501-aa70008e82a7	РКД Майорка	B	active	4.1		\N		1	3	РКД Майорка	5110223_12096962_46386386
1b23212e-a2a5-476f-af89-aa70008e82d1	9768b7e0-e7eb-4b6a-9f22-aa70008e82c9	Депортиво Ла Коруня or Draw	AX	active	1.15		\N		1	1	Депортиво Ла Коруня or Draw	5110223_12096809_46385464
131cf006-8f01-445f-a2b4-aa70008e82d9	9768b7e0-e7eb-4b6a-9f22-aa70008e82c9	Депортиво Ла Коруня or РКД Майорка	AB	active	1.61		\N		1	2	Депортиво Ла Коруня or РКД Майорка	5110223_12096809_46385465
5f98efe8-46a0-4edf-bd8b-aa70008e82e2	9768b7e0-e7eb-4b6a-9f22-aa70008e82c9	Draw or РКД Майорка	BX	active	1.32		\N		1	3	Draw or РКД Майорка	5110223_12096809_46385466
9cfd999d-2ff8-483c-82ea-aa70008e82f4	662090c5-b8cd-45c5-9a0f-aa70008e82ea	Rc Deportivo La Coruna	A	active	2.24		\N		1	1	Rc Deportivo La Coruna	5110223_12096922_46386000
6d3f1694-dbfb-4267-9df6-aa70008e82fd	662090c5-b8cd-45c5-9a0f-aa70008e82ea	Draw	X	active	2.08		\N		1	2	Draw	5110223_12096922_46386001
867ff311-53ec-4096-89c5-aa70008e8309	662090c5-b8cd-45c5-9a0f-aa70008e82ea	РКД Майорка	B	active	3.65		\N		1	3	РКД Майорка	5110223_12096922_46386002
e3578f86-f0d5-40e8-a94a-aa70008e831c	6b64d022-7e8e-489f-8b7c-aa70008e8313	Депортиво Ла Коруня or Draw	AX	active	1.18		\N		1	1	Депортиво Ла Коруня or Draw	5110223_12096920_46385994
8758e43f-5d13-4fbc-94d8-aa70008e8324	6b64d022-7e8e-489f-8b7c-aa70008e8313	Депортиво Ла Коруня or РКД Майорка	AB	active	1.45		\N		1	2	Депортиво Ла Коруня or РКД Майорка	5110223_12096920_46385995
8271ab84-82c0-46a0-95fa-aa70008e832c	6b64d022-7e8e-489f-8b7c-aa70008e8313	Draw or РКД Майорка	BX	active	1.4		\N		1	3	Draw or РКД Майорка	5110223_12096920_46385996
915c2e6b-cf77-40e7-b941-aa70008e833c	6ff4218f-7435-4986-b3a3-aa70008e8334	Rc Deportivo La Coruna	A	active	1.43		\N		1	1	Rc Deportivo La Coruna	5110223_12096884_46385791
116d65fc-2074-4078-9503-aa70008e8345	6ff4218f-7435-4986-b3a3-aa70008e8334	Draw	X	active	1.99		\N		1	2	Draw	5110223_12096884_46385792
93dd696a-ad3d-4969-ba38-aa70008e8356	2888aba4-4903-4f97-814e-aa70008e834d	Draw	X	active	1.51		\N		1	1	Draw	5110223_12096878_46385769
510b0c71-c38a-46f8-a6f2-aa70008e835e	2888aba4-4903-4f97-814e-aa70008e834d	РКД Майорка	B	active	1.86		\N		1	2	РКД Майорка	5110223_12096878_46385770
4ad82374-1181-49e1-8b69-aa70008e836f	cd3975b5-b836-4545-9dcf-aa70008e8366	Under 0.5	Under	active	1.42		\N		1	1	Under 0.5	5110223_12096694_46385162
6f255736-b98b-437f-9d5a-aa70008e8378	cd3975b5-b836-4545-9dcf-aa70008e8366	Over 0.5	Over	active	2.01		\N		1	2	Over 0.5	5110223_12096694_46385161
21222413-f629-432c-be06-aa70008e8389	5074e09f-07ff-4152-ba78-aa70008e8380	Under 0.5	Under	active	1.75		\N		1	1	Under 0.5	5110223_12096687_46385148
a55c8757-78b1-45e1-bcb8-aa70008e8391	5074e09f-07ff-4152-ba78-aa70008e8380	Over 0.5	Over	active	1.59		\N		1	2	Over 0.5	5110223_12096687_46385147
cf2d3c90-ab2b-49cc-9075-aa70008e83a3	78473ae1-8f69-4bff-b467-aa70008e839a	Rc Deportivo La Coruna	A	active	1.32		\N		1	1	Rc Deportivo La Coruna	5110223_12096652_46385052
3ac71752-80da-4ff9-beac-aa70008e83ab	78473ae1-8f69-4bff-b467-aa70008e839a	РКД Майорка	B	active	2.26		\N		1	2	РКД Майорка	5110223_12096652_46385053
55dff080-c959-4d8f-8162-aa70008e83c1	40cd50e7-9e88-4c7c-b88f-aa70008e83b6	Yes	Yes	active	2.7		\N		1	1	Yes	5110223_12096956_46386365
6b12d24f-b949-4edb-9cf3-aa70008e83d1	40cd50e7-9e88-4c7c-b88f-aa70008e83b6	No	No	active	1.2		\N		1	2	No	5110223_12096956_46386366
4e88bebd-47f0-4f02-b617-aa70008e83f1	06250fb4-7c20-4ee4-899b-aa70008e83e8	Yes	Yes	active	1.93		\N		1	1	Yes	5110223_12096954_46386361
9cb3d482-0681-4b6f-8e94-aa70008e83f9	06250fb4-7c20-4ee4-899b-aa70008e83e8	No	No	active	1.47		\N		1	2	No	5110223_12096954_46386362
828a8da2-f649-46bb-a1d1-aa70008e840c	0c6a3419-0e09-4cae-b8be-aa70008e8403	Yes	Yes	active	3.9		\N		1	1	Yes	5110223_12096888_46385799
f8ad2580-4dc3-48af-b464-aa70008e841a	0c6a3419-0e09-4cae-b8be-aa70008e8403	No	No	active	1.06		\N		1	2	No	5110223_12096888_46385800
206266a3-2ca4-455c-aa0f-aa70008e842d	1d70d4c3-32fe-41ea-8142-aa70008e8424	Yes	Yes	active	2.44		\N		1	1	Yes	5110223_12096886_46385795
ec174c4a-30a0-466f-82db-aa70008e8438	1d70d4c3-32fe-41ea-8142-aa70008e8424	No	No	active	1.27		\N		1	2	No	5110223_12096886_46385796
1dc83c51-e139-4667-9ba7-aa70008e844b	bbe7d4dd-537e-4649-9e2c-aa70008e8441	Yes	Yes	active	3.8		\N		1	1	Yes	5110223_12096866_46385711
166ad3d9-1804-4daa-bef3-aa70008e8454	bbe7d4dd-537e-4649-9e2c-aa70008e8441	No	No	active	1.07		\N		1	2	No	5110223_12096866_46385712
cb043eb9-7ca5-4ad6-8f29-aa70008e8466	acc791fd-2c45-4408-b209-aa70008e845d	Under 2.5	Under	active	1.02		\N		1	1	Under 2.5	5110223_12096786_46385404
684b2e14-bcb5-47c0-a01b-aa70008e846e	acc791fd-2c45-4408-b209-aa70008e845d	Over 2.5	Over	active	4.65		\N		1	2	Over 2.5	5110223_12096786_46385402
e9fd1662-4e7e-4551-83d7-aa70008e847f	d4109273-ef34-42a5-be88-aa70008e8477	Under 1.5	Under	active	1.19		\N		1	1	Under 1.5	5110223_12096783_46385394
16bfe225-9deb-483c-a1b5-aa70008e8488	d4109273-ef34-42a5-be88-aa70008e8477	Over 1.5	Over	active	2.75		\N		1	2	Over 1.5	5110223_12096783_46385393
60878da5-0997-47a2-9a8e-aa70008e849b	48923d12-5234-4231-89da-aa70008e8492	Under 0.5	Under	active	2.01		\N		1	1	Under 0.5	5110223_12096781_46385385
050a98f9-12dc-4412-985a-aa70008e84a5	48923d12-5234-4231-89da-aa70008e8492	Over 0.5	Over	active	1.42		\N		1	2	Over 0.5	5110223_12096781_46385383
88931306-c0b6-48fa-89ae-aa70008e84b6	42858998-db90-45b9-a2b8-aa70008e84ae	Yes	Yes	active	3.15		\N		1	1	Yes	5110223_12096880_46385773
38932f13-317f-4b8b-89e6-aa70008e84be	42858998-db90-45b9-a2b8-aa70008e84ae	No	No	active	1.14		\N		1	2	No	5110223_12096880_46385774
c23d3e15-dee5-452e-9b64-aa70008e84cf	6dc8cffd-0bef-42e9-b2b7-aa70008e84c7	Under 2.5	Under	active	1.06		\N		1	1	Under 2.5	5110223_12096794_46385434
45365c2d-58db-404f-bc98-aa70008e84d8	6dc8cffd-0bef-42e9-b2b7-aa70008e84c7	Over 2.5	Over	active	3.95		\N		1	2	Over 2.5	5110223_12096794_46385432
61e0f611-27a2-4a93-9d48-aa70008e84eb	c1b4fe2e-2edf-45b1-94ab-aa70008e84e2	Under 1.5	Under	active	1.35		\N		1	1	Under 1.5	5110223_12096791_46385423
237a4585-2945-4d22-8b35-aa70008e84f5	c1b4fe2e-2edf-45b1-94ab-aa70008e84e2	Over 1.5	Over	active	2.19		\N		1	2	Over 1.5	5110223_12096791_46385422
8ce59db4-7741-4cbe-bf03-aa70008e8507	11908e04-d1fa-448a-9831-aa70008e84fe	Under 0.5	Under	active	2.56		\N		1	1	Under 0.5	5110223_12096788_46385413
c1be99ac-7671-4cf5-b1f6-aa70008e8510	11908e04-d1fa-448a-9831-aa70008e84fe	Over 0.5	Over	active	1.24		\N		1	2	Over 0.5	5110223_12096788_46385411
aa7160f9-3548-43a9-ac8a-aa70008e8534	6f554f89-199e-4e1b-9e33-aa70008e851d	0	0	active	6.9		\N		1	1	0	5110223_12096914_46385962
7162b57f-72bd-46df-b3cc-aa70008e854b	6f554f89-199e-4e1b-9e33-aa70008e851d	1	1	active	3.6		\N		1	2	1	5110223_12096914_46385963
e6329dd3-941a-4271-88e8-aa70008e855f	6f554f89-199e-4e1b-9e33-aa70008e851d	2	2	active	3.1		\N		1	3	2	5110223_12096914_46385964
4607450e-c53e-47d5-b27b-aa70008e8569	6f554f89-199e-4e1b-9e33-aa70008e851d	3	3	active	4.35		\N		2	1	3	5110223_12096914_46385965
e186587a-6047-41e9-a6b0-aa70008e8571	6f554f89-199e-4e1b-9e33-aa70008e851d	4	4	active	7.35		\N		2	2	4	5110223_12096914_46385966
49086f92-e2c2-45f1-bde2-aa70008e857b	6f554f89-199e-4e1b-9e33-aa70008e851d	5	5	active	17		\N		2	3	5	5110223_12096914_46385967
9c1a3770-efe8-4676-a723-aa70008e8585	6f554f89-199e-4e1b-9e33-aa70008e851d	6+	6+	active	30		\N		3	1	6+	5110223_12096914_46385968
66d581bf-5294-449e-b9ea-aa70008e8596	f46041e1-0dcb-4648-9750-aa70008e858f	0	0	active	2.16		\N		1	1	0	5110223_12096662_46385090
2efafa3a-fb7e-49bb-a673-aa70008e859f	f46041e1-0dcb-4648-9750-aa70008e858f	1	1	active	2.36		\N		1	2	1	5110223_12096662_46385091
84537544-f25e-4399-8c1a-aa70008e85a7	f46041e1-0dcb-4648-9750-aa70008e858f	2+	2+	active	3.2		\N		1	3	2+	5110223_12096662_46385092
b36d9524-a60d-4aa6-9732-aa70008e85b6	12f2bdae-df47-4035-8343-aa70008e85ae	0	0	active	2.85		\N		1	1	0	5110223_12096668_46385106
bee1c4f1-8d39-4620-bdee-aa70008e85bf	12f2bdae-df47-4035-8343-aa70008e85ae	1	1	active	2.33		\N		1	2	1	5110223_12096668_46385107
6d32e5b2-4a68-40f3-a6fa-aa70008e85c8	12f2bdae-df47-4035-8343-aa70008e85ae	2+	2+	active	2.37		\N		1	3	2+	5110223_12096668_46385108
88522623-541c-45e3-bf53-aa70008e85dc	0f1f71d5-759f-4272-bf05-aa70008e85d2	Odd	Odd	active	1.73		\N		1	1	Odd	5110223_12096646_46385037
90ee3d5b-5c99-4a17-9ece-aa70008e85e5	0f1f71d5-759f-4272-bf05-aa70008e85d2	Even	Even	active	1.61		\N		1	2	Even	5110223_12096646_46385039
a6023f35-bd1c-4b14-826f-aa70008e85fa	150d261f-238a-41aa-917a-aa70008e85f1	Odd	Odd	active	1.93		\N		1	1	Odd	5110223_12096946_46386279
29a07ea5-5ba9-4f84-9c31-aa70008e8602	150d261f-238a-41aa-917a-aa70008e85f1	Even	Even	active	1.47		\N		1	2	Even	5110223_12096946_46386280
6d8cf94f-e8cc-4251-b912-aa70008e8615	67971bd9-972b-4683-8323-aa70008e860a	Odd	Odd	active	1.79		\N		1	1	Odd	5110223_12096906_46385941
d6dcbeb8-d135-423f-845a-aa70008e861e	67971bd9-972b-4683-8323-aa70008e860a	Even	Even	active	1.56		\N		1	2	Even	5110223_12096906_46385942
317887c2-7d28-442f-8c22-aa70008e8634	8bd49ef5-7565-4e01-8ee7-aa70008e8628	Rc Deportivo La Coruna	A	active	1.63		\N		1	1	Rc Deportivo La Coruna	5110223_12096960_46386379
3584a34a-a3e0-4451-8112-aa70008e863e	8bd49ef5-7565-4e01-8ee7-aa70008e8628	РКД Майорка	B	active	2.33		\N		1	2	РКД Майорка	5110223_12096960_46386380
5887c39b-e57a-4d2d-8721-aa70008e8648	8bd49ef5-7565-4e01-8ee7-aa70008e8628	None	None	active	7.35		\N		2	1	None	5110223_12096960_46386378
913d9510-22bb-4bdb-adc8-aa70008e865d	b069ea12-7a17-4106-9122-aa70008e8653	Rc Deportivo La Coruna	A	active	1.64		\N		1	1	Rc Deportivo La Coruna	5110223_12096890_46385805
020914bc-ff5b-440c-9442-aa70008e8666	b069ea12-7a17-4106-9122-aa70008e8653	РКД Майорка	B	active	2.33		\N		1	2	РКД Майорка	5110223_12096890_46385806
d8d6291f-674e-4fec-921d-aa70008e8671	b069ea12-7a17-4106-9122-aa70008e8653	None	None	active	6.15		\N		2	1	None	5110223_12096890_46385804
085e09f0-fbc2-4435-8adb-aa70008e86a1	92d4a034-12e8-4059-87e1-aa70008e8684	Yes	Yes	active	4.1		\N		1	1	Yes	5110223_12096798_46385440
7246771c-d8b8-4424-857a-aa70008e86b4	92d4a034-12e8-4059-87e1-aa70008e8684	No	No	active	1.05		\N		1	2	No	5110223_12096798_46385442
1486ae8f-1e00-45eb-8532-aa70008e86d4	b917a7e6-b6f9-4df4-a659-aa70008e86c9	Yes	Yes	active	2.95		\N		1	1	Yes	5110223_12096709_46385195
fe5fe341-73f9-4ce2-8bd7-aa70008e86e1	b917a7e6-b6f9-4df4-a659-aa70008e86c9	No	No	active	1.16		\N		1	2	No	5110223_12096709_46385197
3f7d62e6-9c2a-4927-b620-aa70008e86fa	ba0b56b9-5b98-4920-b1ad-aa70008e86ee	Under 0.5	Under	active	1.93		\N		1	1	Under 0.5	5110223_12096680_46385132
78e59aed-2f7d-427c-9ff0-aa70008e8707	ba0b56b9-5b98-4920-b1ad-aa70008e86ee	Over 0.5	Over	active	1.47		\N		1	2	Over 0.5	5110223_12096680_46385131
703058a3-66ca-4f14-ab7b-aa70008e871a	20783f45-bc1d-4559-a5f8-aa70008e8712	Under 1.5	Under	active	1.4		\N		1	1	Under 1.5	5110223_12096691_46385156
60ecf7b8-3c88-422e-a70a-aa70008e8726	20783f45-bc1d-4559-a5f8-aa70008e8712	Over 1.5	Over	active	2.05		\N		1	2	Over 1.5	5110223_12096691_46385155
c048aa58-565e-4229-8e12-aa70008e8738	89ceba9a-dda4-4677-9df2-aa70008e872f	0	0	active	2.06		\N		1	1	0	5110223_12096656_46385066
85095d48-6ec9-461d-825d-aa70008e8742	89ceba9a-dda4-4677-9df2-aa70008e872f	1	1	active	2.29		\N		1	2	1	5110223_12096656_46385067
353bdba0-482e-4046-b446-aa70008e874b	89ceba9a-dda4-4677-9df2-aa70008e872f	2	2	active	4.95		\N		1	3	2	5110223_12096656_46385068
f8327026-48ba-48e6-934c-aa70008e8755	89ceba9a-dda4-4677-9df2-aa70008e872f	3+	3+	active	13.25		\N		2	1	3+	5110223_12096656_46385069
3f47b314-5eaa-4cd1-a83d-aa70008e8768	9cd124b4-dcf4-42c2-b267-aa70008e875f	0	0	active	3.15		\N		1	1	0	5110223_12096654_46385058
aa127d9b-3aea-4dc6-ba2d-aa70008e8771	9cd124b4-dcf4-42c2-b267-aa70008e875f	1	1	active	2.41		\N		1	2	1	5110223_12096654_46385059
d6b599dd-82aa-404d-a784-aa70008e877a	9cd124b4-dcf4-42c2-b267-aa70008e875f	2	2	active	3.55		\N		1	3	2	5110223_12096654_46385060
a4b0b4ed-746a-441c-9c5a-aa70008e8784	9cd124b4-dcf4-42c2-b267-aa70008e875f	3+	3+	active	5.4		\N		2	1	3+	5110223_12096654_46385061
9df1544c-5657-45b8-9bdc-aa70008e8796	06d86463-8cf4-4af5-a478-aa70008e878e	0-1	R_0-1	active	2.37		\N		1	1	0-1	5110223_12096814_46385477
c9714490-c2c9-42d8-ad84-aa70008e879f	06d86463-8cf4-4af5-a478-aa70008e878e	2-3	R_2-3	active	1.85		\N		1	2	2-3	5110223_12096814_46385478
0789215b-a790-46c4-98c9-aa70008e87a9	06d86463-8cf4-4af5-a478-aa70008e878e	4-5	R_4-5	active	4.95		\N		1	3	4-5	5110223_12096814_46385479
db9138b6-946c-4172-81e9-aa70008e87b3	06d86463-8cf4-4af5-a478-aa70008e878e	6+	6+	active	29		\N		2	1	6+	5110223_12096814_46385476
e26a60bb-293a-4012-b272-aa70008e87c8	05df363b-83db-4da4-ae76-aa70008e87bc	1st Half	H1	active	2.95		\N		1	1	1st Half	5110223_12096868_46385716
8bb631b4-aafc-4607-8a96-aa70008e87d4	05df363b-83db-4da4-ae76-aa70008e87bc	2nd	H2	active	2		\N		1	2	2nd	5110223_12096868_46385717
e0544b4c-f180-42eb-a30a-aa70008e87e1	05df363b-83db-4da4-ae76-aa70008e87bc	Equal	Equal	active	2.75		\N		1	3	Equal	5110223_12096868_46385718
4c6eb110-4b98-48bb-8df6-aa70008e8804	91ed3195-900e-46cf-b11e-aa70008e87f1	Депортиво Ла Коруня -1	AH	active	6.8		\N		1	1	Депортиво Ла Коруня -1	5110223_12096684_46385140
36ae7245-1c8c-425b-b534-aa70008e8810	91ed3195-900e-46cf-b11e-aa70008e87f1	Draw sigendLine	XH	active	3.2		\N		1	2	Draw sigendLine	5110223_12096684_46385141
8db23fcf-63af-43e8-a50d-aa70008e8820	91ed3195-900e-46cf-b11e-aa70008e87f1	РКД Майорка +1	BH	active	1.36		\N		1	3	РКД Майорка +1	5110223_12096684_46385143
7f1bb2bf-f695-48f3-bb06-aa70008e8833	cca293a8-7e79-4983-9496-aa70008e882a	Yes	Yes	active	4.1		\N		1	1	Yes	5110223_12096701_46385179
1b47d961-b518-4a60-b225-aa70008e883f	cca293a8-7e79-4983-9496-aa70008e882a	No	No	active	1.05		\N		1	2	No	5110223_12096701_46385181
72ee7d36-6b97-4ab6-a01a-aa70008e8853	90f7c026-2a31-46d7-8429-aa70008e884b	Rc Deportivo La Coruna	A	active	2		\N		1	1	Rc Deportivo La Coruna	5110223_12096856_46385659
85db445e-62f4-4ca4-b23a-aa70008e885d	90f7c026-2a31-46d7-8429-aa70008e884b	РКД Майорка	B	active	2.85		\N		1	2	РКД Майорка	5110223_12096856_46385660
608b5744-c44f-4d63-a9d6-aa70008e8868	90f7c026-2a31-46d7-8429-aa70008e884b	None	None	active	2.85		\N		2	1	None	5110223_12096856_46385658
e90d3ac1-7ef3-484d-9a2b-aa70008e8879	e3bf7815-2c98-4c29-9768-aa70008e8871	Rc Deportivo La Coruna	A	active	2.29		\N		1	1	Rc Deportivo La Coruna	5110223_12096658_46385081
a10957cf-5602-4e63-8658-aa70008e8883	e3bf7815-2c98-4c29-9768-aa70008e8871	РКД Майорка	B	active	3.35		\N		1	2	РКД Майорка	5110223_12096658_46385083
8066e6dc-1a24-4f3d-adb6-aa70008e888d	e3bf7815-2c98-4c29-9768-aa70008e8871	None	None	active	2.15		\N		2	1	None	5110223_12096658_46385079
d8975d63-26db-489d-a9d3-aa70008e889f	a01a7e69-c28f-4ef3-9f07-aa70008e8895	Yes	Yes	active	1.71		\N		1	1	Yes	5110223_12096805_46385454
c4fef177-a84f-43a4-b70c-aa70008e88a8	a01a7e69-c28f-4ef3-9f07-aa70008e8895	No	No	active	1.62		\N		1	2	No	5110223_12096805_46385456
b69bbf90-dc55-46a8-b8c9-aa70008e88ba	ad4e60fe-f98c-4a4e-9f6a-aa70008e88b1	Yes	Yes	active	4.4		\N		1	1	Yes	5110223_12096802_46385448
43b9e3d9-cc1e-4f7d-a444-aa70008e88c4	ad4e60fe-f98c-4a4e-9f6a-aa70008e88b1	No	No	active	1.03		\N		1	2	No	5110223_12096802_46385449
b4b5a5c1-7af3-42f0-a8a1-aa70008e88db	054b1bfe-0f29-4cb4-9e76-aa70008e88d0	Депортиво Ла Коруня and Under 3.5	AUnder	active	2.38		\N		1	1	Депортиво Ла Коруня and Under 3.5	5110223_12096876_46385761
02a5dd7c-1a49-451b-8040-aa70008e88e7	054b1bfe-0f29-4cb4-9e76-aa70008e88d0	Draw and Under 3.5	XUnder	active	3.25		\N		1	2	Draw and Under 3.5	5110223_12096876_46385762
caf58041-b4ec-4524-a319-aa70008e88f0	054b1bfe-0f29-4cb4-9e76-aa70008e88d0	РКД Майорка and Under 3.5	BUnder	active	4.15		\N		1	3	РКД Майорка and Under 3.5	5110223_12096876_46385763
f2cace29-cf8e-4766-b600-aa70008e88fb	054b1bfe-0f29-4cb4-9e76-aa70008e88d0	Депортиво Ла Коруня and Over 3.5	AOver	active	8.05		\N		2	1	Депортиво Ла Коруня and Over 3.5	5110223_12096876_46385764
f314dd4b-d0fc-4c4b-ac5a-aa70008e8905	054b1bfe-0f29-4cb4-9e76-aa70008e88d0	Draw and Over 3.5	XOver	active	16.75		\N		2	2	Draw and Over 3.5	5110223_12096876_46385765
2dfde459-b0a1-4482-8065-aa70008e890e	054b1bfe-0f29-4cb4-9e76-aa70008e88d0	РКД Майорка and Over 3.5	BOver	active	21		\N		2	3	РКД Майорка and Over 3.5	5110223_12096876_46385766
8d9b2b64-2a24-4d75-9878-aa70008e8922	1e4541e5-268a-414b-a4eb-aa70008e8919	Депортиво Ла Коруня and Under 2.5	AUnder	active	3.55		\N		1	1	Депортиво Ла Коруня and Under 2.5	5110223_12096874_46385749
46eefe10-16d4-4ba5-b8e2-aa70008e892b	1e4541e5-268a-414b-a4eb-aa70008e8919	Draw and Under 2.5	XUnder	active	3.3		\N		1	2	Draw and Under 2.5	5110223_12096874_46385750
76ea5786-b1b3-4773-8a2e-aa70008e8938	1e4541e5-268a-414b-a4eb-aa70008e8919	РКД Майорка and Under 2.5	BUnder	active	6.2		\N		1	3	РКД Майорка and Under 2.5	5110223_12096874_46385751
e0db6a03-9a63-4297-ab22-aa70008e8944	1e4541e5-268a-414b-a4eb-aa70008e8919	Депортиво Ла Коруня and Over 2.5	AOver	active	3.75		\N		2	1	Депортиво Ла Коруня and Over 2.5	5110223_12096874_46385752
49d752d1-cb97-4899-a97d-aa70008e8955	1e4541e5-268a-414b-a4eb-aa70008e8919	Draw and Over 2.5	XOver	active	17.25		\N		2	2	Draw and Over 2.5	5110223_12096874_46385753
29938138-255d-41d7-b403-aa70008e896f	1e4541e5-268a-414b-a4eb-aa70008e8919	РКД Майорка and Over 2.5	BOver	active	7.85		\N		2	3	РКД Майорка and Over 2.5	5110223_12096874_46385754
a9b9b69d-8605-401b-a17e-aa70008e898c	e91dfee4-440f-4f18-b5eb-aa70008e8980	Депортиво Ла Коруня and Under 1.5	AUnder	active	5.85		\N		1	1	Депортиво Ла Коруня and Under 1.5	5110223_12096872_46385737
83ba8d34-8b75-4fad-b86f-aa70008e8996	e91dfee4-440f-4f18-b5eb-aa70008e8980	Draw and Under 1.5	XUnder	active	6.9		\N		1	2	Draw and Under 1.5	5110223_12096872_46385738
96eefd1f-b843-42ba-b276-aa70008e89a1	e91dfee4-440f-4f18-b5eb-aa70008e8980	РКД Майорка and Under 1.5	BUnder	active	8.85		\N		1	3	РКД Майорка and Under 1.5	5110223_12096872_46385739
4ef492f3-4457-47d4-ae98-aa70008e89ad	e91dfee4-440f-4f18-b5eb-aa70008e8980	Депортиво Ла Коруня and Over 1.5	AOver	active	2.7		\N		2	1	Депортиво Ла Коруня and Over 1.5	5110223_12096872_46385740
f57ce8a0-e4d1-403a-b030-aa70008e89b8	e91dfee4-440f-4f18-b5eb-aa70008e8980	Draw and Over 1.5	XOver	active	4.45		\N		2	2	Draw and Over 1.5	5110223_12096872_46385741
d155de2e-0b60-4e8d-ab2c-aa70008e89c2	e91dfee4-440f-4f18-b5eb-aa70008e8980	РКД Майорка and Over 1.5	BOver	active	5.7		\N		2	3	РКД Майорка and Over 1.5	5110223_12096872_46385742
9a007eb6-0c3a-49db-9ff6-aa70008e89d5	a8e2b49d-0400-4267-b0f3-aa70008e89cc	Депортиво Ла Коруня and Under 4.5	AUnder	active	2.09		\N		1	1	Депортиво Ла Коруня and Under 4.5	5110223_12096870_46385725
47adfc0c-29c7-4021-8396-aa70008e89df	a8e2b49d-0400-4267-b0f3-aa70008e89cc	Draw and Under 4.5	XUnder	active	2.8		\N		1	2	Draw and Under 4.5	5110223_12096870_46385726
86348bc5-88c9-4937-9078-aa70008e89e9	a8e2b49d-0400-4267-b0f3-aa70008e89cc	РКД Майорка and Under 4.5	BUnder	active	3.75		\N		1	3	РКД Майорка and Under 4.5	5110223_12096870_46385727
3ca9936a-770e-4a4f-b6c3-aa70008e89f3	a8e2b49d-0400-4267-b0f3-aa70008e89cc	Депортиво Ла Коруня and Over 4.5	AOver	active	16.25		\N		2	1	Депортиво Ла Коруня and Over 4.5	5110223_12096870_46385728
e03970da-53e4-439d-9a12-aa70008e89fd	a8e2b49d-0400-4267-b0f3-aa70008e89cc	Draw and Over 4.5	XOver	active	100		\N		2	2	Draw and Over 4.5	5110223_12096870_46385729
f7afee38-ec71-4b73-85fa-aa70008e8a09	a8e2b49d-0400-4267-b0f3-aa70008e89cc	РКД Майорка and Over 4.5	BOver	active	40		\N		2	3	РКД Майорка and Over 4.5	5110223_12096870_46385730
8ded8eb1-64d8-483e-980c-aa70008e8a1d	17dacff0-9a10-41a9-a5f2-aa70008e8a14	1st Half	H1	active	3.2		\N		1	1	1st Half	5110223_12096896_46385834
e9be3aa5-b298-42a9-8335-aa70008e8a26	17dacff0-9a10-41a9-a5f2-aa70008e8a14	2nd	H2	active	2.34		\N		1	2	2nd	5110223_12096896_46385835
20309f60-d32f-46d9-a692-aa70008e8a30	17dacff0-9a10-41a9-a5f2-aa70008e8a14	Equal	Equal	active	2.16		\N		1	3	Equal	5110223_12096896_46385836
849e2a76-251a-44b3-97d6-aa70008e8a46	95ce9768-9921-437a-8f56-aa70008e8a3c	Yes	Yes	active	1.48		\N		1	1	Yes	5110223_12096705_46385187
f9d8884c-fa47-4f17-a787-aa70008e8a50	95ce9768-9921-437a-8f56-aa70008e8a3c	No	No	active	1.91		\N		1	2	No	5110223_12096705_46385188
54854faa-e3a8-4f19-a22f-aa70008e8a64	530fc7e5-e704-4a5e-a167-aa70008e8a5a	Rc Deportivo La Coruna	A	active	2.8		\N		1	1	Rc Deportivo La Coruna	5110223_12096958_46386372
c66822fb-0d11-4621-b303-aa70008e8a6d	530fc7e5-e704-4a5e-a167-aa70008e8a5a	Both	Both	active	1.97		\N		1	2	Both	5110223_12096958_46386374
dcec123b-1ccc-4dda-9e3b-aa70008e8a78	530fc7e5-e704-4a5e-a167-aa70008e8a5a	РКД Майорка	B	active	5.4		\N		1	3	РКД Майорка	5110223_12096958_46386373
b0d236b7-ba26-4366-ab8d-aa70008e8a84	530fc7e5-e704-4a5e-a167-aa70008e8a5a	None	None	active	6.65		\N		2	1	None	5110223_12096958_46386371
1d5c2296-6a9c-49a7-9ebd-aa70008e8a9e	42f28b78-bf1c-49ea-bb06-aa70008e8a91	Депортиво Ла Коруня by exactly 1	A1	active	3.5		\N		1	1	Депортиво Ла Коруня by exactly 1	5110223_12096952_46386355
175d4d2f-72a3-40b9-ae88-aa70008e8aaa	42f28b78-bf1c-49ea-bb06-aa70008e8a91	Draw	X	active	2.8		\N		1	2	Draw	5110223_12096952_46386352
bf6e6bb6-a787-4b0a-9d7c-aa70008e8ab5	42f28b78-bf1c-49ea-bb06-aa70008e8a91	РКД Майорка by exactly 1	B1	active	5.2		\N		1	3	РКД Майорка by exactly 1	5110223_12096952_46386356
3532f54a-dee8-48f4-8a2c-aa70008e8acf	42f28b78-bf1c-49ea-bb06-aa70008e8a91	Депортиво Ла Коруня by exactly 2	A2	active	5.95		\N		2	1	Депортиво Ла Коруня by exactly 2	5110223_12096952_46386354
2e875179-acdb-4dd1-96d5-aa70008e8ae2	42f28b78-bf1c-49ea-bb06-aa70008e8a91	РКД Майорка by exactly 2	B2	active	13.75		\N		2	3	РКД Майорка by exactly 2	5110223_12096952_46386357
ef72b8c9-f9ff-4f67-8c79-aa70008e8aee	42f28b78-bf1c-49ea-bb06-aa70008e8a91	Депортиво Ла Коруня by greater than 2	A>2	active	10		\N		3	1	Депортиво Ла Коруня by greater than 2	5110223_12096952_46386353
4b24a752-78ae-408f-88a7-aa70008e8afa	42f28b78-bf1c-49ea-bb06-aa70008e8a91	РКД Майорка by greater than 2	B>2	active	40		\N		3	3	РКД Майорка by greater than 2	5110223_12096952_46386358
fd8c13c2-fec4-4a8f-8930-aa70008e8b0b	eb901427-b683-4412-9468-aa70008e8b02	Депортиво Ла Коруня/Yes	AYes	active	5.1		\N		1	1	Депортиво Ла Коруня/Yes	5110223_12096948_46386287
7dd52404-46fb-4b8f-8ee5-aa70008e8b16	eb901427-b683-4412-9468-aa70008e8b02	Draw/Yes	XYes	active	4.5		\N		1	2	Draw/Yes	5110223_12096948_46386289
af7f4b5c-4174-4571-84f1-aa70008e8b21	eb901427-b683-4412-9468-aa70008e8b02	РКД Майорка/Yes	BYes	active	8.95		\N		1	3	РКД Майорка/Yes	5110223_12096948_46386291
d6b57516-3325-4522-a1a7-aa70008e8b2b	eb901427-b683-4412-9468-aa70008e8b02	Депортиво Ла Коруня/No	ANo	active	2.9		\N		2	1	Депортиво Ла Коруня/No	5110223_12096948_46386288
64336ac5-ce40-4682-bca1-aa70008e8b37	eb901427-b683-4412-9468-aa70008e8b02	Draw/No	XNo	active	6.85		\N		2	2	Draw/No	5110223_12096948_46386290
a92687bc-dc81-49a3-8605-aa70008e8b43	eb901427-b683-4412-9468-aa70008e8b02	РКД Майорка/No	BNo	active	5.6		\N		2	3	РКД Майорка/No	5110223_12096948_46386292
ca1529a4-54f1-48a6-8b6d-aa70008e8b56	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 1-0	0-0 1-0	active	10.25		\N		1	1	0-0 1-0	5110223_12096930_46386083
b794e843-530e-4b70-8858-aa70008e8b60	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 0-0	0-0 0-0	active	7.3		\N		1	2	0-0 0-0	5110223_12096930_46386081
fc626c47-0db0-40a5-ae8b-aa70008e8b6d	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 2-1	0-0 2-1	active	60		\N		2	1	0-0 2-1	5110223_12096930_46386119
7e4b2e12-61fd-455c-99e6-aa70008e8b78	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 0-1	0-0 0-1	active	15.5		\N		1	3	0-0 0-1	5110223_12096930_46386089
4a5cd92d-eddc-4461-ac28-aa70008e8b83	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 1-1	0-0 1-1	active	18.5		\N		2	2	0-0 1-1	5110223_12096930_46386104
0a89027e-1039-4932-b9f8-aa70008e8b8d	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 0-2	0-0 0-2	active	60		\N		2	3	0-0 0-2	5110223_12096930_46386113
c57a12d7-c13d-42d2-8db1-aa70008e8b96	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 3-0	0-0 3-0	active	100		\N		3	1	0-0 3-0	5110223_12096930_46386118
391e0037-980b-44de-b58c-aa70008e8ba0	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-0 1-1	1-0 1-1	active	25		\N		3	2	1-0 1-1	5110223_12096930_46386092
3dc9aeb1-9e00-42be-b2fe-aa70008e8bac	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 1-2	0-0 1-2	active	90		\N		3	3	0-0 1-2	5110223_12096930_46386124
67aff82a-f2e8-4b6b-b240-aa70008e8bb7	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-0 1-0	1-0 1-0	active	14.75		\N		4	1	1-0 1-0	5110223_12096930_46386121
f5eed7b5-7c6b-455f-8ef2-aa70008e8bc2	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-1 1-1	0-1 1-1	active	25.5		\N		4	2	0-1 1-1	5110223_12096930_46386128
4af70607-621b-4c3a-8d1e-aa70008e8bce	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 0-3	0-0 0-3	active	250		\N		4	3	0-0 0-3	5110223_12096930_46386125
1070431e-dcbd-4c05-aa20-aa70008e8bd9	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-0 2-0	1-0 2-0	active	18.5		\N		5	1	1-0 2-0	5110223_12096930_46386116
5daef962-6ee9-45dd-8c4f-aa70008e8be6	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-1 1-1	1-1 1-1	active	30		\N		5	2	1-1 1-1	5110223_12096930_46386093
6b5c2374-db9b-4ef5-8a0f-aa70008e8bf2	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-1 0-1	0-1 0-1	active	23		\N		5	3	0-1 0-1	5110223_12096930_46386127
abe71480-f316-4ba2-a2d6-aa70008e8c00	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-0 2-1	1-0 2-1	active	35		\N		6	1	1-0 2-1	5110223_12096930_46386106
4d9f0c68-5325-4d39-9430-aa70008e8c0d	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-0 4plus	0-0 4plus	active	60		\N		6	2	0-0 4plus	5110223_12096930_46386126
9b1b5d79-8e5a-4c69-9149-aa70008e8c25	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-1 0-2	0-1 0-2	active	45		\N		6	3	0-1 0-2	5110223_12096930_46386096
cb88bebe-c09a-4a41-9668-aa70008e8c49	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-0 1-2	1-0 1-2	active	100		\N		7	1	1-0 1-2	5110223_12096930_46386112
087bfc14-7c8c-4a3c-ad80-aa70008e8c57	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-0 4plus	1-0 4plus	active	29		\N		7	2	1-0 4plus	5110223_12096930_46386103
7a2880fa-ee4b-426e-8166-aa70008e8c69	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-1 1-2	0-1 1-2	active	55		\N		7	3	0-1 1-2	5110223_12096930_46386088
9ea9cc5a-e1e3-4361-a9cb-aa70008e8c72	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-0 3-0	1-0 3-0	active	50		\N		8	1	1-0 3-0	5110223_12096930_46386130
0753085b-b42b-4570-8167-aa70008e8c7c	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-1 4plus	0-1 4plus	active	45		\N		8	2	0-1 4plus	5110223_12096930_46386109
8bcaf28b-5546-406a-9d16-aa70008e8c87	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-1 2-1	0-1 2-1	active	70		\N		8	3	0-1 2-1	5110223_12096930_46386120
3228e46f-2b04-4b8b-8823-aa70008e8c92	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-1 2-1	1-1 2-1	active	50		\N		9	1	1-1 2-1	5110223_12096930_46386090
4ce5bb5e-96fa-44bf-ac80-aa70008e8c9e	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-1 4plus	1-1 4plus	active	29.5		\N		9	2	1-1 4plus	5110223_12096930_46386102
489a645f-076f-4ec7-929c-aa70008e8caa	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	2-0 2-0	2-0 2-0	active	45		\N		10	1	2-0 2-0	5110223_12096930_46386094
4435ad03-358c-4366-9bb2-aa70008e8cb4	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-1 0-3	0-1 0-3	active	125		\N		9	3	0-1 0-3	5110223_12096930_46386097
316b4ae1-0f08-42a3-ad8a-aa70008e8cbf	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	2-0 4plus	2-0 4plus	active	35		\N		10	2	2-0 4plus	5110223_12096930_46386100
3c40c736-4e34-4ee1-8905-aa70008e8cc9	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-1 1-2	1-1 1-2	active	70		\N		10	3	1-1 1-2	5110223_12096930_46386110
f94bbc9b-763c-4253-91c0-aa70008e8cd2	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	2-0 2-1	2-0 2-1	active	90		\N		11	1	2-0 2-1	5110223_12096930_46386117
93c638dd-ecd6-4af2-bb51-aa70008e8cdb	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-2 4plus	0-2 4plus	active	80		\N		11	2	0-2 4plus	5110223_12096930_46386098
2791fab6-0c44-4b2a-9401-aa70008e8ceb	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-2 0-2	0-2 0-2	active	100		\N		11	3	0-2 0-2	5110223_12096930_46386122
4d7365d2-a826-4323-8593-aa70008e8cf6	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	2-1 2-1	2-1 2-1	active	125		\N		12	1	2-1 2-1	5110223_12096930_46386114
296fcb04-0d3c-4b4e-ae5c-aa70008e8d01	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	2-1 4plus	2-1 4plus	active	45		\N		12	2	2-1 4plus	5110223_12096930_46386107
8efb055d-1329-46ce-b6b8-aa70008e8d0c	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	2-0 3-0	2-0 3-0	active	60		\N		13	1	2-0 3-0	5110223_12096930_46386084
017f7e10-edd5-4eb6-9198-aa70008e8d17	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-2 1-2	0-2 1-2	active	125		\N		12	3	0-2 1-2	5110223_12096930_46386123
3a8f92c0-4991-4a60-9a24-aa70008e8d21	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-2 4plus	1-2 4plus	active	70		\N		13	2	1-2 4plus	5110223_12096930_46386129
f5ba3b9f-58a9-4fb0-98ed-aa70008e8d2a	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	1-2 1-2	1-2 1-2	active	150		\N		13	3	1-2 1-2	5110223_12096930_46386086
06f11296-b43e-4d69-976c-aa70008e8d35	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	3-0 3-0	3-0 3-0	active	150		\N		14	1	3-0 3-0	5110223_12096930_46386085
75f89db4-be86-4c4b-91a9-aa70008e8d40	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	3-0 4plus	3-0 4plus	active	90		\N		14	2	3-0 4plus	5110223_12096930_46386095
2051dd8e-3cbe-4481-b77e-aa70008e8d4a	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-2 0-3	0-2 0-3	active	150		\N		14	3	0-2 0-3	5110223_12096930_46386091
4a44501a-d8dd-4dc2-81b3-aa70008e8d53	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-3 4plus	0-3 4plus	active	200		\N		15	2	0-3 4plus	5110223_12096930_46386105
abdbeeca-26dd-41b6-b93a-aa70008e8d60	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	0-3 0-3	0-3 0-3	active	250		\N		15	3	0-3 0-3	5110223_12096930_46386087
c5d57e07-3863-41cf-9637-aa70008e8d6b	89cc3e5b-5c7f-4d15-bf5c-aa70008e8b4c	4plus 4plus	4plus 4plus	active	45		\N		16	2	4plus 4plus	5110223_12096930_46386115
e20bb1d0-f8b2-49f4-a498-aa70008e8d92	2bbd1475-67ec-4c45-b10e-aa70008e8d7e	Депортиво Ла Коруня/Draw and No	AXNo	active	1.51		\N		1	1	Депортиво Ла Коруня/Draw and No	5110223_12096928_46386030
d3079bcc-c66c-4536-b238-aa70008e8dab	2bbd1475-67ec-4c45-b10e-aa70008e8d7e	Депортиво Ла Коруня/РКД Майорка and Yes	ABYes	active	5.6		\N		1	2	Депортиво Ла Коруня/РКД Майорка and Yes	5110223_12096928_46386031
16cc8356-b772-4228-9d75-aa70008e8dbc	2bbd1475-67ec-4c45-b10e-aa70008e8d7e	Draw/РКД Майорка and Yes	BXYes	active	5.95		\N		1	3	Draw/РКД Майорка and Yes	5110223_12096928_46386033
a413af36-3893-459a-9dac-aa70008e8dcb	2bbd1475-67ec-4c45-b10e-aa70008e8d7e	Депортиво Ла Коруня/РКД Майорка and No	ABNo	active	1.59		\N		2	2	Депортиво Ла Коруня/РКД Майорка and No	5110223_12096928_46386032
d2e32677-b341-4df7-ada0-aa70008e8dd9	2bbd1475-67ec-4c45-b10e-aa70008e8d7e	Draw/РКД Майорка and No	BXNo	active	2.05		\N		2	3	Draw/РКД Майорка and No	5110223_12096928_46386034
8f564d85-b212-404c-a7d3-aa70008e8ded	9ed93ad2-a76e-46b3-b748-aa70008e8de3	Депортиво Ла Коруня/Draw and No	AXNo	active	1.4		\N		1	1	Депортиво Ла Коруня/Draw and No	5110223_12096926_46386018
bc7b0f07-73b2-4927-a357-aa70008e8df7	9ed93ad2-a76e-46b3-b748-aa70008e8de3	Депортиво Ла Коруня/РКД Майорка and Yes	ABYes	active	7.35		\N		1	2	Депортиво Ла Коруня/РКД Майорка and Yes	5110223_12096926_46386019
83b2d22a-9cbe-45f4-9c33-aa70008e8e02	9ed93ad2-a76e-46b3-b748-aa70008e8de3	Draw/РКД Майорка and Yes	BXYes	active	8.05		\N		1	3	Draw/РКД Майорка and Yes	5110223_12096926_46386021
a7874800-dd52-4298-9718-aa70008e8e0b	9ed93ad2-a76e-46b3-b748-aa70008e8de3	Депортиво Ла Коруня/РКД Майорка and No	ABNo	active	1.49		\N		2	2	Депортиво Ла Коруня/РКД Майорка and No	5110223_12096926_46386020
708dbebc-d1e0-444d-8945-aa70008e8e17	9ed93ad2-a76e-46b3-b748-aa70008e8de3	Draw/РКД Майорка and No	BXNo	active	1.87		\N		2	3	Draw/РКД Майорка and No	5110223_12096926_46386022
028f92a0-3f1b-4232-a7eb-aa70008e8e31	d39e068c-7415-4e0c-8260-aa70008e8e24	No/Over 2.5	YUnder	active	5.55		\N		1	1	No/Over 2.5	5110223_12096924_46386008
d2c70805-efd2-4053-b68b-aa70008e8e40	d39e068c-7415-4e0c-8260-aa70008e8e24	Yes/Over 2.5	YOver	active	2.75		\N		1	2	Yes/Over 2.5	5110223_12096924_46386007
1a508e86-7f8a-4cc8-9211-aa70008e8e4b	d39e068c-7415-4e0c-8260-aa70008e8e24	No/Under 2.5	NUnder	active	1.8		\N		2	1	No/Under 2.5	5110223_12096924_46386010
3402bb00-6d99-4fcd-b70b-aa70008e8e55	d39e068c-7415-4e0c-8260-aa70008e8e24	Yes/Under 2.5	NOver	active	9.6		\N		2	2	Yes/Under 2.5	5110223_12096924_46386009
2fcbc870-f966-4ad7-b9e4-aa70008e8e6b	a828abd7-78eb-4352-81db-aa70008e8e61	0	MR_0	active	1.84		\N		1	1	0	5110223_12096918_46385986
ac203157-9faa-49b4-a34e-aa70008e8e75	a828abd7-78eb-4352-81db-aa70008e8e61	1-2	MR_1-2	active	1.54		\N		1	2	1-2	5110223_12096918_46385987
2470bb02-097d-4a79-a6cf-aa70008e8e81	a828abd7-78eb-4352-81db-aa70008e8e61	1-3	MR_1-3	active	1.45		\N		1	3	1-3	5110223_12096918_46385988
df1b3a5b-b90e-4cf6-a8e1-aa70008e8e8c	a828abd7-78eb-4352-81db-aa70008e8e61	2-3	MR_2-3	active	3.25		\N		2	1	2-3	5110223_12096918_46385989
2878e239-3b44-4d0c-9612-aa70008e8e9b	a828abd7-78eb-4352-81db-aa70008e8e61	4+	MR_4+	active	27		\N		3	1	4+	5110223_12096918_46385990
21087092-5913-44d6-a0f1-aa70008e8eb2	4187c488-d96b-4fcd-9597-aa70008e8ea7	Депортиво Ла Коруня/Yes	AYes	active	17		\N		1	1	Депортиво Ла Коруня/Yes	5110223_12096916_46385975
00acbafb-4085-43bd-b49d-aa70008e8ebe	4187c488-d96b-4fcd-9597-aa70008e8ea7	Draw/Yes	XYes	active	8.2		\N		1	2	Draw/Yes	5110223_12096916_46385977
9bde9c00-d391-423e-817f-aa70008e8ec9	4187c488-d96b-4fcd-9597-aa70008e8ea7	РКД Майорка/Yes	BYes	active	23.5		\N		1	3	РКД Майорка/Yes	5110223_12096916_46385979
5f47538d-9bc5-4d26-924b-aa70008e8ed7	4187c488-d96b-4fcd-9597-aa70008e8ea7	Депортиво Ла Коруня/No	ANo	active	3		\N		2	1	Депортиво Ла Коруня/No	5110223_12096916_46385976
4888e40c-10c5-4774-a91e-aa70008e8ee6	4187c488-d96b-4fcd-9597-aa70008e8ea7	Draw/No	XNo	active	2.3		\N		2	2	Draw/No	5110223_12096916_46385978
1f2da9ba-5dce-45b4-91bd-aa70008e8ef1	4187c488-d96b-4fcd-9597-aa70008e8ea7	РКД Майорка/No	BNo	active	4.8		\N		2	3	РКД Майорка/No	5110223_12096916_46385980
4c5b4bd6-a46e-4490-97f3-aa70008e8f17	d621f7e7-beea-4351-b0d0-aa70008e8f00	Rc Deportivo La Coruna	A	active	1.37		\N		1	1	Rc Deportivo La Coruna	5110223_12096911_46385950
6d420b5d-0297-489c-848b-aa70008e8f2c	d621f7e7-beea-4351-b0d0-aa70008e8f00	РКД Майорка	B	active	2.12		\N		1	2	РКД Майорка	5110223_12096911_46385952
81fdb18b-29c2-405e-b143-aa70008e8f5a	936699cb-e1e1-46ca-acb4-aa70008e8f40	Odd	Odd	active	1.93		\N		1	1	Odd	5110223_12096908_46385945
cf20222b-0e2f-4850-959b-aa70008e8f66	936699cb-e1e1-46ca-acb4-aa70008e8f40	Even	Even	active	1.47		\N		1	2	Even	5110223_12096908_46385946
6088afb2-8f23-4408-8b66-aa70008e8f7b	30a9ce48-444c-48d0-9f00-aa70008e8f70	Odd	Odd	active	1.76		\N		1	1	Odd	5110223_12096904_46385937
5c34d363-07a3-4a2c-b67d-aa70008e8f8b	30a9ce48-444c-48d0-9f00-aa70008e8f70	Even	Even	active	1.58		\N		1	2	Even	5110223_12096904_46385938
98509a08-a7a3-4748-84c1-aa70008e8fa8	7d1e261a-9f54-452b-88a0-aa70008e8f9c	0	MR_0	active	5		\N		1	1	0	5110223_12096900_46385861
d45b005e-e61e-4c35-8a0e-aa70008e8fb3	7d1e261a-9f54-452b-88a0-aa70008e8f9c	1-2	MR_1-2	active	1.57		\N		1	2	1-2	5110223_12096900_46385862
79712f6f-0908-4979-be30-aa70008e8fbf	7d1e261a-9f54-452b-88a0-aa70008e8f9c	1-3	MR_1-3	active	1.25		\N		1	3	1-3	5110223_12096900_46385863
589ed287-ce8e-4af7-b847-aa70008e8fcb	7d1e261a-9f54-452b-88a0-aa70008e8f9c	1-4	MR_1-4	active	1.14		\N		2	1	1-4	5110223_12096900_46385864
2d80289a-5741-4080-b5f4-aa70008e8fd7	7d1e261a-9f54-452b-88a0-aa70008e8f9c	1-5	MR_1-5	active	1.09		\N		2	2	1-5	5110223_12096900_46385860
f911a771-1500-493f-829b-aa70008e8fe3	7d1e261a-9f54-452b-88a0-aa70008e8f9c	1-6	MR_1-6	active	1.08		\N		2	3	1-6	5110223_12096900_46385866
ff21e32b-66d0-4bf7-8a27-aa70008e8fef	7d1e261a-9f54-452b-88a0-aa70008e8f9c	2-3	MR_2-3	active	1.67		\N		3	1	2-3	5110223_12096900_46385868
4afaa0c2-acc1-475f-8e11-aa70008e8ffa	7d1e261a-9f54-452b-88a0-aa70008e8f9c	2-4	MR_2-4	active	1.44		\N		3	2	2-4	5110223_12096900_46385869
09541798-dff5-4474-8cd2-aa70008e900a	7d1e261a-9f54-452b-88a0-aa70008e8f9c	2-5	MR_2-5	active	1.35		\N		3	3	2-5	5110223_12096900_46385870
2217aa6e-005d-4e0c-bd18-aa70008e9018	7d1e261a-9f54-452b-88a0-aa70008e8f9c	2-6	MR_2-6	active	1.33		\N		4	1	2-6	5110223_12096900_46385872
e91fcb4b-d874-4862-aebf-aa70008e9024	7d1e261a-9f54-452b-88a0-aa70008e8f9c	3-4	MR_3-4	active	2.32		\N		4	2	3-4	5110223_12096900_46385875
6c8af6d7-20b1-4097-a7c3-aa70008e902e	7d1e261a-9f54-452b-88a0-aa70008e8f9c	3-5	MR_3-5	active	2.07		\N		4	3	3-5	5110223_12096900_46385873
44de49c4-2922-41e9-88f0-aa70008e903c	7d1e261a-9f54-452b-88a0-aa70008e8f9c	3-6	MR_3-6	active	2		\N		5	1	3-6	5110223_12096900_46385865
38088fcf-2554-4057-96ec-aa70008e904b	7d1e261a-9f54-452b-88a0-aa70008e8f9c	4-5	MR_4-5	active	3.9		\N		5	2	4-5	5110223_12096900_46385871
b9e0324d-00c7-4e23-981c-aa70008e9059	7d1e261a-9f54-452b-88a0-aa70008e8f9c	4-6	MR_4-6	active	3.6		\N		5	3	4-6	5110223_12096900_46385874
aec2f788-d880-4c0f-b269-aa70008e9066	7d1e261a-9f54-452b-88a0-aa70008e8f9c	5-6	MR_5-6	active	7.95		\N		6	2	5-6	5110223_12096900_46385867
38decbf3-4787-4a2d-9384-aa70008e9078	7d1e261a-9f54-452b-88a0-aa70008e8f9c	7+	MR_7+	active	35		\N		6	3	7+	5110223_12096900_46385876
391fc408-6b24-4c99-8a95-aa70008e90ac	4ab562ca-2126-40bb-916f-aa70008e908a	1st Half	H1	active	3.75		\N		1	1	1st Half	5110223_12096898_46385840
65a875bf-276e-4d41-be6f-aa70008e90b8	4ab562ca-2126-40bb-916f-aa70008e908a	2nd	H2	active	2.75		\N		1	2	2nd	5110223_12096898_46385841
fde53572-a192-4911-b575-aa70008e90c4	4ab562ca-2126-40bb-916f-aa70008e908a	Equal	Equal	active	1.76		\N		1	3	Equal	5110223_12096898_46385842
89b67f0b-1be8-4855-ad3a-aa70008e90da	07d7c7cb-ef4e-4836-b484-aa70008e90cf	Депортиво Ла Коруня/Draw and Yes	AXYes	active	4.85		\N		1	1	Депортиво Ла Коруня/Draw and Yes	5110223_12096894_46385825
da59ca25-055a-458a-aab5-aa70008e90e7	07d7c7cb-ef4e-4836-b484-aa70008e90cf	Депортиво Ла Коруня/РКД Майорка and Yes	ABYes	active	9.5		\N		1	2	Депортиво Ла Коруня/РКД Майорка and Yes	5110223_12096894_46385827
02c4080e-b49f-4e22-92d6-aa70008e90f3	07d7c7cb-ef4e-4836-b484-aa70008e90cf	Draw/РКД Майорка and Yes	BXYes	active	5.3		\N		1	3	Draw/РКД Майорка and Yes	5110223_12096894_46385829
19207cdb-57e6-42e7-8658-aa70008e90ff	07d7c7cb-ef4e-4836-b484-aa70008e90cf	Депортиво Ла Коруня/Draw and No	AXNo	active	1.26		\N		2	1	Депортиво Ла Коруня/Draw and No	5110223_12096894_46385826
e8d1e3ab-324d-4244-804b-aa70008e910b	07d7c7cb-ef4e-4836-b484-aa70008e90cf	Депортиво Ла Коруня/РКД Майорка and No	ABNo	active	1.67		\N		2	2	Депортиво Ла Коруня/РКД Майорка and No	5110223_12096894_46385828
2844436a-e30b-4c52-b21c-aa70008e9116	07d7c7cb-ef4e-4836-b484-aa70008e90cf	Draw/РКД Майорка and No	BXNo	active	1.45		\N		2	3	Draw/РКД Майорка and No	5110223_12096894_46385830
5a383606-1974-49a3-b94d-aa70008e912c	6ab816f6-64fa-4274-9321-aa70008e9121	Депортиво Ла Коруня/Draw and Yes	AXYes	active	2.45		\N		1	1	Депортиво Ла Коруня/Draw and Yes	5110223_12096892_46385813
864f5ef1-9710-48c4-aaee-aa70008e9137	6ab816f6-64fa-4274-9321-aa70008e9121	Депортиво Ла Коруня/РКД Майорка and Yes	ABYes	active	3.3		\N		1	2	Депортиво Ла Коруня/РКД Майорка and Yes	5110223_12096892_46385815
13f39c09-5154-4bfd-8a38-aa70008e9141	6ab816f6-64fa-4274-9321-aa70008e9121	Draw/РКД Майорка and Yes	BXYes	active	3.05		\N		1	3	Draw/РКД Майорка and Yes	5110223_12096892_46385817
4cc64714-0a8d-4c11-8a7e-aa70008e914e	6ab816f6-64fa-4274-9321-aa70008e9121	Депортиво Ла Коруня/Draw and No	AXNo	active	2.11		\N		2	1	Депортиво Ла Коруня/Draw and No	5110223_12096892_46385814
4bdc9898-23f0-45d3-9216-aa70008e9159	6ab816f6-64fa-4274-9321-aa70008e9121	Депортиво Ла Коруня/РКД Майорка and No	ABNo	active	1.99		\N		2	2	Депортиво Ла Коруня/РКД Майорка and No	5110223_12096892_46385816
f9cc880a-f9e0-47d7-b994-aa70008e9164	6ab816f6-64fa-4274-9321-aa70008e9121	Draw/РКД Майорка and No	BXNo	active	3.15		\N		2	3	Draw/РКД Майорка and No	5110223_12096892_46385818
1c813f2b-66ea-4755-8393-aa70008e9177	c21d408d-3d6c-43a8-9979-aa70008e916e	Депортиво Ла Коруня Score First and Депортиво Ла Коруня	A Goal/A	active	2.12		\N		1	1	Депортиво Ла Коруня Score First and Депортиво Ла Коруня	5110223_12096882_46385782
c69e4c45-8118-4473-b1a9-aa70008e9182	c21d408d-3d6c-43a8-9979-aa70008e916e	РКД Майорка Score First and Депортиво Ла Коруня	B Goal/A	active	15.75		\N		1	2	РКД Майорка Score First and Депортиво Ла Коруня	5110223_12096882_46385785
ec2c81ec-f45f-4d30-9523-aa70008e918d	c21d408d-3d6c-43a8-9979-aa70008e916e	Депортиво Ла Коруня Score First and Draw	A Goal/X	active	8.6		\N		1	3	Депортиво Ла Коруня Score First and Draw	5110223_12096882_46385783
b67aba59-c20e-4641-9357-aa70008e91a4	c21d408d-3d6c-43a8-9979-aa70008e916e	Депортиво Ла Коруня Score First and РКД Майорка	A Goal/B	active	27.5		\N		2	1	Депортиво Ла Коруня Score First and РКД Майорка	5110223_12096882_46385784
2444fe83-ae74-47d7-a336-aa70008e91b9	c21d408d-3d6c-43a8-9979-aa70008e916e	РКД Майорка Score First and Draw	B Goal/X	active	8.6		\N		2	3	РКД Майорка Score First and Draw	5110223_12096882_46385786
2753c4f4-01b1-4b33-8175-aa70008e91c7	c21d408d-3d6c-43a8-9979-aa70008e916e	РКД Майорка Score First and РКД Майорка	B Goal/B	active	4		\N		3	1	РКД Майорка Score First and РКД Майорка	5110223_12096882_46385787
3e729ca2-dd30-4f5f-9711-aa70008e91d7	c21d408d-3d6c-43a8-9979-aa70008e916e	No Goal	M3	active	6.85		\N		3	2	No Goal	5110223_12096882_46385788
f3a3a25d-6f90-4840-b7eb-aa70008e920b	c61a4e7d-291a-4f9c-99fd-aa70008e91ea	Депортиво Ла Коруня/Draw  Under 3.5	AXUnder	active	1.47		\N		1	1	Депортиво Ла Коруня/Draw  Under 3.5	5110223_12096864_46385703
9c4f2d22-b021-4c94-bbe3-aa70008e9219	c61a4e7d-291a-4f9c-99fd-aa70008e91ea	Депортиво Ла Коруня/РКД Майорка - Under 3.5	ABUnder	active	1.6		\N		1	2	Депортиво Ла Коруня/РКД Майорка - Under 3.5	5110223_12096864_46385704
292a1500-7f53-40f5-990a-aa70008e9225	c61a4e7d-291a-4f9c-99fd-aa70008e91ea	Draw/РКД Майорка  Under 3.5	XBUnder	active	1.9		\N		1	3	Draw/РКД Майорка  Under 3.5	5110223_12096864_46385705
19c70677-0bda-4207-a51e-aa70008e9235	c61a4e7d-291a-4f9c-99fd-aa70008e91ea	Депортиво Ла Коруня/Draw  Over 3.5	AXOver	active	5.1		\N		2	1	Депортиво Ла Коруня/Draw  Over 3.5	5110223_12096864_46385706
a732b457-18df-478c-b704-aa70008e9242	c61a4e7d-291a-4f9c-99fd-aa70008e91ea	Депортиво Ла Коруня/РКД Майорка  Over 3.5	ABOver	active	5.35		\N		2	2	Депортиво Ла Коруня/РКД Майорка  Over 3.5	5110223_12096864_46385707
5424c0f6-6758-4607-abf9-aa70008e9252	c61a4e7d-291a-4f9c-99fd-aa70008e91ea	Draw/РКД Майорка  Over 3.5	XBOver	active	7.95		\N		2	3	Draw/РКД Майорка  Over 3.5	5110223_12096864_46385708
e572e867-7561-4e82-8683-aa70008e959e	6773ee70-6537-416c-a433-aa70008e9584	No	No	active	1.01		\N		1	2	No	5110223_12096714_46385206
4d3b909a-2e05-4ea7-875e-aa70008e926c	6034fcaf-a4b6-4bd3-a54e-aa70008e9260	Депортиво Ла Коруня/Draw  Under 2.5	AXUnder	active	1.81		\N		1	1	Депортиво Ла Коруня/Draw  Under 2.5	5110223_12096862_46385691
efdc41df-992f-429c-b643-aa70008e927a	6034fcaf-a4b6-4bd3-a54e-aa70008e9260	Депортиво Ла Коруня/РКД Майорка - Under 2.5	ABUnder	active	2.34		\N		1	2	Депортиво Ла Коруня/РКД Майорка - Under 2.5	5110223_12096862_46385692
43b67660-30c3-4c7f-8016-aa70008e9288	6034fcaf-a4b6-4bd3-a54e-aa70008e9260	Draw/РКД Майорка  Under 2.5	XBUnder	active	2.22		\N		1	3	Draw/РКД Майорка  Under 2.5	5110223_12096862_46385693
12fa34c8-0c73-458f-8a75-aa70008e9297	6034fcaf-a4b6-4bd3-a54e-aa70008e9260	Депортиво Ла Коруня/Draw  Over 2.5	AXOver	active	3.05		\N		2	1	Депортиво Ла Коруня/Draw  Over 2.5	5110223_12096862_46385694
d33f60a4-e606-49b4-895c-aa70008e92a4	6034fcaf-a4b6-4bd3-a54e-aa70008e9260	Депортиво Ла Коруня/РКД Майорка  Over 2.5	ABOver	active	2.58		\N		2	2	Депортиво Ла Коруня/РКД Майорка  Over 2.5	5110223_12096862_46385695
29e3ba3e-8c77-4a20-8f34-aa70008e92b2	6034fcaf-a4b6-4bd3-a54e-aa70008e9260	Draw/РКД Майорка  Over 2.5	XBOver	active	5.15		\N		2	3	Draw/РКД Майорка  Over 2.5	5110223_12096862_46385696
8ebfd490-8b21-4061-bfbc-aa70008e92cb	0becdfd0-7335-4e96-9068-aa70008e92bf	Депортиво Ла Коруня/Draw  Under 1.5	AXUnder	active	3.2		\N		1	1	Депортиво Ла Коруня/Draw  Under 1.5	5110223_12096860_46385679
447fb0ba-88cc-4acd-bec9-aa70008e92db	0becdfd0-7335-4e96-9068-aa70008e92bf	Депортиво Ла Коруня/РКД Майорка - Under 1.5	ABUnder	active	3.5		\N		1	2	Депортиво Ла Коруня/РКД Майорка - Under 1.5	5110223_12096860_46385680
72d58033-3958-4014-81c2-aa70008e92e8	0becdfd0-7335-4e96-9068-aa70008e92bf	Draw/РКД Майорка  Under 1.5	XBUnder	active	3.85		\N		1	3	Draw/РКД Майорка  Under 1.5	5110223_12096860_46385681
7f01fcd3-09cf-4364-a36f-aa70008e92fd	0becdfd0-7335-4e96-9068-aa70008e92bf	Депортиво Ла Коруня/Draw  Over 1.5	AXOver	active	1.77		\N		2	1	Депортиво Ла Коруня/Draw  Over 1.5	5110223_12096860_46385682
d26206d3-66c9-4557-8aa1-aa70008e930c	0becdfd0-7335-4e96-9068-aa70008e92bf	Депортиво Ла Коруня/РКД Майорка  Over 1.5	ABOver	active	1.91		\N		2	2	Депортиво Ла Коруня/РКД Майорка  Over 1.5	5110223_12096860_46385683
9414b783-a19a-4c31-ba5b-aa70008e931c	0becdfd0-7335-4e96-9068-aa70008e92bf	Draw/РКД Майорка  Over 1.5	XBOver	active	2.57		\N		2	3	Draw/РКД Майорка  Over 1.5	5110223_12096860_46385684
16e8c085-ebca-4dd9-baa7-aa70008e9336	3de3d5d3-a2df-4683-92c3-aa70008e932a	Депортиво Ла Коруня/Draw  Under 4.5	AXUnder	active	1.29		\N		1	1	Депортиво Ла Коруня/Draw  Under 4.5	5110223_12096858_46385667
b82f2cc4-3b08-4685-b4df-aa70008e934b	3de3d5d3-a2df-4683-92c3-aa70008e932a	Депортиво Ла Коруня/РКД Майорка - Under 4.5	ABUnder	active	1.43		\N		1	2	Депортиво Ла Коруня/РКД Майорка - Under 4.5	5110223_12096858_46385668
7936ee09-e66e-4542-ad40-aa70008e936a	3de3d5d3-a2df-4683-92c3-aa70008e932a	Draw/РКД Майорка  Under 4.5	XBUnder	active	1.67		\N		1	3	Draw/РКД Майорка  Under 4.5	5110223_12096858_46385669
c04cd8a9-6edf-4b13-8d43-aa70008e9379	3de3d5d3-a2df-4683-92c3-aa70008e932a	Депортиво Ла Коруня/Draw  Over 4.5	AXOver	active	10.5		\N		2	1	Депортиво Ла Коруня/Draw  Over 4.5	5110223_12096858_46385670
f9cf92a5-4245-4d43-ae05-aa70008e9388	3de3d5d3-a2df-4683-92c3-aa70008e932a	Депортиво Ла Коруня/РКД Майорка  Over 4.5	ABOver	active	8.95		\N		2	2	Депортиво Ла Коруня/РКД Майорка  Over 4.5	5110223_12096858_46385671
d7d37429-0982-4793-b30f-aa70008e9396	3de3d5d3-a2df-4683-92c3-aa70008e932a	Draw/РКД Майорка  Over 4.5	XBOver	active	17.75		\N		2	3	Draw/РКД Майорка  Over 4.5	5110223_12096858_46385672
bf429f1f-f5c3-4f5d-83bb-aa70008e93b4	5136512f-14bb-4673-9ccd-aa70008e93a5	1-15	R_1-15	active	3.5		\N		1	1	1-15	5110223_12096852_46385643
b529b4a0-70f3-469d-8b07-aa70008e93c3	5136512f-14bb-4673-9ccd-aa70008e93a5	16-30	R_16-30	active	4.1		\N		1	2	16-30	5110223_12096852_46385645
a7645538-0a0e-4cbf-8e23-aa70008e93d8	5136512f-14bb-4673-9ccd-aa70008e93a5	31-45	R_31-45	active	4.95		\N		1	3	31-45	5110223_12096852_46385647
e6ee6bb8-b710-4f41-a6be-aa70008e93e8	5136512f-14bb-4673-9ccd-aa70008e93a5	46-60	R_46-60	active	7.35		\N		2	1	46-60	5110223_12096852_46385648
47607b92-930e-4a02-824c-aa70008e93f9	5136512f-14bb-4673-9ccd-aa70008e93a5	61-75	R_61-75	active	9.8		\N		2	2	61-75	5110223_12096852_46385649
f930d33c-2042-4c17-a08b-aa70008e9406	5136512f-14bb-4673-9ccd-aa70008e93a5	76-90	R_76-90	active	11.75		\N		3	1	76-90	5110223_12096852_46385650
e784a011-c1e0-4f38-9b2c-aa70008e9414	5136512f-14bb-4673-9ccd-aa70008e93a5	None	None	active	6.95		\N		4	1	None	5110223_12096852_46385640
d60fa0aa-672b-4678-8308-aa70008e942c	231fd7cb-4301-4aae-a16a-aa70008e9420	Депортиво Ла Коруня/Yes	AYes	active	14.5		\N		1	1	Депортиво Ла Коруня/Yes	5110223_12096848_46385619
5a85f6ca-72ae-4aae-909e-aa70008e9439	231fd7cb-4301-4aae-a16a-aa70008e9420	Draw/Yes	XYes	active	6.65		\N		1	2	Draw/Yes	5110223_12096848_46385621
f95735a7-3470-4a14-93ae-aa70008e944a	231fd7cb-4301-4aae-a16a-aa70008e9420	РКД Майорка/Yes	BYes	active	23.5		\N		1	3	РКД Майорка/Yes	5110223_12096848_46385624
41a1f470-d3d4-49b0-85e1-aa70008e945d	231fd7cb-4301-4aae-a16a-aa70008e9420	Депортиво Ла Коруня/No	ANo	active	2.65		\N		2	1	Депортиво Ла Коруня/No	5110223_12096848_46385620
b99f6100-a97d-4570-b548-aa70008e9476	231fd7cb-4301-4aae-a16a-aa70008e9420	Draw/No	XNo	active	2.95		\N		2	2	Draw/No	5110223_12096848_46385622
2092d9bd-d5a5-4b7b-b103-aa70008e9485	231fd7cb-4301-4aae-a16a-aa70008e9420	РКД Майорка/No	BNo	active	4.45		\N		2	3	РКД Майорка/No	5110223_12096848_46385626
e1fbf610-9070-4fac-84cf-aa70008e94ac	6f636c87-92ed-4077-a28f-aa70008e9493	61-70	R_61-70	active	13.75		\N		1	1	61-70	5110223_12096836_46385566
210cf411-f6ce-4e5c-b5bf-aa70008e94c1	6f636c87-92ed-4077-a28f-aa70008e9493	11-20	R_11-20	active	5.4		\N		1	2	11-20	5110223_12096836_46385559
5659d577-bcf4-402f-b10f-aa70008e94d3	6f636c87-92ed-4077-a28f-aa70008e9493	21-30	R_21-30	active	6.4		\N		1	3	21-30	5110223_12096836_46385561
8c7e062f-3b0e-4c7a-8cc6-aa70008e94de	6f636c87-92ed-4077-a28f-aa70008e9493	31-40	R_31-40	active	7.7		\N		2	1	31-40	5110223_12096836_46385562
1801d00e-df1f-4660-9110-aa70008e94ea	6f636c87-92ed-4077-a28f-aa70008e9493	41-50	R_41-50	active	8.5		\N		2	2	41-50	5110223_12096836_46385564
0287cefa-5197-4d95-a65b-aa70008e94f7	6f636c87-92ed-4077-a28f-aa70008e9493	81-90	R_81-90	active	17		\N		2	3	81-90	5110223_12096836_46385571
9962d456-666e-49ae-9380-aa70008e9515	6f636c87-92ed-4077-a28f-aa70008e9493	None	None	active	7.1		\N		3	1	None	5110223_12096836_46385555
97b73cf2-542f-4470-9578-aa70008e9527	6f636c87-92ed-4077-a28f-aa70008e9493	71-80	R_71-80	active	18		\N		3	2	71-80	5110223_12096836_46385569
9569c738-b829-49e6-9425-aa70008e9543	b5c3a5a5-34f4-49ca-b909-aa70008e9536	Rc Deportivo La Coruna	A	active	1.37		\N		1	1	Rc Deportivo La Coruna	5110223_12096830_46385531
8b78e742-9e3f-4216-bcf6-aa70008e9552	b5c3a5a5-34f4-49ca-b909-aa70008e9536	РКД Майорка	B	active	2.12		\N		1	2	РКД Майорка	5110223_12096830_46385532
733d7e8b-307b-41ea-be74-aa70008e956b	eb10947f-716a-411a-8a6a-aa70008e955e	Yes	Yes	active	2.1		\N		1	1	Yes	5110223_12096717_46385211
252d5242-37bc-4e0e-9eb9-aa70008e9577	eb10947f-716a-411a-8a6a-aa70008e955e	No	No	active	1.38		\N		1	2	No	5110223_12096717_46385213
11f6a39a-553f-412f-ab27-aa70008e9591	6773ee70-6537-416c-a433-aa70008e9584	Yes	Yes	active	5.65		\N		1	1	Yes	5110223_12096714_46385204
4166d8ac-93de-4345-a7c5-aa7000a76d7c	6900a0d8-3807-40a5-852c-aa7000a76d4d	Gottne IF or Draw	AX	active	1.2		\N		1	1	Gottne IF or Draw	5026340_12095170_46379302
89dcaf56-8eaf-479e-afcb-aa7000a76d86	6900a0d8-3807-40a5-852c-aa7000a76d4d	Gottne IF or IFK Umea	AB	active	1.17		\N		1	2	Gottne IF or IFK Umea	5026340_12095170_46379304
c580ac21-5040-4ae9-bdba-aa7000a76d8e	6900a0d8-3807-40a5-852c-aa7000a76d4d	Draw or IFK Umea	BX	active	1.78		\N		1	3	Draw or IFK Umea	5026340_12095170_46379306
7a6a2f72-67c7-4ef6-ae68-aa7000a76da0	6414b0d3-d260-48ac-bed3-aa7000a76d95	Gottne IF	A	active	1.42		\N		1	1	Gottne IF	5026340_12095175_46379318
b54aa3a8-89ce-4a30-ab31-aa7000a76da8	6414b0d3-d260-48ac-bed3-aa7000a76d95	IFK Umea	B	active	3.35		\N		1	2	IFK Umea	5026340_12095175_46379320
e1b6dd4f-e6dc-40ed-b426-aa7000a76dc0	08d476c0-31ef-40bf-a561-aa7000a76dba	Sandviks Ik or Draw	AX	active	1.23		\N		1	1	Sandviks Ik or Draw	5026342_12095462_46380262
e1d97a4b-82ea-4b7c-ae1a-aa7000a76dc6	08d476c0-31ef-40bf-a561-aa7000a76dba	Sandviks Ik or Anundsjo If	AB	active	1.18		\N		1	2	Sandviks Ik or Anundsjo If	5026342_12095462_46380263
4305d8c1-8392-4539-b120-aa7000a76dcd	08d476c0-31ef-40bf-a561-aa7000a76dba	Draw or Anundsjo If	BX	active	1.69		\N		1	3	Draw or Anundsjo If	5026342_12095462_46380264
3ed945d3-1bbe-42a4-b731-aa7000a76ddf	22759bdc-8b66-4784-8b0e-aa7000a76dd8	Sandviks IK	A	active	1.51		\N		1	1	Sandviks IK	5026342_12095464_46380267
e377afc7-eea7-48fd-9f73-aa7000a76de7	22759bdc-8b66-4784-8b0e-aa7000a76dd8	Anundsjo If	B	active	2.95		\N		1	2	Anundsjo If	5026342_12095464_46380268
5920e77f-0b5e-4ba6-9bf4-aa7000a76e04	f1033fee-ec21-44eb-93a1-aa7000a76dfb	2-1	2-1	active	11.5		\N		1	1	2-1	5026356_12111616_46435579
bfc78a1d-9a9f-4b4a-93eb-aa7000a76e0f	f1033fee-ec21-44eb-93a1-aa7000a76dfb	1-0	1-0	active	15		\N		1	2	1-0	5026356_12111616_46435584
20251eea-5df6-4102-a92e-aa7000a76e1e	f1033fee-ec21-44eb-93a1-aa7000a76dfb	2-0	2-0	active	9.85		\N		1	3	2-0	5026356_12111616_46435589
ea0b0a62-0f85-45c4-ac7a-aa7000a76e28	f1033fee-ec21-44eb-93a1-aa7000a76dfb	1-2	1-2	active	40		\N		2	1	1-2	5026356_12111616_46435592
5e5b0755-2a6f-4785-8964-aa7000a76e34	f1033fee-ec21-44eb-93a1-aa7000a76dfb	3-0	3-0	active	9.6		\N		2	2	3-0	5026356_12111616_46435598
68d4c7e3-fd21-4345-8b14-aa7000a76e3c	f1033fee-ec21-44eb-93a1-aa7000a76dfb	3-1	3-1	active	11.25		\N		2	3	3-1	5026356_12111616_46435606
72551273-c629-4edb-9dfc-aa7000a76e42	f1033fee-ec21-44eb-93a1-aa7000a76dfb	3-2	3-2	active	26		\N		3	1	3-2	5026356_12111616_46435611
7f30ef19-5458-4c4a-acd4-aa7000a76e49	f1033fee-ec21-44eb-93a1-aa7000a76dfb	4-0	4-0	active	12.5		\N		3	2	4-0	5026356_12111616_46435629
30678b43-b91d-47e4-8fad-aa7000a76e50	f1033fee-ec21-44eb-93a1-aa7000a76dfb	4-4	4-4	active	250		\N		3	3	4-4	5026356_12111616_46435633
8e4fa26f-b8e7-496d-af44-aa7000a76e57	f1033fee-ec21-44eb-93a1-aa7000a76dfb	0-1	0-1	active	55		\N		4	1	0-1	5026356_12111616_46435640
d7fe27ea-4235-435e-87b0-aa7000a76e5e	f1033fee-ec21-44eb-93a1-aa7000a76dfb	4-1	4-1	active	14.5		\N		4	2	4-1	5026356_12111616_46435648
80c73300-e5e8-4286-aca9-aa7000a76e65	f1033fee-ec21-44eb-93a1-aa7000a76dfb	2-3	2-3	active	90		\N		4	3	2-3	5026356_12111616_46435661
1b736a74-ca35-4539-9677-aa7000a76e6c	f1033fee-ec21-44eb-93a1-aa7000a76dfb	0-4	0-4	active	250		\N		5	1	0-4	5026356_12111616_46435666
f03d4624-9870-4d88-a991-aa7000a76e75	f1033fee-ec21-44eb-93a1-aa7000a76dfb	4-2	4-2	active	35		\N		5	2	4-2	5026356_12111616_46435671
7e24a629-55e2-4ed8-b408-aa7000a76e7e	f1033fee-ec21-44eb-93a1-aa7000a76dfb	1-4	1-4	active	250		\N		5	3	1-4	5026356_12111616_46435682
0da5fa73-1ad8-4180-9a65-aa7000a76e84	f1033fee-ec21-44eb-93a1-aa7000a76dfb	2-4	2-4	active	250		\N		6	1	2-4	5026356_12111616_46435687
f7d71dd8-f81d-48ad-8021-aa7000a76e8b	f1033fee-ec21-44eb-93a1-aa7000a76dfb	3-4	3-4	active	250		\N		6	2	3-4	5026356_12111616_46435694
b88c3d6f-7473-470b-b2ff-aa7000a76e92	f1033fee-ec21-44eb-93a1-aa7000a76dfb	2-2	2-2	active	28		\N		6	3	2-2	5026356_12111616_46435701
aff1ee39-34a5-4b70-b040-aa7000a76e99	f1033fee-ec21-44eb-93a1-aa7000a76dfb	1-3	1-3	active	150		\N		7	1	1-3	5026356_12111616_46435706
af78ca38-de76-416c-94cc-aa7000a76ea1	f1033fee-ec21-44eb-93a1-aa7000a76dfb	0-0	0-0	active	50		\N		7	2	0-0	5026356_12111616_46435713
d8d79c6f-8797-468e-9039-aa7000a76eb2	f1033fee-ec21-44eb-93a1-aa7000a76dfb	0-2	0-2	active	125		\N		7	3	0-2	5026356_12111616_46435718
875944a6-d876-47a4-a38b-aa7000a76ec3	f1033fee-ec21-44eb-93a1-aa7000a76dfb	3-3	3-3	active	100		\N		8	1	3-3	5026356_12111616_46435722
216bcba0-c372-4481-a3b0-aa7000a76ed3	f1033fee-ec21-44eb-93a1-aa7000a76dfb	4-3	4-3	active	125		\N		8	2	4-3	5026356_12111616_46435725
af785778-a1d2-444c-92d0-aa7000a76edb	f1033fee-ec21-44eb-93a1-aa7000a76dfb	Any Other	M1	active	4.65		\N		8	3	Any Other	5026356_12111616_46435730
a9f0ee11-6c6b-422c-9726-aa7000a76ee2	f1033fee-ec21-44eb-93a1-aa7000a76dfb	1-1	1-1	active	18.5		\N		9	1	1-1	5026356_12111616_46435734
d6cbc08e-5e38-4f35-9a8d-aa7000a76eeb	f1033fee-ec21-44eb-93a1-aa7000a76dfb	0-3	0-3	active	250		\N		9	2	0-3	5026356_12111616_46435737
7734a568-4a59-4b6a-823e-aa7000a76efb	5c92bff6-5076-4b09-847a-aa7000a76ef3	Yes	Yes	active	4.3		\N		1	1	Yes	5026356_12110864_46430868
271860ea-de07-4bb8-a3de-aa7000a76f3e	5c92bff6-5076-4b09-847a-aa7000a76ef3	No	No	active	1.15		\N		1	2	No	5026356_12110864_46430871
68a7d9bc-3269-4dc4-9aaa-aa7000a76f51	4b7e0f53-417d-4c7f-bc16-aa7000a76f46	0	0	active	5.2		\N		1	1	0	5026356_12111494_46434211
c3b6cae0-29c1-47b0-b053-aa7000a76f5e	4b7e0f53-417d-4c7f-bc16-aa7000a76f46	1	1	active	3		\N		1	2	1	5026356_12111494_46434216
bff80dd7-39a6-450e-bbb8-aa7000a76f70	4b7e0f53-417d-4c7f-bc16-aa7000a76f46	2	2	active	3.4		\N		1	3	2	5026356_12111494_46434224
255ab1a3-b7be-4d5f-ac68-aa7000a76f86	4b7e0f53-417d-4c7f-bc16-aa7000a76f46	3+	3+	active	3.5		\N		2	1	3+	5026356_12111494_46434228
25c46a9b-da6a-40e8-9f9e-aa7000a76fa3	99d697d8-ed44-487d-8339-aa7000a76f9c	Ifk Ostersund/Ifk Ostersund and over +4.5	A/AOver	active	3.5		\N		1	1	Ifk Ostersund/Ifk Ostersund and over +4.5	5026356_12111510_46434470
1bcfc116-77d8-427e-8b26-aa7000a76fab	99d697d8-ed44-487d-8339-aa7000a76f9c	Ifk Ostersund/Ifk Ostersund and under +4.5	A/AUnder	active	2.9		\N		1	2	Ifk Ostersund/Ifk Ostersund and under +4.5	5026356_12111510_46434554
4060209a-500c-4bc4-add5-aa7000a76fb4	99d697d8-ed44-487d-8339-aa7000a76f9c	Ifk Ostersund/Kramfors-alliansen and over +4.5	A/BOver	active	200		\N		2	1	Ifk Ostersund/Kramfors-alliansen and over +4.5	5026356_12111510_46434475
859d464b-85d8-425f-904e-aa7000a76fc0	99d697d8-ed44-487d-8339-aa7000a76f9c	Ifk Ostersund/Kramfors-alliansen and under +4.5	A/BUnder	active	150		\N		2	2	Ifk Ostersund/Kramfors-alliansen and under +4.5	5026356_12111510_46434530
ee340b03-ed8a-4d70-9cf9-aa7000a76fc7	99d697d8-ed44-487d-8339-aa7000a76f9c	Ifk Ostersund/Draw and over +4.5	A/XOver	active	150		\N		3	1	Ifk Ostersund/Draw and over +4.5	5026356_12111510_46434464
cc11a76d-11d9-4c5a-8a9d-aa7000a76fce	99d697d8-ed44-487d-8339-aa7000a76f9c	Ifk Ostersund/Draw and under +4.5	A/XUnder	active	40		\N		3	2	Ifk Ostersund/Draw and under +4.5	5026356_12111510_46434559
9c5e7761-e82b-47e0-805b-aa7000a76fd5	99d697d8-ed44-487d-8339-aa7000a76f9c	Kramfors-alliansen/Ifk Ostersund and over +4.5	B/AOver	active	45		\N		4	1	Kramfors-alliansen/Ifk Ostersund and over +4.5	5026356_12111510_46434515
51d38b92-b1f2-4609-9559-aa7000a76fdc	99d697d8-ed44-487d-8339-aa7000a76f9c	Kramfors-alliansen/Ifk Ostersund and under +4.5	B/AUnder	active	50		\N		4	2	Kramfors-alliansen/Ifk Ostersund and under +4.5	5026356_12111510_46434546
b7985034-fe1b-41bd-8060-aa7000a76fe3	99d697d8-ed44-487d-8339-aa7000a76f9c	Kramfors-alliansen/Kramfors-alliansen and over +4.5	B/BOver	active	100		\N		5	1	Kramfors-alliansen/Kramfors-alliansen and over +4.5	5026356_12111510_46434541
44c7afd3-a94e-4678-ae73-aa7000a76fe9	99d697d8-ed44-487d-8339-aa7000a76f9c	Kramfors-alliansen/Kramfors-alliansen and under +4.5	B/BUnder	active	30		\N		5	2	Kramfors-alliansen/Kramfors-alliansen and under +4.5	5026356_12111510_46434519
77a50cdf-fc20-4a71-b018-aa7000a76ff0	99d697d8-ed44-487d-8339-aa7000a76f9c	Kramfors-alliansen/Draw and over +4.5	B/XOver	active	150		\N		6	1	Kramfors-alliansen/Draw and over +4.5	5026356_12111510_46434523
fd0ced8c-c82c-4fad-97a1-aa7000a76ff8	99d697d8-ed44-487d-8339-aa7000a76f9c	Kramfors-alliansen/Draw and under +4.5	B/XUnder	active	40		\N		6	2	Kramfors-alliansen/Draw and under +4.5	5026356_12111510_46434551
0390d6ab-7a1e-4fba-90eb-aa7000a77000	99d697d8-ed44-487d-8339-aa7000a76f9c	Draw/{0} and over	X/AOver	active	20		\N		7	1	Draw/{0} and over	5026356_12111510_46434480
52c677df-f5e4-49ec-93ef-aa7000a77011	99d697d8-ed44-487d-8339-aa7000a76f9c	Draw/{0} and under	X/AUnder	active	6.4		\N		7	2	Draw/{0} and under	5026356_12111510_46434501
8cf7adb5-0aac-49d9-b866-aa7000a77024	99d697d8-ed44-487d-8339-aa7000a76f9c	Draw/Kramfors-alliansen and over +4.5	X/BOver	active	150		\N		8	1	Draw/Kramfors-alliansen and over +4.5	5026356_12111510_46434509
365f1c3a-a253-454f-8122-aa7000a7703c	99d697d8-ed44-487d-8339-aa7000a76f9c	Draw/Kramfors-alliansen and under +4.5	X/BUnder	active	40		\N		8	2	Draw/Kramfors-alliansen and under +4.5	5026356_12111510_46434486
bf22cf06-1059-48e0-8e32-aa7000a77054	99d697d8-ed44-487d-8339-aa7000a76f9c	Draw/Draw and over	X/XOver	active	150		\N		9	1	Draw/Draw and over	5026356_12111510_46434491
4582bd8d-935c-43b6-8a75-aa7000a7705c	99d697d8-ed44-487d-8339-aa7000a76f9c	Draw/Draw and under	X/XUnder	active	16		\N		9	2	Draw/Draw and under	5026356_12111510_46434534
9dcab09a-56d3-4ded-adee-aa7000a7706b	21b31e6d-7968-4716-8d79-aa7000a77063	Ifk Ostersund/Ifk Ostersund and over +3.5	A/AOver	active	2.44		\N		1	1	Ifk Ostersund/Ifk Ostersund and over +3.5	5026356_12111564_46435073
5825d800-4b7d-4ab2-a746-aa7000a77073	21b31e6d-7968-4716-8d79-aa7000a77063	Ifk Ostersund/Ifk Ostersund and under +3.5	A/AUnder	active	4.45		\N		1	2	Ifk Ostersund/Ifk Ostersund and under +3.5	5026356_12111564_46435171
c6d5ec8a-c3d6-4ed9-b5f1-aa7000a7707d	21b31e6d-7968-4716-8d79-aa7000a77063	Ifk Ostersund/Kramfors-alliansen and over +3.5	A/BOver	active	150		\N		2	1	Ifk Ostersund/Kramfors-alliansen and over +3.5	5026356_12111564_46435069
227bbc9b-825d-49bd-a509-aa7000a77085	21b31e6d-7968-4716-8d79-aa7000a77063	Ifk Ostersund/Kramfors-alliansen and under +3.5	A/BUnder	active	200		\N		2	2	Ifk Ostersund/Kramfors-alliansen and under +3.5	5026356_12111564_46435146
dc114a5d-7b78-412e-8ad7-aa7000a7708e	21b31e6d-7968-4716-8d79-aa7000a77063	Ifk Ostersund/Draw and over +3.5	A/XOver	active	60		\N		3	1	Ifk Ostersund/Draw and over +3.5	5026356_12111564_46435082
ff87e9fb-3c38-41e6-9c2f-aa7000a77095	21b31e6d-7968-4716-8d79-aa7000a77063	Ifk Ostersund/Draw and under +3.5	A/XUnder	active	70		\N		3	2	Ifk Ostersund/Draw and under +3.5	5026356_12111564_46435176
9014f422-71be-4f9b-8822-aa7000a7709e	21b31e6d-7968-4716-8d79-aa7000a77063	Kramfors-alliansen/Ifk Ostersund and over +3.5	B/AOver	active	30		\N		4	1	Kramfors-alliansen/Ifk Ostersund and over +3.5	5026356_12111564_46435126
b4f21fca-2f54-41ef-be1d-aa7000a770a6	21b31e6d-7968-4716-8d79-aa7000a77063	Kramfors-alliansen/Ifk Ostersund and under +3.5	B/AUnder	active	80		\N		4	2	Kramfors-alliansen/Ifk Ostersund and under +3.5	5026356_12111564_46435141
240dbd36-b676-4119-8851-aa7000a770ae	21b31e6d-7968-4716-8d79-aa7000a77063	Kramfors-alliansen/Kramfors-alliansen and over +3.5	B/BOver	active	70		\N		5	1	Kramfors-alliansen/Kramfors-alliansen and over +3.5	5026356_12111564_46435159
b04e9834-092c-457c-826d-aa7000a770b6	21b31e6d-7968-4716-8d79-aa7000a77063	Kramfors-alliansen/Kramfors-alliansen and under +3.5	B/BUnder	active	40		\N		5	2	Kramfors-alliansen/Kramfors-alliansen and under +3.5	5026356_12111564_46435104
bab4cabb-30db-4db1-bbc2-aa7000a770be	21b31e6d-7968-4716-8d79-aa7000a77063	Kramfors-alliansen/Draw and over +3.5	B/XOver	active	60		\N		6	1	Kramfors-alliansen/Draw and over +3.5	5026356_12111564_46435152
dc24421d-97b3-4d10-af44-aa7000a770c7	21b31e6d-7968-4716-8d79-aa7000a77063	Kramfors-alliansen/Draw and under +3.5	B/XUnder	active	80		\N		6	2	Kramfors-alliansen/Draw and under +3.5	5026356_12111564_46435166
489d66e9-45a8-4e0a-b8cf-aa7000a770d4	21b31e6d-7968-4716-8d79-aa7000a77063	Draw/{0} and over	X/AOver	active	12		\N		7	1	Draw/{0} and over	5026356_12111564_46435088
a331e237-356a-4b18-9da9-aa7000a770e2	21b31e6d-7968-4716-8d79-aa7000a77063	Draw/{0} and under	X/AUnder	active	7.9		\N		7	2	Draw/{0} and under	5026356_12111564_46435095
e156165e-40ca-4f16-be2e-aa7000a770eb	21b31e6d-7968-4716-8d79-aa7000a77063	Draw/Kramfors-alliansen and over +3.5	X/BOver	active	125		\N		8	1	Draw/Kramfors-alliansen and over +3.5	5026356_12111564_46435120
378ba36c-ad71-4a45-8ebe-aa7000a770f5	21b31e6d-7968-4716-8d79-aa7000a77063	Draw/Kramfors-alliansen and under +3.5	X/BUnder	active	40		\N		8	2	Draw/Kramfors-alliansen and under +3.5	5026356_12111564_46435132
920793c8-71af-4128-b554-aa7000a770ff	21b31e6d-7968-4716-8d79-aa7000a77063	Draw/Draw and over	X/XOver	active	60		\N		9	1	Draw/Draw and over	5026356_12111564_46435115
588aeeb5-779e-40f1-b7fc-aa7000a77106	21b31e6d-7968-4716-8d79-aa7000a77063	Draw/Draw and under	X/XUnder	active	20		\N		9	2	Draw/Draw and under	5026356_12111564_46435108
34f14b78-6c91-4990-bc66-aa7000a77116	88411be4-8f9a-4276-912d-aa7000a7710d	ИФК Йостерсунд -2.75	AH	active	2.38		\N		1	1	ИФК Йостерсунд -2.75	5026356_12111899_46437305
33aef3fc-faaa-4a81-9093-aa7000a7711d	88411be4-8f9a-4276-912d-aa7000a7710d	Kramfors-alliansen +2.75	BH	active	1.47		\N		1	2	Kramfors-alliansen +2.75	5026356_12111899_46437306
4b1418e4-ec5c-4103-9cee-aa7000a7712c	c4c5b107-16d4-458b-ac73-aa7000a77124	Ifk Ostersund/Ifk Ostersund and over +2.5	A/AOver	active	1.88		\N		1	1	Ifk Ostersund/Ifk Ostersund and over +2.5	5026356_12111545_46434855
31442137-a23b-44c2-a598-aa7000a77134	c4c5b107-16d4-458b-ac73-aa7000a77124	Ifk Ostersund/Ifk Ostersund and under +2.5	A/AUnder	active	10		\N		1	2	Ifk Ostersund/Ifk Ostersund and under +2.5	5026356_12111545_46434936
7d6d7546-7f7c-438b-8f64-aa7000a7713b	c4c5b107-16d4-458b-ac73-aa7000a77124	Ifk Ostersund/Kramfors-alliansen and over +2.5	A/BOver	active	125		\N		2	1	Ifk Ostersund/Kramfors-alliansen and over +2.5	5026356_12111545_46434848
f88b6786-4cd3-4f30-a5b9-aa7000a77143	c4c5b107-16d4-458b-ac73-aa7000a77124	Ifk Ostersund/Draw and under +2.5	A/XUnder	active	70		\N		2	2	Ifk Ostersund/Draw and under +2.5	5026356_12111545_46434942
c535e923-cb82-4900-91e5-aa7000a7714c	c4c5b107-16d4-458b-ac73-aa7000a77124	Ifk Ostersund/Draw and over +2.5	A/XOver	active	60		\N		3	1	Ifk Ostersund/Draw and over +2.5	5026356_12111545_46434868
3be0d295-b4fb-4263-bd60-aa7000a77156	c4c5b107-16d4-458b-ac73-aa7000a77124	Kramfors-alliansen/Ifk Ostersund and over +2.5	B/AOver	active	22.5		\N		4	1	Kramfors-alliansen/Ifk Ostersund and over +2.5	5026356_12111545_46434899
58da4545-f4c8-4eff-99dc-aa7000a77160	c4c5b107-16d4-458b-ac73-aa7000a77124	Kramfors-alliansen/Kramfors-alliansen and under +2.5	B/BUnder	active	70		\N		4	2	Kramfors-alliansen/Kramfors-alliansen and under +2.5	5026356_12111545_46434911
d596719a-310c-495e-9a3f-aa7000a77168	c4c5b107-16d4-458b-ac73-aa7000a77124	Kramfors-alliansen/Kramfors-alliansen and over +2.5	B/BOver	active	35		\N		5	1	Kramfors-alliansen/Kramfors-alliansen and over +2.5	5026356_12111545_46434923
e62be98d-eb03-43d1-8960-aa7000a77170	c4c5b107-16d4-458b-ac73-aa7000a77124	Kramfors-alliansen/Draw and under +2.5	B/XUnder	active	70		\N		5	2	Kramfors-alliansen/Draw and under +2.5	5026356_12111545_46434906
e51fa55a-aa28-4710-b990-aa7000a77178	c4c5b107-16d4-458b-ac73-aa7000a77124	Kramfors-alliansen/Draw and over +2.5	B/XOver	active	60		\N		6	1	Kramfors-alliansen/Draw and over +2.5	5026356_12111545_46434917
a25cc112-afc7-46f5-8ad8-aa7000a77189	c4c5b107-16d4-458b-ac73-aa7000a77124	Draw/{0} and under	X/AUnder	active	13.25		\N		6	2	Draw/{0} and under	5026356_12111545_46434872
8c9537a8-6bab-476a-b5a3-aa7000a771a8	c4c5b107-16d4-458b-ac73-aa7000a77124	Draw/{0} and over	X/AOver	active	7.25		\N		7	1	Draw/{0} and over	5026356_12111545_46434877
92b2546d-d12f-4132-9d52-aa7000a771bd	c4c5b107-16d4-458b-ac73-aa7000a77124	Draw/Kramfors-alliansen and under +2.5	X/BUnder	active	70		\N		7	2	Draw/Kramfors-alliansen and under +2.5	5026356_12111545_46434862
6b6fbf1c-3730-4cea-87ed-aa7000a7792a	6c752021-8c08-45c3-b3a5-aa7000a776e6	1-1	1-1	active	9.95		\N		2	2	1-1	5026356_12110896_46430993
ce3dbec1-373b-4b87-ab27-aa7000a771c7	c4c5b107-16d4-458b-ac73-aa7000a77124	Draw/Kramfors-alliansen and over +2.5	X/BOver	active	55		\N		8	1	Draw/Kramfors-alliansen and over +2.5	5026356_12111545_46434893
ef065fe9-9326-493b-a7d1-aa7000a771cf	c4c5b107-16d4-458b-ac73-aa7000a77124	Draw/Draw and under	X/XUnder	active	20		\N		8	2	Draw/Draw and under	5026356_12111545_46434926
67d6901f-65b5-4243-b572-aa7000a771d9	c4c5b107-16d4-458b-ac73-aa7000a77124	Draw/Draw and over	X/XOver	active	55		\N		9	1	Draw/Draw and over	5026356_12111545_46434885
531745d7-4d01-4246-b066-aa7000a771eb	52ea676c-3ff2-4883-a704-aa7000a771e2	Ifk Ostersund/Ifk Ostersund and over +1.5	A/AOver	active	1.67		\N		1	1	Ifk Ostersund/Ifk Ostersund and over +1.5	5026356_12111527_46434677
1e183831-45d8-48a7-84cd-aa7000a771f5	52ea676c-3ff2-4883-a704-aa7000a771e2	Ifk Ostersund/Ifk Ostersund and under +1.5	A/AUnder	active	35		\N		1	2	Ifk Ostersund/Ifk Ostersund and under +1.5	5026356_12111527_46434736
f7325f8a-cae1-49b9-8c21-aa7000a771fd	52ea676c-3ff2-4883-a704-aa7000a771e2	Ifk Ostersund/Kramfors-alliansen and over +1.5	A/BOver	active	125		\N		2	1	Ifk Ostersund/Kramfors-alliansen and over +1.5	5026356_12111527_46434688
c26ca4fc-2622-4908-8eac-aa7000a77206	52ea676c-3ff2-4883-a704-aa7000a771e2	Ifk Ostersund/Draw and over +1.5	A/XOver	active	35		\N		3	1	Ifk Ostersund/Draw and over +1.5	5026356_12111527_46434683
a36e7192-ed3d-4e2a-9556-aa7000a7720f	52ea676c-3ff2-4883-a704-aa7000a771e2	Kramfors-alliansen/Ifk Ostersund and over +1.5	B/AOver	active	22.5		\N		4	1	Kramfors-alliansen/Ifk Ostersund and over +1.5	5026356_12111527_46434717
fab05a86-470b-4494-bb23-aa7000a77217	52ea676c-3ff2-4883-a704-aa7000a771e2	Kramfors-alliansen/Kramfors-alliansen and under +1.5	B/BUnder	active	125		\N		4	2	Kramfors-alliansen/Kramfors-alliansen and under +1.5	5026356_12111527_46434700
f3dcfa4d-756a-43f7-bddf-aa7000a77222	52ea676c-3ff2-4883-a704-aa7000a771e2	Kramfors-alliansen/Kramfors-alliansen and over +1.5	B/BOver	active	28.5		\N		5	1	Kramfors-alliansen/Kramfors-alliansen and over +1.5	5026356_12111527_46434729
6fea1d7c-bbad-4122-8bbe-aa7000a77230	52ea676c-3ff2-4883-a704-aa7000a771e2	Kramfors-alliansen/Draw and over +1.5	B/XOver	active	35		\N		6	1	Kramfors-alliansen/Draw and over +1.5	5026356_12111527_46434723
4170efac-0083-4b69-a31f-aa7000a7723d	52ea676c-3ff2-4883-a704-aa7000a771e2	Draw/{0} and under	X/AUnder	active	24.5		\N		6	2	Draw/{0} and under	5026356_12111527_46434748
85dee2da-fc69-4d91-b2b2-aa7000a7724b	52ea676c-3ff2-4883-a704-aa7000a771e2	Draw/{0} and over	X/AOver	active	5.75		\N		7	1	Draw/{0} and over	5026356_12111527_46434671
1547303e-9a39-43cb-b9f3-aa7000a77256	52ea676c-3ff2-4883-a704-aa7000a771e2	Draw/Kramfors-alliansen and under +1.5	X/BUnder	active	90		\N		7	2	Draw/Kramfors-alliansen and under +1.5	5026356_12111527_46434707
a25eac1c-4f42-4cac-ae42-aa7000a7725f	52ea676c-3ff2-4883-a704-aa7000a771e2	Draw/Kramfors-alliansen and over +1.5	X/BOver	active	50		\N		8	1	Draw/Kramfors-alliansen and over +1.5	5026356_12111527_46434712
788c99fa-06d7-4f93-908f-aa7000a77267	52ea676c-3ff2-4883-a704-aa7000a771e2	Draw/Draw and under	X/XUnder	active	45		\N		8	2	Draw/Draw and under	5026356_12111527_46434742
0b986a35-ddf3-46bf-92fe-aa7000a77272	52ea676c-3ff2-4883-a704-aa7000a771e2	Draw/Draw and over	X/XOver	active	21		\N		9	1	Draw/Draw and over	5026356_12111527_46434694
5121a43e-a234-483a-915c-aa7000a77283	aefe765a-bc63-4058-99e3-aa7000a7727a	Under 1.25	Under	active	2.31		\N		1	1	Under 1.25	5026356_12110536_46430072
5a35d3e6-7a6e-4ab8-b633-aa7000a7728b	aefe765a-bc63-4058-99e3-aa7000a7727a	Over 1.25	Over	active	1.5		\N		1	2	Over 1.25	5026356_12110536_46430069
3ba1ce87-556c-46bf-a5a4-aa7000a7729d	d6efc55a-ad38-4eff-918b-aa7000a77294	Under 1.5	Under	active	1.9		\N		1	1	Under 1.5	5026356_12110524_46430048
bb063336-40be-4167-ba43-aa7000a772a6	d6efc55a-ad38-4eff-918b-aa7000a77294	Over 1.5	Over	active	1.74		\N		1	2	Over 1.5	5026356_12110524_46430044
b7647990-f98d-4c7a-9013-aa7000a772b7	c90fb92e-87a7-4618-8a0b-aa7000a772af	Under 1.75	Under	active	1.68		\N		1	1	Under 1.75	5026356_12110512_46430021
40de550b-7b48-4c1f-aac8-aa7000a772c0	c90fb92e-87a7-4618-8a0b-aa7000a772af	Over 1.75	Over	active	1.99		\N		1	2	Over 1.75	5026356_12110512_46430016
1cf41b0b-22f7-4b9b-9b97-aa7000a772d0	b2643003-454b-4b01-b36e-aa7000a772c8	ИФК Йостерсунд -2.25	AH	active	1.91		\N		1	1	ИФК Йостерсунд -2.25	5026356_12110492_46429967
de06327c-fc2b-4097-ad59-aa7000a772d8	b2643003-454b-4b01-b36e-aa7000a772c8	Kramfors-alliansen +2.25	BH	active	1.74		\N		1	2	Kramfors-alliansen +2.25	5026356_12110492_46429970
e5d92f3a-b639-4c6a-8d6e-aa7000a7731d	00670801-2cf8-44e4-b376-aa7000a772fc	ИФК Йостерсунд -2.5	AH	active	2.1		\N		1	1	ИФК Йостерсунд -2.5	5026356_12110483_46429947
e482ee20-6dde-45f6-9eff-aa7000a77325	00670801-2cf8-44e4-b376-aa7000a772fc	Kramfors-alliansen +2.5	BH	active	1.6		\N		1	2	Kramfors-alliansen +2.5	5026356_12110483_46429948
1c410136-1120-4aff-9c96-aa7000a77362	cc73bf82-de4f-4b95-8a22-aa7000a7732e	ИФК Йостерсунд -1.75	AH	active	1.57		\N		1	1	ИФК Йостерсунд -1.75	5026356_12110464_46429920
29238647-2db0-4ddc-af3e-aa7000a7736a	cc73bf82-de4f-4b95-8a22-aa7000a7732e	Kramfors-alliansen +1.75	BH	active	2.16		\N		1	2	Kramfors-alliansen +1.75	5026356_12110464_46429927
b4bbc90c-b188-474f-9674-aa7000a7737a	41630da4-b796-4fb8-842c-aa7000a77372	ИФК Йостерсунд -2	AH	active	1.71		\N		1	1	ИФК Йостерсунд -2	5026356_12110449_46429873
f31c71c5-8ba6-4a5c-81f0-aa7000a77387	41630da4-b796-4fb8-842c-aa7000a77372	Kramfors-alliansen +2	BH	active	1.94		\N		1	2	Kramfors-alliansen +2	5026356_12110449_46429874
4e72de64-bb5d-4091-8489-aa7000a773c3	e0ea15fe-322d-49c3-9a26-aa7000a773b7	No/No	NN	active	1.77		\N		1	1	No/No	5026356_12110379_46429713
99826e6c-e9d7-422a-866e-aa7000a773ce	e0ea15fe-322d-49c3-9a26-aa7000a773b7	Yes/No	YN	active	5.3		\N		1	2	Yes/No	5026356_12110379_46429719
29b4e7e6-e726-4b07-b0ec-aa7000a773d8	e0ea15fe-322d-49c3-9a26-aa7000a773b7	Yes/Yes	YY	active	12		\N		1	3	Yes/Yes	5026356_12110379_46429725
667940e1-66b8-49b6-ba59-aa7000a773e1	e0ea15fe-322d-49c3-9a26-aa7000a773b7	No/Yes	NY	active	3.8		\N		2	1	No/Yes	5026356_12110379_46429728
9a79e81d-5b07-4f8c-819b-aa7000a773f0	b1f06cb7-e7f5-4500-a651-aa7000a773e8	Yes	Yes	active	1.37		\N		1	1	Yes	5026356_12110309_46429521
1e78d054-438d-4676-8b80-aa7000a773fa	b1f06cb7-e7f5-4500-a651-aa7000a773e8	No	No	active	2.7		\N		1	2	No	5026356_12110309_46429527
01efd2ec-3322-444c-80c6-aa7000a7740a	9ef27af0-a814-4ad9-95b3-aa7000a77403	Under 3.5	Under	active	2.25		\N		1	1	Under 3.5	5026356_12110642_46430347
e143eb57-7f4a-4913-8d1f-aa7000a77414	9ef27af0-a814-4ad9-95b3-aa7000a77403	Over 3.5	Over	active	1.81		\N		1	2	Over 3.5	5026356_12110642_46430344
730ba0fd-5fd8-4343-9507-aa7000a77426	347b900b-7199-49f3-9947-aa7000a7741e	Under 2.5	Under	active	4.1		\N		1	1	Under 2.5	5026356_12110631_46430321
a784ff92-4590-4ff0-b2de-aa7000a7742f	347b900b-7199-49f3-9947-aa7000a7741e	Over 2.5	Over	active	1.32		\N		1	2	Over 2.5	5026356_12110631_46430317
7c51b070-e68d-4a51-bed4-aa7000a77441	3a7b39b2-aba0-44ca-85fa-aa7000a77438	Under 1.5	Under	active	10.75		\N		1	1	Under 1.5	5026356_12110619_46430287
9ee7a3b1-7cf2-480d-99f9-aa7000a77449	3a7b39b2-aba0-44ca-85fa-aa7000a77438	Over 1.5	Over	active	1.1		\N		1	2	Over 1.5	5026356_12110619_46430284
0cdd2895-4a80-453c-aaf5-aa7000a7746c	948e74f4-52b6-4a07-ac2c-aa7000a7745a	Under 5.5	Under	active	1.25		\N		1	1	Under 5.5	5026356_12110608_46430257
aa91cf0d-a603-4a32-b92f-aa7000a77479	948e74f4-52b6-4a07-ac2c-aa7000a7745a	Over 5.5	Over	active	4.95		\N		1	2	Over 5.5	5026356_12110608_46430251
fe1b60f9-c967-4997-b9c5-aa7000a77496	3f10d3eb-cc22-4519-9439-aa7000a77484	Under 4.5	Under	active	1.56		\N		1	1	Under 4.5	5026356_12110596_46430222
355a30bc-18da-4224-b3e7-aa7000a774a1	3f10d3eb-cc22-4519-9439-aa7000a77484	Over 4.5	Over	active	2.8		\N		1	2	Over 4.5	5026356_12110596_46430217
d271ed0d-1bd4-4bf1-8f1c-aa7000a774b7	d0576bfe-7ca7-4949-8df0-aa7000a774ab	ИФК Йостерсунд or Draw	AX	active	1.04		\N		1	1	ИФК Йостерсунд or Draw	5026356_12095172_46379301
399a947b-d4e7-42b8-806e-aa7000a774c0	d0576bfe-7ca7-4949-8df0-aa7000a774ab	ИФК Йостерсунд or Kramfors-alliansen	AB	active	1.06		\N		1	2	ИФК Йостерсунд or Kramfors-alliansen	5026356_12095172_46379303
0b5cba58-90ba-4f1f-9946-aa7000a774c8	d0576bfe-7ca7-4949-8df0-aa7000a774ab	Draw or Kramfors-alliansen	BX	active	2.95		\N		1	3	Draw or Kramfors-alliansen	5026356_12095172_46379305
cd9b59d2-7058-4630-94c8-aa7000a774d7	65ec8936-e9a1-4e28-97cd-aa7000a774d0	Ifk Ostersund	A	active	1.16		\N		1	1	Ifk Ostersund	5026356_12111889_46437282
661b967b-d2f8-4cc5-b350-aa7000a774e0	65ec8936-e9a1-4e28-97cd-aa7000a774d0	Draw	X	active	7.15		\N		1	2	Draw	5026356_12111889_46437283
4747eba4-6291-4687-b453-aa7000a774e9	65ec8936-e9a1-4e28-97cd-aa7000a774d0	Kramfors-alliansen	B	active	10.5		\N		1	3	Kramfors-alliansen	5026356_12111889_46437284
6355135e-8230-4372-a1b3-aa7000a774ff	23e36f62-38fa-42bc-a33e-aa7000a774f3	Yes	Yes	active	1.68		\N		1	1	Yes	5026356_12111668_46435989
913975a6-f80d-478f-9417-aa7000a77508	23e36f62-38fa-42bc-a33e-aa7000a774f3	No	No	active	1.99		\N		1	2	No	5026356_12111668_46435996
00700435-1dfc-4c0b-b7b0-aa7000a7751b	620143d8-1b9e-4354-b415-aa7000a77513	ИФК Йостерсунд -1	AH	active	1.48		\N		1	1	ИФК Йостерсунд -1	5026356_12111498_46434269
cb761f65-bd43-4e96-814a-aa7000a77524	620143d8-1b9e-4354-b415-aa7000a77513	Draw sigendLine	XH	active	4.7		\N		1	2	Draw sigendLine	5026356_12111498_46434277
559fd6ac-aac5-4c2c-9004-aa7000a7752c	620143d8-1b9e-4354-b415-aa7000a77513	Kramfors-alliansen +1	BH	active	4.7		\N		1	3	Kramfors-alliansen +1	5026356_12111498_46434285
ff0c643a-0f69-497d-a02d-aa7000a7753c	24eca9f5-307e-4d18-80f4-aa7000a77534	ИФК Йостерсунд +1	AH	active	1.03		\N		1	1	ИФК Йостерсунд +1	5026356_12110584_46430179
494ba456-c4ec-4080-939a-aa7000a77543	24eca9f5-307e-4d18-80f4-aa7000a77534	Draw sigendLine	XH	active	10.5		\N		1	2	Draw sigendLine	5026356_12110584_46430184
c4c14ab3-0953-43fe-a0ed-aa7000a7754b	24eca9f5-307e-4d18-80f4-aa7000a77534	Kramfors-alliansen -1	BH	active	26		\N		1	3	Kramfors-alliansen -1	5026356_12110584_46430189
ca4d4e3e-2305-4897-8a84-aa7000a7755a	de2c7fdd-7e8b-46d8-88c1-aa7000a77553	ИФК Йостерсунд -1	AH	active	1.48		\N		1	1	ИФК Йостерсунд -1	5026356_12110567_46430137
bc89bab0-83c5-4fe9-a103-aa7000a77562	de2c7fdd-7e8b-46d8-88c1-aa7000a77553	Draw sigendLine	XH	active	4.7		\N		1	2	Draw sigendLine	5026356_12110567_46430141
2d2e6000-9669-4ac2-b04a-aa7000a77569	de2c7fdd-7e8b-46d8-88c1-aa7000a77553	Kramfors-alliansen +1	BH	active	4.7		\N		1	3	Kramfors-alliansen +1	5026356_12110567_46430147
e47c8dcc-2621-4be7-9094-aa7000a77577	2e118b83-9c52-4745-bdd9-aa7000a77570	ИФК Йостерсунд -2	AH	active	2.16		\N		1	1	ИФК Йостерсунд -2	5026356_12110551_46430100
c837384d-a2c9-4fa9-bc91-aa7000a7757e	2e118b83-9c52-4745-bdd9-aa7000a77570	Draw sigendLine	XH	active	4.3		\N		1	2	Draw sigendLine	5026356_12110551_46430107
a1ba3ef1-a547-4e5b-9f66-aa7000a77585	2e118b83-9c52-4745-bdd9-aa7000a77570	Kramfors-alliansen +2	BH	active	2.47		\N		1	3	Kramfors-alliansen +2	5026356_12110551_46430108
c68dc59a-4b00-469a-88fa-aa7000a77594	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	2-0	2-0	active	10		\N		1	1	2-0	5026356_12111243_46432711
1fbae13e-605c-416b-8d17-aa7000a7759c	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	1-0	1-0	active	15.25		\N		1	2	1-0	5026356_12111243_46432718
92cd86c5-b22c-4dcb-9497-aa7000a775a4	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	2-1	2-1	active	11.75		\N		1	3	2-1	5026356_12111243_46432724
04bffd8f-7360-4ceb-8521-aa7000a775ac	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	3-0	3-0	active	9.75		\N		2	1	3-0	5026356_12111243_46432730
78a9cb4a-d94b-4f8a-9558-aa7000a775be	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	0-2	0-2	active	125		\N		2	2	0-2	5026356_12111243_46432735
ed4f0913-94f1-4c82-bb60-aa7000a775cc	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	1-4	1-4	active	250		\N		2	3	1-4	5026356_12111243_46432741
400b55aa-d0af-4f68-b0f3-aa7000a775d6	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	3-3	3-3	active	100		\N		3	1	3-3	5026356_12111243_46432749
270f137e-014d-4f1d-9e10-aa7000a775e5	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	2-4	2-4	active	250		\N		3	2	2-4	5026356_12111243_46432755
2c25fe8f-c82b-4f38-9432-aa7000a775f0	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	3-1	3-1	active	11.5		\N		3	3	3-1	5026356_12111243_46432762
43e428ca-a973-4fc7-9b1d-aa7000a775f9	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	0-0	0-0	active	50		\N		4	1	0-0	5026356_12111243_46432770
9d7aa412-34a5-4a7c-819a-aa7000a77601	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	0-4	0-4	active	250		\N		4	2	0-4	5026356_12111243_46432775
da9f43a6-f5c7-49f6-a4d4-aa7000a7760b	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	3-2	3-2	active	26.5		\N		4	3	3-2	5026356_12111243_46432781
abd91bd6-6d89-445f-9a17-aa7000a77615	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	4-0	4-0	active	12.75		\N		5	1	4-0	5026356_12111243_46432786
cdfee9bb-2816-4f17-82d4-aa7000a7761d	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	4-1	4-1	active	14.75		\N		5	2	4-1	5026356_12111243_46432795
0777bb66-f2d2-4769-96be-aa7000a77625	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	0-3	0-3	active	250		\N		5	3	0-3	5026356_12111243_46432801
2d6acb62-cdb8-4307-949d-aa7000a7762d	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	4-2	4-2	active	35		\N		6	1	4-2	5026356_12111243_46432806
350cf5f1-9923-448d-a64f-aa7000a77635	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	0-5	0-5	active	250		\N		6	2	0-5	5026356_12111243_46432813
3471210d-7e29-4df1-bcac-aa7000a7763e	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	1-5	1-5	active	250		\N		6	3	1-5	5026356_12111243_46432820
a0881e69-d8ac-4132-a3a0-aa7000a77648	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	0-1	0-1	active	55		\N		7	1	0-1	5026356_12111243_46432828
0c595731-baae-4215-aed8-aa7000a77654	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	1-2	1-2	active	40		\N		7	2	1-2	5026356_12111243_46432834
677e0de4-0580-4fcc-be2d-aa7000a7765c	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	1-3	1-3	active	150		\N		7	3	1-3	5026356_12111243_46432838
fdb95433-13bd-46ec-b81b-aa7000a77666	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	5-0	5-0	active	20.5		\N		8	1	5-0	5026356_12111243_46432846
e0e3589e-ea4e-4e97-b39f-aa7000a77670	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	Any Other	M1	active	9		\N		8	2	Any Other	5026356_12111243_46432853
37c6ea0b-1676-4242-a135-aa7000a77679	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	2-3	2-3	active	90		\N		8	3	2-3	5026356_12111243_46432859
6263ceca-d8e0-4d89-bf69-aa7000a77681	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	0-6	0-6	active	250		\N		9	1	0-6	5026356_12111243_46432871
492bb114-6d28-486f-801c-aa7000a77689	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	6-0	6-0	active	40		\N		9	2	6-0	5026356_12111243_46432877
7128d794-848a-420c-9dd3-aa7000a77692	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	1-1	1-1	active	18.75		\N		9	3	1-1	5026356_12111243_46432882
ff0d97ae-734a-4d6f-b61b-aa7000a7769b	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	5-1	5-1	active	24		\N		10	1	5-1	5026356_12111243_46432888
f8b5bdfe-207f-4cf7-b9d0-aa7000a776a5	90a0b6d1-12d5-44ab-a13b-aa7000a7758c	2-2	2-2	active	28.5		\N		10	2	2-2	5026356_12111243_46432894
5e6442c7-6308-4759-9c97-aa7000a776b6	c73ed3b9-02ee-4ab4-8097-aa7000a776ad	Under 0.5	Under	active	1.37		\N		1	1	Under 0.5	5026356_12110302_46429494
6a797ec7-d6a3-47fe-bac7-aa7000a776c0	c73ed3b9-02ee-4ab4-8097-aa7000a776ad	Over 0.5	Over	active	2.7		\N		1	2	Over 0.5	5026356_12110302_46429489
33a360e7-3f10-423a-a4a4-aa7000a776d3	c5e1d233-b261-4d94-a1eb-aa7000a776c9	Under 1.5	Under	active	1.54		\N		1	1	Under 1.5	5026356_12110280_46429440
4d0b8b01-5d1c-4db4-97f8-aa7000a776dd	c5e1d233-b261-4d94-a1eb-aa7000a776c9	Over 1.5	Over	active	2.21		\N		1	2	Over 1.5	5026356_12110280_46429438
03d118d0-56cc-4ee3-a37d-aa7000a776f0	6c752021-8c08-45c3-b3a5-aa7000a776e6	1-0	1-0	active	4.7		\N		1	1	1-0	5026356_12110896_46430974
708996ce-79af-4887-90b9-aa7000a776f9	6c752021-8c08-45c3-b3a5-aa7000a776e6	2-0	2-0	active	5.4		\N		1	2	2-0	5026356_12110896_46430982
f46e7996-719b-4291-8c62-aa7000a77700	6c752021-8c08-45c3-b3a5-aa7000a776e6	2-1	2-1	active	11.5		\N		1	3	2-1	5026356_12110896_46430987
3aecb2af-905d-4e17-87da-aa7000a7791d	6c752021-8c08-45c3-b3a5-aa7000a776e6	0-0	0-0	active	8.3		\N		2	1	0-0	5026356_12110896_46430989
148ae937-0837-49f1-9968-aa7000a77935	6c752021-8c08-45c3-b3a5-aa7000a776e6	2-2	2-2	active	50		\N		2	3	2-2	5026356_12110896_46430998
12d01b84-e15a-486e-8f76-aa7000a7793d	6c752021-8c08-45c3-b3a5-aa7000a776e6	0-1	0-1	active	16.75		\N		3	1	0-1	5026356_12110896_46431004
fbbbfa9c-8993-41cf-88cd-aa7000a77945	6c752021-8c08-45c3-b3a5-aa7000a776e6	0-2	0-2	active	70		\N		3	2	0-2	5026356_12110896_46431011
f9366f8c-1f1d-4af7-a5f0-aa7000a7794d	6c752021-8c08-45c3-b3a5-aa7000a776e6	1-2	1-2	active	40		\N		3	3	1-2	5026356_12110896_46431015
38fd4023-0db2-49f7-8d4e-aa7000a77954	6c752021-8c08-45c3-b3a5-aa7000a776e6	Any Other	M1	active	3.65		\N		4	1	Any Other	5026356_12110896_46431022
6dfa295e-f8b0-4a1b-b3ec-aa7000a77965	68455abb-3b0b-4408-ad79-aa7000a7795c	Any Other	M1	active	5.5		\N		1	1	Any Other	5026356_12110837_46430796
b8256ab0-e063-4969-a0c2-aa7000a77970	68455abb-3b0b-4408-ad79-aa7000a7795c	1-0	1-0	active	3.9		\N		1	2	1-0	5026356_12110837_46430802
bd429c9c-e759-49bd-af0a-aa7000a77978	68455abb-3b0b-4408-ad79-aa7000a7795c	2-0	2-0	active	5.6		\N		1	3	2-0	5026356_12110837_46430807
0e599040-a8e1-48fd-8e58-aa7000a77982	68455abb-3b0b-4408-ad79-aa7000a7795c	2-1	2-1	active	14.25		\N		2	1	2-1	5026356_12110837_46430812
0044bf58-5b97-4c53-bd84-aa7000a7798b	68455abb-3b0b-4408-ad79-aa7000a7795c	0-0	0-0	active	5.25		\N		2	2	0-0	5026356_12110837_46430814
8f158459-6477-4f10-9446-aa7000a77992	68455abb-3b0b-4408-ad79-aa7000a7795c	1-1	1-1	active	9.95		\N		2	3	1-1	5026356_12110837_46430822
664dbfba-51e3-4ec0-96af-aa7000a7799a	68455abb-3b0b-4408-ad79-aa7000a7795c	2-2	2-2	active	70		\N		3	1	2-2	5026356_12110837_46430827
e6d85a77-1a20-47c2-a632-aa7000a779a3	68455abb-3b0b-4408-ad79-aa7000a7795c	0-1	0-1	active	13.5		\N		3	2	0-1	5026356_12110837_46430829
16eec08c-ec07-4296-8f97-aa7000a779ac	68455abb-3b0b-4408-ad79-aa7000a7795c	0-2	0-2	active	70		\N		3	3	0-2	5026356_12110837_46430832
8c2b3a2c-df86-41e5-b92a-aa7000a779b5	68455abb-3b0b-4408-ad79-aa7000a7795c	1-2	1-2	active	50		\N		4	1	1-2	5026356_12110837_46430836
3f949454-4cb7-4dab-a5cf-aa7000a779c3	0c41a310-f584-4377-98f7-aa7000a779bc	ИФК Йостерсунд/ИФК Йостерсунд	A/A	active	1.73		\N		1	1	ИФК Йостерсунд/ИФК Йостерсунд	5026356_12110235_46429263
c508d737-930d-49ba-92f1-aa7000a779cb	0c41a310-f584-4377-98f7-aa7000a779bc	ИФК Йостерсунд/Draw	A/X	active	30		\N		1	2	ИФК Йостерсунд/Draw	5026356_12110235_46429271
f61923e5-a8f9-4c59-961a-aa7000a779d2	0c41a310-f584-4377-98f7-aa7000a779bc	ИФК Йостерсунд/Kramfors-alliansen	A/B	active	90		\N		1	3	ИФК Йостерсунд/Kramfors-alliansen	5026356_12110235_46429281
95227940-a530-4015-9b5f-aa7000a779db	0c41a310-f584-4377-98f7-aa7000a779bc	Draw/ИФК Йостерсунд	X/A	active	5		\N		2	1	Draw/ИФК Йостерсунд	5026356_12110235_46429266
2f9c7d1f-9f05-4b89-84b2-aa7000a779e4	0c41a310-f584-4377-98f7-aa7000a779bc	Draw/Draw	X/X	active	19.5		\N		2	2	Draw/Draw	5026356_12110235_46429274
a3656e24-a57b-421a-8173-aa7000a779ed	0c41a310-f584-4377-98f7-aa7000a779bc	Draw/Kramfors-alliansen	X/B	active	40		\N		2	3	Draw/Kramfors-alliansen	5026356_12110235_46429284
279c44f1-aa5f-4baf-b3ac-aa7000a779fb	0c41a310-f584-4377-98f7-aa7000a779bc	Kramfors-alliansen/ИФК Йостерсунд	B/A	active	26		\N		3	1	Kramfors-alliansen/ИФК Йостерсунд	5026356_12110235_46429269
18739a66-ab53-43a9-bf2c-aa7000a77a05	0c41a310-f584-4377-98f7-aa7000a779bc	Kramfors-alliansen/Draw	B/X	active	35		\N		3	2	Kramfors-alliansen/Draw	5026356_12110235_46429277
0159a749-6c12-4a0d-9183-aa7000a77a18	0c41a310-f584-4377-98f7-aa7000a779bc	Kramfors-alliansen/Kramfors-alliansen	B/B	active	28.5		\N		3	3	Kramfors-alliansen/Kramfors-alliansen	5026356_12110235_46429289
ec1b8479-53bb-4c5b-a9da-aa7000a77a3b	5407ae60-9710-480c-a904-aa7000a77a2c	Ifk Ostersund	A	active	1.5		\N		1	1	Ifk Ostersund	5026356_12111661_46435941
cf6fea50-e665-4dc5-bdc0-aa7000a77a45	5407ae60-9710-480c-a904-aa7000a77a2c	Draw	X	active	3.2		\N		1	2	Draw	5026356_12111661_46435947
fd91d10d-cdf1-46bc-a6f9-aa7000a77a4f	5407ae60-9710-480c-a904-aa7000a77a2c	Kramfors-alliansen	B	active	8.35		\N		1	3	Kramfors-alliansen	5026356_12111661_46435954
3fc7ed54-6154-4f41-94b1-aa7000a77a65	e6c17a58-3424-4d1a-8240-aa7000a77a5a	ИФК Йостерсунд or Draw	AX	active	1.06		\N		1	1	ИФК Йостерсунд or Draw	5026356_12110789_46430681
c099b4f2-e206-49a8-9092-aa7000a77a70	e6c17a58-3424-4d1a-8240-aa7000a77a5a	ИФК Йостерсунд or Kramfors-alliansen	AB	active	1.24		\N		1	2	ИФК Йостерсунд or Kramfors-alliansen	5026356_12110789_46430684
529594bb-98da-4345-a5bc-aa7000a77a7f	e6c17a58-3424-4d1a-8240-aa7000a77a5a	Draw or Kramfors-alliansen	BX	active	1.99		\N		1	3	Draw or Kramfors-alliansen	5026356_12110789_46430688
da040f2e-7f70-4d9b-b41f-aa7000a77a97	1159a180-93df-4c3a-a168-aa7000a77a8c	ИФК Йостерсунд or Draw	AX	active	1.06		\N		1	1	ИФК Йостерсунд or Draw	5026356_12111336_46433374
c23ecf16-e105-4bef-975b-aa7000a77aa4	1159a180-93df-4c3a-a168-aa7000a77a8c	ИФК Йостерсунд or Kramfors-alliansen	AB	active	1.17		\N		1	2	ИФК Йостерсунд or Kramfors-alliansen	5026356_12111336_46433380
b91883b5-7d60-43dd-b3f2-aa7000a77aaf	1159a180-93df-4c3a-a168-aa7000a77a8c	Draw or Kramfors-alliansen	BX	active	2.24		\N		1	3	Draw or Kramfors-alliansen	5026356_12111336_46433385
3bb69360-33f7-4b6a-aa05-aa7000a77ac7	034b5e64-46cc-4ab1-92c1-aa7000a77ab8	Ifk Ostersund	A	active	1.38		\N		1	1	Ifk Ostersund	5026356_12111326_46433316
3dab98bc-aee2-4653-8bab-aa7000a77ad1	034b5e64-46cc-4ab1-92c1-aa7000a77ab8	Draw	X	active	3.9		\N		1	2	Draw	5026356_12111326_46433323
ef176085-6aef-412a-9598-aa7000a77aef	034b5e64-46cc-4ab1-92c1-aa7000a77ab8	Kramfors-alliansen	B	active	8.45		\N		1	3	Kramfors-alliansen	5026356_12111326_46433334
6cde1404-d5bb-4539-a79e-aa7000a77b03	e1ff82ef-094b-449e-97ba-aa7000a77af9	Ifk Ostersund	A	active	1.08		\N		1	1	Ifk Ostersund	5026356_12111098_46431992
2d573d12-f9b2-488c-b0dd-aa7000a77b0c	e1ff82ef-094b-449e-97ba-aa7000a77af9	Draw	X	active	5.75		\N		1	2	Draw	5026356_12111098_46431997
b6f72517-e2ee-4b5c-b6fa-aa7000a77b1f	de3bd68c-1310-461e-b78e-aa7000a77b15	Draw	X	active	1.52		\N		1	1	Draw	5026356_12111013_46431599
6756bfc3-a6cb-44f9-8a31-aa7000a77b28	de3bd68c-1310-461e-b78e-aa7000a77b15	Kramfors-alliansen	B	active	2.26		\N		1	2	Kramfors-alliansen	5026356_12111013_46431606
2b35be6d-dbac-4f03-a2cf-aa7000a77b3b	12903df0-96b0-4bfc-8a28-aa7000a77b31	Under 0.5	Under	active	1.49		\N		1	1	Under 0.5	5026356_12110370_46429675
3025f351-2b76-44b6-8909-aa7000a77b46	12903df0-96b0-4bfc-8a28-aa7000a77b31	Over 0.5	Over	active	2.34		\N		1	2	Over 0.5	5026356_12110370_46429674
156aa5cd-6216-4041-8b30-aa7000a77b58	6ec1bd84-9b6c-4d02-bd53-aa7000a77b4f	Under 1.5	Under	active	1.86		\N		1	1	Under 1.5	5026356_12110342_46429612
ed032509-f811-43e9-b16b-aa7000a77b61	6ec1bd84-9b6c-4d02-bd53-aa7000a77b4f	Over 1.5	Over	active	1.78		\N		1	2	Over 1.5	5026356_12110342_46429610
30aa97ba-d648-4103-adfb-aa7000a77b9a	57eb4b3e-ec19-4ca2-a1f7-aa7000a77b70	IFK Ostersund	A	active	1.08		\N		1	1	IFK Ostersund	5026356_12095176_46379316
de9950f1-98bc-471a-927c-aa7000a77ba5	57eb4b3e-ec19-4ca2-a1f7-aa7000a77b70	Kramfors-alliansen	B	active	13		\N		1	2	Kramfors-alliansen	5026356_12095176_46379319
e5e91d46-f8a7-4078-918a-aa7000a77bb8	fad5dc27-b181-43fa-891e-aa7000a77bae	Yes	Yes	active	2.09		\N		1	1	Yes	5026356_12111638_46435783
52cf89e4-b348-4b30-97ae-aa7000a77bc5	fad5dc27-b181-43fa-891e-aa7000a77bae	No	No	active	1.61		\N		1	2	No	5026356_12111638_46435787
13d3f63c-7a7e-4afe-ae5a-aa7000a77c02	df953838-2202-42a1-80d4-aa7000a77bf7	Yes	Yes	active	8.9		\N		1	1	Yes	5026356_12111646_46435828
ef4928a6-c525-4b12-992a-aa7000a77c0b	df953838-2202-42a1-80d4-aa7000a77bf7	No	No	active	1.01		\N		1	2	No	5026356_12111646_46435832
613fa651-1bb6-4c3c-9ee5-aa7000a77c21	3fa0f052-6ba8-45de-b854-aa7000a77c16	Yes	Yes	active	2.18		\N		1	1	Yes	5026356_12111105_46432033
33586da8-22ed-4e7d-ab84-aa7000a77c2c	3fa0f052-6ba8-45de-b854-aa7000a77c16	No	No	active	1.56		\N		1	2	No	5026356_12111105_46432041
8e6a28b3-dacd-4a76-b4a8-aa7000a77c44	0f26b37e-764a-45d4-81cc-aa7000a77c37	Yes	Yes	active	3.4		\N		1	1	Yes	5026356_12110986_46431469
c61a74e5-c999-4eb7-8aa1-aa7000a77c4f	0f26b37e-764a-45d4-81cc-aa7000a77c37	No	No	active	1.24		\N		1	2	No	5026356_12110986_46431476
921caccf-5ac1-4e33-8b04-aa7000a77c64	3cadc86b-9455-4a42-8abe-aa7000a77c5a	Under 2.5	Under	active	1.27		\N		1	1	Under 2.5	5026356_12110696_46430475
89f2d54a-3850-4229-9997-aa7000a77c6e	3cadc86b-9455-4a42-8abe-aa7000a77c5a	Over 2.5	Over	active	3.2		\N		1	2	Over 2.5	5026356_12110696_46430470
ac245a79-efbe-4a28-a770-aa7000a77c92	bcac2687-4fa0-486f-9b54-aa7000a77c88	Under 1.5	Under	active	1.9		\N		1	1	Under 1.5	5026356_12110684_46430444
a5d07d66-b614-4d39-a8cf-aa7000a77ca7	bcac2687-4fa0-486f-9b54-aa7000a77c88	Over 1.5	Over	active	1.74		\N		1	2	Over 1.5	5026356_12110684_46430440
cd4bcf92-69e9-486c-966d-aa7000a77cc2	ca71741a-540b-4486-9b1f-aa7000a77cb7	Under 0.5	Under	active	4.3		\N		1	1	Under 0.5	5026356_12110655_46430412
588975a4-46e6-4554-9176-aa7000a77d07	ca71741a-540b-4486-9b1f-aa7000a77cb7	Over 0.5	Over	active	1.15		\N		1	2	Over 0.5	5026356_12110655_46430404
d71c1166-0a8d-4f53-ad76-aa7000a77d1b	0917fbc9-1015-4343-8fec-aa7000a77d11	Yes	Yes	active	2.8		\N		1	1	Yes	5026356_12111004_46431562
b90bd21d-0c11-4f2b-a3fa-aa7000a77d54	0917fbc9-1015-4343-8fec-aa7000a77d11	No	No	active	1.34		\N		1	2	No	5026356_12111004_46431568
8aa1bf3c-5c23-4a2c-b9c6-aa7000a77d6d	420dd87c-e9a0-4302-bc25-aa7000a77d5f	Under 2.5	Under	active	1.48		\N		1	1	Under 2.5	5026356_12110733_46430563
f0229881-e28d-4a6a-af78-aa7000a77d78	420dd87c-e9a0-4302-bc25-aa7000a77d5f	Over 2.5	Over	active	2.36		\N		1	2	Over 2.5	5026356_12110733_46430557
e4df7c35-774d-43ad-8230-aa7000a77d8b	9dd0fcaf-da1b-455d-a631-aa7000a77d81	Under 1.5	Under	active	2.44		\N		1	1	Under 1.5	5026356_12110721_46430534
78fb0717-6c5b-4bda-88b1-aa7000a77d96	9dd0fcaf-da1b-455d-a631-aa7000a77d81	Over 1.5	Over	active	1.45		\N		1	2	Over 1.5	5026356_12110721_46430530
19c30c35-f83d-4acd-b103-aa7000a77dae	d6224ae4-fb76-4c2f-bd13-aa7000a77da4	Under 0.5	Under	active	5.75		\N		1	1	Under 0.5	5026356_12110708_46430506
a4dd551d-f716-4654-99d2-aa7000a77db9	d6224ae4-fb76-4c2f-bd13-aa7000a77da4	Over 0.5	Over	active	1.09		\N		1	2	Over 0.5	5026356_12110708_46430503
b7bded4b-ce40-423a-baa4-aa7000a77dcd	711a9fe1-d735-436c-be11-aa7000a77dc4	0	0	active	45		\N		1	1	0	5026356_12111297_46433150
328549a0-5786-4455-b88a-aa7000a77dd7	711a9fe1-d735-436c-be11-aa7000a77dc4	1	1	active	11.5		\N		1	2	1	5026356_12111297_46433155
115dd5db-8628-4315-bf25-aa7000a77de5	711a9fe1-d735-436c-be11-aa7000a77dc4	2	2	active	6.05		\N		1	3	2	5026356_12111297_46433157
1a45f92b-30b4-42c8-87e6-aa7000a77df2	711a9fe1-d735-436c-be11-aa7000a77dc4	3	3	active	4.55		\N		2	1	3	5026356_12111297_46433166
1bb12e94-20bc-424d-9531-aa7000a77e02	711a9fe1-d735-436c-be11-aa7000a77dc4	4	4	active	4.7		\N		2	2	4	5026356_12111297_46433173
4eddd23a-eb95-473f-8bfa-aa7000a77e0f	711a9fe1-d735-436c-be11-aa7000a77dc4	5	5	active	5.9		\N		2	3	5	5026356_12111297_46433176
60daea57-2dbd-4978-8463-aa7000a77e1a	711a9fe1-d735-436c-be11-aa7000a77dc4	6+	6+	active	4.45		\N		3	1	6+	5026356_12111297_46433180
fce7f605-084d-4aff-985e-aa7000a77e53	ca607a59-5763-49a0-85c8-aa7000a77e23	0	0	active	5		\N		1	1	0	5026356_12110272_46429410
1021d1de-d5de-4ee6-a185-aa7000a77e66	ca607a59-5763-49a0-85c8-aa7000a77e23	1	1	active	2.95		\N		1	2	1	5026356_12110272_46429411
697408c1-8b47-47b4-878b-aa7000a77e85	ca607a59-5763-49a0-85c8-aa7000a77e23	2+	2+	active	1.78		\N		1	3	2+	5026356_12110272_46429416
0d0d12a3-d418-4778-924a-aa7000a77efa	a1f685c9-040f-4fec-b7a1-aa7000a77eda	0	0	active	7.75		\N		1	1	0	5026356_12110292_46429462
fc7161bd-dfad-453c-8813-aa7000a77f07	a1f685c9-040f-4fec-b7a1-aa7000a77eda	1	1	active	3.5		\N		1	2	1	5026356_12110292_46429467
cfbc8e10-ee6c-497f-a288-aa7000a77f15	a1f685c9-040f-4fec-b7a1-aa7000a77eda	2+	2+	active	1.46		\N		1	3	2+	5026356_12110292_46429471
74b2d9d4-d4ac-4319-a74b-aa7000a77f37	ea5ac99b-f21f-4b30-a145-aa7000a77f20	Odd	Odd	active	1.81		\N		1	1	Odd	5026356_12110244_46429315
af5c91a1-76a8-4078-97c1-aa7000a77f42	ea5ac99b-f21f-4b30-a145-aa7000a77f20	Even	Even	active	1.83		\N		1	2	Even	5026356_12110244_46429317
e3631f28-9d5f-47ce-9133-aa7000a77f59	6e3918e1-eccc-4ac8-b4dc-aa7000a77f4e	Odd	Odd	active	1.87		\N		1	1	Odd	5026356_12111501_46434325
cc181d3f-b095-4a62-8b92-aa7000a77f67	6e3918e1-eccc-4ac8-b4dc-aa7000a77f4e	Even	Even	active	1.77		\N		1	2	Even	5026356_12111501_46434331
a3402160-2d09-4bd6-a069-aa7000a77f7b	d3aa7dcc-6ee0-48d2-9f03-aa7000a77f71	Odd	Odd	active	1.83		\N		1	1	Odd	5026356_12111275_46432979
31aa3a39-5b59-4799-b070-aa7000a77f88	d3aa7dcc-6ee0-48d2-9f03-aa7000a77f71	Even	Even	active	1.8		\N		1	2	Even	5026356_12111275_46432985
dc6db011-769c-4d2a-8309-aa7000a77fcf	2416b64b-d35e-4c07-b5d3-aa7000a77fc3	Yes	Yes	active	5.85		\N		1	1	Yes	5026356_12110748_46430589
3c82a386-f684-43aa-b2da-aa7000a77fd9	2416b64b-d35e-4c07-b5d3-aa7000a77fc3	No	No	active	1.08		\N		1	2	No	5026356_12110748_46430592
dcd60ab4-1947-4a27-9773-aa7000a77ff9	c92dcdf9-1afd-4286-b945-aa7000a77fe3	Yes	Yes	active	1.51		\N		1	1	Yes	5026356_12110422_46429815
0f00a353-bfab-47fb-97a2-aa7000a78020	c92dcdf9-1afd-4286-b945-aa7000a77fe3	No	No	active	2.29		\N		1	2	No	5026356_12110422_46429818
06428c79-36ae-435f-b534-aa7000a78037	7535ed83-1662-4ef8-901b-aa7000a7802b	Under 3.5	Under	active	1.48		\N		1	1	Under 3.5	5026356_12111897_46437302
512bf8c3-1511-4a0e-b5b8-aa7000a78042	7535ed83-1662-4ef8-901b-aa7000a7802b	Over 3.5	Over	active	2.36		\N		1	2	Over 3.5	5026356_12111897_46437301
ee5f1516-af8b-4a82-9814-aa7000a78059	de0eee17-29ef-4abd-880e-aa7000a7804f	Under 0.5	Under	active	2.1		\N		1	1	Under 0.5	5026356_12110320_46429556
9c36e4cb-2550-490a-9f97-aa7000a78066	de0eee17-29ef-4abd-880e-aa7000a7804f	Over 0.5	Over	active	1.61		\N		1	2	Over 0.5	5026356_12110320_46429552
98730d08-b40b-4257-8ac9-aa7000a7807a	70ee7d8c-69cd-4747-8e86-aa7000a78070	0	0	active	2.16		\N		1	1	0	5026356_12110265_46429371
fc86e768-03c2-4654-adf2-aa7000a7808a	70ee7d8c-69cd-4747-8e86-aa7000a78070	1	1	active	2.52		\N		1	2	1	5026356_12110265_46429375
b4066e55-05ec-46e1-a55c-aa7000a7809d	70ee7d8c-69cd-4747-8e86-aa7000a78070	2	2	active	5.7		\N		1	3	2	5026356_12110265_46429380
461a5d94-9fa2-4612-9129-aa7000a780aa	70ee7d8c-69cd-4747-8e86-aa7000a78070	3+	3+	active	15.5		\N		2	1	3+	5026356_12110265_46429383
3d59b89d-8492-42b2-9565-aa7000a780c4	0337e930-d7a5-4852-9081-aa7000a780b3	0	0	active	18.25		\N		1	1	0	5026356_12110255_46429338
1858099a-27c7-4d5f-9ddd-aa7000a780cf	0337e930-d7a5-4852-9081-aa7000a780b3	1	1	active	6.1		\N		1	2	1	5026356_12110255_46429340
616424cb-5749-492e-ab97-aa7000a780dd	0337e930-d7a5-4852-9081-aa7000a780b3	2	2	active	4		\N		1	3	2	5026356_12110255_46429345
136afb59-9871-4fa0-9631-aa7000a780e7	0337e930-d7a5-4852-9081-aa7000a780b3	3+	3+	active	1.58		\N		2	1	3+	5026356_12110255_46429347
387c0ba7-3a77-4787-9313-aa7000a78148	bfd51abc-80f1-4224-a1a2-aa7000a7812a	0-1	R_0-1	active	9.05		\N		1	1	0-1	5026356_12110807_46430724
d9dbed86-ea5e-4e7f-bb0a-aa7000a78191	bfd51abc-80f1-4224-a1a2-aa7000a7812a	2-3	R_2-3	active	2.63		\N		1	2	2-3	5026356_12110807_46430728
2f2586b7-40bb-4a80-b0ba-aa7000a781a4	bfd51abc-80f1-4224-a1a2-aa7000a7812a	4-5	R_4-5	active	2.63		\N		1	3	4-5	5026356_12110807_46430734
19229f73-57c1-4843-bd84-aa7000a781c5	bfd51abc-80f1-4224-a1a2-aa7000a7812a	6+	6+	active	4.4		\N		2	1	6+	5026356_12110807_46430722
3381c0ab-2321-4899-b1a9-aa7000a781f2	3c3ef620-82e7-4afb-8f69-aa7000a781e9	1st Half	H1	active	2.9		\N		1	1	1st Half	5026356_12110996_46431514
d808f622-6451-4fbe-b5f9-aa7000a781ff	3c3ef620-82e7-4afb-8f69-aa7000a781e9	2nd	H2	active	1.91		\N		1	2	2nd	5026356_12110996_46431523
b4feabbe-7830-4c8e-a29c-aa7000a7820f	3c3ef620-82e7-4afb-8f69-aa7000a781e9	Equal	Equal	active	4.35		\N		1	3	Equal	5026356_12110996_46431528
289020cb-4d03-40bc-94be-aa7000a78227	c4848078-2114-40d2-9f61-aa7000a7821c	ИФК Йостерсунд -1	AH	active	2.85		\N		1	1	ИФК Йостерсунд -1	5026356_12110334_46429583
d59ee52f-b48c-4beb-9e99-aa7000a78233	c4848078-2114-40d2-9f61-aa7000a7821c	Draw sigendLine	XH	active	2.95		\N		1	2	Draw sigendLine	5026356_12110334_46429585
f79c0dae-7867-43af-a7b5-aa7000a7823d	c4848078-2114-40d2-9f61-aa7000a7821c	Kramfors-alliansen +1	BH	active	2.43		\N		1	3	Kramfors-alliansen +1	5026356_12110334_46429588
16a53c64-bfb8-4626-9e75-aa7000a78273	9a2b1c26-b35c-458f-a449-aa7000a78249	Yes	Yes	active	2.1		\N		1	1	Yes	5026356_12110399_46429754
e41d2c88-c3d7-4f6f-867e-aa7000a78286	9a2b1c26-b35c-458f-a449-aa7000a78249	No	No	active	1.6		\N		1	2	No	5026356_12110399_46429757
78e71b0e-a61c-4a84-85b8-aa7000a782a3	d8840a5a-d1ca-4938-a7b1-aa7000a78294	Yes	Yes	active	4.4		\N		1	1	Yes	5026356_12110770_46430645
55ff653f-c201-49a4-af55-aa7000a782bd	d8840a5a-d1ca-4938-a7b1-aa7000a78294	No	No	active	1.15		\N		1	2	No	5026356_12110770_46430650
c2930ae3-ab30-417c-83a3-aa7000a782d5	e8887610-af69-46cc-8044-aa7000a782ca	Yes	Yes	active	2.56		\N		1	1	Yes	5026356_12110759_46430617
c920bf2b-d1ef-4372-a718-aa7000a782e2	e8887610-af69-46cc-8044-aa7000a782ca	No	No	active	1.41		\N		1	2	No	5026356_12110759_46430621
3d1cd425-5c71-4dfc-adea-aa7000a782f7	ef8642ec-d81f-453e-a3f9-aa7000a782ed	ИФК Йостерсунд and Under 3.5	AUnder	active	2.75		\N		1	1	ИФК Йостерсунд and Under 3.5	5026356_12111084_46431933
56fba52a-3e6b-4a39-99e0-aa7000a78301	ef8642ec-d81f-453e-a3f9-aa7000a782ed	Draw and Under 3.5	XUnder	active	12.5		\N		1	2	Draw and Under 3.5	5026356_12111084_46431940
e73322ed-a5ee-4e78-aeaa-aa7000a7830b	ef8642ec-d81f-453e-a3f9-aa7000a782ed	Kramfors-alliansen and Under 3.5	BUnder	active	17.5		\N		1	3	Kramfors-alliansen and Under 3.5	5026356_12111084_46431948
526e07a3-3884-4f85-8b7f-aa7000a78317	ef8642ec-d81f-453e-a3f9-aa7000a782ed	ИФК Йостерсунд and Over 3.5	AOver	active	1.92		\N		2	1	ИФК Йостерсунд and Over 3.5	5026356_12111084_46431951
9ec9faa2-75a1-47c4-9447-aa7000a78322	ef8642ec-d81f-453e-a3f9-aa7000a782ed	Draw and Over 3.5	XOver	active	19.5		\N		2	2	Draw and Over 3.5	5026356_12111084_46431956
d0149399-1f8a-4115-8a1d-aa7000a7832e	ef8642ec-d81f-453e-a3f9-aa7000a782ed	Kramfors-alliansen and Over 3.5	BOver	active	35		\N		2	3	Kramfors-alliansen and Over 3.5	5026356_12111084_46431961
5db8b68b-eaa4-4c4c-8592-aa7000a78344	575cd28f-3fd9-42e6-bb43-aa7000a78339	ИФК Йостерсунд and Under 2.5	AUnder	active	5.55		\N		1	1	ИФК Йостерсунд and Under 2.5	5026356_12111065_46431839
1f42c389-cdfb-493e-9e6d-aa7000a7834e	575cd28f-3fd9-42e6-bb43-aa7000a78339	Draw and Under 2.5	XUnder	active	12.25		\N		1	2	Draw and Under 2.5	5026356_12111065_46431845
874b7bfb-78bf-4423-aa81-aa7000a7835a	575cd28f-3fd9-42e6-bb43-aa7000a78339	Kramfors-alliansen and Under 2.5	BUnder	active	35		\N		1	3	Kramfors-alliansen and Under 2.5	5026356_12111065_46431850
9ef8e46d-2835-466b-a099-aa7000a78365	575cd28f-3fd9-42e6-bb43-aa7000a78339	ИФК Йостерсунд and Over 2.5	AOver	active	1.44		\N		2	1	ИФК Йостерсунд and Over 2.5	5026356_12111065_46431861
a6c01c14-96f9-4383-af2e-aa7000a78370	575cd28f-3fd9-42e6-bb43-aa7000a78339	Draw and Over 2.5	XOver	active	18.75		\N		2	2	Draw and Over 2.5	5026356_12111065_46431868
7e3b0615-4e56-4e61-8907-aa7000a7837a	575cd28f-3fd9-42e6-bb43-aa7000a78339	Kramfors-alliansen and Over 2.5	BOver	active	17.25		\N		2	3	Kramfors-alliansen and Over 2.5	5026356_12111065_46431873
87ade9fd-2a1a-4b61-af78-aa7000a7838c	54daaa10-d28a-48e0-8587-aa7000a78384	ИФК Йостерсунд and Under 1.5	AUnder	active	13		\N		1	1	ИФК Йостерсунд and Under 1.5	5026356_12111048_46431756
183cde2a-07bc-400d-903f-aa7000a78396	54daaa10-d28a-48e0-8587-aa7000a78384	Draw and Under 1.5	XUnder	active	40		\N		1	2	Draw and Under 1.5	5026356_12111048_46431760
552d6334-a657-4d39-b703-aa7000a783a0	54daaa10-d28a-48e0-8587-aa7000a78384	Kramfors-alliansen and Under 1.5	BUnder	active	45		\N		1	3	Kramfors-alliansen and Under 1.5	5026356_12111048_46431767
fe1a00cb-6fd7-4060-be2f-aa7000a783aa	54daaa10-d28a-48e0-8587-aa7000a78384	ИФК Йостерсунд and Over 1.5	AOver	active	1.26		\N		2	1	ИФК Йостерсунд and Over 1.5	5026356_12111048_46431772
597e219b-1fe2-40fb-8caa-aa7000a783bf	54daaa10-d28a-48e0-8587-aa7000a78384	Draw and Over 1.5	XOver	active	8.65		\N		2	2	Draw and Over 1.5	5026356_12111048_46431777
af8d6e9f-099b-4c7f-b2d7-aa7000a783cd	54daaa10-d28a-48e0-8587-aa7000a78384	Kramfors-alliansen and Over 1.5	BOver	active	14.5		\N		2	3	Kramfors-alliansen and Over 1.5	5026356_12111048_46431785
a147dff1-800d-43cb-bf08-aa7000a78409	9e50ee7e-aef1-4114-811b-aa7000a783fd	ИФК Йостерсунд and Under 4.5	AUnder	active	1.92		\N		1	1	ИФК Йостерсунд and Under 4.5	5026356_12111026_46431666
91c02f61-f850-490e-b606-aa7000a78416	9e50ee7e-aef1-4114-811b-aa7000a783fd	Draw and Under 4.5	XUnder	active	8.6		\N		1	2	Draw and Under 4.5	5026356_12111026_46431670
8b1a148b-0c7b-46b0-9275-aa7000a78427	9e50ee7e-aef1-4114-811b-aa7000a783fd	Kramfors-alliansen and Under 4.5	BUnder	active	15.5		\N		1	3	Kramfors-alliansen and Under 4.5	5026356_12111026_46431676
f4bb4a5a-9def-4456-af43-aa7000a78439	9e50ee7e-aef1-4114-811b-aa7000a783fd	ИФК Йостерсунд and Over 4.5	AOver	active	2.75		\N		2	1	ИФК Йостерсунд and Over 4.5	5026356_12111026_46431684
95492932-a512-4919-88f5-aa7000a78447	9e50ee7e-aef1-4114-811b-aa7000a783fd	Draw and Over 4.5	XOver	active	70		\N		2	2	Draw and Over 4.5	5026356_12111026_46431691
95315ca7-e489-454c-9808-aa7000a78454	9e50ee7e-aef1-4114-811b-aa7000a783fd	Kramfors-alliansen and Over 4.5	BOver	active	50		\N		2	3	Kramfors-alliansen and Over 4.5	5026356_12111026_46431697
a751183a-98b4-42b9-a2b3-aa7000a7846b	04782eea-5582-469f-9d2e-aa7000a7845f	1st Half	H1	active	2.95		\N		1	1	1st Half	5026356_12111156_46432253
ed323ab9-ff85-4391-968b-aa7000a78478	04782eea-5582-469f-9d2e-aa7000a7845f	2nd	H2	active	2.03		\N		1	2	2nd	5026356_12111156_46432259
8ef87c8d-64c5-43e4-9485-aa7000a78482	04782eea-5582-469f-9d2e-aa7000a7845f	Equal	Equal	active	3.75		\N		1	3	Equal	5026356_12111156_46432265
8764ad82-d99d-4db6-a7a8-aa7000a78496	6eed4a42-efe4-4d1d-a98b-aa7000a7848c	Yes	Yes	active	1.09		\N		1	1	Yes	5026356_12110410_46429786
bb32e766-aba5-47f4-84ed-aa7000a784a1	6eed4a42-efe4-4d1d-a98b-aa7000a7848c	No	No	active	5.5		\N		1	2	No	5026356_12110410_46429791
f3c68937-a09a-4245-b2df-aa7000a784b8	da5e2f48-2a83-46a3-b59b-aa7000a784ab	ИФК Йостерсунд/Draw  Under 4.5	AXUnder	active	1.54		\N		1	1	ИФК Йостерсунд/Draw  Under 4.5	5026356_12110932_46431152
62b4fe62-f2e3-4d2d-81b5-aa7000a784c4	da5e2f48-2a83-46a3-b59b-aa7000a784ab	ИФК Йостерсунд/Kramfors-alliansen - Under 4.5	ABUnder	active	1.65		\N		1	2	ИФК Йостерсунд/Kramfors-alliansen - Under 4.5	5026356_12110932_46431158
0ea1972c-19ea-4959-9367-aa7000a784d2	da5e2f48-2a83-46a3-b59b-aa7000a784ab	Draw/Kramfors-alliansen  Under 4.5	XBUnder	active	4.85		\N		1	3	Draw/Kramfors-alliansen  Under 4.5	5026356_12110932_46431164
c1f27d18-b14b-4fd4-931a-aa7000a784e2	da5e2f48-2a83-46a3-b59b-aa7000a784ab	ИФК Йостерсунд/Draw  Over 4.5	AXOver	active	2.44		\N		2	1	ИФК Йостерсунд/Draw  Over 4.5	5026356_12110932_46431168
718e4151-1b94-46dc-9daa-aa7000a784fd	da5e2f48-2a83-46a3-b59b-aa7000a784ab	ИФК Йостерсунд/Kramfors-alliansen  Over 4.5	ABOver	active	2.41		\N		2	2	ИФК Йостерсунд/Kramfors-alliansen  Over 4.5	5026356_12110932_46431178
8616341d-4e37-40ea-b8b0-aa7000a7850c	da5e2f48-2a83-46a3-b59b-aa7000a784ab	Draw/Kramfors-alliansen  Over 4.5	XBOver	active	18.5		\N		2	3	Draw/Kramfors-alliansen  Over 4.5	5026356_12110932_46431181
fccb83b1-4ac2-4fe9-a9fe-aa7000a7855d	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 2-0	0-0 2-0	active	30		\N		1	1	0-0 2-0	5026356_12111470_46433957
43455a2f-c868-40e4-90fd-aa7000a7857c	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 0-0	0-0 0-0	active	50		\N		1	2	0-0 0-0	5026356_12111470_46433936
29bc1672-c44f-403a-a44a-aa7000a78592	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 2-1	0-0 2-1	active	70		\N		2	1	0-0 2-1	5026356_12111470_46434027
62afa451-4189-4be0-b891-aa7000a785b2	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 0-1	0-0 0-1	active	90		\N		1	3	0-0 0-1	5026356_12111470_46433948
aeda484b-4cf8-4a41-a64c-aa7000a785c3	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 1-1	0-0 1-1	active	60		\N		2	2	0-0 1-1	5026356_12111470_46433963
52888096-c84f-48af-9208-aa7000a785e7	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 0-2	0-0 0-2	active	250		\N		2	3	0-0 0-2	5026356_12111470_46433932
6c568183-205e-4b02-af43-aa7000a785ff	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 3-0	0-0 3-0	active	55		\N		3	1	0-0 3-0	5026356_12111470_46433969
6b839fe7-555c-42bb-93be-aa7000a78619	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-0 1-1	1-0 1-1	active	80		\N		3	2	1-0 1-1	5026356_12111470_46434073
d6e40f3e-a69a-4f3f-9f94-aa7000a7862e	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 1-2	0-0 1-2	active	200		\N		3	3	0-0 1-2	5026356_12111470_46434059
aab3f079-dfc8-4c7f-8594-aa7000a78643	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-0 1-0	1-0 1-0	active	35		\N		4	1	1-0 1-0	5026356_12111470_46434089
891ea7f3-f23d-4aec-b50d-aa7000a78653	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-1 1-1	0-1 1-1	active	80		\N		4	2	0-1 1-1	5026356_12111470_46434046
c3460184-fc56-433b-9c45-aa7000a78664	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 0-3	0-0 0-3	active	250		\N		4	3	0-0 0-3	5026356_12111470_46434067
b4d5d5e9-a6f4-4899-81f4-aa7000a7869e	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-0 2-0	1-0 2-0	active	20.5		\N		5	1	1-0 2-0	5026356_12111470_46434117
724a73d9-559f-42a0-824d-aa7000a786aa	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-1 1-1	1-1 1-1	active	90		\N		5	2	1-1 1-1	5026356_12111470_46434003
53256657-20f9-4792-b9b3-aa7000a786b8	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-1 0-1	0-1 0-1	active	125		\N		5	3	0-1 0-1	5026356_12111470_46434008
d976abdc-8960-4c09-b604-aa7000a786c3	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-0 2-1	1-0 2-1	active	45		\N		6	1	1-0 2-1	5026356_12111470_46434121
d8b8a831-4361-4d32-ab59-aa7000a786d7	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-0 4plus	0-0 4plus	active	35		\N		6	2	0-0 4plus	5026356_12111470_46434093
e9c95a8b-9e68-4723-bdf2-aa7000a786e8	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-1 0-2	0-1 0-2	active	200		\N		6	3	0-1 0-2	5026356_12111470_46434049
66ad1679-64d7-47fa-aba6-aa7000a786fc	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-0 1-2	1-0 1-2	active	250		\N		7	1	1-0 1-2	5026356_12111470_46434152
bc044be7-a69e-44ab-9ea8-aa7000a78707	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-0 4plus	1-0 4plus	active	10.5		\N		7	2	1-0 4plus	5026356_12111470_46433983
4347b528-931e-4064-b746-aa7000a78713	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-1 1-2	0-1 1-2	active	150		\N		7	3	0-1 1-2	5026356_12111470_46434128
567c1f71-18dd-4b6b-b9e4-aa7000a7871f	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-0 3-0	1-0 3-0	active	23.5		\N		8	1	1-0 3-0	5026356_12111470_46433979
d933e495-70ba-4918-afb8-aa7000a7872a	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-1 4plus	0-1 4plus	active	35		\N		8	2	0-1 4plus	5026356_12111470_46434037
acb1cf17-bd19-419d-982d-aa7000a78735	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-1 2-1	1-1 2-1	active	50		\N		9	1	1-1 2-1	5026356_12111470_46434142
a1780c35-2b90-4a4f-9d3b-aa7000a78741	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-1 2-1	0-1 2-1	active	80		\N		8	3	0-1 2-1	5026356_12111470_46434099
db373781-efd4-4946-a5d4-aa7000a7874e	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-1 4plus	1-1 4plus	active	16.5		\N		9	2	1-1 4plus	5026356_12111470_46434134
fb387212-5444-46c3-a751-aa7000a7875d	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-1 0-3	0-1 0-3	active	250		\N		9	3	0-1 0-3	5026356_12111470_46433990
5708d3f5-e506-4ad7-8994-aa7000a78768	ef05af45-4a70-4c95-9ba2-aa7000a78545	2-0 2-0	2-0 2-0	active	55		\N		10	1	2-0 2-0	5026356_12111470_46434158
b263b349-9d99-456a-bfff-aa7000a78776	ef05af45-4a70-4c95-9ba2-aa7000a78545	2-0 4plus	2-0 4plus	active	8.8		\N		10	2	2-0 4plus	5026356_12111470_46434013
4d4697db-6a00-4d01-bc4f-aa7000a78789	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-1 1-2	1-1 1-2	active	150		\N		10	3	1-1 1-2	5026356_12111470_46433941
73ad0d63-3942-41f6-9a78-aa7000a78798	ef05af45-4a70-4c95-9ba2-aa7000a78545	2-0 2-1	2-0 2-1	active	125		\N		11	1	2-0 2-1	5026356_12111470_46434032
0f430bed-e35a-4721-85dd-aa7000a787a4	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-2 4plus	0-2 4plus	active	125		\N		11	2	0-2 4plus	5026356_12111470_46433997
923beacb-a4b6-4cb6-bf15-aa7000a787b1	ef05af45-4a70-4c95-9ba2-aa7000a78545	2-1 2-1	2-1 2-1	active	125		\N		12	1	2-1 2-1	5026356_12111470_46433953
23b7f243-ac9c-43fd-80c4-aa7000a787c2	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-2 0-2	0-2 0-2	active	250		\N		11	3	0-2 0-2	5026356_12111470_46434064
9eab3b98-666b-44b1-810f-aa7000a787d5	ef05af45-4a70-4c95-9ba2-aa7000a78545	2-1 4plus	2-1 4plus	active	17		\N		12	2	2-1 4plus	5026356_12111470_46434040
6a305b9c-023e-48bb-96b5-aa7000a787f5	ef05af45-4a70-4c95-9ba2-aa7000a78545	2-0 3-0	2-0 3-0	active	30		\N		13	1	2-0 3-0	5026356_12111470_46434106
81ddff4c-ee76-4f6d-9ec0-aa7000a78817	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-2 1-2	0-2 1-2	active	250		\N		12	3	0-2 1-2	5026356_12111470_46434053
d79a5e02-b6f2-4ae7-abf9-aa7000a78828	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-2 4plus	1-2 4plus	active	60		\N		13	2	1-2 4plus	5026356_12111470_46434164
919c045d-2156-4d5f-88da-aa7000a78836	ef05af45-4a70-4c95-9ba2-aa7000a78545	3-0 3-0	3-0 3-0	active	125		\N		14	1	3-0 3-0	5026356_12111470_46433974
af48a19f-a54a-44a6-a612-aa7000a7884b	ef05af45-4a70-4c95-9ba2-aa7000a78545	1-2 1-2	1-2 1-2	active	250		\N		13	3	1-2 1-2	5026356_12111470_46434019
47b32044-570b-49f2-b905-aa7000a7885c	ef05af45-4a70-4c95-9ba2-aa7000a78545	3-0 4plus	3-0 4plus	active	14		\N		14	2	3-0 4plus	5026356_12111470_46434084
99d46b57-4cc6-4422-875f-aa7000a78868	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-2 0-3	0-2 0-3	active	250		\N		14	3	0-2 0-3	5026356_12111470_46434056
2afb18ed-116f-4d1b-a220-aa7000a78873	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-3 4plus	0-3 4plus	active	250		\N		15	2	0-3 4plus	5026356_12111470_46434146
01407496-6da6-4324-b2b9-aa7000a7887d	ef05af45-4a70-4c95-9ba2-aa7000a78545	0-3 0-3	0-3 0-3	active	250		\N		15	3	0-3 0-3	5026356_12111470_46434111
0d3281e9-75d3-4e49-91b8-aa7000a78887	ef05af45-4a70-4c95-9ba2-aa7000a78545	4plus 4plus	4plus 4plus	active	9.2		\N		16	2	4plus 4plus	5026356_12111470_46434080
a8b7c9e4-85f3-4b8a-aacc-aa7000a7889e	7abe1e2b-658c-4e56-9838-aa7000a78894	ИФК Йостерсунд/Yes	AYes	active	2.25		\N		1	1	ИФК Йостерсунд/Yes	5026356_12111582_46435240
2a804660-8bbc-478e-98e5-aa7000a788a9	7abe1e2b-658c-4e56-9838-aa7000a78894	Draw/Yes	XYes	active	9.4		\N		1	2	Draw/Yes	5026356_12111582_46435252
b216dee2-a7bc-423f-a559-aa7000a788b3	7abe1e2b-658c-4e56-9838-aa7000a78894	Kramfors-alliansen/Yes	BYes	active	19		\N		1	3	Kramfors-alliansen/Yes	5026356_12111582_46435264
42b59ef6-95d4-4072-bfbe-aa7000a788bf	7abe1e2b-658c-4e56-9838-aa7000a78894	ИФК Йостерсунд/No	ANo	active	2.25		\N		2	1	ИФК Йостерсунд/No	5026356_12111582_46435242
a933737e-04e7-4520-af7d-aa7000a788cb	7abe1e2b-658c-4e56-9838-aa7000a78894	Draw/No	XNo	active	45		\N		2	2	Draw/No	5026356_12111582_46435258
2332cb2d-a322-4833-80e6-aa7000a788d9	7abe1e2b-658c-4e56-9838-aa7000a78894	Kramfors-alliansen/No	BNo	active	35		\N		2	3	Kramfors-alliansen/No	5026356_12111582_46435268
4f11a8da-439c-4683-8135-aa7000a788f1	2ea3e628-4b79-4303-83d9-aa7000a788e5	ИФК Йостерсунд by exactly 1	A1	active	4.9		\N		1	1	ИФК Йостерсунд by exactly 1	5026356_12111592_46435367
5ba74df1-f892-4896-bbce-aa7000a7890d	2ea3e628-4b79-4303-83d9-aa7000a788e5	Draw	X	active	7.95		\N		1	2	Draw	5026356_12111592_46435346
f1a0e4ce-c863-4bb4-bdbc-aa7000a7891e	2ea3e628-4b79-4303-83d9-aa7000a788e5	Kramfors-alliansen by exactly 1	B1	active	17		\N		1	3	Kramfors-alliansen by exactly 1	5026356_12111592_46435373
11bbea35-c12c-492c-a9d3-aa7000a7892a	2ea3e628-4b79-4303-83d9-aa7000a788e5	ИФК Йостерсунд by exactly 2	A2	active	4.35		\N		2	1	ИФК Йостерсунд by exactly 2	5026356_12111592_46435362
e5e8002f-7975-47dc-9d51-aa7000a78955	2ea3e628-4b79-4303-83d9-aa7000a788e5	Kramfors-alliansen by exactly 2	B2	active	55		\N		2	3	Kramfors-alliansen by exactly 2	5026356_12111592_46435379
cbfe8f78-b3b1-477b-9416-aa7000a78972	2ea3e628-4b79-4303-83d9-aa7000a788e5	ИФК Йостерсунд by greater than 2	A>2	active	2.2		\N		3	1	ИФК Йостерсунд by greater than 2	5026356_12111592_46435360
f67db827-2502-4d01-bb9f-aa7000a78990	2ea3e628-4b79-4303-83d9-aa7000a788e5	Kramfors-alliansen by greater than 2	B>2	active	125		\N		3	3	Kramfors-alliansen by greater than 2	5026356_12111592_46435383
7188ba55-7e31-439d-8762-aa7000a78b7f	a44f7ddc-4adf-44ab-a696-aa7000a789ae	Ifk Ostersund	A	active	2.21		\N		1	1	Ifk Ostersund	5026356_12111654_46435887
c3e96886-3757-4f47-848f-aa7000a78b8d	a44f7ddc-4adf-44ab-a696-aa7000a789ae	Both	Both	active	1.69		\N		1	2	Both	5026356_12111654_46435900
f03572a6-d1d9-4cac-b641-aa7000a78b9a	a44f7ddc-4adf-44ab-a696-aa7000a789ae	Kramfors-alliansen	B	active	29.5		\N		1	3	Kramfors-alliansen	5026356_12111654_46435890
4beeaf83-3f92-46cb-9277-aa7000a78ba8	a44f7ddc-4adf-44ab-a696-aa7000a789ae	None	None	active	40		\N		2	1	None	5026356_12111654_46435882
ac8ab504-c195-45c0-9599-aa7000a78bdb	dcf10c10-41eb-4602-8988-aa7000a78bc0	ИФК Йостерсунд/Draw and No	AXNo	active	1.42		\N		1	1	ИФК Йостерсунд/Draw and No	5026356_12111413_46433649
2fc0916e-71ed-44a4-9864-aa7000a78bee	dcf10c10-41eb-4602-8988-aa7000a78bc0	ИФК Йостерсунд/Kramfors-alliansen and Yes	ABYes	active	3.05		\N		1	2	ИФК Йостерсунд/Kramfors-alliansen and Yes	5026356_12111413_46433654
4b9e281d-e435-4980-9a37-aa7000a78c03	dcf10c10-41eb-4602-8988-aa7000a78bc0	Draw/Kramfors-alliansen and Yes	BXYes	active	9.15		\N		1	3	Draw/Kramfors-alliansen and Yes	5026356_12111413_46433660
8778c58e-3762-4d96-918e-aa7000a78c12	dcf10c10-41eb-4602-8988-aa7000a78bc0	ИФК Йостерсунд/Kramfors-alliansen and No	ABNo	active	1.45		\N		2	2	ИФК Йостерсунд/Kramfors-alliansen and No	5026356_12111413_46433658
5a626b9d-9fca-463a-bed2-aa7000a78c34	dcf10c10-41eb-4602-8988-aa7000a78bc0	Draw/Kramfors-alliansen and No	BXNo	active	6.25		\N		2	3	Draw/Kramfors-alliansen and No	5026356_12111413_46433667
67f43617-8ed2-41f1-ab6d-aa7000a78c57	1f7b5949-0d6b-4487-a221-aa7000a78c4b	No/Over 2.5	YUnder	active	17.25		\N		1	1	No/Over 2.5	5026356_12111397_46433586
0a275a12-a948-44a5-b399-aa7000a78c64	1f7b5949-0d6b-4487-a221-aa7000a78c4b	Yes/Over 2.5	YOver	active	1.87		\N		1	2	Yes/Over 2.5	5026356_12111397_46433579
cf8bf5ac-d879-416a-89c7-aa7000a78c70	1f7b5949-0d6b-4487-a221-aa7000a78c4b	No/Under 2.5	NUnder	active	4.5		\N		2	1	No/Under 2.5	5026356_12111397_46433595
146a6778-6366-4010-8e08-aa7000a78c90	1f7b5949-0d6b-4487-a221-aa7000a78c4b	Yes/Under 2.5	NOver	active	3.5		\N		2	2	Yes/Under 2.5	5026356_12111397_46433590
2f30a4bb-8ae2-484f-8ecd-aa7000a78d50	67dcc314-86ac-4a28-a685-aa7000a78cf8	ИФК Йостерсунд/Draw and No	AXNo	active	1.3		\N		1	1	ИФК Йостерсунд/Draw and No	5026356_12111378_46433519
2403b1d4-c779-4a55-babf-aa7000a78da7	67dcc314-86ac-4a28-a685-aa7000a78cf8	ИФК Йостерсунд/Kramfors-alliansen and Yes	ABYes	active	3.75		\N		1	2	ИФК Йостерсунд/Kramfors-alliansen and Yes	5026356_12111378_46433522
95c939e1-903d-4097-9480-aa7000a78db4	67dcc314-86ac-4a28-a685-aa7000a78cf8	Draw/Kramfors-alliansen and Yes	BXYes	active	11		\N		1	3	Draw/Kramfors-alliansen and Yes	5026356_12111378_46433535
ab71b20a-6c9e-4df7-ba56-aa7000a78dc5	67dcc314-86ac-4a28-a685-aa7000a78cf8	ИФК Йостерсунд/Kramfors-alliansen and No	ABNo	active	1.34		\N		2	2	ИФК Йостерсунд/Kramfors-alliansen and No	5026356_12111378_46433530
84f6c83d-6079-43d0-906e-aa7000a78dda	67dcc314-86ac-4a28-a685-aa7000a78cf8	Draw/Kramfors-alliansen and No	BXNo	active	5.5		\N		2	3	Draw/Kramfors-alliansen and No	5026356_12111378_46433539
6c62edc1-5a24-48c3-ab61-aa7000a78df2	8e387bca-e222-4b61-b5e8-aa7000a78de6	0	MR_0	active	1.8		\N		1	1	0	5026356_12111354_46433436
12a2424c-b9db-47c0-9326-aa7000a78e2a	8e387bca-e222-4b61-b5e8-aa7000a78de6	1-2	MR_1-2	active	1.56		\N		1	2	1-2	5026356_12111354_46433443
f7c40059-21cf-4e2b-b5f3-aa7000a78e5b	8e387bca-e222-4b61-b5e8-aa7000a78de6	1-3	MR_1-3	active	1.47		\N		1	3	1-3	5026356_12111354_46433450
647a1d61-be5f-47be-bfad-aa7000a78e6e	8e387bca-e222-4b61-b5e8-aa7000a78de6	2-3	MR_2-3	active	3.35		\N		2	1	2-3	5026356_12111354_46433455
00b3f5ad-3692-442f-a49f-aa7000a78e7f	8e387bca-e222-4b61-b5e8-aa7000a78de6	4+	MR_4+	active	28		\N		3	1	4+	5026356_12111354_46433459
0904de41-1593-43b5-8a00-aa7000a78ea5	bdfc015d-9aea-4861-abef-aa7000a78e96	ИФК Йостерсунд/Yes	AYes	active	7.75		\N		1	1	ИФК Йостерсунд/Yes	5026356_12111314_46433243
c943c666-5e0a-46d9-bc46-aa7000a78eb3	bdfc015d-9aea-4861-abef-aa7000a78e96	Draw/Yes	XYes	active	8.35		\N		1	2	Draw/Yes	5026356_12111314_46433256
c95bdc16-0f71-466b-b113-aa7000a78ec1	bdfc015d-9aea-4861-abef-aa7000a78e96	Kramfors-alliansen/Yes	BYes	active	30		\N		1	3	Kramfors-alliansen/Yes	5026356_12111314_46433267
474fe3b2-9a8c-4c71-8a29-aa7000a78ed7	bdfc015d-9aea-4861-abef-aa7000a78e96	ИФК Йостерсунд/No	ANo	active	1.89		\N		2	1	ИФК Йостерсунд/No	5026356_12111314_46433249
daad2b81-6a03-4911-be9d-aa7000a78ee5	bdfc015d-9aea-4861-abef-aa7000a78e96	Draw/No	XNo	active	5.2		\N		2	2	Draw/No	5026356_12111314_46433261
1cb631f5-d377-4155-a6f0-aa7000a78ef4	bdfc015d-9aea-4861-abef-aa7000a78e96	Kramfors-alliansen/No	BNo	active	10.5		\N		2	3	Kramfors-alliansen/No	5026356_12111314_46433274
a69adfb4-15e8-4d5e-b07f-aa7000a78f13	58ba0a63-b7da-4ae9-8f1b-aa7000a78f00	Ifk Ostersund	A	active	1.09		\N		1	1	Ifk Ostersund	5026356_12111285_46433075
f59a01e7-b0d8-4bf3-aa59-aa7000a78f1f	58ba0a63-b7da-4ae9-8f1b-aa7000a78f00	Kramfors-alliansen	B	active	5.35		\N		1	2	Kramfors-alliansen	5026356_12111285_46433081
6695a713-363b-492f-8eef-aa7000a78f37	16ff504c-d390-49e7-ad30-aa7000a78f2c	Odd	Odd	active	2.17		\N		1	1	Odd	5026356_12111280_46433028
9ce64454-dc30-4e78-be57-aa7000a78f45	16ff504c-d390-49e7-ad30-aa7000a78f2c	Even	Even	active	1.56		\N		1	2	Even	5026356_12111280_46433032
a130336f-08eb-49c2-8b3c-aa7000a78f5f	ab283011-81c3-4fe2-bbd1-aa7000a78f52	Odd	Odd	active	1.82		\N		1	1	Odd	5026356_12111267_46432932
c5513164-065c-4393-a8d7-aa7000a78f92	ab283011-81c3-4fe2-bbd1-aa7000a78f52	Even	Even	active	1.81		\N		1	2	Even	5026356_12111267_46432938
8e210ab6-27cc-44d8-b43a-aa7000a78fba	7e3f97ad-42be-417c-abb9-aa7000a78fac	0	MR_0	active	20		\N		1	1	0	5026356_12111198_46432421
e9d51941-ba5b-445c-a7a8-aa7000a78fc8	7e3f97ad-42be-417c-abb9-aa7000a78fac	1-2	MR_1-2	active	2.95		\N		1	2	1-2	5026356_12111198_46432429
eabb5be5-f81c-4664-89e8-aa7000a78fd4	7e3f97ad-42be-417c-abb9-aa7000a78fac	1-3	MR_1-3	active	1.8		\N		1	3	1-3	5026356_12111198_46432436
e52e561f-f4c8-4cb2-8dfa-aa7000a78fe1	7e3f97ad-42be-417c-abb9-aa7000a78fac	1-4	MR_1-4	active	1.36		\N		2	1	1-4	5026356_12111198_46432440
d7c617ec-a067-4102-9d04-aa7000a78fee	7e3f97ad-42be-417c-abb9-aa7000a78fac	1-5	MR_1-5	active	1.17		\N		2	2	1-5	5026356_12111198_46432444
dd1ddc63-88a9-4228-a5a7-aa7000a78ffa	7e3f97ad-42be-417c-abb9-aa7000a78fac	1-6	MR_1-6	active	1.08		\N		2	3	1-6	5026356_12111198_46432451
4a7146ab-07ff-4925-b7a9-aa7000a79005	7e3f97ad-42be-417c-abb9-aa7000a78fac	2-3	MR_2-3	active	2.1		\N		3	1	2-3	5026356_12111198_46432478
a7b2219d-7553-4434-b573-aa7000a79011	7e3f97ad-42be-417c-abb9-aa7000a78fac	2-4	MR_2-4	active	1.5		\N		3	2	2-4	5026356_12111198_46432484
e54d4687-36b7-4f34-8715-aa7000a7901b	7e3f97ad-42be-417c-abb9-aa7000a78fac	2-5	MR_2-5	active	1.26		\N		3	3	2-5	5026356_12111198_46432497
ec0afc12-54c6-4778-a207-aa7000a79056	7e3f97ad-42be-417c-abb9-aa7000a78fac	2-6	MR_2-6	active	1.15		\N		4	1	2-6	5026356_12111198_46432505
e0c1d44b-5dcf-43ca-a547-aa7000a79069	7e3f97ad-42be-417c-abb9-aa7000a78fac	3-4	MR_3-4	active	1.91		\N		4	2	3-4	5026356_12111198_46432517
47a6b179-cb27-47af-9fb3-aa7000a79079	7e3f97ad-42be-417c-abb9-aa7000a78fac	3-5	MR_3-5	active	1.5		\N		4	3	3-5	5026356_12111198_46432471
25b81071-4d32-443f-8107-aa7000a7908a	7e3f97ad-42be-417c-abb9-aa7000a78fac	3-6	MR_3-6	active	1.32		\N		5	1	3-6	5026356_12111198_46432463
cd09be1a-1e44-4f53-9fa7-aa7000a7909a	7e3f97ad-42be-417c-abb9-aa7000a78fac	4-5	MR_4-5	active	2.1		\N		5	2	4-5	5026356_12111198_46432466
40ec7e9c-1de0-4488-a7c7-aa7000a790ab	7e3f97ad-42be-417c-abb9-aa7000a78fac	4-6	MR_4-6	active	1.73		\N		5	3	4-6	5026356_12111198_46432458
47583552-fd4c-4d15-912f-aa7000a790bd	7e3f97ad-42be-417c-abb9-aa7000a78fac	5-6	MR_5-6	active	2.7		\N		6	2	5-6	5026356_12111198_46432512
2388ec90-7f50-4f48-8857-aa7000a790cd	7e3f97ad-42be-417c-abb9-aa7000a78fac	7+	MR_7+	active	5.65		\N		6	3	7+	5026356_12111198_46432522
97f78054-b540-4abc-b2fc-aa7000a7913f	8eb7507e-4de0-46cc-aeb6-aa7000a79131	1st Half	H1	active	4.1		\N		1	1	1st Half	5026356_12111170_46432297
7132ad56-4795-423e-904c-aa7000a7914c	8eb7507e-4de0-46cc-aeb6-aa7000a79131	2nd	H2	active	3.2		\N		1	2	2nd	5026356_12111170_46432302
3cea561e-c1c8-4774-a242-aa7000a79162	8eb7507e-4de0-46cc-aeb6-aa7000a79131	Equal	Equal	active	1.83		\N		1	3	Equal	5026356_12111170_46432308
93150bc3-f65d-4257-911e-aa7000a7917e	0f62f261-ac51-455a-8067-aa7000a79172	ИФК Йостерсунд/Draw and Yes	AXYes	active	3.15		\N		1	1	ИФК Йостерсунд/Draw and Yes	5026356_12111139_46432182
6d9b4e7c-3539-46f6-8dcb-aa7000a7918a	0f62f261-ac51-455a-8067-aa7000a79172	ИФК Йостерсунд/Kramfors-alliansen and Yes	ABYes	active	4.65		\N		1	2	ИФК Йостерсунд/Kramfors-alliansen and Yes	5026356_12111139_46432194
69d80d36-6855-4117-aa75-aa7000a79197	0f62f261-ac51-455a-8067-aa7000a79172	Draw/Kramfors-alliansen and Yes	BXYes	active	4.95		\N		1	3	Draw/Kramfors-alliansen and Yes	5026356_12111139_46432203
31f263a5-df72-4e43-b565-aa7000a791a2	0f62f261-ac51-455a-8067-aa7000a79172	ИФК Йостерсунд/Draw and No	AXNo	active	1.28		\N		2	1	ИФК Йостерсунд/Draw and No	5026356_12111139_46432188
a9d969a6-10aa-4daf-ae16-aa7000a791b0	0f62f261-ac51-455a-8067-aa7000a79172	ИФК Йостерсунд/Kramfors-alliansen and No	ABNo	active	1.43		\N		2	2	ИФК Йостерсунд/Kramfors-alliansen and No	5026356_12111139_46432199
90a7e692-14bc-4463-884c-aa7000a791bd	0f62f261-ac51-455a-8067-aa7000a79172	Draw/Kramfors-alliansen and No	BXNo	active	2.75		\N		2	3	Draw/Kramfors-alliansen and No	5026356_12111139_46432207
d71e25d7-788a-4e80-9a6e-aa7000a791d6	382a4a8e-15cf-4216-ba20-aa7000a791ca	ИФК Йостерсунд/Draw and Yes	AXYes	active	1.77		\N		1	1	ИФК Йостерсунд/Draw and Yes	5026356_12111117_46432090
7809ae47-c034-4601-bcbb-aa7000a791e3	382a4a8e-15cf-4216-ba20-aa7000a791ca	ИФК Йостерсунд/Kramfors-alliansen and Yes	ABYes	active	1.92		\N		1	2	ИФК Йостерсунд/Kramfors-alliansen and Yes	5026356_12111117_46432100
714c70ae-a5b9-4ff7-a9ed-aa7000a791ee	382a4a8e-15cf-4216-ba20-aa7000a791ca	Draw/Kramfors-alliansen and Yes	BXYes	active	5.45		\N		1	3	Draw/Kramfors-alliansen and Yes	5026356_12111117_46432112
f6fbe60e-6ebc-423c-813c-aa7000a791fa	382a4a8e-15cf-4216-ba20-aa7000a791ca	ИФК Йостерсунд/Draw and No	AXNo	active	2.03		\N		2	1	ИФК Йостерсунд/Draw and No	5026356_12111117_46432095
c3613567-25a2-4f6b-bc17-aa7000a79205	382a4a8e-15cf-4216-ba20-aa7000a791ca	ИФК Йостерсунд/Kramfors-alliansen and No	ABNo	active	1.99		\N		2	2	ИФК Йостерсунд/Kramfors-alliansen and No	5026356_12111117_46432107
fbafbf2f-1b6b-4b69-bb0e-aa7000a79211	382a4a8e-15cf-4216-ba20-aa7000a791ca	Draw/Kramfors-alliansen and No	BXNo	active	13.25		\N		2	3	Draw/Kramfors-alliansen and No	5026356_12111117_46432116
466568c7-eaea-46a5-97e0-aa7000a7922c	34ee1de8-ec49-4874-9bbd-aa7000a7921d	ИФК Йостерсунд/Draw  Under 3.5	AXUnder	active	2.15		\N		1	1	ИФК Йостерсунд/Draw  Under 3.5	5026356_12110976_46431396
24e14130-cd86-4aa4-8b7a-aa7000a7926c	34ee1de8-ec49-4874-9bbd-aa7000a7921d	ИФК Йостерсунд/Kramfors-alliansen - Under 3.5	ABUnder	active	2.25		\N		1	2	ИФК Йостерсунд/Kramfors-alliansen - Under 3.5	5026356_12110976_46431403
43c6b1f3-8027-4cb6-a4aa-aa7000a7928b	34ee1de8-ec49-4874-9bbd-aa7000a7921d	Draw/Kramfors-alliansen  Under 3.5	XBUnder	active	6.25		\N		1	3	Draw/Kramfors-alliansen  Under 3.5	5026356_12110976_46431414
fdb23f3b-79b0-414e-80fd-aa7000a7929d	34ee1de8-ec49-4874-9bbd-aa7000a7921d	ИФК Йостерсунд/Draw  Over 3.5	AXOver	active	1.68		\N		2	1	ИФК Йостерсунд/Draw  Over 3.5	5026356_12110976_46431420
8b31630c-9e6a-42ef-a947-aa7000a792b9	34ee1de8-ec49-4874-9bbd-aa7000a7921d	ИФК Йостерсунд/Kramfors-alliansen  Over 3.5	ABOver	active	1.74		\N		2	2	ИФК Йостерсунд/Kramfors-alliansen  Over 3.5	5026356_12110976_46431426
114e606a-8c71-429a-b5fe-aa7000a792e6	34ee1de8-ec49-4874-9bbd-aa7000a7921d	Draw/Kramfors-alliansen  Over 3.5	XBOver	active	9.75		\N		2	3	Draw/Kramfors-alliansen  Over 3.5	5026356_12110976_46431432
45579113-7187-40e5-a227-aa7000a79332	e9448147-e994-49af-9cde-aa7000a79318	ИФК Йостерсунд/Draw  Under 2.5	AXUnder	active	3.45		\N		1	1	ИФК Йостерсунд/Draw  Under 2.5	5026356_12110961_46431313
561b560e-c73d-4ae6-bedd-aa7000a79345	e9448147-e994-49af-9cde-aa7000a79318	ИФК Йостерсунд/Kramfors-alliansen - Under 2.5	ABUnder	active	4.15		\N		1	2	ИФК Йостерсунд/Kramfors-alliansen - Under 2.5	5026356_12110961_46431317
c3f08a81-f671-4e98-9802-aa7000a79352	e9448147-e994-49af-9cde-aa7000a79318	Draw/Kramfors-alliansen  Under 2.5	XBUnder	active	7.25		\N		1	3	Draw/Kramfors-alliansen  Under 2.5	5026356_12110961_46431324
2de89078-e81c-421c-bcbb-aa7000a7935d	e9448147-e994-49af-9cde-aa7000a79318	ИФК Йостерсунд/Draw  Over 2.5	AXOver	active	1.31		\N		2	1	ИФК Йостерсунд/Draw  Over 2.5	5026356_12110961_46431331
cb8afa5f-adcb-4917-828a-aa7000a79367	e9448147-e994-49af-9cde-aa7000a79318	ИФК Йостерсунд/Kramfors-alliansen  Over 2.5	ABOver	active	1.3		\N		2	2	ИФК Йостерсунд/Kramfors-alliansen  Over 2.5	5026356_12110961_46431336
5585ac16-c9db-4a2c-8901-aa7000a79371	e9448147-e994-49af-9cde-aa7000a79318	Draw/Kramfors-alliansen  Over 2.5	XBOver	active	7.3		\N		2	3	Draw/Kramfors-alliansen  Over 2.5	5026356_12110961_46431341
32d74127-69d4-4f60-b0aa-aa7000a79389	322d2e07-7fc1-4133-bcae-aa7000a7937e	ИФК Йостерсунд/Draw  Under 1.5	AXUnder	active	7.3		\N		1	1	ИФК Йостерсунд/Draw  Under 1.5	5026356_12110947_46431229
f8ab5512-7ef7-4f6d-82ef-aa7000a79394	322d2e07-7fc1-4133-bcae-aa7000a7937e	ИФК Йостерсунд/Kramfors-alliansen - Under 1.5	ABUnder	active	7.4		\N		1	2	ИФК Йостерсунд/Kramfors-alliansen - Under 1.5	5026356_12110947_46431235
1c6fac23-5512-4185-ad36-aa7000a7939f	322d2e07-7fc1-4133-bcae-aa7000a7937e	Draw/Kramfors-alliansen  Under 1.5	XBUnder	active	13		\N		1	3	Draw/Kramfors-alliansen  Under 1.5	5026356_12110947_46431242
cdacb4ba-fa15-404b-aac9-aa7000a793c6	322d2e07-7fc1-4133-bcae-aa7000a7937e	ИФК Йостерсунд/Draw  Over 1.5	AXOver	active	1.12		\N		2	1	ИФК Йостерсунд/Draw  Over 1.5	5026356_12110947_46431246
dfea3349-7705-473c-aa10-aa7000a793dc	322d2e07-7fc1-4133-bcae-aa7000a7937e	ИФК Йостерсунд/Kramfors-alliansen  Over 1.5	ABOver	active	1.15		\N		2	2	ИФК Йостерсунд/Kramfors-alliansen  Over 1.5	5026356_12110947_46431254
6842669b-de45-4e25-8b19-aa7000a793e6	322d2e07-7fc1-4133-bcae-aa7000a7937e	Draw/Kramfors-alliansen  Over 1.5	XBOver	active	4.45		\N		2	3	Draw/Kramfors-alliansen  Over 1.5	5026356_12110947_46431260
b324ee77-dce9-4ddd-93f9-aa7000a79400	ce3a7628-5456-41d6-8f1d-aa7000a793f3	ИФК Йостерсунд/Yes	AYes	active	5.35		\N		1	1	ИФК Йостерсунд/Yes	5026356_12110915_46431074
e69be014-eb2e-4350-b4b2-aa7000a7940f	ce3a7628-5456-41d6-8f1d-aa7000a793f3	Draw/Yes	XYes	active	8		\N		1	2	Draw/Yes	5026356_12110915_46431084
5a91991e-633d-41a5-823b-aa7000a7941a	ce3a7628-5456-41d6-8f1d-aa7000a793f3	Kramfors-alliansen/Yes	BYes	active	29.5		\N		1	3	Kramfors-alliansen/Yes	5026356_12110915_46431093
8d4e4567-d51a-402e-8c84-aa7000a79424	ce3a7628-5456-41d6-8f1d-aa7000a793f3	ИФК Йостерсунд/No	ANo	active	1.81		\N		2	1	ИФК Йостерсунд/No	5026356_12110915_46431080
d375941e-669f-48d8-a1a1-aa7000a79430	ce3a7628-5456-41d6-8f1d-aa7000a793f3	Draw/No	XNo	active	8.1		\N		2	2	Draw/No	5026356_12110915_46431088
739515c7-8a39-4394-bbe2-aa7000a7943b	ce3a7628-5456-41d6-8f1d-aa7000a793f3	Kramfors-alliansen/No	BNo	active	12.75		\N		2	3	Kramfors-alliansen/No	5026356_12110915_46431099
106a7c05-7c5e-4b61-88d2-aa7000a79451	534de11e-8bb9-48b6-9d6b-aa7000a79446	Ifk Ostersund	A	active	1.11		\N		1	1	Ifk Ostersund	5026356_12110873_46430901
248065b0-e47b-4c86-8707-aa7000a7945e	534de11e-8bb9-48b6-9d6b-aa7000a79446	Kramfors-alliansen	B	active	5		\N		1	2	Kramfors-alliansen	5026356_12110873_46430910
35f02328-5d8d-4b31-8ffd-aa7000a79470	02f30d5d-ee1c-4e20-94a0-aa7000a79469	Yes	Yes	active	4.1		\N		1	1	Yes	5026356_12110437_46429844
b3199b55-40fd-4d33-84e1-aa7000a79479	02f30d5d-ee1c-4e20-94a0-aa7000a79469	No	No	active	1.17		\N		1	2	No	5026356_12110437_46429847
f4001d7c-2558-4b83-a052-aa7000a79499	a85ad4bc-550b-4b6c-b9cf-aa7000a79490	Ifk Luleaa	A	active	1.85		\N		1	1	Ifk Luleaa	5029992_12132023_46508220
ffe3d4d3-f373-415f-b660-aa7000a794a8	a85ad4bc-550b-4b6c-b9cf-aa7000a79490	Draw	X	active	3.7		\N		1	2	Draw	5029992_12132023_46508221
3ada9513-8029-4c7f-a69a-aa7000a794b5	a85ad4bc-550b-4b6c-b9cf-aa7000a79490	Питеаа ИФ	B	active	3.45		\N		1	3	Питеаа ИФ	5029992_12132023_46508222
49c88111-6f39-4798-b47e-aa7000a794cc	511408fa-8462-49eb-a1d8-aa7000a794c0	ИФК Лулеа or Draw	AX	active	1.23		\N		1	1	ИФК Лулеа or Draw	5029992_12095169_46379312
b543c033-74c4-47ab-ab79-aa7000a794dc	511408fa-8462-49eb-a1d8-aa7000a794c0	ИФК Лулеа or Питеаа ИФ	AB	active	1.2		\N		1	2	ИФК Лулеа or Питеаа ИФ	5029992_12095169_46379314
a3bb28bc-2d8b-47ba-9f82-aa7000a794ea	511408fa-8462-49eb-a1d8-aa7000a794c0	Draw or Питеаа ИФ	BX	active	1.66		\N		1	3	Draw or Питеаа ИФ	5029992_12095169_46379317
3b4e7c75-56a3-469e-a4b5-aa7000a79513	1d2cef4a-7d4d-4b4b-9d49-aa7000a794f8	IFK Luleaa	A	active	1.51		\N		1	1	IFK Luleaa	5029992_12095179_46379329
4da998d3-1717-4c90-b1ab-aa7000a7953f	1d2cef4a-7d4d-4b4b-9d49-aa7000a794f8	Питеаа ИФ	B	active	2.95		\N		1	2	Питеаа ИФ	5029992_12095179_46379330
d4b7e974-83dd-43d0-98c5-aa7000a813bd	3e1ad458-4c80-4333-9e4a-aa7000a8139c	2-1	2-1	active	11.25		\N		1	1	2-1	5026344_12111675_46436057
bd3ff504-257c-4c6a-a448-aa7000a813c5	3e1ad458-4c80-4333-9e4a-aa7000a8139c	1-0	1-0	active	13.5		\N		1	2	1-0	5026344_12111675_46436062
af0c741d-2f89-40ac-911a-aa7000a813cc	3e1ad458-4c80-4333-9e4a-aa7000a8139c	2-0	2-0	active	17.75		\N		1	3	2-0	5026344_12111675_46436067
d60e2eb6-2646-4792-b6b1-aa7000a813d3	3e1ad458-4c80-4333-9e4a-aa7000a8139c	1-4	1-4	active	50		\N		2	1	1-4	5026344_12111675_46436072
df6cb670-da92-4c7d-b970-aa7000a813db	3e1ad458-4c80-4333-9e4a-aa7000a8139c	3-4	3-4	active	125		\N		2	2	3-4	5026344_12111675_46436077
2e2e8a4f-6fb6-4a66-9a0a-aa7000a813e3	3e1ad458-4c80-4333-9e4a-aa7000a8139c	2-2	2-2	active	13.75		\N		2	3	2-2	5026344_12111675_46436081
5f396eca-c185-42f7-b807-aa7000a813ef	3e1ad458-4c80-4333-9e4a-aa7000a8139c	1-3	1-3	active	20		\N		3	1	1-3	5026344_12111675_46436086
112b9643-f562-428d-a676-aa7000a813f7	3e1ad458-4c80-4333-9e4a-aa7000a8139c	3-0	3-0	active	35		\N		3	2	3-0	5026344_12111675_46436092
07391d34-9d1c-4404-b85c-aa7000a81401	3e1ad458-4c80-4333-9e4a-aa7000a8139c	3-1	3-1	active	22.5		\N		3	3	3-1	5026344_12111675_46436094
ea749fe6-16ce-4169-aea6-aa7000a8140a	3e1ad458-4c80-4333-9e4a-aa7000a8139c	3-2	3-2	active	28		\N		4	1	3-2	5026344_12111675_46436098
183ab856-a022-4798-a948-aa7000a81413	3e1ad458-4c80-4333-9e4a-aa7000a8139c	2-4	2-4	active	70		\N		4	2	2-4	5026344_12111675_46436104
c3d1e825-ebc8-43d2-a170-aa7000a8141c	3e1ad458-4c80-4333-9e4a-aa7000a8139c	4-3	4-3	active	150		\N		4	3	4-3	5026344_12111675_46436108
86967080-479d-4787-a03d-aa7000a81426	3e1ad458-4c80-4333-9e4a-aa7000a8139c	Any Other	M1	active	22		\N		5	1	Any Other	5026344_12111675_46436113
436646fc-af31-40db-8429-aa7000a8142f	3e1ad458-4c80-4333-9e4a-aa7000a8139c	2-3	2-3	active	26.5		\N		5	2	2-3	5026344_12111675_46436115
564e200b-b8bd-461b-bf82-aa7000a81436	3e1ad458-4c80-4333-9e4a-aa7000a8139c	4-0	4-0	active	90		\N		5	3	4-0	5026344_12111675_46436120
6c9a8eef-f0b2-4a88-8360-aa7000a8143f	3e1ad458-4c80-4333-9e4a-aa7000a8139c	3-3	3-3	active	50		\N		6	1	3-3	5026344_12111675_46436123
425f44a1-f3d9-413d-9b03-aa7000a81447	3e1ad458-4c80-4333-9e4a-aa7000a8139c	0-4	0-4	active	80		\N		6	2	0-4	5026344_12111675_46436127
6060c0b0-9f68-45b4-8d60-aa7000a8144f	3e1ad458-4c80-4333-9e4a-aa7000a8139c	4-1	4-1	active	60		\N		6	3	4-1	5026344_12111675_46436131
ebe1cb43-00f6-47d1-b0ad-aa7000a81456	3e1ad458-4c80-4333-9e4a-aa7000a8139c	4-2	4-2	active	70		\N		7	1	4-2	5026344_12111675_46436135
2402f62a-487a-4568-bdc7-aa7000a8145d	3e1ad458-4c80-4333-9e4a-aa7000a8139c	1-2	1-2	active	10.75		\N		7	2	1-2	5026344_12111675_46436139
13c5193f-caca-4eff-a636-aa7000a81467	3e1ad458-4c80-4333-9e4a-aa7000a8139c	0-3	0-3	active	30		\N		7	3	0-3	5026344_12111675_46436143
e99f6df4-f11e-427b-b054-aa7000a81470	3e1ad458-4c80-4333-9e4a-aa7000a8139c	0-1	0-1	active	12.75		\N		8	1	0-1	5026344_12111675_46436146
891f263a-a15f-48b0-bb83-aa7000a81486	3e1ad458-4c80-4333-9e4a-aa7000a8139c	0-0	0-0	active	19.5		\N		8	2	0-0	5026344_12111675_46436150
8651ab9c-95ed-4706-bd46-aa7000a814a0	3e1ad458-4c80-4333-9e4a-aa7000a8139c	0-2	0-2	active	16		\N		8	3	0-2	5026344_12111675_46436154
2356e07c-555a-4867-899d-aa7000a814a8	3e1ad458-4c80-4333-9e4a-aa7000a8139c	4-4	4-4	active	250		\N		9	1	4-4	5026344_12111675_46436160
e2f18f55-c067-4f25-9f28-aa7000a814b9	3e1ad458-4c80-4333-9e4a-aa7000a8139c	1-1	1-1	active	8.25		\N		9	2	1-1	5026344_12111675_46436166
4f6d6b07-5be5-49ee-b126-aa7000a814c9	6777ee9d-d69a-483b-a351-aa7000a814c0	Ifk Hassleholm/Ifk Hassleholm and over +4.5	A/AOver	active	17		\N		1	1	Ifk Hassleholm/Ifk Hassleholm and over +4.5	5026344_12111560_46435006
e24225be-c06d-4340-aeb7-aa7000a814d1	6777ee9d-d69a-483b-a351-aa7000a814c0	Ifk Hassleholm/Ifk Hassleholm and under +4.5	A/AUnder	active	6		\N		1	2	Ifk Hassleholm/Ifk Hassleholm and under +4.5	5026344_12111560_46435102
b00372a1-5920-4bfd-8d35-aa7000a814db	6777ee9d-d69a-483b-a351-aa7000a814c0	Ifk Hassleholm/Nosaby If and over +4.5	A/BOver	active	70		\N		2	1	Ifk Hassleholm/Nosaby If and over +4.5	5026344_12111560_46435018
e2363405-4c64-4436-b862-aa7000a814e4	6777ee9d-d69a-483b-a351-aa7000a814c0	Ifk Hassleholm/Nosaby If and under +4.5	A/BUnder	active	55		\N		2	2	Ifk Hassleholm/Nosaby If and under +4.5	5026344_12111560_46435081
9cde10f2-55a2-4f57-a28d-aa7000a814ed	6777ee9d-d69a-483b-a351-aa7000a814c0	Ifk Hassleholm/Draw and over +4.5	A/XOver	active	125		\N		3	1	Ifk Hassleholm/Draw and over +4.5	5026344_12111560_46435012
5c229ce7-f7a9-4f53-98d4-aa7000a814f5	6777ee9d-d69a-483b-a351-aa7000a814c0	Ifk Hassleholm/Draw and under +4.5	A/XUnder	active	19		\N		3	2	Ifk Hassleholm/Draw and under +4.5	5026344_12111560_46435109
6923ee86-9a59-4f57-900e-aa7000a814fd	6777ee9d-d69a-483b-a351-aa7000a814c0	Nosaby If/Ifk Hassleholm and over +4.5	B/AOver	active	70		\N		4	1	Nosaby If/Ifk Hassleholm and over +4.5	5026344_12111560_46435062
33761b56-3440-41a7-8363-aa7000a81504	6777ee9d-d69a-483b-a351-aa7000a814c0	Nosaby If/Ifk Hassleholm and under +4.5	B/AUnder	active	60		\N		4	2	Nosaby If/Ifk Hassleholm and under +4.5	5026344_12111560_46435098
f13013ee-2d36-4710-950e-aa7000a8150d	6777ee9d-d69a-483b-a351-aa7000a814c0	Nosaby If/Nosaby If and over +4.5	B/BOver	active	15		\N		5	1	Nosaby If/Nosaby If and over +4.5	5026344_12111560_46435076
0f56fa55-65d2-4764-9f23-aa7000a81515	6777ee9d-d69a-483b-a351-aa7000a814c0	Nosaby If/Nosaby If and under +4.5	B/BUnder	active	5.45		\N		5	2	Nosaby If/Nosaby If and under +4.5	5026344_12111560_46435038
29506ab0-fc9a-4a9e-8f41-aa7000a8151c	6777ee9d-d69a-483b-a351-aa7000a814c0	Nosaby If/Draw and over +4.5	B/XOver	active	125		\N		6	1	Nosaby If/Draw and over +4.5	5026344_12111560_46435066
c3b78dcf-5506-4dc0-8d3f-aa7000a81524	6777ee9d-d69a-483b-a351-aa7000a814c0	Nosaby If/Draw and under +4.5	B/XUnder	active	19		\N		6	2	Nosaby If/Draw and under +4.5	5026344_12111560_46435031
e216637b-c64b-43f4-8649-aa7000a81530	6777ee9d-d69a-483b-a351-aa7000a814c0	Draw/{0} and over	X/AOver	active	45		\N		7	1	Draw/{0} and over	5026344_12111560_46435025
05f4e277-6551-4d39-91b1-aa7000a81539	6777ee9d-d69a-483b-a351-aa7000a814c0	Draw/{0} and under	X/AUnder	active	8.45		\N		7	2	Draw/{0} and under	5026344_12111560_46435092
6a23ed78-bc58-4021-8164-aa7000a81541	6777ee9d-d69a-483b-a351-aa7000a814c0	Draw/Nosaby If and over +4.5	X/BOver	active	40		\N		8	1	Draw/Nosaby If and over +4.5	5026344_12111560_46435050
184dd01f-7382-4c6c-90d5-aa7000a81549	6777ee9d-d69a-483b-a351-aa7000a814c0	Draw/Nosaby If and under +4.5	X/BUnder	active	7.9		\N		8	2	Draw/Nosaby If and under +4.5	5026344_12111560_46435070
c01edb1a-669c-46c5-bdef-aa7000a81551	6777ee9d-d69a-483b-a351-aa7000a814c0	Draw/Draw and over	X/XOver	active	125		\N		9	1	Draw/Draw and over	5026344_12111560_46435044
b4308047-89ba-4544-96e0-aa7000a8155d	6777ee9d-d69a-483b-a351-aa7000a814c0	Draw/Draw and under	X/XUnder	active	7.05		\N		9	2	Draw/Draw and under	5026344_12111560_46435058
71cc1106-541b-430b-85d8-aa7000a81572	f4cb2ae7-9757-4c90-ac84-aa7000a81567	Ifk Hassleholm +0.5	AH	active	1.53		\N		1	1	Ifk Hassleholm +0.5	5026344_12110519_46430034
a92f2951-9d58-4b6a-9a1e-aa7000a8157c	f4cb2ae7-9757-4c90-ac84-aa7000a81567	Носаби ИФ -0.5	BH	active	2.24		\N		1	2	Носаби ИФ -0.5	5026344_12110519_46430037
96babfdb-d753-40ea-bf43-aa7000a8158b	fea163b1-99d5-4a4e-b6e0-aa7000a81584	Ifk Hassleholm -0.25	AH	active	2.16		\N		1	1	Ifk Hassleholm -0.25	5026344_12110533_46430063
3c5679ad-914a-4c79-8105-aa7000a81595	fea163b1-99d5-4a4e-b6e0-aa7000a81584	Носаби ИФ +0.25	BH	active	1.57		\N		1	2	Носаби ИФ +0.25	5026344_12110533_46430068
68aba00c-7899-4f2f-8704-aa7000a815a9	a600a21d-1bdc-4260-9757-aa7000a8159e	Under 1	Under	active	2.25		\N		1	1	Under 1	5026344_12110561_46430134
e6db6f3b-6f3b-400d-8930-aa7000a815b1	a600a21d-1bdc-4260-9757-aa7000a8159e	Over 1	Over	active	1.53		\N		1	2	Over 1	5026344_12110561_46430128
6b2320d9-93a5-430d-aeed-aa7000a815c5	b6a6f54c-5082-451d-939b-aa7000a815bb	Under 1.5	Under	active	1.54		\N		1	1	Under 1.5	5026344_12110575_46430160
b7b56277-7729-4fcd-b175-aa7000a815d1	b6a6f54c-5082-451d-939b-aa7000a815bb	Over 1.5	Over	active	2.22		\N		1	2	Over 1.5	5026344_12110575_46430153
52f2dcab-19ad-4030-b8be-aa7000a815ed	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Ifk Hassleholm/Ifk Hassleholm and over +3.5	A/AOver	active	10.25		\N		1	1	Ifk Hassleholm/Ifk Hassleholm and over +3.5	5026344_12111625_46435675
7b8c3cec-fe80-4d3a-8539-aa7000a815fe	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Ifk Hassleholm/Ifk Hassleholm and under +3.5	A/AUnder	active	7.75		\N		1	2	Ifk Hassleholm/Ifk Hassleholm and under +3.5	5026344_12111625_46435763
9b15d461-73cc-41c6-a44f-aa7000a8160d	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Ifk Hassleholm/Nosaby If and over +3.5	A/BOver	active	55		\N		2	1	Ifk Hassleholm/Nosaby If and over +3.5	5026344_12111625_46435699
130d67eb-1868-4dfd-8704-aa7000a81616	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Ifk Hassleholm/Nosaby If and under +3.5	A/BUnder	active	70		\N		2	2	Ifk Hassleholm/Nosaby If and under +3.5	5026344_12111625_46435720
8af555e6-beb2-4ae6-a80d-aa7000a81620	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Ifk Hassleholm/Draw and over +3.5	A/XOver	active	30		\N		3	1	Ifk Hassleholm/Draw and over +3.5	5026344_12111625_46435692
6cfaa590-7ed5-421d-92eb-aa7000a81629	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Ifk Hassleholm/Draw and under +3.5	A/XUnder	active	35		\N		3	2	Ifk Hassleholm/Draw and under +3.5	5026344_12111625_46435766
c962ecd7-9350-49dd-a435-aa7000a81633	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Nosaby If/Ifk Hassleholm and over +3.5	B/AOver	active	60		\N		4	1	Nosaby If/Ifk Hassleholm and over +3.5	5026344_12111625_46435733
26e6ec23-7b82-4e29-9c46-aa7000a8163b	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Nosaby If/Ifk Hassleholm and under +3.5	B/AUnder	active	80		\N		4	2	Nosaby If/Ifk Hassleholm and under +3.5	5026344_12111625_46435727
e5cac0e3-6efb-4654-a43c-aa7000a81642	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Nosaby If/Nosaby If and over +3.5	B/BOver	active	9.1		\N		5	1	Nosaby If/Nosaby If and over +3.5	5026344_12111625_46435757
72cd394e-3c24-47d8-a721-aa7000a8164b	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Nosaby If/Nosaby If and under +3.5	B/BUnder	active	7.1		\N		5	2	Nosaby If/Nosaby If and under +3.5	5026344_12111625_46435686
c438818b-54bf-4725-97de-aa7000a81653	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Nosaby If/Draw and over +3.5	B/XOver	active	30		\N		6	1	Nosaby If/Draw and over +3.5	5026344_12111625_46435746
1a08cdb4-cb19-478d-a709-aa7000a8165c	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Nosaby If/Draw and under +3.5	B/XUnder	active	35		\N		6	2	Nosaby If/Draw and under +3.5	5026344_12111625_46435679
d856344b-517f-41d8-99a8-aa7000a81665	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Draw/{0} and over	X/AOver	active	28.5		\N		7	1	Draw/{0} and over	5026344_12111625_46435704
93cec052-98a0-4e8c-b83b-aa7000a8166e	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Draw/{0} and under	X/AUnder	active	9.55		\N		7	2	Draw/{0} and under	5026344_12111625_46435752
b7d98161-052b-4f11-9d19-aa7000a81676	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Draw/Nosaby If and over +3.5	X/BOver	active	26		\N		8	1	Draw/Nosaby If and over +3.5	5026344_12111625_46435711
19a6497d-0d76-432c-9a5a-aa7000a8167f	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Draw/Nosaby If and under +3.5	X/BUnder	active	8.9		\N		8	2	Draw/Nosaby If and under +3.5	5026344_12111625_46435723
7b24e3f8-fe59-4188-88ed-aa7000a81687	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Draw/Draw and over	X/XOver	active	29.5		\N		9	1	Draw/Draw and over	5026344_12111625_46435669
8f26951e-f87f-4bea-ab94-aa7000a81690	fa9c0ee5-7af0-49f6-b826-aa7000a815de	Draw/Draw and under	X/XUnder	active	8.7		\N		9	2	Draw/Draw and under	5026344_12111625_46435740
5347cd35-3e68-4be4-9d80-aa7000a8169f	acf7824d-c5c0-4129-9a59-aa7000a81698	Ifk Hassleholm/Ifk Hassleholm and over +2.5	A/AOver	active	6.3		\N		1	1	Ifk Hassleholm/Ifk Hassleholm and over +2.5	5026344_12111598_46435423
4d4ee4bf-97ea-42e2-9c37-aa7000a816a8	acf7824d-c5c0-4129-9a59-aa7000a81698	Ifk Hassleholm/Ifk Hassleholm and under +2.5	A/AUnder	active	15.25		\N		1	2	Ifk Hassleholm/Ifk Hassleholm and under +2.5	5026344_12111598_46435504
2d6fc6fa-837d-40ad-b1d7-aa7000a816b0	acf7824d-c5c0-4129-9a59-aa7000a81698	Ifk Hassleholm/Nosaby If and over +2.5	A/BOver	active	30		\N		2	1	Ifk Hassleholm/Nosaby If and over +2.5	5026344_12111598_46435436
8ccb511e-e597-4e3a-89e4-aa7000a816b8	acf7824d-c5c0-4129-9a59-aa7000a81698	Ifk Hassleholm/Draw and under +2.5	A/XUnder	active	35		\N		2	2	Ifk Hassleholm/Draw and under +2.5	5026344_12111598_46435510
dc6574b3-f096-43bd-afc0-aa7000a816c0	acf7824d-c5c0-4129-9a59-aa7000a81698	Ifk Hassleholm/Draw and over +2.5	A/XOver	active	30		\N		3	1	Ifk Hassleholm/Draw and over +2.5	5026344_12111598_46435429
2dd55eb4-ae61-4653-a53a-aa7000a816c8	acf7824d-c5c0-4129-9a59-aa7000a81698	Nosaby If/Ifk Hassleholm and over +2.5	B/AOver	active	35		\N		4	1	Nosaby If/Ifk Hassleholm and over +2.5	5026344_12111598_46435462
e86bad3b-25a8-45aa-bd27-aa7000a816d0	acf7824d-c5c0-4129-9a59-aa7000a81698	Nosaby If/Nosaby If and under +2.5	B/BUnder	active	14		\N		4	2	Nosaby If/Nosaby If and under +2.5	5026344_12111598_46435469
a7a3614e-7933-4de0-8a2a-aa7000a816d9	acf7824d-c5c0-4129-9a59-aa7000a81698	Nosaby If/Nosaby If and over +2.5	B/BOver	active	5.6		\N		5	1	Nosaby If/Nosaby If and over +2.5	5026344_12111598_46435489
bc7a33d5-29c3-4a1e-af2a-aa7000a816e1	acf7824d-c5c0-4129-9a59-aa7000a81698	Nosaby If/Draw and under +2.5	B/XUnder	active	35		\N		5	2	Nosaby If/Draw and under +2.5	5026344_12111598_46435472
0cd7a20b-661f-407d-bb7b-aa7000a816e9	acf7824d-c5c0-4129-9a59-aa7000a81698	Nosaby If/Draw and over +2.5	B/XOver	active	30		\N		6	1	Nosaby If/Draw and over +2.5	5026344_12111598_46435478
99290539-b775-4e8b-a4e3-aa7000a816f3	acf7824d-c5c0-4129-9a59-aa7000a81698	Draw/{0} and under	X/AUnder	active	15.5		\N		6	2	Draw/{0} and under	5026344_12111598_46435498
f0231990-a10a-40de-b8ff-aa7000a816fb	acf7824d-c5c0-4129-9a59-aa7000a81698	Draw/{0} and over	X/AOver	active	13.25		\N		7	1	Draw/{0} and over	5026344_12111598_46435442
cf7c7c0e-359e-4241-8a2b-aa7000a81703	acf7824d-c5c0-4129-9a59-aa7000a81698	Draw/Nosaby If and under +2.5	X/BUnder	active	14.5		\N		7	2	Draw/Nosaby If and under +2.5	5026344_12111598_46435482
f0e187f9-380e-47bf-b263-aa7000a8170b	acf7824d-c5c0-4129-9a59-aa7000a81698	Draw/Nosaby If and over +2.5	X/BOver	active	12.25		\N		8	1	Draw/Nosaby If and over +2.5	5026344_12111598_46435455
0c146b77-1aee-4c8f-85d2-aa7000a81713	acf7824d-c5c0-4129-9a59-aa7000a81698	Draw/Draw and under	X/XUnder	active	8.7		\N		8	2	Draw/Draw and under	5026344_12111598_46435517
b1a44f9e-43ed-4972-87ba-aa7000a8171c	acf7824d-c5c0-4129-9a59-aa7000a81698	Draw/Draw and over	X/XOver	active	29.5		\N		9	1	Draw/Draw and over	5026344_12111598_46435447
440575f5-e55e-4e35-adca-aa7000a8172c	4fdd9403-fb96-416a-8695-aa7000a81724	Ifk Hassleholm/Ifk Hassleholm and over +1.5	A/AOver	active	5.1		\N		1	1	Ifk Hassleholm/Ifk Hassleholm and over +1.5	5026344_12111581_46435232
bc6b348b-9dfd-4093-ac62-aa7000a81737	4fdd9403-fb96-416a-8695-aa7000a81724	Ifk Hassleholm/Ifk Hassleholm and under +1.5	A/AUnder	active	35		\N		1	2	Ifk Hassleholm/Ifk Hassleholm and under +1.5	5026344_12111581_46435298
588275c0-fe1d-44ae-a388-aa7000a81744	4fdd9403-fb96-416a-8695-aa7000a81724	Ifk Hassleholm/Nosaby If and over +1.5	A/BOver	active	30		\N		2	1	Ifk Hassleholm/Nosaby If and over +1.5	5026344_12111581_46435250
d8d4afce-261a-42f1-b4fd-aa7000a81753	4fdd9403-fb96-416a-8695-aa7000a81724	Ifk Hassleholm/Draw and over +1.5	A/XOver	active	16.5		\N		3	1	Ifk Hassleholm/Draw and over +1.5	5026344_12111581_46435238
e15c757d-b28c-4886-8d71-aa7000a81766	4fdd9403-fb96-416a-8695-aa7000a81724	Nosaby If/Ifk Hassleholm and over +1.5	B/AOver	active	35		\N		4	1	Nosaby If/Ifk Hassleholm and over +1.5	5026344_12111581_46435265
8b430cee-a045-4195-8c0a-aa7000a81777	4fdd9403-fb96-416a-8695-aa7000a81724	Nosaby If/Nosaby If and under +1.5	B/BUnder	active	30		\N		4	2	Nosaby If/Nosaby If and under +1.5	5026344_12111581_46435313
47dbbfa1-e418-408b-91de-aa7000a81780	4fdd9403-fb96-416a-8695-aa7000a81724	Nosaby If/Nosaby If and over +1.5	B/BOver	active	4.6		\N		5	1	Nosaby If/Nosaby If and over +1.5	5026344_12111581_46435285
1f838acc-e0ce-472b-92e2-aa7000a81788	4fdd9403-fb96-416a-8695-aa7000a81724	Nosaby If/Draw and over +1.5	B/XOver	active	16.5		\N		6	1	Nosaby If/Draw and over +1.5	5026344_12111581_46435272
b5734741-f832-4786-a013-aa7000a81790	4fdd9403-fb96-416a-8695-aa7000a81724	Draw/{0} and under	X/AUnder	active	22		\N		6	2	Draw/{0} and under	5026344_12111581_46435305
3712a490-db7c-4fb8-a01a-aa7000a81798	4fdd9403-fb96-416a-8695-aa7000a81724	Draw/{0} and over	X/AOver	active	10.5		\N		7	1	Draw/{0} and over	5026344_12111581_46435225
5eecc5fd-4f8e-468f-8107-aa7000a817a0	4fdd9403-fb96-416a-8695-aa7000a81724	Draw/Nosaby If and under +1.5	X/BUnder	active	21		\N		7	2	Draw/Nosaby If and under +1.5	5026344_12111581_46435277
efcc7b30-2725-4573-b933-aa7000a817a9	4fdd9403-fb96-416a-8695-aa7000a81724	Draw/Nosaby If and over +1.5	X/BOver	active	9.65		\N		8	1	Draw/Nosaby If and over +1.5	5026344_12111581_46435261
678d49a5-7a63-44d8-8e97-aa7000a817b1	4fdd9403-fb96-416a-8695-aa7000a81724	Draw/Draw and under	X/XUnder	active	19.5		\N		8	2	Draw/Draw and under	5026344_12111581_46435245
04f50e10-fbfb-431d-acfe-aa7000a817b9	4fdd9403-fb96-416a-8695-aa7000a81724	Draw/Draw and over	X/XOver	active	10.25		\N		9	1	Draw/Draw and over	5026344_12111581_46435255
64f28a6f-212d-4be4-bea9-aa7000a817c9	92569274-edec-49a5-8ad8-aa7000a817c1	0	0	active	3.4		\N		1	1	0	5026344_12111535_46434784
36e15173-dd2f-4696-b547-aa7000a817d1	92569274-edec-49a5-8ad8-aa7000a817c1	1	1	active	2.7		\N		1	2	1	5026344_12111535_46434792
a65ea3d9-89a3-4ec1-9f3a-aa7000a817d9	92569274-edec-49a5-8ad8-aa7000a817c1	2	2	active	3.85		\N		1	3	2	5026344_12111535_46434798
b184dc53-cd21-482b-a4a8-aa7000a817e0	92569274-edec-49a5-8ad8-aa7000a817c1	3+	3+	active	5.6		\N		2	1	3+	5026344_12111535_46434807
203597f9-e274-4005-b724-aa7000a817f1	ff0c0dbf-89e4-4349-8384-aa7000a817e8	Yes	Yes	active	2.09		\N		1	1	Yes	5026344_12110924_46431126
ab6724c4-2252-4e34-ad86-aa7000a817f9	ff0c0dbf-89e4-4349-8384-aa7000a817e8	No	No	active	1.61		\N		1	2	No	5026344_12110924_46431130
3e754690-1c27-4280-bf5c-aa7000a81809	0d8a7659-5c43-48b2-8851-aa7000a81801	Under 1.25	Under	active	1.7		\N		1	1	Under 1.25	5026344_12110586_46430194
6fad4929-c0d1-4e11-baa8-aa7000a81811	0d8a7659-5c43-48b2-8851-aa7000a81801	Over 1.25	Over	active	1.95		\N		1	2	Over 1.25	5026344_12110586_46430190
7054e57a-9de2-4e1b-bab9-aa7000a81824	5dee0f3b-9068-4875-a20e-aa7000a8181a	Ifk Hassleholm -0.5	AH	active	2.43		\N		1	1	Ifk Hassleholm -0.5	5026344_12110547_46430095
bcebf394-b375-4ab6-aa2b-aa7000a8182c	5dee0f3b-9068-4875-a20e-aa7000a8181a	Носаби ИФ +0.5	BH	active	1.45		\N		1	2	Носаби ИФ +0.5	5026344_12110547_46430102
23785c22-d2af-4549-b786-aa7000a8183c	d1b28612-2062-449e-88ad-aa7000a81834	Ifk Hassleholm +0.25	AH	active	1.67		\N		1	1	Ifk Hassleholm +0.25	5026344_12110506_46430004
2fad21e1-0b23-4135-8c9b-aa7000a81852	d1b28612-2062-449e-88ad-aa7000a81834	Носаби ИФ -0.25	BH	active	2		\N		1	2	Носаби ИФ -0.25	5026344_12110506_46430006
5bd7e779-af6e-4582-a3d1-aa7000a81862	b2ff814f-f921-42a6-a5d1-aa7000a8185a	Ifk Hassleholm 0	AH	active	1.9		\N		1	1	Ifk Hassleholm 0	5026344_12110496_46429977
014b41e5-11f3-4944-a4ad-aa7000a8186c	b2ff814f-f921-42a6-a5d1-aa7000a8185a	Носаби ИФ 0	BH	active	1.75		\N		1	2	Носаби ИФ 0	5026344_12110496_46429984
2fefb520-9ec4-475b-9213-aa7000a8187e	d589dd5d-502a-4ecd-8b98-aa7000a81875	Yes	Yes	active	1.81		\N		1	1	Yes	5026344_12110315_46429536
4536e7c3-aea9-43af-b6aa-aa7000a81886	d589dd5d-502a-4ecd-8b98-aa7000a81875	No	No	active	1.82		\N		1	2	No	5026344_12110315_46429541
b79a9c15-7389-4cf4-8fba-aa7000a81898	a71d2bd3-2cc3-445b-9c8e-aa7000a81890	No/No	NN	active	1.87		\N		1	1	No/No	5026344_12110401_46429759
5cd53463-8a91-4cea-af7e-aa7000a818a2	a71d2bd3-2cc3-445b-9c8e-aa7000a81890	Yes/No	YN	active	5.35		\N		1	2	Yes/No	5026344_12110401_46429764
a4e60c30-48c5-40b4-b39c-aa7000a818bb	a71d2bd3-2cc3-445b-9c8e-aa7000a81890	Yes/Yes	YY	active	10.75		\N		1	3	Yes/Yes	5026344_12110401_46429770
e73115f8-1774-40b2-a1f7-aa7000a818c3	a71d2bd3-2cc3-445b-9c8e-aa7000a81890	No/Yes	NY	active	3.5		\N		2	1	No/Yes	5026344_12110401_46429778
8ce5482f-471e-4243-a2a2-aa7000a818e6	79336adf-f18b-4ae7-8624-aa7000a818d8	Under 3.5	Under	active	1.6		\N		1	1	Under 3.5	5026344_12110732_46430560
deebb265-4894-49fb-8814-aa7000a818ef	79336adf-f18b-4ae7-8624-aa7000a818d8	Over 3.5	Over	active	2.65		\N		1	2	Over 3.5	5026344_12110732_46430555
bd890d25-37f2-4f48-9ead-aa7000a81900	315596df-3e1e-4399-9bcd-aa7000a818f7	Under 2.5	Under	active	2.48		\N		1	1	Under 2.5	5026344_12110720_46430532
cf6c930b-ef3c-421b-beb9-aa7000a8190a	315596df-3e1e-4399-9bcd-aa7000a818f7	Over 2.5	Over	active	1.68		\N		1	2	Over 2.5	5026344_12110720_46430529
1e64fb2a-1b2f-42a3-99c2-aa7000a8191d	22424e69-99b6-4760-a9a9-aa7000a81913	Under 1.5	Under	active	5.5		\N		1	1	Under 1.5	5026344_12110706_46430498
1c8752a3-c35b-45e8-9412-aa7000a81928	22424e69-99b6-4760-a9a9-aa7000a81913	Over 1.5	Over	active	1.22		\N		1	2	Over 1.5	5026344_12110706_46430495
bc3648c8-31d3-4395-84e8-aa7000a81939	847b2fe9-2d3d-419f-a40c-aa7000a81930	Under 0.5	Under	active	19.5		\N		1	1	Under 0.5	5026344_12110693_46430466
6239ee0e-178c-471c-89bb-aa7000a81942	847b2fe9-2d3d-419f-a40c-aa7000a81930	Over 0.5	Over	active	1.04		\N		1	2	Over 0.5	5026344_12110693_46430461
3284a3b5-2014-4046-bfe8-aa7000a81953	c270e763-e37d-45ff-9c67-aa7000a8194a	Under 5.5	Under	active	1.1		\N		1	1	Under 5.5	5026344_12110681_46430436
06b05a1e-3783-4863-a4b4-aa7000a8195d	c270e763-e37d-45ff-9c67-aa7000a8194a	Over 5.5	Over	active	11.25		\N		1	2	Over 5.5	5026344_12110681_46430433
c707efec-29e0-4aae-9b26-aa7000a8196e	ff5941ec-91ca-4b87-bf42-aa7000a81966	Under 4.5	Under	active	1.25		\N		1	1	Under 4.5	5026344_12110658_46430406
fd6d55cf-e4ed-4810-b7b1-aa7000a81977	ff5941ec-91ca-4b87-bf42-aa7000a81966	Over 4.5	Over	active	5.05		\N		1	2	Over 4.5	5026344_12110658_46430398
8cbbe8cb-18c9-4ed2-aaba-aa7000a81986	43b33637-b2e6-4f39-98f3-aa7000a8197f	IFK Hassleholm	A	active	2.53		\N		1	1	IFK Hassleholm	5026344_12095470_46380282
c9ea4637-7dc3-407d-9f1f-aa7000a81990	43b33637-b2e6-4f39-98f3-aa7000a8197f	Draw	X	active	3.65		\N		1	2	Draw	5026344_12095470_46380283
32110692-ebab-46fe-9954-aa7000a8199e	43b33637-b2e6-4f39-98f3-aa7000a8197f	Носаби ИФ	B	active	2.32		\N		1	3	Носаби ИФ	5026344_12095470_46380284
5aa546f3-b463-425f-a385-aa7000a819b4	b9edd2a3-0d4f-4d46-b80f-aa7000a819a8	Ifk Hassleholm or Draw	AX	active	1.44		\N		1	1	Ifk Hassleholm or Draw	5026344_12095466_46380272
8684abd9-18cb-4d3e-a88c-aa7000a819bf	b9edd2a3-0d4f-4d46-b80f-aa7000a819a8	Ifk Hassleholm or Носаби ИФ	AB	active	1.21		\N		1	2	Ifk Hassleholm or Носаби ИФ	5026344_12095466_46380273
397a27e6-fec4-4176-a717-aa7000a819c8	b9edd2a3-0d4f-4d46-b80f-aa7000a819a8	Draw or Носаби ИФ	BX	active	1.38		\N		1	3	Draw or Носаби ИФ	5026344_12095466_46380274
c4946a12-a8bd-41c3-b029-aa7000a819d9	c4c94e32-11c0-452c-9784-aa7000a819d1	Yes	Yes	active	1.5		\N		1	1	Yes	5026344_12111734_46436363
d76c97b2-ca52-440b-a4fa-aa7000a819e1	c4c94e32-11c0-452c-9784-aa7000a819d1	No	No	active	2.32		\N		1	2	No	5026344_12111734_46436366
2a54129f-b57f-4650-866e-aa7000a819f3	657a276c-419a-4ffd-b0b4-aa7000a819eb	Ifk Hassleholm -1	AH	active	5		\N		1	1	Ifk Hassleholm -1	5026344_12110615_46430271
725a0728-89a3-4863-95b1-aa7000a819fd	657a276c-419a-4ffd-b0b4-aa7000a819eb	Draw sigendLine	XH	active	4.55		\N		1	2	Draw sigendLine	5026344_12110615_46430275
8fbba073-eb6b-4bc6-b1c4-aa7000a81a08	657a276c-419a-4ffd-b0b4-aa7000a819eb	Носаби ИФ +1	BH	active	1.47		\N		1	3	Носаби ИФ +1	5026344_12110615_46430279
1378684e-69f2-454f-a15c-aa7000a81a1b	4ecf0193-654a-4d34-ab88-aa7000a81a11	Ifk Hassleholm +1	AH	active	1.55		\N		1	1	Ifk Hassleholm +1	5026344_12110627_46430309
61829e04-b51b-4cec-bc3b-aa7000a81a25	4ecf0193-654a-4d34-ab88-aa7000a81a11	Draw sigendLine	XH	active	4.4		\N		1	2	Draw sigendLine	5026344_12110627_46430312
a4a6905e-15e9-4cae-8c54-aa7000a81a42	4ecf0193-654a-4d34-ab88-aa7000a81a11	Носаби ИФ -1	BH	active	4.4		\N		1	3	Носаби ИФ -1	5026344_12110627_46430318
bf0a2a03-ab70-44cc-a4ac-aa7000a81a5d	162a1688-fd17-4530-b1d3-aa7000a81a53	Ifk Hassleholm +2	AH	active	1.18		\N		1	1	Ifk Hassleholm +2	5026344_12110643_46430345
784475f8-1e91-4474-9055-aa7000a81a65	162a1688-fd17-4530-b1d3-aa7000a81a53	Draw sigendLine	XH	active	6.7		\N		1	2	Draw sigendLine	5026344_12110643_46430348
a9680f47-cb24-4f8f-959a-aa7000a81a6e	162a1688-fd17-4530-b1d3-aa7000a81a53	Носаби ИФ -2	BH	active	9.9		\N		1	3	Носаби ИФ -2	5026344_12110643_46430352
79f70df6-5c21-4e04-a370-aa7000a81a80	cfebeb86-147e-4286-b390-aa7000a81a77	Ifk Hassleholm +1	AH	active	1.55		\N		1	1	Ifk Hassleholm +1	5026344_12111544_46434852
fc88daba-68cc-441a-be74-aa7000a81a89	cfebeb86-147e-4286-b390-aa7000a81a77	Draw sigendLine	XH	active	4.4		\N		1	2	Draw sigendLine	5026344_12111544_46434859
8b6cc6a1-8656-4775-9388-aa7000a81a92	cfebeb86-147e-4286-b390-aa7000a81a77	Носаби ИФ -1	BH	active	4.4		\N		1	3	Носаби ИФ -1	5026344_12111544_46434865
707b2ce8-b4c8-4ec4-833d-aa7000a81aa4	ac66fe2d-2e99-42e4-93d3-aa7000a81a9b	Ifk Hassleholm -2	AH	active	11.5		\N		1	1	Ifk Hassleholm -2	5026344_12110601_46430225
be0c5f99-18b0-4d32-8d27-aa7000a81aad	ac66fe2d-2e99-42e4-93d3-aa7000a81a9b	Draw sigendLine	XH	active	7.2		\N		1	2	Draw sigendLine	5026344_12110601_46430232
6a4fea14-f782-4d37-99d2-aa7000a81ab6	ac66fe2d-2e99-42e4-93d3-aa7000a81a9b	Носаби ИФ +2	BH	active	1.14		\N		1	3	Носаби ИФ +2	5026344_12110601_46430239
642ae94e-7ed4-41e6-9a95-aa7000a81ac8	6c0ca19a-aac2-405f-8534-aa7000a81abf	3-0	3-0	active	35		\N		1	1	3-0	5026344_12111272_46432956
f199c96b-27a5-40ec-9d49-aa7000a81ad1	6c0ca19a-aac2-405f-8534-aa7000a81abf	1-0	1-0	active	13.75		\N		1	2	1-0	5026344_12111272_46432966
6bf36239-d23b-4558-ab93-aa7000a81ad9	6c0ca19a-aac2-405f-8534-aa7000a81abf	1-2	1-2	active	10.75		\N		1	3	1-2	5026344_12111272_46432972
10dc69ab-e25e-40ba-af35-aa7000a81ae3	6c0ca19a-aac2-405f-8534-aa7000a81abf	0-5	0-5	active	200		\N		2	1	0-5	5026344_12111272_46432975
a0a105a7-88df-4b7d-b898-aa7000a81aec	6c0ca19a-aac2-405f-8534-aa7000a81abf	Any Other	M1	active	24		\N		2	2	Any Other	5026344_12111272_46432982
ae108f54-b193-421f-9026-aa7000a81af6	6c0ca19a-aac2-405f-8534-aa7000a81abf	1-1	1-1	active	8.35		\N		2	3	1-1	5026344_12111272_46432990
ba05ae44-0412-4546-bf1b-aa7000a81aff	6c0ca19a-aac2-405f-8534-aa7000a81abf	0-4	0-4	active	80		\N		3	1	0-4	5026344_12111272_46432998
7040bf5e-1556-43a0-b148-aa7000a81b08	6c0ca19a-aac2-405f-8534-aa7000a81abf	2-0	2-0	active	18		\N		3	2	2-0	5026344_12111272_46433006
d2b0d66b-a1ca-4ac5-99b3-aa7000a81b11	6c0ca19a-aac2-405f-8534-aa7000a81abf	2-1	2-1	active	11.5		\N		3	3	2-1	5026344_12111272_46433012
9612b536-e4c9-4fa8-9f8c-aa7000a81b1b	6c0ca19a-aac2-405f-8534-aa7000a81abf	3-1	3-1	active	22.5		\N		4	1	3-1	5026344_12111272_46433019
06150ca0-544d-4d05-9a81-aa7000a81b23	6c0ca19a-aac2-405f-8534-aa7000a81abf	3-3	3-3	active	50		\N		4	2	3-3	5026344_12111272_46433026
14dcfcd9-9ab2-4904-b3d0-aa7000a81b2c	6c0ca19a-aac2-405f-8534-aa7000a81abf	1-3	1-3	active	20.5		\N		4	3	1-3	5026344_12111272_46433031
50df1fce-5b7c-4b7c-bee2-aa7000a81b35	6c0ca19a-aac2-405f-8534-aa7000a81abf	3-2	3-2	active	28		\N		5	1	3-2	5026344_12111272_46433036
ce8d7662-7d0c-4b9f-a51d-aa7000a81b3e	6c0ca19a-aac2-405f-8534-aa7000a81abf	2-2	2-2	active	13.75		\N		5	2	2-2	5026344_12111272_46433042
6fcd4903-7649-433c-bd40-aa7000a81b4b	6c0ca19a-aac2-405f-8534-aa7000a81abf	0-2	0-2	active	16.25		\N		5	3	0-2	5026344_12111272_46433051
f4e3ed28-ffeb-4aee-ad7a-aa7000a81b63	6c0ca19a-aac2-405f-8534-aa7000a81abf	2-3	2-3	active	27		\N		6	1	2-3	5026344_12111272_46433059
a4973826-78ff-40fc-bec1-aa7000a81b6c	6c0ca19a-aac2-405f-8534-aa7000a81abf	4-0	4-0	active	90		\N		6	2	4-0	5026344_12111272_46433064
f6106510-ab52-4f58-b146-aa7000a81b75	6c0ca19a-aac2-405f-8534-aa7000a81abf	0-1	0-1	active	13		\N		6	3	0-1	5026344_12111272_46433073
cfff42e7-2fca-449e-9d38-aa7000a81b95	6c0ca19a-aac2-405f-8534-aa7000a81abf	4-1	4-1	active	60		\N		7	1	4-1	5026344_12111272_46433080
17e56e78-a4a8-471e-b0dd-aa7000a81b9e	6c0ca19a-aac2-405f-8534-aa7000a81abf	0-6	0-6	active	250		\N		7	2	0-6	5026344_12111272_46433086
e2dd9857-1d5c-4fce-addd-aa7000a81bb8	6c0ca19a-aac2-405f-8534-aa7000a81abf	1-5	1-5	active	150		\N		7	3	1-5	5026344_12111272_46433091
d4074840-6bf6-497e-9507-aa7000a81bc6	6c0ca19a-aac2-405f-8534-aa7000a81abf	0-3	0-3	active	30		\N		8	1	0-3	5026344_12111272_46433095
f791c8ac-6e18-478f-8787-aa7000a81bcf	6c0ca19a-aac2-405f-8534-aa7000a81abf	1-4	1-4	active	50		\N		8	2	1-4	5026344_12111272_46433101
d2d7424a-4283-436b-801b-aa7000a81bd9	6c0ca19a-aac2-405f-8534-aa7000a81abf	4-2	4-2	active	70		\N		8	3	4-2	5026344_12111272_46433112
0f13a010-5d88-492b-88f8-aa7000a81be3	6c0ca19a-aac2-405f-8534-aa7000a81abf	5-0	5-0	active	250		\N		9	1	5-0	5026344_12111272_46433119
13b590dc-9178-454a-afb8-aa7000a81bec	6c0ca19a-aac2-405f-8534-aa7000a81abf	0-0	0-0	active	19.5		\N		9	2	0-0	5026344_12111272_46433127
03fb2865-88d7-46a5-8667-aa7000a81c00	6c0ca19a-aac2-405f-8534-aa7000a81abf	5-1	5-1	active	150		\N		9	3	5-1	5026344_12111272_46433133
8c645aa5-c75d-48c8-b34a-aa7000a81c09	6c0ca19a-aac2-405f-8534-aa7000a81abf	2-4	2-4	active	70		\N		10	1	2-4	5026344_12111272_46433139
5a36c417-99d0-4a15-8033-aa7000a81c12	6c0ca19a-aac2-405f-8534-aa7000a81abf	6-0	6-0	active	250		\N		10	2	6-0	5026344_12111272_46433147
d3a7b4fe-f456-4df3-917e-aa7000a81c22	94908ff8-ac1e-4c19-93ca-aa7000a81c19	Under 0.5	Under	active	1.81		\N		1	1	Under 0.5	5026344_12110306_46429516
21137a01-aa10-454e-8728-aa7000a81c2b	94908ff8-ac1e-4c19-93ca-aa7000a81c19	Over 0.5	Over	active	1.83		\N		1	2	Over 0.5	5026344_12110306_46429510
b26e0037-9101-4114-9844-aa7000a81c3c	b73e7f27-18ca-4ac7-b6fc-aa7000a81c34	Under 0.5	Under	active	1.75		\N		1	1	Under 0.5	5026344_12110290_46429459
3789b6f6-e2b7-45ca-94c7-aa7000a81c45	b73e7f27-18ca-4ac7-b6fc-aa7000a81c34	Over 0.5	Over	active	1.89		\N		1	2	Over 0.5	5026344_12110290_46429455
690781ae-7555-422d-8723-aa7000a81c57	2691af49-f553-469b-ba06-aa7000a81c4e	1-0	1-0	active	6.1		\N		1	1	1-0	5026344_12110943_46431207
3d46fc44-b63a-4ed8-ba74-aa7000a81c60	2691af49-f553-469b-ba06-aa7000a81c4e	2-0	2-0	active	14		\N		1	2	2-0	5026344_12110943_46431212
ad054225-d4e1-41de-8a88-aa7000a81c6a	2691af49-f553-469b-ba06-aa7000a81c4e	2-1	2-1	active	16		\N		1	3	2-1	5026344_12110943_46431217
f662987a-9602-41c1-b4f4-aa7000a81c78	2691af49-f553-469b-ba06-aa7000a81c4e	0-0	0-0	active	5.4		\N		2	1	0-0	5026344_12110943_46431222
a81b1295-99d5-49bd-82b1-aa7000a81c83	2691af49-f553-469b-ba06-aa7000a81c4e	1-1	1-1	active	6.8		\N		2	2	1-1	5026344_12110943_46431226
e84053cc-97a0-40f5-833c-aa7000a81c8f	2691af49-f553-469b-ba06-aa7000a81c4e	2-2	2-2	active	35		\N		2	3	2-2	5026344_12110943_46431231
19847cfd-8964-4b09-ab1d-aa7000a81c98	2691af49-f553-469b-ba06-aa7000a81c4e	0-1	0-1	active	5.8		\N		3	1	0-1	5026344_12110943_46431238
a23daf93-2667-4f56-81df-aa7000a81ca2	2691af49-f553-469b-ba06-aa7000a81c4e	0-2	0-2	active	12.5		\N		3	2	0-2	5026344_12110943_46431244
d434c64c-f198-4903-9b69-aa7000a81cab	2691af49-f553-469b-ba06-aa7000a81c4e	1-2	1-2	active	15.25		\N		3	3	1-2	5026344_12110943_46431249
45052d47-b1f8-42af-9cce-aa7000a81cb5	2691af49-f553-469b-ba06-aa7000a81c4e	Any Other	M1	active	8.2		\N		4	1	Any Other	5026344_12110943_46431257
26e5dd55-7a7b-474e-b9b7-aa7000a81ccc	242af76a-2fc9-49e9-8d94-aa7000a81cbf	Any Other	M1	active	14		\N		1	1	Any Other	5026344_12110908_46431040
413365a3-43db-48c7-9b08-aa7000a81cd9	242af76a-2fc9-49e9-8d94-aa7000a81cbf	1-0	1-0	active	5.55		\N		1	2	1-0	5026344_12110908_46431044
13f7b042-c093-44b0-a91c-aa7000a81ce9	242af76a-2fc9-49e9-8d94-aa7000a81cbf	2-0	2-0	active	16		\N		1	3	2-0	5026344_12110908_46431048
4fd8447d-c57a-4d08-9e6b-aa7000a81d0d	242af76a-2fc9-49e9-8d94-aa7000a81cbf	2-1	2-1	active	22.5		\N		2	1	2-1	5026344_12110908_46431053
8155ff31-0535-43f9-9467-aa7000a81d1d	242af76a-2fc9-49e9-8d94-aa7000a81cbf	0-0	0-0	active	3.45		\N		2	2	0-0	5026344_12110908_46431059
51ad7bf8-f5f6-4a5d-b6b2-aa7000a81d28	242af76a-2fc9-49e9-8d94-aa7000a81cbf	1-1	1-1	active	7.75		\N		2	3	1-1	5026344_12110908_46431064
5586ea38-6fe2-4e22-8b2d-aa7000a81d32	242af76a-2fc9-49e9-8d94-aa7000a81cbf	2-2	2-2	active	60		\N		3	1	2-2	5026344_12110908_46431067
b1d84f2a-7fb6-439f-ae17-aa7000a81d3b	242af76a-2fc9-49e9-8d94-aa7000a81cbf	0-1	0-1	active	5.25		\N		3	2	0-1	5026344_12110908_46431070
55dbcf0d-9677-4c48-8d78-aa7000a81d45	242af76a-2fc9-49e9-8d94-aa7000a81cbf	0-2	0-2	active	14.5		\N		3	3	0-2	5026344_12110908_46431077
697740cc-efcc-4013-847c-aa7000a81d4e	242af76a-2fc9-49e9-8d94-aa7000a81cbf	1-2	1-2	active	21		\N		4	1	1-2	5026344_12110908_46431082
015921c8-a1c2-487c-b937-aa7000a81d61	ea5c99c2-c664-4db3-aadb-aa7000a81d57	Ifk Hassleholm/Ifk Hassleholm	A/A	active	4.95		\N		1	1	Ifk Hassleholm/Ifk Hassleholm	5026344_12110238_46429283
07071d86-e5f3-42ae-b69d-aa7000a81d6a	ea5c99c2-c664-4db3-aadb-aa7000a81d57	Ifk Hassleholm/Draw	A/X	active	17.5		\N		1	2	Ifk Hassleholm/Draw	5026344_12110238_46429296
044e1753-7893-4128-9dad-aa7000a81d73	ea5c99c2-c664-4db3-aadb-aa7000a81d57	Ifk Hassleholm/Носаби ИФ	A/B	active	30		\N		1	3	Ifk Hassleholm/Носаби ИФ	5026344_12110238_46429300
dc0d4bf0-2d09-461a-afa5-aa7000a81d7c	ea5c99c2-c664-4db3-aadb-aa7000a81d57	Draw/Ifk Hassleholm	X/A	active	7.75		\N		2	1	Draw/Ifk Hassleholm	5026344_12110238_46429290
b452f04e-7037-43db-a63d-aa7000a81d85	ea5c99c2-c664-4db3-aadb-aa7000a81d57	Draw/Draw	X/X	active	7.6		\N		2	2	Draw/Draw	5026344_12110238_46429297
09253772-130b-4319-9578-aa7000a81d8e	ea5c99c2-c664-4db3-aadb-aa7000a81d57	Draw/Носаби ИФ	X/B	active	7.2		\N		2	3	Draw/Носаби ИФ	5026344_12110238_46429302
28c6bf92-477e-413f-b552-aa7000a81d98	ea5c99c2-c664-4db3-aadb-aa7000a81d57	Носаби ИФ/Ifk Hassleholm	B/A	active	35		\N		3	1	Носаби ИФ/Ifk Hassleholm	5026344_12110238_46429292
13347822-2885-41c3-8856-aa7000a81da3	ea5c99c2-c664-4db3-aadb-aa7000a81d57	Носаби ИФ/Draw	B/X	active	17.5		\N		3	2	Носаби ИФ/Draw	5026344_12110238_46429298
bd51a931-fb02-484d-9c0b-aa7000a81dae	ea5c99c2-c664-4db3-aadb-aa7000a81d57	Носаби ИФ/Носаби ИФ	B/B	active	4.45		\N		3	3	Носаби ИФ/Носаби ИФ	5026344_12110238_46429305
eb9e5d62-c6c3-4429-9b93-aa7000a81dd3	2fa2f3d8-35cd-4368-b923-aa7000a81dc6	Ifk Hassleholm	A	active	3.1		\N		1	1	Ifk Hassleholm	5026344_12111730_46436342
3a3d5582-1a67-464d-a83f-aa7000a81de3	2fa2f3d8-35cd-4368-b923-aa7000a81dc6	Draw	X	active	2.29		\N		1	2	Draw	5026344_12111730_46436343
fdf91003-06f2-4aee-b62f-aa7000a81dee	2fa2f3d8-35cd-4368-b923-aa7000a81dc6	Носаби ИФ	B	active	2.9		\N		1	3	Носаби ИФ	5026344_12111730_46436347
5c47741d-433a-4e54-838d-aa7000a81e03	7996264e-c74c-41d1-b3ca-aa7000a81df9	Ifk Hassleholm or Draw	AX	active	1.3		\N		1	1	Ifk Hassleholm or Draw	5026344_12110883_46430929
a524177f-1f86-43d8-8788-aa7000a81e0d	7996264e-c74c-41d1-b3ca-aa7000a81df9	Ifk Hassleholm or Носаби ИФ	AB	active	1.45		\N		1	2	Ifk Hassleholm or Носаби ИФ	5026344_12110883_46430934
75d8864d-4fad-46be-a61e-aa7000a81e16	7996264e-c74c-41d1-b3ca-aa7000a81df9	Draw or Носаби ИФ	BX	active	1.27		\N		1	3	Draw or Носаби ИФ	5026344_12110883_46430939
3062b37b-fc4d-471b-8882-aa7000a81e29	29229fb1-a26a-422a-80a1-aa7000a81e1f	Ifk Hassleholm	A	active	2.8		\N		1	1	Ifk Hassleholm	5026344_12111446_46433787
2c7f22e6-43bb-4756-a2e9-aa7000a81e3c	29229fb1-a26a-422a-80a1-aa7000a81e1f	Draw	X	active	2.75		\N		1	2	Draw	5026344_12111446_46433792
10a646fd-7c1e-4c76-ab6a-aa7000a81e59	29229fb1-a26a-422a-80a1-aa7000a81e1f	Носаби ИФ	B	active	2.63		\N		1	3	Носаби ИФ	5026344_12111446_46433796
0244e6a5-9bf0-4db0-b49c-aa7000a81e8b	e3dd6670-b374-4c3e-99c7-aa7000a81e81	Ifk Hassleholm or Draw	AX	active	1.35		\N		1	1	Ifk Hassleholm or Draw	5026344_12111420_46433663
8e474742-362e-4924-871b-aa7000a81e95	e3dd6670-b374-4c3e-99c7-aa7000a81e81	Ifk Hassleholm or Носаби ИФ	AB	active	1.33		\N		1	2	Ifk Hassleholm or Носаби ИФ	5026344_12111420_46433669
390a88f9-9e84-4aff-8ea6-aa7000a81ea0	e3dd6670-b374-4c3e-99c7-aa7000a81e81	Draw or Носаби ИФ	BX	active	1.31		\N		1	3	Draw or Носаби ИФ	5026344_12111420_46433673
5407a66a-fb45-4331-8788-aa7000a81eb5	418e7e95-4375-4a70-aa37-aa7000a81eaa	Ifk Hassleholm	A	active	1.55		\N		1	1	Ifk Hassleholm	5026344_12111165_46432284
0bb4b258-477f-49d4-8482-aa7000a81ebf	418e7e95-4375-4a70-aa37-aa7000a81eaa	Draw	X	active	2.19		\N		1	2	Draw	5026344_12111165_46432290
1064ef1e-4c7a-4f83-863c-aa7000a81ed9	b8da9b76-6063-4fe1-9a3a-aa7000a81ecd	Draw	X	active	2.3		\N		1	1	Draw	5026344_12111062_46431829
f99cb51d-9548-44ae-b665-aa7000a81ee3	b8da9b76-6063-4fe1-9a3a-aa7000a81ecd	Носаби ИФ	B	active	1.5		\N		1	2	Носаби ИФ	5026344_12111062_46431832
7eee4fc3-cf91-4005-940f-aa7000a81ef9	e350b3cd-ea9d-4d52-b603-aa7000a81eee	Under 0.5	Under	active	2.09		\N		1	1	Under 0.5	5026344_12110350_46429634
22ab5975-4ffd-4406-9f24-aa7000a81f04	e350b3cd-ea9d-4d52-b603-aa7000a81eee	Over 0.5	Over	active	1.61		\N		1	2	Over 0.5	5026344_12110350_46429629
50c346f0-94f5-4c3e-9477-aa7000a81f17	6bf37ba8-e058-4fbc-9009-aa7000a81f0d	Under 0.5	Under	active	2.18		\N		1	1	Under 0.5	5026344_12110381_46429724
e05e375d-18b2-4905-8052-aa7000a81f20	6bf37ba8-e058-4fbc-9009-aa7000a81f0d	Over 0.5	Over	active	1.56		\N		1	2	Over 0.5	5026344_12110381_46429718
484c12f0-66a3-4616-b61b-aa7000a81f3c	39d86ebd-b898-49b0-8767-aa7000a81f29	IFK Hassleholm	A	active	2.1		\N		1	1	IFK Hassleholm	5026344_12095468_46380277
180b291a-b54e-4cfb-8575-aa7000a81f49	39d86ebd-b898-49b0-8767-aa7000a81f29	Носаби ИФ	B	active	1.91		\N		1	2	Носаби ИФ	5026344_12095468_46380278
b3e493c6-a055-4c87-a20a-aa7000a81f6d	1d23938b-961b-4725-8de0-aa7000a81f63	Yes	Yes	active	3.7		\N		1	1	Yes	5026344_12111717_46436287
e81a9dfc-a45f-4902-9ca3-aa7000a81f76	1d23938b-961b-4725-8de0-aa7000a81f63	No	No	active	1.21		\N		1	2	No	5026344_12111717_46436291
fe19b108-5f19-4b66-b827-aa7000a81fa1	189ae426-c1ca-440c-96fe-aa7000a81f8d	Yes	Yes	active	3.9		\N		1	1	Yes	5026344_12111712_46436266
63207771-f241-46ae-b382-aa7000a81fb9	189ae426-c1ca-440c-96fe-aa7000a81f8d	No	No	active	1.19		\N		1	2	No	5026344_12111712_46436269
e0d9179c-dc88-4b14-82eb-aa7000a81fd6	1f095e4e-ab18-4f08-8f5b-aa7000a81fc9	Yes	Yes	active	4.25		\N		1	1	Yes	5026344_12111195_46432407
96fd6840-839a-498a-b957-aa7000a81fef	1f095e4e-ab18-4f08-8f5b-aa7000a81fc9	No	No	active	1.16		\N		1	2	No	5026344_12111195_46432413
fb3236ed-0886-4e82-946b-aa7000a82005	b8cb1eb9-f950-4a0c-ac24-aa7000a81ffa	Yes	Yes	active	4.8		\N		1	1	Yes	5026344_12111177_46432370
755bef8d-b2e0-4661-8057-aa7000a8200e	b8cb1eb9-f950-4a0c-ac24-aa7000a81ffa	No	No	active	1.12		\N		1	2	No	5026344_12111177_46432374
ca7d160d-287f-4f36-83c9-aa7000a8202a	7aecdc29-93a1-4c2b-97be-aa7000a82018	Yes	Yes	active	3.35		\N		1	1	Yes	5026344_12111041_46431726
8e98d3d8-e2da-4e51-925c-aa7000a82034	7aecdc29-93a1-4c2b-97be-aa7000a82018	No	No	active	1.25		\N		1	2	No	5026344_12111041_46431730
5ccf2138-9bc7-48b5-8384-aa7000a8204a	d9c76bc9-a187-4686-aa8c-aa7000a8203f	Under 2.5	Under	active	1.13		\N		1	1	Under 2.5	5026344_12110771_46430653
91085f98-e897-490f-982f-aa7000a82054	d9c76bc9-a187-4686-aa8c-aa7000a8203f	Over 2.5	Over	active	4.6		\N		1	2	Over 2.5	5026344_12110771_46430647
8b45ab77-5c7f-49e3-a759-aa7000a82068	35d1995e-14ff-4b40-9eb5-aa7000a8205e	Under 1.5	Under	active	1.53		\N		1	1	Under 1.5	5026344_12110758_46430619
b33f8dcc-8e80-4892-b352-aa7000a82072	35d1995e-14ff-4b40-9eb5-aa7000a8205e	Over 1.5	Over	active	2.24		\N		1	2	Over 1.5	5026344_12110758_46430616
4092ada6-0b3b-4be4-aaec-aa7000a8208d	701c8310-8296-4bf8-9a76-aa7000a82081	Under 0.5	Under	active	3.1		\N		1	1	Under 0.5	5026344_12110744_46430590
5145d0c3-6cf5-48ab-8fa1-aa7000a82099	701c8310-8296-4bf8-9a76-aa7000a82081	Over 0.5	Over	active	1.28		\N		1	2	Over 0.5	5026344_12110744_46430584
703b4854-4998-41fe-99be-aa7000a820ae	9642d8ad-487e-4c07-8385-aa7000a820a4	Yes	Yes	active	2.57		\N		1	1	Yes	5026344_12111149_46432239
285c1fe9-ee35-4a97-a421-aa7000a820b8	9642d8ad-487e-4c07-8385-aa7000a820a4	No	No	active	1.41		\N		1	2	No	5026344_12111149_46432247
d1e5a21c-2041-49ee-adc7-aa7000a820d4	94ad081d-a04c-48c8-890f-aa7000a820ca	Under 2.5	Under	active	1.26		\N		1	1	Under 2.5	5026344_12110815_46430744
63d67dd0-e1d0-4e25-8fd3-aa7000a820de	94ad081d-a04c-48c8-890f-aa7000a820ca	Over 2.5	Over	active	3.3		\N		1	2	Over 2.5	5026344_12110815_46430741
baeca2d2-19f2-4109-b4eb-aa7000a820f1	a4319102-daf5-4905-a672-aa7000a820e7	Under 1.5	Under	active	1.89		\N		1	1	Under 1.5	5026344_12110800_46430712
737ae035-42dc-4e60-8d88-aa7000a82102	a4319102-daf5-4905-a672-aa7000a820e7	Over 1.5	Over	active	1.75		\N		1	2	Over 1.5	5026344_12110800_46430710
588753be-bf12-4209-86e4-aa7000a82124	ff628114-e78c-462d-a9a4-aa7000a8210e	Under 0.5	Under	active	4.4		\N		1	1	Under 0.5	5026344_12110787_46430682
91850ab2-ac29-48e2-8f9c-aa7000a82138	ff628114-e78c-462d-a9a4-aa7000a8210e	Over 0.5	Over	active	1.15		\N		1	2	Over 0.5	5026344_12110787_46430678
b593931f-1fae-4ff3-96d0-aa7000a82155	5e3f1524-be16-4dcc-88fe-aa7000a8214b	0	0	active	19		\N		1	1	0	5026344_12111388_46433552
f91fed93-ae17-4e0d-b762-aa7000a8215f	5e3f1524-be16-4dcc-88fe-aa7000a8214b	1	1	active	6.5		\N		1	2	1	5026344_12111388_46433559
0b010f78-70d9-41a1-abfc-aa7000a82169	5e3f1524-be16-4dcc-88fe-aa7000a8214b	2	2	active	4.2		\N		1	3	2	5026344_12111388_46433564
2dbb9d10-f14e-4a19-a329-aa7000a82175	5e3f1524-be16-4dcc-88fe-aa7000a8214b	3	3	active	4.15		\N		2	1	3	5026344_12111388_46433570
ba5e7318-1331-4f4e-81e4-aa7000a8217e	5e3f1524-be16-4dcc-88fe-aa7000a8214b	4	4	active	5.25		\N		2	2	4	5026344_12111388_46433577
858b5822-69f2-4851-b044-aa7000a82189	5e3f1524-be16-4dcc-88fe-aa7000a8214b	5	5	active	8.45		\N		2	3	5	5026344_12111388_46433582
31b3e255-c4db-4a86-b6e3-aa7000a82192	5e3f1524-be16-4dcc-88fe-aa7000a8214b	6+	6+	active	9.55		\N		3	1	6+	5026344_12111388_46433588
c2e5cb70-20fb-4b03-99da-aa7000a821a8	5b0ce817-8360-4e0b-9fa0-aa7000a8219d	0	0	active	3.35		\N		1	1	0	5026344_12110277_46429431
a99072c0-7e85-4102-8279-aa7000a821b2	5b0ce817-8360-4e0b-9fa0-aa7000a8219d	1	1	active	2.7		\N		1	2	1	5026344_12110277_46429434
7c0f63eb-5c97-46a8-ab6c-aa7000a821bd	5b0ce817-8360-4e0b-9fa0-aa7000a8219d	2+	2+	active	2.32		\N		1	3	2+	5026344_12110277_46429436
b09dc645-0d4b-4c6f-a95c-aa7000a821d4	cf5975a4-4cca-45a6-bb38-aa7000a821ca	0	0	active	5.15		\N		1	1	0	5026344_12110298_46429478
9afd4266-50d2-4625-98db-aa7000a821de	cf5975a4-4cca-45a6-bb38-aa7000a821ca	1	1	active	2.9		\N		1	2	1	5026344_12110298_46429482
ed84dadd-1eaa-44ad-9279-aa7000a821e9	cf5975a4-4cca-45a6-bb38-aa7000a821ca	2+	2+	active	1.78		\N		1	3	2+	5026344_12110298_46429485
67491649-ff53-44ce-9e18-aa7000a82212	8854278e-fc59-424c-b7fe-aa7000a821f5	Odd	Odd	active	1.84		\N		1	1	Odd	5026344_12110253_46429330
639c549f-5a85-4b42-a92e-aa7000a8221f	8854278e-fc59-424c-b7fe-aa7000a821f5	Even	Even	active	1.8		\N		1	2	Even	5026344_12110253_46429331
f5f89681-cfba-4b78-9896-aa7000a82234	62f8c060-4318-41e4-9f3b-aa7000a8222a	Odd	Odd	active	1.97		\N		1	1	Odd	5026344_12111640_46435792
4f6a00a3-4493-436f-8d55-aa7000a82241	62f8c060-4318-41e4-9f3b-aa7000a8222a	Even	Even	active	1.69		\N		1	2	Even	5026344_12111640_46435798
ec1943ec-2f6b-4c7e-a806-aa7000a82256	2ed67447-f050-49dc-9a9a-aa7000a8224a	Odd	Odd	active	1.86		\N		1	1	Odd	5026344_12111356_46433440
828ea382-5239-47aa-8bc8-aa7000a82264	2ed67447-f050-49dc-9a9a-aa7000a8224a	Even	Even	active	1.78		\N		1	2	Even	5026344_12111356_46433448
e7d3ee61-c37b-475c-b3f6-aa7000a822aa	7f754238-fe8f-4d64-ab38-aa7000a82289	Yes	Yes	active	3.1		\N		1	1	Yes	5026344_12110446_46429863
b9cfc3c6-1d50-4d5d-b619-aa7000a822b7	7f754238-fe8f-4d64-ab38-aa7000a82289	No	No	active	1.29		\N		1	2	No	5026344_12110446_46429867
2e02d941-183c-435e-b80a-aa7000a822ce	d70287d0-981e-4905-9e5a-aa7000a822c4	Yes	Yes	active	2.9		\N		1	1	Yes	5026344_12110828_46430773
6ee0b741-f59c-4001-a1cb-aa7000a822d9	d70287d0-981e-4905-9e5a-aa7000a822c4	No	No	active	1.32		\N		1	2	No	5026344_12110828_46430775
19cdfa9c-5214-4e57-a763-aa7000a822ed	ebdebe8f-dd95-451e-933d-aa7000a822e4	Under 1.5	Under	active	1.65		\N		1	1	Under 1.5	5026344_12110362_46429659
c227412e-9976-45ca-b410-aa7000a822f8	ebdebe8f-dd95-451e-933d-aa7000a822e4	Over 1.5	Over	active	2.02		\N		1	2	Over 1.5	5026344_12110362_46429657
931e8754-a054-449f-b93d-aa7000a82307	ec3fee5a-4e07-416c-8783-aa7000a822ff	Under 1.5	Under	active	1.73		\N		1	1	Under 1.5	5026344_12110340_46429608
eeffe7fd-bd1e-4e65-9ea9-aa7000a8230f	ec3fee5a-4e07-416c-8783-aa7000a822ff	Over 1.5	Over	active	1.92		\N		1	2	Over 1.5	5026344_12110340_46429604
5c44d708-905e-47b8-8b08-aa7000a82321	49cf0b80-81ce-4028-9e9e-aa7000a82318	0	0	active	4.4		\N		1	1	0	5026344_12110268_46429390
3c61a38d-9085-4936-9bee-aa7000a8232c	49cf0b80-81ce-4028-9e9e-aa7000a82318	1	1	active	2.85		\N		1	2	1	5026344_12110268_46429394
ea62f5ff-c57d-4ebe-876c-aa7000a82336	49cf0b80-81ce-4028-9e9e-aa7000a82318	2	2	active	3.55		\N		1	3	2	5026344_12110268_46429399
7920e1fd-d63a-44c2-bc31-aa7000a82341	49cf0b80-81ce-4028-9e9e-aa7000a82318	3+	3+	active	4.25		\N		2	1	3+	5026344_12110268_46429405
aee91027-0368-4be1-b043-aa7000a82353	644b0ebb-67c0-44b0-aac5-aa7000a8234b	0	0	active	4.1		\N		1	1	0	5026344_12110259_46429354
78f4aa27-3c54-4319-8751-aa7000a8235b	644b0ebb-67c0-44b0-aac5-aa7000a8234b	1	1	active	2.75		\N		1	2	1	5026344_12110259_46429357
9c8bd6ef-b43d-441e-8433-aa7000a82366	644b0ebb-67c0-44b0-aac5-aa7000a8234b	2	2	active	3.6		\N		1	3	2	5026344_12110259_46429362
ecc64fcb-47be-4d61-a07f-aa7000a82375	644b0ebb-67c0-44b0-aac5-aa7000a8234b	3+	3+	active	4.65		\N		2	1	3+	5026344_12110259_46429366
aca6dcdf-0aec-4910-bc8a-aa7000a8238b	8e2d3713-6fdc-4885-9a7b-aa7000a82380	0-1	R_0-1	active	4.8		\N		1	1	0-1	5026344_12110867_46430886
006763c3-ef89-4d0f-afed-aa7000a82395	8e2d3713-6fdc-4885-9a7b-aa7000a82380	2-3	R_2-3	active	2.11		\N		1	2	2-3	5026344_12110867_46430892
9a94f69a-0c9b-4cde-a723-aa7000a8239f	8e2d3713-6fdc-4885-9a7b-aa7000a82380	4-5	R_4-5	active	3.25		\N		1	3	4-5	5026344_12110867_46430896
90192a6a-32a6-46dd-8e84-aa7000a823a9	8e2d3713-6fdc-4885-9a7b-aa7000a82380	6+	6+	active	9.25		\N		2	1	6+	5026344_12110867_46430880
93a4f14e-3b65-4030-a9eb-aa7000a823ca	c6f1fcae-7d30-4212-9901-aa7000a823b7	1st Half	H1	active	3.05		\N		1	1	1st Half	5026344_12111051_46431776
47eb6704-934e-4432-9ba7-aa7000a823e2	c6f1fcae-7d30-4212-9901-aa7000a823b7	2nd	H2	active	1.96		\N		1	2	2nd	5026344_12111051_46431783
1d804a37-f13b-488b-b81b-aa7000a823fb	c6f1fcae-7d30-4212-9901-aa7000a823b7	Equal	Equal	active	3.8		\N		1	3	Equal	5026344_12111051_46431791
d7a8de84-70a5-4fc4-8778-aa7000a82417	e2a5a10d-8a01-47cf-aef8-aa7000a8240d	Ifk Hassleholm +1	AH	active	1.39		\N		1	1	Ifk Hassleholm +1	5026344_12110325_46429566
5887b188-1819-4415-b30e-aa7000a82422	e2a5a10d-8a01-47cf-aef8-aa7000a8240d	Draw sigendLine	XH	active	3.9		\N		1	2	Draw sigendLine	5026344_12110325_46429570
288fc45a-8f45-4855-9795-aa7000a8242e	e2a5a10d-8a01-47cf-aef8-aa7000a8240d	Носаби ИФ -1	BH	active	8		\N		1	3	Носаби ИФ -1	5026344_12110325_46429573
dbcb2214-0c05-49b2-a76e-aa7000a82443	a79ef1df-7a9e-49d3-8b40-aa7000a82439	Yes	Yes	active	6.7		\N		1	1	Yes	5026344_12110417_46429807
af3ced6a-0530-4c74-9dde-aa7000a8244c	a79ef1df-7a9e-49d3-8b40-aa7000a82439	No	No	active	1.05		\N		1	2	No	5026344_12110417_46429809
cac843ab-c458-4cef-b0e9-aa7000a82461	d785fdb4-89d9-4781-80c8-aa7000a82455	Yes	Yes	active	3.85		\N		1	1	Yes	5026344_12110840_46430799
c6ba0a63-4ea6-41d6-8f8d-aa7000a8246a	d785fdb4-89d9-4781-80c8-aa7000a82455	No	No	active	1.19		\N		1	2	No	5026344_12110840_46430806
54bdc9e2-b11b-4f0e-bcb7-aa7000a8247a	21280eb5-ad53-4ee1-869d-aa7000a82471	Yes	Yes	active	2.95		\N		1	1	Yes	5026344_12110851_46430833
04155e0b-6ffe-480b-83a0-aa7000a82484	21280eb5-ad53-4ee1-869d-aa7000a82471	No	No	active	1.32		\N		1	2	No	5026344_12110851_46430838
2cd9ffcf-8a28-47a8-975f-aa7000a82497	3f991c02-6e95-401d-9538-aa7000a8248e	Ifk Hassleholm and Under 4.5	AUnder	active	3.35		\N		1	1	Ifk Hassleholm and Under 4.5	5026344_12111078_46431903
52757c47-d760-4105-b8db-aa7000a824a1	3f991c02-6e95-401d-9538-aa7000a8248e	Draw and Under 4.5	XUnder	active	4.05		\N		1	2	Draw and Under 4.5	5026344_12111078_46431906
719c8d68-7fd7-460e-a140-aa7000a824ab	3f991c02-6e95-401d-9538-aa7000a8248e	Носаби ИФ and Under 4.5	BUnder	active	3.05		\N		1	3	Носаби ИФ and Under 4.5	5026344_12111078_46431912
a6daf6b6-e988-427f-8d8e-aa7000a824b4	3f991c02-6e95-401d-9538-aa7000a8248e	Ifk Hassleholm and Over 4.5	AOver	active	10.5		\N		2	1	Ifk Hassleholm and Over 4.5	5026344_12111078_46431918
be64ee71-6ba1-425e-a3ed-aa7000a824be	3f991c02-6e95-401d-9538-aa7000a8248e	Draw and Over 4.5	XOver	active	40		\N		2	2	Draw and Over 4.5	5026344_12111078_46431922
140d622e-f988-4cdd-b056-aa7000a824c8	3f991c02-6e95-401d-9538-aa7000a8248e	Носаби ИФ and Over 4.5	BOver	active	9.35		\N		2	3	Носаби ИФ and Over 4.5	5026344_12111078_46431927
44f057ce-cd04-4db3-8763-aa7000a824dd	cccc9c48-3779-4180-9130-aa7000a824d3	Ifk Hassleholm and Under 1.5	AUnder	active	13		\N		1	1	Ifk Hassleholm and Under 1.5	5026344_12111097_46431988
17d13eb9-ece9-4d63-a8a0-aa7000a824e9	cccc9c48-3779-4180-9130-aa7000a824d3	Draw and Under 1.5	XUnder	active	18.75		\N		1	2	Draw and Under 1.5	5026344_12111097_46431993
6c08777a-63b4-44fa-9ce2-aa7000a824f3	cccc9c48-3779-4180-9130-aa7000a824d3	Носаби ИФ and Under 1.5	BUnder	active	12.25		\N		1	3	Носаби ИФ and Under 1.5	5026344_12111097_46431999
bdb6674b-f06d-4a74-ab09-aa7000a824fe	cccc9c48-3779-4180-9130-aa7000a824d3	Ifk Hassleholm and Over 1.5	AOver	active	3.15		\N		2	1	Ifk Hassleholm and Over 1.5	5026344_12111097_46432000
0a4d82dc-b991-4ab0-9a82-aa7000a82509	cccc9c48-3779-4180-9130-aa7000a824d3	Draw and Over 1.5	XOver	active	4.55		\N		2	2	Draw and Over 1.5	5026344_12111097_46432005
2b1e1a08-76a9-48d3-b2ea-aa7000a82514	cccc9c48-3779-4180-9130-aa7000a824d3	Носаби ИФ and Over 1.5	BOver	active	2.85		\N		2	3	Носаби ИФ and Over 1.5	5026344_12111097_46432012
525fb3b2-a762-4f03-85d5-aa7000a82530	0bc4f1b7-d2cf-4dd9-bc0e-aa7000a82521	Ifk Hassleholm and Under 3.5	AUnder	active	4.05		\N		1	1	Ifk Hassleholm and Under 3.5	5026344_12111133_46432157
bd3565b5-56be-49b3-aa6a-aa7000a82543	0bc4f1b7-d2cf-4dd9-bc0e-aa7000a82521	Draw and Under 3.5	XUnder	active	5.75		\N		1	2	Draw and Under 3.5	5026344_12111133_46432164
777b9e5c-dcbf-4ee8-a3eb-aa7000a82558	0bc4f1b7-d2cf-4dd9-bc0e-aa7000a82521	Носаби ИФ and Under 3.5	BUnder	active	3.8		\N		1	3	Носаби ИФ and Under 3.5	5026344_12111133_46432171
0cc8bb29-ceb0-410a-a0aa-aa7000a82564	0bc4f1b7-d2cf-4dd9-bc0e-aa7000a82521	Ifk Hassleholm and Over 3.5	AOver	active	6.7		\N		2	1	Ifk Hassleholm and Over 3.5	5026344_12111133_46432178
6913f1ec-2994-406d-896d-aa7000a82575	0bc4f1b7-d2cf-4dd9-bc0e-aa7000a82521	Draw and Over 3.5	XOver	active	10.25		\N		2	2	Draw and Over 3.5	5026344_12111133_46432185
18944788-eadb-4cff-851b-aa7000a82580	0bc4f1b7-d2cf-4dd9-bc0e-aa7000a82521	Носаби ИФ and Over 3.5	BOver	active	5.95		\N		2	3	Носаби ИФ and Over 3.5	5026344_12111133_46432192
7a0866c3-471e-4fb2-89b8-aa7000a82594	4da53022-3cc8-4568-add6-aa7000a8258a	Ifk Hassleholm and Under 2.5	AUnder	active	7.6		\N		1	1	Ifk Hassleholm and Under 2.5	5026344_12111115_46432070
1969f0ac-dbef-4ebe-8617-aa7000a8259d	4da53022-3cc8-4568-add6-aa7000a8258a	Draw and Under 2.5	XUnder	active	5.75		\N		1	2	Draw and Under 2.5	5026344_12111115_46432078
b46561bd-a51f-4973-9dd8-aa7000a825a6	4da53022-3cc8-4568-add6-aa7000a8258a	Носаби ИФ and Under 2.5	BUnder	active	7.05		\N		1	3	Носаби ИФ and Under 2.5	5026344_12111115_46432081
7b3f6a0a-eb51-407f-a61b-aa7000a825b1	4da53022-3cc8-4568-add6-aa7000a8258a	Ifk Hassleholm and Over 2.5	AOver	active	3.8		\N		2	1	Ifk Hassleholm and Over 2.5	5026344_12111115_46432088
c49ce5b2-616f-4d95-809f-aa7000a825bb	4da53022-3cc8-4568-add6-aa7000a8258a	Draw and Over 2.5	XOver	active	10.25		\N		2	2	Draw and Over 2.5	5026344_12111115_46432098
29d2c742-ae2e-48b2-8f56-aa7000a825c6	4da53022-3cc8-4568-add6-aa7000a8258a	Носаби ИФ and Over 2.5	BOver	active	3.45		\N		2	3	Носаби ИФ and Over 2.5	5026344_12111115_46432103
9c38de3a-67b9-4dd1-a407-aa7000a825dc	49d01b92-c277-48d8-884b-aa7000a825d0	Yes	Yes	active	1.76		\N		1	1	Yes	5026344_12110433_46429836
050e875e-0521-43a8-ba32-aa7000a825e6	49d01b92-c277-48d8-884b-aa7000a825d0	No	No	active	1.88		\N		1	2	No	5026344_12110433_46429840
91b89d25-5a2d-47b5-9d60-aa7000a825fb	d803cfb6-cc48-4885-9110-aa7000a825f1	1st Half	H1	active	3.4		\N		1	1	1st Half	5026344_12111234_46432652
3f625f47-8c0b-4bae-8606-aa7000a82608	d803cfb6-cc48-4885-9110-aa7000a825f1	2nd	H2	active	2.44		\N		1	2	2nd	5026344_12111234_46432659
c6761bcd-6137-4c6a-8a15-aa7000a82613	d803cfb6-cc48-4885-9110-aa7000a825f1	Equal	Equal	active	2.52		\N		1	3	Equal	5026344_12111234_46432663
0da5f571-719f-49ec-af7c-aa7000a82629	31dee395-67c3-4b84-a865-aa7000a8261e	Ifk Hassleholm/Draw and No	AXNo	active	2.2		\N		1	1	Ifk Hassleholm/Draw and No	5026344_12111486_46434109
c0c68aaf-8465-4c80-a6d4-aa7000a82633	31dee395-67c3-4b84-a865-aa7000a8261e	Ifk Hassleholm/Носаби ИФ and Yes	ABYes	active	3.4		\N		1	2	Ifk Hassleholm/Носаби ИФ and Yes	5026344_12111486_46434115
83c072f5-c3f8-4489-82ba-aa7000a8263e	31dee395-67c3-4b84-a865-aa7000a8261e	Draw/Носаби ИФ and Yes	BXYes	active	3.65		\N		1	3	Draw/Носаби ИФ and Yes	5026344_12111486_46434131
becc6fe9-d7c7-4b24-9f1c-aa7000a8264b	31dee395-67c3-4b84-a865-aa7000a8261e	Ifk Hassleholm/Носаби ИФ and No	ABNo	active	1.74		\N		2	2	Ifk Hassleholm/Носаби ИФ and No	5026344_12111486_46434122
d26d8d36-ad8c-4f02-a2f6-aa7000a82657	31dee395-67c3-4b84-a865-aa7000a8261e	Draw/Носаби ИФ and No	BXNo	active	2.09		\N		2	3	Draw/Носаби ИФ and No	5026344_12111486_46434141
7134213f-b7ea-4c67-a979-aa7000a8266e	2cb01cb2-5587-45b9-a7cf-aa7000a82662	Ifk Hassleholm/Yes	AYes	active	14.75		\N		1	1	Ifk Hassleholm/Yes	5026344_12111457_46433850
a9dd94fa-f82c-4c32-a209-aa7000a8267e	2cb01cb2-5587-45b9-a7cf-aa7000a82662	Draw/Yes	XYes	active	6.75		\N		1	2	Draw/Yes	5026344_12111457_46433860
4f9614c9-b2af-4976-868c-aa7000a8268b	2cb01cb2-5587-45b9-a7cf-aa7000a82662	Носаби ИФ/Yes	BYes	active	13.75		\N		1	3	Носаби ИФ/Yes	5026344_12111457_46433871
549f8d47-adfd-49b7-99bf-aa7000a82699	2cb01cb2-5587-45b9-a7cf-aa7000a82662	Ifk Hassleholm/No	ANo	active	3.95		\N		2	1	Ifk Hassleholm/No	5026344_12111457_46433855
2db6d569-ac84-4cf5-a170-aa7000a826b1	2cb01cb2-5587-45b9-a7cf-aa7000a82662	Draw/No	XNo	active	3.5		\N		2	2	Draw/No	5026344_12111457_46433867
55d12bbe-df62-4098-8fec-aa7000a826cb	2cb01cb2-5587-45b9-a7cf-aa7000a82662	Носаби ИФ/No	BNo	active	3.7		\N		2	3	Носаби ИФ/No	5026344_12111457_46433880
e0ea04cd-c8c5-4af0-bf69-aa7000a826e2	a6499c8e-7f2f-4747-bf4d-aa7000a826d8	Yes	Yes	active	1.66		\N		1	1	Yes	5026344_12110477_46429939
a1db190f-5ca0-4cfe-a27d-aa7000a826ec	a6499c8e-7f2f-4747-bf4d-aa7000a826d8	No	No	active	2.01		\N		1	2	No	5026344_12110477_46429944
f7a9c8f9-8da3-4d76-b61d-aa7000a82700	dd372b73-b3c5-4321-ba8f-aa7000a826f6	Ifk Hassleholm/Draw and Yes	AXYes	active	3.65		\N		1	1	Ifk Hassleholm/Draw and Yes	5026344_12111225_46432569
d0c9d552-a4e0-4aec-b1f6-aa7000a8270b	dd372b73-b3c5-4321-ba8f-aa7000a826f6	Ifk Hassleholm/Носаби ИФ and Yes	ABYes	active	5.6		\N		1	2	Ifk Hassleholm/Носаби ИФ and Yes	5026344_12111225_46432586
21ce82b6-7780-44e3-9311-aa7000a82718	dd372b73-b3c5-4321-ba8f-aa7000a826f6	Draw/Носаби ИФ and Yes	BXYes	active	3.6		\N		1	3	Draw/Носаби ИФ and Yes	5026344_12111225_46432604
6cede847-15c6-4702-9b74-aa7000a82723	dd372b73-b3c5-4321-ba8f-aa7000a826f6	Ifk Hassleholm/Draw and No	AXNo	active	1.63		\N		2	1	Ifk Hassleholm/Draw and No	5026344_12111225_46432578
09f80f4f-3484-4136-94e5-aa7000a8272d	dd372b73-b3c5-4321-ba8f-aa7000a826f6	Ifk Hassleholm/Носаби ИФ and No	ABNo	active	1.66		\N		2	2	Ifk Hassleholm/Носаби ИФ and No	5026344_12111225_46432593
b4abce4e-597a-45ed-8a41-aa7000a82739	dd372b73-b3c5-4321-ba8f-aa7000a826f6	Draw/Носаби ИФ and No	BXNo	active	1.59		\N		2	3	Draw/Носаби ИФ and No	5026344_12111225_46432610
ef4c591b-979d-4118-b75a-aa7000a8274f	1c9f968e-ae11-4def-a152-aa7000a82745	1st Half	H1	active	3.35		\N		1	1	1st Half	5026344_12111241_46432707
8c6373a9-1cde-4b29-b0ee-aa7000a8275a	1c9f968e-ae11-4def-a152-aa7000a82745	2nd	H2	active	2.39		\N		1	2	2nd	5026344_12111241_46432715
1e27b065-7ac5-4c3e-9e7c-aa7000a82766	1c9f968e-ae11-4def-a152-aa7000a82745	Equal	Equal	active	2.6		\N		1	3	Equal	5026344_12111241_46432722
9ae3ad26-b98f-489b-80d8-aa7000a8277b	f6133ee7-2a95-4371-bc5c-aa7000a82771	Ifk Hassleholm/Draw and Yes	AXYes	active	5		\N		1	1	Ifk Hassleholm/Draw and Yes	5026344_12111479_46434010
af01f810-35a3-4aca-a24e-aa7000a82788	f6133ee7-2a95-4371-bc5c-aa7000a82771	Ifk Hassleholm/Носаби ИФ and Yes	ABYes	active	4.4		\N		1	2	Ifk Hassleholm/Носаби ИФ and Yes	5026344_12111479_46434022
7fadb944-afee-4001-bde5-aa7000a82794	f6133ee7-2a95-4371-bc5c-aa7000a82771	Draw/Носаби ИФ and Yes	BXYes	active	4.8		\N		1	3	Draw/Носаби ИФ and Yes	5026344_12111479_46434034
19c05642-a4e3-4db6-8ea4-aa7000a827a0	f6133ee7-2a95-4371-bc5c-aa7000a82771	Ifk Hassleholm/Носаби ИФ and No	ABNo	active	1.56		\N		2	2	Ifk Hassleholm/Носаби ИФ and No	5026344_12111479_46434028
569ba52b-77b8-410a-8387-aa7000a827ac	f6133ee7-2a95-4371-bc5c-aa7000a82771	Draw/Носаби ИФ and No	BXNo	active	1.83		\N		2	3	Draw/Носаби ИФ and No	5026344_12111479_46434041
efb7d9f0-0bdc-480a-8936-aa7000a827c3	5dd54104-c1b4-4268-bc53-aa7000a827b8	Ifk Hassleholm	A	active	5.45		\N		1	1	Ifk Hassleholm	5026344_12111723_46436320
0cff9830-07c5-422f-b791-aa7000a827cf	5dd54104-c1b4-4268-bc53-aa7000a827b8	Both	Both	active	1.52		\N		1	2	Both	5026344_12111723_46436325
44a594f9-6057-41bf-8694-aa7000a827dd	5dd54104-c1b4-4268-bc53-aa7000a827b8	Носаби ИФ	B	active	4.95		\N		1	3	Носаби ИФ	5026344_12111723_46436323
2bf26313-acbc-4a29-8880-aa7000a827ea	5dd54104-c1b4-4268-bc53-aa7000a827b8	None	None	active	17.75		\N		2	1	None	5026344_12111723_46436316
ee098ef2-8b8e-49b6-83bd-aa7000a82806	6943b526-0e2c-4ea4-bd6a-aa7000a827f7	Ifk Hassleholm by exactly 1	A1	active	4.85		\N		1	1	Ifk Hassleholm by exactly 1	5026344_12111701_46436230
13a4b49b-eacd-4028-a957-aa7000a8281a	6943b526-0e2c-4ea4-bd6a-aa7000a827f7	Draw	X	active	3.75		\N		1	2	Draw	5026344_12111701_46436218
828efdea-3c88-467a-a8c0-aa7000a82828	6943b526-0e2c-4ea4-bd6a-aa7000a827f7	Носаби ИФ by exactly 1	B1	active	4.6		\N		1	3	Носаби ИФ by exactly 1	5026344_12111701_46436234
14e22183-2741-4d65-a8e4-aa7000a8283c	6943b526-0e2c-4ea4-bd6a-aa7000a827f7	Ifk Hassleholm by exactly 2	A2	active	8.5		\N		2	1	Ifk Hassleholm by exactly 2	5026344_12111701_46436227
23b57bf3-b161-41fa-80aa-aa7000a8284a	6943b526-0e2c-4ea4-bd6a-aa7000a827f7	Носаби ИФ by exactly 2	B2	active	7.65		\N		2	3	Носаби ИФ by exactly 2	5026344_12111701_46436237
f61b7ec4-49e3-49c8-827e-aa7000a8285a	6943b526-0e2c-4ea4-bd6a-aa7000a827f7	Ifk Hassleholm by greater than 2	A>2	active	13.5		\N		3	1	Ifk Hassleholm by greater than 2	5026344_12111701_46436222
e695d6e6-04e6-49a3-afa5-aa7000a82867	6943b526-0e2c-4ea4-bd6a-aa7000a827f7	Носаби ИФ by greater than 2	B>2	active	11.25		\N		3	3	Носаби ИФ by greater than 2	5026344_12111701_46436241
2025e734-3838-4eb6-b694-aa7000a8287f	aa9a599c-46ca-4a20-a0bc-aa7000a82873	Ifk Hassleholm/Yes	AYes	active	4.5		\N		1	1	Ifk Hassleholm/Yes	5026344_12111651_46435867
e293a7f2-99c5-4b87-9ffe-aa7000a8288b	aa9a599c-46ca-4a20-a0bc-aa7000a82873	Draw/Yes	XYes	active	4.6		\N		1	2	Draw/Yes	5026344_12111651_46435880
52de8ade-20a0-4d03-9985-aa7000a82896	aa9a599c-46ca-4a20-a0bc-aa7000a82873	Носаби ИФ/Yes	BYes	active	4.15		\N		1	3	Носаби ИФ/Yes	5026344_12111651_46435888
2a0c0a36-83d3-41e5-88e5-aa7000a828a3	aa9a599c-46ca-4a20-a0bc-aa7000a82873	Ifk Hassleholm/No	ANo	active	5.75		\N		2	1	Ifk Hassleholm/No	5026344_12111651_46435873
ec02c7d8-6b96-49b4-b577-aa7000a828ae	aa9a599c-46ca-4a20-a0bc-aa7000a82873	Draw/No	XNo	active	19		\N		2	2	Draw/No	5026344_12111651_46435883
55ecd6a3-b3c6-4147-84a4-aa7000a828ba	aa9a599c-46ca-4a20-a0bc-aa7000a82873	Носаби ИФ/No	BNo	active	5.2		\N		2	3	Носаби ИФ/No	5026344_12111651_46435896
173b5ed9-9eb1-4f90-914a-aa7000a828cf	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 2-0	0-0 2-0	active	50		\N		1	1	0-0 2-0	5026344_12111509_46434544
9de05864-29b7-4a90-b9aa-aa7000a828db	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 0-0	0-0 0-0	active	19.5		\N		1	2	0-0 0-0	5026344_12111509_46434468
5f06aa80-d057-4a53-824f-aa7000a828e6	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 0-1	0-0 0-1	active	21		\N		1	3	0-0 0-1	5026344_12111509_46434537
3105d92d-f25b-4b0d-97b7-aa7000a828f2	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 2-1	0-0 2-1	active	60		\N		2	1	0-0 2-1	5026344_12111509_46434461
2c983e06-2153-4c98-96d9-aa7000a828ff	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 1-1	0-0 1-1	active	25		\N		2	2	0-0 1-1	5026344_12111509_46434550
39ab876b-6e1d-4f32-bf0b-aa7000a8290a	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 3-0	0-0 3-0	active	150		\N		3	1	0-0 3-0	5026344_12111509_46434620
b9070aab-671e-49f1-b128-aa7000a82917	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 0-2	0-0 0-2	active	45		\N		2	3	0-0 0-2	5026344_12111509_46434573
2fc7f498-73aa-4404-a573-aa7000a82922	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-0 1-1	1-0 1-1	active	35		\N		3	2	1-0 1-1	5026344_12111509_46434733
07b0ed8a-e322-4707-8960-aa7000a8292d	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-0 1-0	1-0 1-0	active	35		\N		4	1	1-0 1-0	5026344_12111509_46434514
cb40fe8c-488f-400e-b0ac-aa7000a8293b	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 1-2	0-0 1-2	active	60		\N		3	3	0-0 1-2	5026344_12111509_46434673
ea1f697f-1f22-4261-bd1c-aa7000a82948	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-1 1-1	0-1 1-1	active	35		\N		4	2	0-1 1-1	5026344_12111509_46434666
5e9d0b94-65ba-4633-8a60-aa7000a82954	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-0 2-0	1-0 2-0	active	40		\N		5	1	1-0 2-0	5026344_12111509_46434478
ee2e39ba-0c47-462a-825f-aa7000a82962	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 0-3	0-0 0-3	active	150		\N		4	3	0-0 0-3	5026344_12111509_46434685
77fbe1cd-4a0c-42e1-b935-aa7000a8296e	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-1 1-1	1-1 1-1	active	40		\N		5	2	1-1 1-1	5026344_12111509_46434499
fa243c80-21ac-467a-8ceb-aa7000a8297a	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-1 0-1	0-1 0-1	active	35		\N		5	3	0-1 0-1	5026344_12111509_46434607
c613d07d-01fa-40a0-816a-aa7000a82986	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-0 2-1	1-0 2-1	active	40		\N		6	1	1-0 2-1	5026344_12111509_46434625
46ae823a-5a95-4d8f-aa7d-aa7000a82999	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-0 4plus	0-0 4plus	active	40		\N		6	2	0-0 4plus	5026344_12111509_46434720
6919e6c3-13aa-4ef4-955c-aa7000a829a8	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-1 0-2	0-1 0-2	active	35		\N		6	3	0-1 0-2	5026344_12111509_46434740
78ca5de0-e1a8-4d3a-b605-aa7000a829bb	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-0 1-2	1-0 1-2	active	80		\N		7	1	1-0 1-2	5026344_12111509_46434655
e2b90e58-3ffa-46f2-a5bd-aa7000a829c9	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-0 4plus	1-0 4plus	active	21		\N		7	2	1-0 4plus	5026344_12111509_46434661
109ac9d8-c084-4a4c-b7b7-aa7000a829d6	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-1 1-2	0-1 1-2	active	40		\N		7	3	0-1 1-2	5026344_12111509_46434640
1b831934-d2ab-4020-9d4f-aa7000a829e1	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-0 3-0	1-0 3-0	active	90		\N		8	1	1-0 3-0	5026344_12111509_46434526
95a6faf9-f793-43cf-87b4-aa7000a829ec	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-1 4plus	0-1 4plus	active	20		\N		8	2	0-1 4plus	5026344_12111509_46434601
1051b102-d809-4b00-bebd-aa7000a829f6	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-1 2-1	0-1 2-1	active	80		\N		8	3	0-1 2-1	5026344_12111509_46434715
d310efb7-b469-4795-a86f-aa7000a82a04	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-1 2-1	1-1 2-1	active	50		\N		9	1	1-1 2-1	5026344_12111509_46434708
b1ce2015-3af8-4924-8518-aa7000a82a11	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-1 4plus	1-1 4plus	active	15.5		\N		9	2	1-1 4plus	5026344_12111509_46434522
8e2f2352-1cc5-4954-a04a-aa7000a82a21	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-1 0-3	0-1 0-3	active	70		\N		9	3	0-1 0-3	5026344_12111509_46434576
05564413-0db3-4a8d-8895-aa7000a82a30	22f5756e-2797-45b8-b3ea-aa7000a828c4	2-0 2-0	2-0 2-0	active	100		\N		10	1	2-0 2-0	5026344_12111509_46434582
474eeeec-3298-400a-95ea-aa7000a82a3f	22f5756e-2797-45b8-b3ea-aa7000a828c4	2-0 4plus	2-0 4plus	active	30		\N		10	2	2-0 4plus	5026344_12111509_46434506
fdb44bb3-2e54-4db9-8f91-aa7000a82a4b	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-1 1-2	1-1 1-2	active	50		\N		10	3	1-1 1-2	5026344_12111509_46434678
64fabcf9-c4ad-4e13-9b48-aa7000a82a58	22f5756e-2797-45b8-b3ea-aa7000a828c4	2-0 2-1	2-0 2-1	active	100		\N		11	1	2-0 2-1	5026344_12111509_46434691
b83bc4da-9c33-4d41-b5bd-aa7000a82a65	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-2 4plus	0-2 4plus	active	27.5		\N		11	2	0-2 4plus	5026344_12111509_46434634
c9fdaa73-29c1-4aca-a36e-aa7000a82a71	22f5756e-2797-45b8-b3ea-aa7000a828c4	2-1 2-1	2-1 2-1	active	125		\N		12	1	2-1 2-1	5026344_12111509_46434703
d68d6060-9a91-468c-a870-aa7000a82a7d	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-2 0-2	0-2 0-2	active	90		\N		11	3	0-2 0-2	5026344_12111509_46434614
db3f8769-d69b-4486-a9a7-aa7000a82a88	22f5756e-2797-45b8-b3ea-aa7000a828c4	2-1 4plus	2-1 4plus	active	28		\N		12	2	2-1 4plus	5026344_12111509_46434592
c3a1c95c-60af-47b2-a0c7-aa7000a82a94	22f5756e-2797-45b8-b3ea-aa7000a828c4	2-0 3-0	2-0 3-0	active	100		\N		13	1	2-0 3-0	5026344_12111509_46434488
1bb8af10-c03a-4c1b-8ce5-aa7000a82aab	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-2 1-2	0-2 1-2	active	100		\N		12	3	0-2 1-2	5026344_12111509_46434649
bee4e103-32dc-46f1-ba35-aa7000a82abc	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-2 4plus	1-2 4plus	active	26.5		\N		13	2	1-2 4plus	5026344_12111509_46434697
a4556c77-1fff-4cfc-b4a5-aa7000a82acd	22f5756e-2797-45b8-b3ea-aa7000a828c4	1-2 1-2	1-2 1-2	active	125		\N		13	3	1-2 1-2	5026344_12111509_46434557
77665128-e464-48ba-8ba8-aa7000a82ad8	22f5756e-2797-45b8-b3ea-aa7000a828c4	3-0 3-0	3-0 3-0	active	250		\N		14	1	3-0 3-0	5026344_12111509_46434589
cb2684bd-c3ae-40e0-8df7-aa7000a82aef	22f5756e-2797-45b8-b3ea-aa7000a828c4	3-0 4plus	3-0 4plus	active	90		\N		14	2	3-0 4plus	5026344_12111509_46434484
5979c121-2521-4a4e-abd6-aa7000a82b1f	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-2 0-3	0-2 0-3	active	90		\N		14	3	0-2 0-3	5026344_12111509_46434532
10aa9c95-51aa-4340-ae92-aa7000a82b2c	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-3 4plus	0-3 4plus	active	80		\N		15	2	0-3 4plus	5026344_12111509_46434564
0167a090-b054-4d20-adba-aa7000a82b3b	22f5756e-2797-45b8-b3ea-aa7000a828c4	0-3 0-3	0-3 0-3	active	250		\N		15	3	0-3 0-3	5026344_12111509_46434494
9ab4b786-f833-410d-9812-aa7000a82b4a	22f5756e-2797-45b8-b3ea-aa7000a828c4	4plus 4plus	4plus 4plus	active	18		\N		16	2	4plus 4plus	5026344_12111509_46434727
ca5ce3af-6d0a-4380-af5c-aa7000a82b71	57e29679-0f04-493a-a839-aa7000a82b5b	No/Over 2.5	YUnder	active	7.8		\N		1	1	No/Over 2.5	5026344_12111469_46433935
ac6113b9-99a3-4a5b-812b-aa7000a82b83	57e29679-0f04-493a-a839-aa7000a82b5b	Yes/Over 2.5	YOver	active	1.82		\N		1	2	Yes/Over 2.5	5026344_12111469_46433929
10f2c403-1997-482f-a5e4-aa7000a82b8f	57e29679-0f04-493a-a839-aa7000a82b5b	No/Under 2.5	NUnder	active	3.1		\N		2	1	No/Under 2.5	5026344_12111469_46433944
7ac654e0-8211-451d-b0cc-aa7000a82b9c	57e29679-0f04-493a-a839-aa7000a82b5b	Yes/Under 2.5	NOver	active	10		\N		2	2	Yes/Under 2.5	5026344_12111469_46433938
413dc73a-0392-4a83-8bef-aa7000a82bbc	c15c1ecf-f7b5-4ebb-afb0-aa7000a82bab	0	MR_0	active	3.15		\N		1	1	0	5026344_12111435_46433730
5e7db7a6-6b36-4b06-88e9-aa7000a82bc9	c15c1ecf-f7b5-4ebb-afb0-aa7000a82bab	1-2	MR_1-2	active	1.42		\N		1	2	1-2	5026344_12111435_46433736
ce6f84b5-5ed9-4120-a672-aa7000a82bd6	c15c1ecf-f7b5-4ebb-afb0-aa7000a82bab	1-3	MR_1-3	active	1.22		\N		1	3	1-3	5026344_12111435_46433740
742ff4b9-ac83-4a80-b70a-aa7000a82be4	c15c1ecf-f7b5-4ebb-afb0-aa7000a82bab	2-3	MR_2-3	active	1.88		\N		2	1	2-3	5026344_12111435_46433744
f553dfe6-a5e4-44a8-87ad-aa7000a82bf0	c15c1ecf-f7b5-4ebb-afb0-aa7000a82bab	4+	MR_4+	active	7		\N		3	1	4+	5026344_12111435_46433751
22b4d243-6523-47f0-b089-aa7000a82c11	7dd568d9-33e4-4174-a0bb-aa7000a82c01	Ifk Hassleholm	A	active	1.88		\N		1	1	Ifk Hassleholm	5026344_12111408_46433624
f063686d-564a-4bf6-96a8-aa7000a82c25	7dd568d9-33e4-4174-a0bb-aa7000a82c01	Носаби ИФ	B	active	1.76		\N		1	2	Носаби ИФ	5026344_12111408_46433630
cf6f611f-c93e-445e-887c-aa7000a82c40	183ff77d-6086-479b-8d8a-aa7000a82c34	Odd	Odd	active	1.89		\N		1	1	Odd	5026344_12111370_46433487
86ef4979-d1dc-4640-a51e-aa7000a82c53	183ff77d-6086-479b-8d8a-aa7000a82c34	Even	Even	active	1.75		\N		1	2	Even	5026344_12111370_46433492
1d0b78b4-6319-4db0-9603-aa7000a82c7c	a477dcaf-56a1-4267-a36e-aa7000a82c68	Odd	Odd	active	1.9		\N		1	1	Odd	5026344_12111345_46433405
0c009200-6ecc-41a5-aedc-aa7000a82c87	a477dcaf-56a1-4267-a36e-aa7000a82c68	Even	Even	active	1.75		\N		1	2	Even	5026344_12111345_46433407
145db446-c631-4d29-9072-aa7000a82c9f	aa6b0035-c07d-433c-beff-aa7000a82c93	0	MR_0	active	10		\N		1	1	0	5026344_12111318_46433280
6b1f19e5-bba7-4415-a0da-aa7000a82cab	aa6b0035-c07d-433c-beff-aa7000a82c93	1-2	MR_1-2	active	2.01		\N		1	2	1-2	5026344_12111318_46433284
78c9c5e4-5d4c-40fb-bff3-aa7000a82cb7	aa6b0035-c07d-433c-beff-aa7000a82c93	1-3	MR_1-3	active	1.42		\N		1	3	1-3	5026344_12111318_46433291
e84e2f8e-44c1-459d-b7de-aa7000a82cc4	aa6b0035-c07d-433c-beff-aa7000a82c93	1-4	MR_1-4	active	1.19		\N		2	1	1-4	5026344_12111318_46433307
6d909ede-549e-4a28-ba84-aa7000a82cd1	aa6b0035-c07d-433c-beff-aa7000a82c93	1-5	MR_1-5	active	1.09		\N		2	2	1-5	5026344_12111318_46433314
e0fe2fdb-93cb-4e4e-81fd-aa7000a82cdd	aa6b0035-c07d-433c-beff-aa7000a82c93	1-6	MR_1-6	active	1.05		\N		2	3	1-6	5026344_12111318_46433322
919aa166-9ee3-4eb2-a549-aa7000a82ce8	aa6b0035-c07d-433c-beff-aa7000a82c93	2-3	MR_2-3	active	1.72		\N		3	1	2-3	5026344_12111318_46433338
c906a9f9-d372-478f-a949-aa7000a82cf4	aa6b0035-c07d-433c-beff-aa7000a82c93	2-4	MR_2-4	active	1.36		\N		3	2	2-4	5026344_12111318_46433273
67690861-0f90-4a34-ad20-aa7000a82d01	aa6b0035-c07d-433c-beff-aa7000a82c93	2-5	MR_2-5	active	1.22		\N		3	3	2-5	5026344_12111318_46433358
9a7cf160-f87c-44ef-978c-aa7000a82d11	aa6b0035-c07d-433c-beff-aa7000a82c93	2-6	MR_2-6	active	1.16		\N		4	1	2-6	5026344_12111318_46433364
e5910bc1-a4f9-484f-a2ff-aa7000a82d1d	aa6b0035-c07d-433c-beff-aa7000a82c93	3-4	MR_3-4	active	1.86		\N		4	2	3-4	5026344_12111318_46433369
f6182e45-03fd-4b6c-a74b-aa7000a82d29	aa6b0035-c07d-433c-beff-aa7000a82c93	3-5	MR_3-5	active	1.57		\N		4	3	3-5	5026344_12111318_46433298
d01f0e70-5037-4760-9811-aa7000a82d36	aa6b0035-c07d-433c-beff-aa7000a82c93	3-6	MR_3-6	active	1.46		\N		5	1	3-6	5026344_12111318_46433342
a6161219-296c-4db7-b1b1-aa7000a82d43	aa6b0035-c07d-433c-beff-aa7000a82c93	4-5	MR_4-5	active	2.43		\N		5	2	4-5	5026344_12111318_46433331
e8e28600-2d2b-438e-902a-aa7000a82d51	aa6b0035-c07d-433c-beff-aa7000a82c93	4-6	MR_4-6	active	2.11		\N		5	3	4-6	5026344_12111318_46433354
e48ed85d-1035-46c8-b6c0-aa7000a82d61	aa6b0035-c07d-433c-beff-aa7000a82c93	5-6	MR_5-6	active	3.8		\N		6	2	5-6	5026344_12111318_46433347
5ab4b36e-31e7-4db3-a9a3-aa7000a82d71	aa6b0035-c07d-433c-beff-aa7000a82c93	7+	MR_7+	active	11.5		\N		6	3	7+	5026344_12111318_46433303
69cd6b7b-ef89-403e-98dd-aa7000a82d93	707166b2-0302-4b67-a698-aa7000a82d80	Ifk Hassleholm/Draw and Yes	AXYes	active	2.17		\N		1	1	Ifk Hassleholm/Draw and Yes	5026344_12111209_46432476
b706db22-bcb8-4f0b-b5ca-aa7000a82da0	707166b2-0302-4b67-a698-aa7000a82d80	Ifk Hassleholm/Носаби ИФ and Yes	ABYes	active	2.07		\N		1	2	Ifk Hassleholm/Носаби ИФ and Yes	5026344_12111209_46432488
0c9783fe-ecda-4056-ba04-aa7000a82db2	707166b2-0302-4b67-a698-aa7000a82d80	Draw/Носаби ИФ and Yes	BXYes	active	2.09		\N		1	3	Draw/Носаби ИФ and Yes	5026344_12111209_46432499
501169f2-8889-44a7-9ef9-aa7000a82dc5	707166b2-0302-4b67-a698-aa7000a82d80	Ifk Hassleholm/Draw and No	AXNo	active	3.95		\N		2	1	Ifk Hassleholm/Draw and No	5026344_12111209_46432482
89052a66-301a-4a9f-ab9a-aa7000a82ddf	707166b2-0302-4b67-a698-aa7000a82d80	Ifk Hassleholm/Носаби ИФ and No	ABNo	active	2.56		\N		2	2	Ifk Hassleholm/Носаби ИФ and No	5026344_12111209_46432494
fc72797c-1471-40ca-b73a-aa7000a82dea	707166b2-0302-4b67-a698-aa7000a82d80	Draw/Носаби ИФ and No	BXNo	active	3.7		\N		2	3	Draw/Носаби ИФ and No	5026344_12111209_46432507
9af50c08-2d3b-46e6-a384-aa7000a82e02	e2ea1f40-a7b7-4f88-b582-aa7000a82df7	Ifk Hassleholm/Draw  Under 3.5	AXUnder	active	2.26		\N		1	1	Ifk Hassleholm/Draw  Under 3.5	5026344_12111028_46431667
375e9063-11ec-498e-9ed5-aa7000a82e0e	e2ea1f40-a7b7-4f88-b582-aa7000a82df7	Ifk Hassleholm/Носаби ИФ - Under 3.5	ABUnder	active	1.9		\N		1	2	Ifk Hassleholm/Носаби ИФ - Under 3.5	5026344_12111028_46431671
66c841de-0bd9-420d-9efe-aa7000a82e22	e2ea1f40-a7b7-4f88-b582-aa7000a82df7	Draw/Носаби ИФ  Under 3.5	XBUnder	active	2.17		\N		1	3	Draw/Носаби ИФ  Under 3.5	5026344_12111028_46431677
d10f4dd6-e8f8-43da-ba50-aa7000a82e2e	e2ea1f40-a7b7-4f88-b582-aa7000a82df7	Ifk Hassleholm/Draw  Over 3.5	AXOver	active	3.65		\N		2	1	Ifk Hassleholm/Draw  Over 3.5	5026344_12111028_46431683
f453e6ef-4741-4ff6-a77b-aa7000a82e39	e2ea1f40-a7b7-4f88-b582-aa7000a82df7	Ifk Hassleholm/Носаби ИФ  Over 3.5	ABOver	active	2.9		\N		2	2	Ifk Hassleholm/Носаби ИФ  Over 3.5	5026344_12111028_46431690
162aef9e-7434-4418-b6cf-aa7000a82e47	e2ea1f40-a7b7-4f88-b582-aa7000a82df7	Draw/Носаби ИФ  Over 3.5	XBOver	active	3.4		\N		2	3	Draw/Носаби ИФ  Over 3.5	5026344_12111028_46431694
342c0440-976f-48f4-b529-aa7000a82e65	235695e1-d767-4fa6-8482-aa7000a82e56	Ifk Hassleholm/Draw  Under 2.5	AXUnder	active	3		\N		1	1	Ifk Hassleholm/Draw  Under 2.5	5026344_12111005_46431574
b3ef8219-991a-4665-8ed5-aa7000a82e71	235695e1-d767-4fa6-8482-aa7000a82e56	Ifk Hassleholm/Носаби ИФ - Under 2.5	ABUnder	active	3.35		\N		1	2	Ifk Hassleholm/Носаби ИФ - Under 2.5	5026344_12111005_46431579
17670762-ea2d-47ff-ab4f-aa7000a82e7d	235695e1-d767-4fa6-8482-aa7000a82e56	Draw/Носаби ИФ  Under 2.5	XBUnder	active	2.95		\N		1	3	Draw/Носаби ИФ  Under 2.5	5026344_12111005_46431586
ccb0ddaa-d9aa-4733-83f5-aa7000a82e89	235695e1-d767-4fa6-8482-aa7000a82e56	Ifk Hassleholm/Draw  Over 2.5	AXOver	active	2.59		\N		2	1	Ifk Hassleholm/Draw  Over 2.5	5026344_12111005_46431593
43a43316-6980-4b66-b6e2-aa7000a82e95	235695e1-d767-4fa6-8482-aa7000a82e56	Ifk Hassleholm/Носаби ИФ  Over 2.5	ABOver	active	1.76		\N		2	2	Ifk Hassleholm/Носаби ИФ  Over 2.5	5026344_12111005_46431600
c150166a-4f74-4538-b000-aa7000a82ea1	235695e1-d767-4fa6-8482-aa7000a82e56	Draw/Носаби ИФ  Over 2.5	XBOver	active	2.42		\N		2	3	Draw/Носаби ИФ  Over 2.5	5026344_12111005_46431605
e004fb92-f4e5-4f8f-a3d3-aa7000a82eb9	c4bc847c-16d5-4e7f-babb-aa7000a82eae	Ifk Hassleholm/Draw  Under 1.5	AXUnder	active	6.25		\N		1	1	Ifk Hassleholm/Draw  Under 1.5	5026344_12110991_46431487
eafc8174-71d9-4c0d-a936-aa7000a82eca	c4bc847c-16d5-4e7f-babb-aa7000a82eae	Ifk Hassleholm/Носаби ИФ - Under 1.5	ABUnder	active	5.3		\N		1	2	Ifk Hassleholm/Носаби ИФ - Under 1.5	5026344_12110991_46431491
82d1af85-2189-4f1c-8884-aa7000a82ed8	c4bc847c-16d5-4e7f-babb-aa7000a82eae	Draw/Носаби ИФ  Under 1.5	XBUnder	active	6.1		\N		1	3	Draw/Носаби ИФ  Under 1.5	5026344_12110991_46431499
53601360-761e-4456-9fcb-aa7000a82eea	c4bc847c-16d5-4e7f-babb-aa7000a82eae	Ifk Hassleholm/Draw  Over 1.5	AXOver	active	1.78		\N		2	1	Ifk Hassleholm/Draw  Over 1.5	5026344_12110991_46431506
3e8ca8b4-d4a4-4cd2-9438-aa7000a82ef9	c4bc847c-16d5-4e7f-babb-aa7000a82eae	Ifk Hassleholm/Носаби ИФ  Over 1.5	ABOver	active	1.48		\N		2	2	Ifk Hassleholm/Носаби ИФ  Over 1.5	5026344_12110991_46431513
785c3b05-8e4b-483d-bf8c-aa7000a82f04	c4bc847c-16d5-4e7f-babb-aa7000a82eae	Draw/Носаби ИФ  Over 1.5	XBOver	active	1.7		\N		2	3	Draw/Носаби ИФ  Over 1.5	5026344_12110991_46431521
4d540bd1-e80f-44b0-9d61-aa7000a82f39	a481d8ef-51f5-452e-ae1c-aa7000a82f25	Ifk Hassleholm/Draw  Under 4.5	AXUnder	active	1.77		\N		1	1	Ifk Hassleholm/Draw  Under 4.5	5026344_12110974_46431390
0dd993ba-0d53-42d4-bd04-aa7000a82f47	a481d8ef-51f5-452e-ae1c-aa7000a82f25	Ifk Hassleholm/Носаби ИФ - Under 4.5	ABUnder	active	1.57		\N		1	2	Ifk Hassleholm/Носаби ИФ - Under 4.5	5026344_12110974_46431395
7ad4ac21-1d92-411b-bb87-aa7000a82f54	a481d8ef-51f5-452e-ae1c-aa7000a82f25	Draw/Носаби ИФ  Under 4.5	XBUnder	active	1.69		\N		1	3	Draw/Носаби ИФ  Under 4.5	5026344_12110974_46431402
67ba0d6c-d63f-4947-9802-aa7000a82f61	a481d8ef-51f5-452e-ae1c-aa7000a82f25	Ifk Hassleholm/Draw  Over 4.5	AXOver	active	6.75		\N		2	1	Ifk Hassleholm/Draw  Over 4.5	5026344_12110974_46431413
1adb27c2-3b17-43e5-ae3e-aa7000a82f6d	a481d8ef-51f5-452e-ae1c-aa7000a82f25	Ifk Hassleholm/Носаби ИФ  Over 4.5	ABOver	active	4.3		\N		2	2	Ifk Hassleholm/Носаби ИФ  Over 4.5	5026344_12110974_46431419
071cfcb7-4943-4df0-9837-aa7000a82f77	a481d8ef-51f5-452e-ae1c-aa7000a82f25	Draw/Носаби ИФ  Over 4.5	XBOver	active	6.25		\N		2	3	Draw/Носаби ИФ  Over 4.5	5026344_12110974_46431428
dec495e9-b805-4541-acff-aa7000a82f8f	352a4048-3347-4488-87ef-aa7000a82f83	Ifk Hassleholm/Yes	AYes	active	10.5		\N		1	1	Ifk Hassleholm/Yes	5026344_12110960_46431311
05a9c2c1-19c6-4bc6-84cb-aa7000a82fa2	352a4048-3347-4488-87ef-aa7000a82f83	Draw/Yes	XYes	active	5.65		\N		1	2	Draw/Yes	5026344_12110960_46431321
5b29669b-7882-4c61-b22a-aa7000a82faf	352a4048-3347-4488-87ef-aa7000a82f83	Носаби ИФ/Yes	BYes	active	9.9		\N		1	3	Носаби ИФ/Yes	5026344_12110960_46431334
27df823c-c307-4f09-b666-aa7000a82fbf	352a4048-3347-4488-87ef-aa7000a82f83	Ifk Hassleholm/No	ANo	active	3.85		\N		2	1	Ifk Hassleholm/No	5026344_12110960_46431320
04b1cfbd-1bfb-4851-88c8-aa7000a82fcc	352a4048-3347-4488-87ef-aa7000a82f83	Draw/No	XNo	active	5.35		\N		2	2	Draw/No	5026344_12110960_46431327
130f415e-29cb-4c47-b8ce-aa7000a82fda	352a4048-3347-4488-87ef-aa7000a82f83	Носаби ИФ/No	BNo	active	3.6		\N		2	3	Носаби ИФ/No	5026344_12110960_46431340
4f54159e-4839-40c4-bb3e-aa7000a82ff3	d859bba3-977f-4435-b78e-aa7000a82fe6	Ifk Hassleholm	A	active	1.88		\N		1	1	Ifk Hassleholm	5026344_12110893_46430961
a19c6920-2254-476f-a46e-aa7000a83000	d859bba3-977f-4435-b78e-aa7000a82fe6	Носаби ИФ	B	active	1.76		\N		1	2	Носаби ИФ	5026344_12110893_46430967
8df19351-b002-4aa4-b5ec-aa7000a83018	0f6ec7be-57cf-48ba-8659-aa7000a8300b	Yes	Yes	active	6.2		\N		1	1	Yes	5026344_12110460_46429892
f15d888d-f248-413b-8d2c-aa7000a8302b	0f6ec7be-57cf-48ba-8659-aa7000a8300b	No	No	active	1.07		\N		1	2	No	5026344_12110460_46429895
708efb01-0bcd-4a1f-98b3-aa7000a83093	9351e30a-a68f-4ffb-8a34-aa7000a83074	3-0	3-0	active	60		\N		1	1	3-0	5026346_12111664_46435972
7032940e-ebaf-4e25-96e9-aa7000a830a3	9351e30a-a68f-4ffb-8a34-aa7000a83074	1-0	1-0	active	16		\N		1	2	1-0	5026346_12111664_46435976
0408a770-7a17-44fc-b547-aa7000a830c2	9351e30a-a68f-4ffb-8a34-aa7000a83074	2-0	2-0	active	25.5		\N		1	3	2-0	5026346_12111664_46435980
6e419ee2-9aa4-4ab9-830c-aa7000a830cf	9351e30a-a68f-4ffb-8a34-aa7000a83074	2-1	2-1	active	14		\N		2	1	2-1	5026346_12111664_46435985
7420f0af-1fc1-490e-94ad-aa7000a830dc	9351e30a-a68f-4ffb-8a34-aa7000a83074	2-4	2-4	active	55		\N		2	2	2-4	5026346_12111664_46435991
215e3bb5-7300-4b8f-b367-aa7000a830e9	9351e30a-a68f-4ffb-8a34-aa7000a83074	3-1	3-1	active	35		\N		2	3	3-1	5026346_12111664_46435992
030ee082-e1f0-44fb-afa9-aa7000a830f5	9351e30a-a68f-4ffb-8a34-aa7000a83074	3-2	3-2	active	35		\N		3	1	3-2	5026346_12111664_46436000
6943e997-4480-49b9-9d2e-aa7000a83101	9351e30a-a68f-4ffb-8a34-aa7000a83074	4-0	4-0	active	150		\N		3	2	4-0	5026346_12111664_46436007
d209cb9b-5add-4339-a2c0-aa7000a8310c	9351e30a-a68f-4ffb-8a34-aa7000a83074	1-2	1-2	active	9.8		\N		3	3	1-2	5026346_12111664_46436013
d52d68e5-f3fd-48b9-923e-aa7000a83119	9351e30a-a68f-4ffb-8a34-aa7000a83074	0-2	0-2	active	12.25		\N		4	1	0-2	5026346_12111664_46436018
3f58666d-be63-4058-bd04-aa7000a83126	9351e30a-a68f-4ffb-8a34-aa7000a83074	4-1	4-1	active	100		\N		4	2	4-1	5026346_12111664_46436022
65918e77-ef1a-44c5-b38c-aa7000a83130	9351e30a-a68f-4ffb-8a34-aa7000a83074	Any Other	M1	active	20.5		\N		4	3	Any Other	5026346_12111664_46436025
2c9d82a1-7218-4402-b012-aa7000a83149	9351e30a-a68f-4ffb-8a34-aa7000a83074	3-4	3-4	active	125		\N		5	1	3-4	5026346_12111664_46436031
4dd0fec7-6b60-4d68-9bce-aa7000a83155	9351e30a-a68f-4ffb-8a34-aa7000a83074	4-3	4-3	active	150		\N		5	2	4-3	5026346_12111664_46436036
b0c83170-71da-48b2-8015-aa7000a83163	9351e30a-a68f-4ffb-8a34-aa7000a83074	0-1	0-1	active	11.25		\N		5	3	0-1	5026346_12111664_46436041
d0615825-7918-4fbd-82af-aa7000a8316f	9351e30a-a68f-4ffb-8a34-aa7000a83074	0-3	0-3	active	20.5		\N		6	1	0-3	5026346_12111664_46436047
a62a87cc-4d93-484c-861f-aa7000a8317a	9351e30a-a68f-4ffb-8a34-aa7000a83074	4-2	4-2	active	125		\N		6	2	4-2	5026346_12111664_46436052
b6d2379d-f586-447b-8766-aa7000a8318e	9351e30a-a68f-4ffb-8a34-aa7000a83074	1-3	1-3	active	16.25		\N		6	3	1-3	5026346_12111664_46436054
3f80d37a-6d7e-4b76-b673-aa7000a831a2	9351e30a-a68f-4ffb-8a34-aa7000a83074	1-4	1-4	active	35		\N		7	1	1-4	5026346_12111664_46436055
df866511-7a2d-48ce-832a-aa7000a831b3	9351e30a-a68f-4ffb-8a34-aa7000a83074	0-4	0-4	active	45		\N		7	2	0-4	5026346_12111664_46436061
5951bf1e-cbd0-4753-a08b-aa7000a831c2	9351e30a-a68f-4ffb-8a34-aa7000a83074	0-0	0-0	active	18		\N		7	3	0-0	5026346_12111664_46436068
fdefc88d-311d-452d-beb8-aa7000a831f0	9351e30a-a68f-4ffb-8a34-aa7000a83074	1-1	1-1	active	8		\N		8	1	1-1	5026346_12111664_46436074
c1e3fa65-b2a4-4efb-8e6b-aa7000a8320b	9351e30a-a68f-4ffb-8a34-aa7000a83074	3-3	3-3	active	55		\N		8	2	3-3	5026346_12111664_46436076
08d213ea-d3ff-4959-971a-aa7000a8321a	9351e30a-a68f-4ffb-8a34-aa7000a83074	4-4	4-4	active	250		\N		8	3	4-4	5026346_12111664_46436080
f926f8ad-8b16-4d42-9cd3-aa7000a83229	9351e30a-a68f-4ffb-8a34-aa7000a83074	2-2	2-2	active	14		\N		9	1	2-2	5026346_12111664_46436087
4142bae4-d250-4bd8-baa5-aa7000a83236	9351e30a-a68f-4ffb-8a34-aa7000a83074	2-3	2-3	active	25.5		\N		9	2	2-3	5026346_12111664_46436090
9ef08b93-b0ad-4dba-b63e-aa7000a8324d	26e67321-f784-4d71-97f4-aa7000a83241	Ifo Bromolla If/Ifo Bromolla If and over +4.5	A/AOver	active	27.5		\N		1	1	Ifo Bromolla If/Ifo Bromolla If and over +4.5	5026346_12111558_46434976
31f5dade-779f-4f7b-b733-aa7000a8325a	26e67321-f784-4d71-97f4-aa7000a83241	Ifo Bromolla If/Ifo Bromolla If and under +4.5	A/AUnder	active	8.25		\N		1	2	Ifo Bromolla If/Ifo Bromolla If and under +4.5	5026346_12111558_46435055
86f4787b-ea2c-4dd7-96fb-aa7000a83268	26e67321-f784-4d71-97f4-aa7000a83241	Ifo Bromolla If/Ifk Berga and over +4.5	A/BOver	active	60		\N		2	1	Ifo Bromolla If/Ifk Berga and over +4.5	5026346_12111558_46434986
c1fedfac-eb93-4357-960d-aa7000a83275	26e67321-f784-4d71-97f4-aa7000a83241	Ifo Bromolla If/Ifk Berga and under +4.5	A/BUnder	active	50		\N		2	2	Ifo Bromolla If/Ifk Berga and under +4.5	5026346_12111558_46435075
c1b3113d-1238-4635-8702-aa7000a83281	26e67321-f784-4d71-97f4-aa7000a83241	Ifo Bromolla If/Draw and over +4.5	A/XOver	active	125		\N		3	1	Ifo Bromolla If/Draw and over +4.5	5026346_12111558_46434970
21c53181-aa9e-49ff-9a5f-aa7000a8328e	26e67321-f784-4d71-97f4-aa7000a83241	Ifo Bromolla If/Draw and under +4.5	A/XUnder	active	19		\N		3	2	Ifo Bromolla If/Draw and under +4.5	5026346_12111558_46435064
2b97b6e2-bca1-410c-9212-aa7000a832a0	26e67321-f784-4d71-97f4-aa7000a83241	Ifk Berga/Ifo Bromolla If and over +4.5	B/AOver	active	100		\N		4	1	Ifk Berga/Ifo Bromolla If and over +4.5	5026346_12111558_46435013
16bdfcd9-360d-4c54-b1a5-aa7000a832ad	26e67321-f784-4d71-97f4-aa7000a83241	Ifk Berga/Ifo Bromolla If and under +4.5	B/AUnder	active	80		\N		4	2	Ifk Berga/Ifo Bromolla If and under +4.5	5026346_12111558_46435068
0b4f57c4-a855-4372-bb49-aa7000a832bb	26e67321-f784-4d71-97f4-aa7000a83241	Ifk Berga/Ifk Berga and over +4.5	B/BOver	active	11.25		\N		5	1	Ifk Berga/Ifk Berga and over +4.5	5026346_12111558_46435040
9f257546-8f94-4623-bfc4-aa7000a832c8	26e67321-f784-4d71-97f4-aa7000a83241	Ifk Berga/Ifk Berga and under +4.5	B/BUnder	active	4.25		\N		5	2	Ifk Berga/Ifk Berga and under +4.5	5026346_12111558_46435049
a2469f1d-35cb-4baf-b7d5-aa7000a832d5	26e67321-f784-4d71-97f4-aa7000a83241	Ifk Berga/Draw and over +4.5	B/XOver	active	125		\N		6	1	Ifk Berga/Draw and over +4.5	5026346_12111558_46435030
1cd64bdb-3396-4c46-b837-aa7000a832e5	26e67321-f784-4d71-97f4-aa7000a83241	Ifk Berga/Draw and under +4.5	B/XUnder	active	18.5		\N		6	2	Ifk Berga/Draw and under +4.5	5026346_12111558_46435021
37b413af-7141-4407-9f4f-aa7000a832fd	26e67321-f784-4d71-97f4-aa7000a83241	Draw/{0} and over	X/AOver	active	70		\N		7	1	Draw/{0} and over	5026346_12111558_46434994
5753f330-8a64-4a18-93b8-aa7000a83311	26e67321-f784-4d71-97f4-aa7000a83241	Draw/{0} and under	X/AUnder	active	11		\N		7	2	Draw/{0} and under	5026346_12111558_46435034
bbc24b67-4ef5-44e0-990d-aa7000a8331d	26e67321-f784-4d71-97f4-aa7000a83241	Draw/Ifk Berga and over +4.5	X/BOver	active	35		\N		8	1	Draw/Ifk Berga and over +4.5	5026346_12111558_46435007
0b018c5b-2620-41f1-9203-aa7000a83329	26e67321-f784-4d71-97f4-aa7000a83241	Draw/Ifk Berga and under +4.5	X/BUnder	active	6.75		\N		8	2	Draw/Ifk Berga and under +4.5	5026346_12111558_46435045
724d520b-3852-4740-8fdb-aa7000a8333f	26e67321-f784-4d71-97f4-aa7000a83241	Draw/Draw and over	X/XOver	active	125		\N		9	1	Draw/Draw and over	5026346_12111558_46435000
b09a49c4-8bc1-42ea-bb80-aa7000a83356	26e67321-f784-4d71-97f4-aa7000a83241	Draw/Draw and under	X/XUnder	active	6.8		\N		9	2	Draw/Draw and under	5026346_12111558_46435060
c74e35dd-46cf-4e90-a5d6-aa7000a83378	4c2962c2-1894-4dba-b0b0-aa7000a83365	IFO Bromolla IF +0.75	AH	active	1.61		\N		1	1	IFO Bromolla IF +0.75	5026346_12110517_46430028
902ce1d2-cc8b-4dc2-ba20-aa7000a83387	4c2962c2-1894-4dba-b0b0-aa7000a83365	IFK Berga -0.75	BH	active	2.09		\N		1	2	IFK Berga -0.75	5026346_12110517_46430032
8d012974-bbf5-4165-92ed-aa7000a833a4	a9e8e4ea-32ba-49db-a0fd-aa7000a83395	IFO Bromolla IF 0	AH	active	2.52		\N		1	1	IFO Bromolla IF 0	5026346_12110529_46430057
914f6471-53d6-4116-bab1-aa7000a833b0	a9e8e4ea-32ba-49db-a0fd-aa7000a83395	IFK Berga 0	BH	active	1.42		\N		1	2	IFK Berga 0	5026346_12110529_46430060
0bb83007-94fa-4712-a692-aa7000a833c7	023f3db0-a0b7-46ca-8c9c-aa7000a833bb	IFO Bromolla IF +1	AH	active	1.43		\N		1	1	IFO Bromolla IF +1	5026346_12110543_46430088
04d22032-fb87-427e-a33c-aa7000a833d3	023f3db0-a0b7-46ca-8c9c-aa7000a833bb	IFK Berga -1	BH	active	2.5		\N		1	2	IFK Berga -1	5026346_12110543_46430093
24e72576-2794-4124-819b-aa7000a833f4	88c0d4cf-49a9-4e0b-a68b-aa7000a833e4	IFO Bromolla IF +0.25	AH	active	2.04		\N		1	1	IFO Bromolla IF +0.25	5026346_12110571_46430142
fd1b98c9-3706-40bb-a387-aa7000a83403	88c0d4cf-49a9-4e0b-a68b-aa7000a833e4	IFK Berga -0.25	BH	active	1.64		\N		1	2	IFK Berga -0.25	5026346_12110571_46430146
9b16ff0e-04b2-455d-8331-aa7000a8341e	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifo Bromolla If/Ifo Bromolla If and over +3.5	A/AOver	active	16.75		\N		1	1	Ifo Bromolla If/Ifo Bromolla If and over +3.5	5026346_12111615_46435576
c1b4d502-c1a3-4111-8631-aa7000a844b5	c2284a44-bee7-4239-bc16-aa7000a8448b	2	2	active	4.1		\N		1	3	2	5026346_12111381_46433540
b2c31ed7-71de-4bf7-805c-aa7000a8342c	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifo Bromolla If/Ifo Bromolla If and under +3.5	A/AUnder	active	10.25		\N		1	2	Ifo Bromolla If/Ifo Bromolla If and under +3.5	5026346_12111615_46435655
7f7f2732-0b2c-47ce-bfed-aa7000a83439	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifo Bromolla If/Ifk Berga and over +3.5	A/BOver	active	50		\N		2	1	Ifo Bromolla If/Ifk Berga and over +3.5	5026346_12111615_46435572
5c9aba43-5eac-42d5-92cc-aa7000a83449	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifo Bromolla If/Ifk Berga and under +3.5	A/BUnder	active	70		\N		2	2	Ifo Bromolla If/Ifk Berga and under +3.5	5026346_12111615_46435658
d97e06af-3213-4b8c-8746-aa7000a83459	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifo Bromolla If/Draw and over +3.5	A/XOver	active	35		\N		3	1	Ifo Bromolla If/Draw and over +3.5	5026346_12111615_46435593
d34148c4-eddc-49db-866c-aa7000a8346e	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifo Bromolla If/Draw and under +3.5	A/XUnder	active	35		\N		3	2	Ifo Bromolla If/Draw and under +3.5	5026346_12111615_46435667
8af7affb-d895-46b3-a37f-aa7000a8347a	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifk Berga/Ifo Bromolla If and over +3.5	B/AOver	active	80		\N		4	1	Ifk Berga/Ifo Bromolla If and over +3.5	5026346_12111615_46435638
2fd76675-5fb3-482f-96d6-aa7000a83486	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifk Berga/Ifo Bromolla If and under +3.5	B/AUnder	active	90		\N		4	2	Ifk Berga/Ifo Bromolla If and under +3.5	5026346_12111615_46435626
28fca908-3a21-441f-b3d5-aa7000a834a3	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifk Berga/Ifk Berga and over +3.5	B/BOver	active	6.75		\N		5	1	Ifk Berga/Ifk Berga and over +3.5	5026346_12111615_46435651
fd51c5ba-5839-4164-b987-aa7000a834c2	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifk Berga/Ifk Berga and under +3.5	B/BUnder	active	5.65		\N		5	2	Ifk Berga/Ifk Berga and under +3.5	5026346_12111615_46435608
0d0e7300-4058-45a5-ad14-aa7000a834d6	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifk Berga/Draw and over +3.5	B/XOver	active	35		\N		6	1	Ifk Berga/Draw and over +3.5	5026346_12111615_46435644
064e3e87-9ee8-43b0-96ba-aa7000a834e7	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Ifk Berga/Draw and under +3.5	B/XUnder	active	35		\N		6	2	Ifk Berga/Draw and under +3.5	5026346_12111615_46435663
0cde9802-07d4-4739-a49e-aa7000a834f3	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Draw/{0} and over	X/AOver	active	45		\N		7	1	Draw/{0} and over	5026346_12111615_46435600
aa16b8f5-c023-4368-b1ef-aa7000a834fe	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Draw/{0} and under	X/AUnder	active	12		\N		7	2	Draw/{0} and under	5026346_12111615_46435621
f6cdc898-9efb-4c49-9acf-aa7000a8350c	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Draw/Ifk Berga and over +3.5	X/BOver	active	22		\N		8	1	Draw/Ifk Berga and over +3.5	5026346_12111615_46435634
6332a72e-69c0-4d9b-814f-aa7000a83517	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Draw/Ifk Berga and under +3.5	X/BUnder	active	7.7		\N		8	2	Draw/Ifk Berga and under +3.5	5026346_12111615_46435605
e72f087e-dbd7-4e8c-a33b-aa7000a83530	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Draw/Draw and over	X/XOver	active	30		\N		9	1	Draw/Draw and over	5026346_12111615_46435616
d9a1aa88-3c0a-4f08-9b73-aa7000a8353f	f2e2ed42-a39c-4a2a-b6fa-aa7000a83411	Draw/Draw and under	X/XUnder	active	8.25		\N		9	2	Draw/Draw and under	5026346_12111615_46435680
3f17970f-2425-4275-a93f-aa7000a8355e	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifo Bromolla If/Ifo Bromolla If and over +2.5	A/AOver	active	9.4		\N		1	1	Ifo Bromolla If/Ifo Bromolla If and over +2.5	5026346_12111593_46435376
cc9c41a3-5be0-4fe0-a3d7-aa7000a83570	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifo Bromolla If/Ifo Bromolla If and under +2.5	A/AUnder	active	19.5		\N		1	2	Ifo Bromolla If/Ifo Bromolla If and under +2.5	5026346_12111593_46435444
176ad190-2332-4db4-a2a8-aa7000a83580	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifo Bromolla If/Ifk Berga and over +2.5	A/BOver	active	28		\N		2	1	Ifo Bromolla If/Ifk Berga and over +2.5	5026346_12111593_46435384
6837a570-3c13-4bf5-bfa1-aa7000a8358c	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifo Bromolla If/Draw and under +2.5	A/XUnder	active	35		\N		2	2	Ifo Bromolla If/Draw and under +2.5	5026346_12111593_46435456
ba37b926-9bf8-4572-8bbe-aa7000a8359c	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifo Bromolla If/Draw and over +2.5	A/XOver	active	35		\N		3	1	Ifo Bromolla If/Draw and over +2.5	5026346_12111593_46435381
7e538302-54d4-44b7-9f2d-aa7000a835ab	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifk Berga/Ifo Bromolla If and over +2.5	B/AOver	active	45		\N		4	1	Ifk Berga/Ifo Bromolla If and over +2.5	5026346_12111593_46435371
d803fc38-bb4d-4fb5-9a98-aa7000a835c0	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifk Berga/Ifk Berga and under +2.5	B/BUnder	active	11		\N		4	2	Ifk Berga/Ifk Berga and under +2.5	5026346_12111593_46435393
f31bf0f7-834e-47b7-80fe-aa7000a835d1	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifk Berga/Ifk Berga and over +2.5	B/BOver	active	4.25		\N		5	1	Ifk Berga/Ifk Berga and over +2.5	5026346_12111593_46435438
7f381699-3ec6-489a-b913-aa7000a835e0	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifk Berga/Draw and under +2.5	B/XUnder	active	35		\N		5	2	Ifk Berga/Draw and under +2.5	5026346_12111593_46435435
b18609d1-fd15-443e-8a55-aa7000a835f5	e0a8c651-37ec-4302-b93a-aa7000a83550	Ifk Berga/Draw and over +2.5	B/XOver	active	35		\N		6	1	Ifk Berga/Draw and over +2.5	5026346_12111593_46435427
729ef424-e4e5-4669-ba39-aa7000a8360c	e0a8c651-37ec-4302-b93a-aa7000a83550	Draw/{0} and under	X/AUnder	active	19.5		\N		6	2	Draw/{0} and under	5026346_12111593_46435422
d9045d41-0928-4905-a827-aa7000a83621	e0a8c651-37ec-4302-b93a-aa7000a83550	Draw/{0} and over	X/AOver	active	18.25		\N		7	1	Draw/{0} and over	5026346_12111593_46435388
a6e04b51-2e61-43c0-bf9a-aa7000a8362e	e0a8c651-37ec-4302-b93a-aa7000a83550	Draw/Ifk Berga and under +2.5	X/BUnder	active	12.25		\N		7	2	Draw/Ifk Berga and under +2.5	5026346_12111593_46435451
0d913b3f-fa36-4132-bdc1-aa7000a8363b	e0a8c651-37ec-4302-b93a-aa7000a83550	Draw/Ifk Berga and over +2.5	X/BOver	active	10.5		\N		8	1	Draw/Ifk Berga and over +2.5	5026346_12111593_46435417
ff286a2f-71a4-44a5-b929-aa7000a83649	e0a8c651-37ec-4302-b93a-aa7000a83550	Draw/Draw and under	X/XUnder	active	8.25		\N		8	2	Draw/Draw and under	5026346_12111593_46435413
babb124d-7a10-4fa8-a120-aa7000a83654	e0a8c651-37ec-4302-b93a-aa7000a83550	Draw/Draw and over	X/XOver	active	30		\N		9	1	Draw/Draw and over	5026346_12111593_46435407
4120c696-d7b3-4d4f-a74d-aa7000a8366d	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Ifo Bromolla If/Ifo Bromolla If and over +1.5	A/AOver	active	7.55		\N		1	1	Ifo Bromolla If/Ifo Bromolla If and over +1.5	5026346_12111575_46435185
13a3c44f-8424-44ea-b3df-aa7000a83679	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Ifo Bromolla If/Ifo Bromolla If and under +1.5	A/AUnder	active	40		\N		1	2	Ifo Bromolla If/Ifo Bromolla If and under +1.5	5026346_12111575_46435251
095a4586-ab92-4e85-8651-aa7000a83687	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Ifo Bromolla If/Ifk Berga and over +1.5	A/BOver	active	28		\N		2	1	Ifo Bromolla If/Ifk Berga and over +1.5	5026346_12111575_46435204
443f0034-8d75-4976-a3a6-aa7000a83694	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Ifo Bromolla If/Draw and over +1.5	A/XOver	active	16.5		\N		3	1	Ifo Bromolla If/Draw and over +1.5	5026346_12111575_46435191
bbd80dbd-ef1f-4c86-b660-aa7000a836a1	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Ifk Berga/Ifo Bromolla If and over +1.5	B/AOver	active	45		\N		4	1	Ifk Berga/Ifo Bromolla If and over +1.5	5026346_12111575_46435222
6b220d50-9ebb-42f3-b3fa-aa7000a836af	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Ifk Berga/Ifk Berga and under +1.5	B/BUnder	active	27		\N		4	2	Ifk Berga/Ifk Berga and under +1.5	5026346_12111575_46435197
c8d93136-6f41-43b5-bae4-aa7000a836be	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Ifk Berga/Ifk Berga and over +1.5	B/BOver	active	3.5		\N		5	1	Ifk Berga/Ifk Berga and over +1.5	5026346_12111575_46435244
73925cf5-df84-4a98-aeea-aa7000a836cb	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Ifk Berga/Draw and over +1.5	B/XOver	active	16.25		\N		6	1	Ifk Berga/Draw and over +1.5	5026346_12111575_46435230
cd6a3592-dc50-4d39-8ff7-aa7000a836d8	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Draw/{0} and under	X/AUnder	active	26		\N		6	2	Draw/{0} and under	5026346_12111575_46435257
43e5470d-7c0a-4a32-a12a-aa7000a836e6	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Draw/{0} and over	X/AOver	active	14.5		\N		7	1	Draw/{0} and over	5026346_12111575_46435210
d78e06b9-bee8-4058-9560-aa7000a836f3	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Draw/Ifk Berga and under +1.5	X/BUnder	active	18.25		\N		7	2	Draw/Ifk Berga and under +1.5	5026346_12111575_46435236
575cc51f-0c52-469b-9152-aa7000a83704	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Draw/Ifk Berga and over +1.5	X/BOver	active	8.2		\N		8	1	Draw/Ifk Berga and over +1.5	5026346_12111575_46435180
63cbde93-6533-483f-bcb0-aa7000a83716	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Draw/Draw and under	X/XUnder	active	17.75		\N		8	2	Draw/Draw and under	5026346_12111575_46435254
8aef8b9a-14e1-4c88-9305-aa7000a83727	67a7cf25-6ddd-46f1-bf88-aa7000a83661	Draw/Draw and over	X/XOver	active	10.25		\N		9	1	Draw/Draw and over	5026346_12111575_46435216
7bd8d20a-9f48-4169-bb6b-aa7000a83743	012481e5-9b5e-497d-b614-aa7000a83736	0	0	active	3.35		\N		1	1	0	5026346_12111532_46434757
eb9f8b56-d545-4bc7-b685-aa7000a83759	012481e5-9b5e-497d-b614-aa7000a83736	1	1	active	2.7		\N		1	2	1	5026346_12111532_46434766
3789463f-b68b-4973-a842-aa7000a83775	012481e5-9b5e-497d-b614-aa7000a83736	2	2	active	3.85		\N		1	3	2	5026346_12111532_46434773
66e0b5e7-4ff9-4d45-98dd-aa7000a83783	012481e5-9b5e-497d-b614-aa7000a83736	3+	3+	active	5.7		\N		2	1	3+	5026346_12111532_46434779
d10e4e45-5b90-4be3-9e2c-aa7000a8379b	21437e86-3dc4-4572-9be6-aa7000a83790	Yes	Yes	active	1.85		\N		1	1	Yes	5026346_12110933_46431151
0c6e0925-49c3-4af1-8012-aa7000a837a7	21437e86-3dc4-4572-9be6-aa7000a83790	No	No	active	1.79		\N		1	2	No	5026346_12110933_46431156
395a2bca-85fe-49b0-9b19-aa7000a837be	7223aa87-6bbd-4886-bd37-aa7000a837b1	Under 1.25	Under	active	1.73		\N		1	1	Under 1.25	5026346_12110605_46430240
d35c0551-ce37-41af-89da-aa7000a837cc	7223aa87-6bbd-4886-bd37-aa7000a837b1	Over 1.25	Over	active	1.91		\N		1	2	Over 1.25	5026346_12110605_46430238
a85304b4-d019-4463-92cc-aa7000a837e3	36f49148-bbbc-4dc1-9c3f-aa7000a837d6	Under 1.5	Under	active	1.5		\N		1	1	Under 1.5	5026346_12110592_46430213
151e1ea4-57d0-4b47-ba49-aa7000a837f0	36f49148-bbbc-4dc1-9c3f-aa7000a837d6	Over 1.5	Over	active	2.3		\N		1	2	Over 1.5	5026346_12110592_46430208
787d6fa4-5db6-42ed-a57f-aa7000a8380b	7aabee49-3818-4184-9b09-aa7000a837fd	Under 1	Under	active	2.16		\N		1	1	Under 1	5026346_12110580_46430174
e9d9449a-6e22-4e91-8223-aa7000a8381a	7aabee49-3818-4184-9b09-aa7000a837fd	Over 1	Over	active	1.57		\N		1	2	Over 1	5026346_12110580_46430171
2ae1cc1f-515b-4438-bbe1-aa7000a83839	1c114036-50f5-495c-912d-aa7000a83829	IFO Bromolla IF +0.5	AH	active	1.79		\N		1	1	IFO Bromolla IF +0.5	5026346_12110556_46430114
22d04ca7-f858-4f41-bbbc-aa7000a83847	1c114036-50f5-495c-912d-aa7000a83829	IFK Berga -0.5	BH	active	1.85		\N		1	2	IFK Berga -0.5	5026346_12110556_46430120
4d73dd29-1c1a-422c-8cad-aa7000a83863	3d3ab6ff-8367-4d3b-8fcd-aa7000a83853	No/No	NN	active	1.81		\N		1	1	No/No	5026346_12110424_46429817
dc304db6-0b4e-4a4d-956c-aa7000a83874	3d3ab6ff-8367-4d3b-8fcd-aa7000a83853	Yes/No	YN	active	5.5		\N		1	2	Yes/No	5026346_12110424_46429821
022a671a-5e91-4125-8c22-aa7000a8388a	3d3ab6ff-8367-4d3b-8fcd-aa7000a83853	Yes/Yes	YY	active	11.5		\N		1	3	Yes/Yes	5026346_12110424_46429825
84a98be5-85f3-482a-b9d6-aa7000a83898	3d3ab6ff-8367-4d3b-8fcd-aa7000a83853	No/Yes	NY	active	3.6		\N		2	1	No/Yes	5026346_12110424_46429830
ccd1c089-df20-4dbe-90dc-aa7000a838ce	482c67c0-111f-4596-971f-aa7000a838a6	Yes	Yes	active	1.97		\N		1	1	Yes	5026346_12110326_46429565
02d03564-224a-42d9-85d2-aa7000a838e5	482c67c0-111f-4596-971f-aa7000a838a6	No	No	active	1.69		\N		1	2	No	5026346_12110326_46429571
edc213ec-081f-4838-af62-aa7000a838ff	7bca39d7-79dc-4e68-9f13-aa7000a838f3	Under 3.5	Under	active	1.58		\N		1	1	Under 3.5	5026346_12110750_46430602
d34aba1f-11ef-4cc9-9fb2-aa7000a8390b	7bca39d7-79dc-4e68-9f13-aa7000a838f3	Over 3.5	Over	active	2.75		\N		1	2	Over 3.5	5026346_12110750_46430596
c7bf11b8-3847-498c-82e2-aa7000a83924	3d664944-a237-45b9-a658-aa7000a83917	Under 2.5	Under	active	2.41		\N		1	1	Under 2.5	5026346_12110737_46430570
fa345c8d-519d-46a2-a121-aa7000a83931	3d664944-a237-45b9-a658-aa7000a83917	Over 2.5	Over	active	1.71		\N		1	2	Over 2.5	5026346_12110737_46430566
402cb946-c4b9-4747-a223-aa7000a8394f	3a45aa7b-2c67-488e-bbf5-aa7000a83941	Under 1.5	Under	active	5.35		\N		1	1	Under 1.5	5026346_12110722_46430541
239f7361-a88f-4936-954c-aa7000a83967	3a45aa7b-2c67-488e-bbf5-aa7000a83941	Over 1.5	Over	active	1.23		\N		1	2	Over 1.5	5026346_12110722_46430537
df359c67-8728-4be1-abd7-aa7000a83989	b9481739-17e4-4e71-ab2c-aa7000a83978	Under 0.5	Under	active	18.25		\N		1	1	Under 0.5	5026346_12110709_46430509
a82698b3-478d-4165-bbf8-aa7000a83995	b9481739-17e4-4e71-ab2c-aa7000a83978	Over 0.5	Over	active	1.05		\N		1	2	Over 0.5	5026346_12110709_46430500
e38e0b4a-a72d-4c06-84ba-aa7000a839b0	d149a1aa-eefd-4b75-87cc-aa7000a839a4	Under 5.5	Under	active	1.09		\N		1	1	Under 5.5	5026346_12110697_46430476
dc5d6137-06fa-48aa-b1ca-aa7000a839c0	d149a1aa-eefd-4b75-87cc-aa7000a839a4	Over 5.5	Over	active	11.5		\N		1	2	Over 5.5	5026346_12110697_46430471
a488a214-2fbf-4887-8aeb-aa7000a839ef	f744431b-14a7-4d58-8bd3-aa7000a839d3	Under 4.5	Under	active	1.23		\N		1	1	Under 4.5	5026346_12110686_46430450
faf6df46-7534-4cbc-bc60-aa7000a839fd	f744431b-14a7-4d58-8bd3-aa7000a839d3	Over 4.5	Over	active	5.25		\N		1	2	Over 4.5	5026346_12110686_46430445
bb7d59da-d767-4309-b6bb-aa7000a83a25	2426ad85-170f-476e-8c99-aa7000a83a08	IFO Bromolla IF	A	active	3.4		\N		1	1	IFO Bromolla IF	5026346_12095217_46379412
4ad241c5-ea4c-4388-8129-aa7000a83a38	2426ad85-170f-476e-8c99-aa7000a83a08	Draw	X	active	3.6		\N		1	2	Draw	5026346_12095217_46379413
0f015703-5339-47b5-8787-aa7000a83a4c	2426ad85-170f-476e-8c99-aa7000a83a08	IFK Berga	B	active	1.89		\N		1	3	IFK Berga	5026346_12095217_46379415
c730b9f3-4a5b-4a35-a640-aa7000a83a67	3203e28d-47d1-4fc4-9ea5-aa7000a83a59	IFO Bromolla IF or Draw	AX	active	1.63		\N		1	1	IFO Bromolla IF or Draw	5026346_12095208_46379392
8a255b8b-9659-4aea-8b40-aa7000a83a74	3203e28d-47d1-4fc4-9ea5-aa7000a83a59	IFO Bromolla IF or IFK Berga	AB	active	1.21		\N		1	2	IFO Bromolla IF or IFK Berga	5026346_12095208_46379394
b0cee87a-dcaa-42f1-8b12-aa7000a83a81	3203e28d-47d1-4fc4-9ea5-aa7000a83a59	Draw or IFK Berga	BX	active	1.23		\N		1	3	Draw or IFK Berga	5026346_12095208_46379397
00bfa9cf-13b9-4b8e-9665-aa7000a83a9a	1aaf010c-b3ff-44f6-9a56-aa7000a83a8d	Yes	Yes	active	1.54		\N		1	1	Yes	5026346_12111726_46436330
73146d5a-ad47-47cb-97d4-aa7000a83aa9	1aaf010c-b3ff-44f6-9a56-aa7000a83a8d	No	No	active	2.23		\N		1	2	No	5026346_12111726_46436333
907313c7-c0d2-4c19-911a-aa7000a83ac3	b0838e65-7761-47c5-a4b3-aa7000a83ab5	IFO Bromolla IF +1	AH	active	1.82		\N		1	1	IFO Bromolla IF +1	5026346_12111539_46434818
c2449298-4e61-4880-8f17-aa7000a83acf	b0838e65-7761-47c5-a4b3-aa7000a83ab5	Draw sigendLine	XH	active	4.05		\N		1	2	Draw sigendLine	5026346_12111539_46434825
9602267d-c5f0-45d7-967d-aa7000a83add	b0838e65-7761-47c5-a4b3-aa7000a83ab5	IFK Berga -1	BH	active	3.3		\N		1	3	IFK Berga -1	5026346_12111539_46434828
dc341e3a-96b5-4677-a8e6-aa7000a83af9	d00015b9-e610-4813-9318-aa7000a83aec	IFO Bromolla IF +2	AH	active	1.29		\N		1	1	IFO Bromolla IF +2	5026346_12110663_46430403
3ab02feb-483d-4da3-94c2-aa7000a83b08	d00015b9-e610-4813-9318-aa7000a83aec	Draw sigendLine	XH	active	5.6		\N		1	2	Draw sigendLine	5026346_12110663_46430411
e35b60bf-72c4-4dc0-a773-aa7000a83b18	d00015b9-e610-4813-9318-aa7000a83aec	IFK Berga -2	BH	active	6.75		\N		1	3	IFK Berga -2	5026346_12110663_46430414
89ce93f8-bbcd-458a-aba0-aa7000a83b3e	b270e6b3-7cbf-4063-ae76-aa7000a83b2b	IFO Bromolla IF +1	AH	active	1.82		\N		1	1	IFO Bromolla IF +1	5026346_12110646_46430349
52876a43-4970-4278-81cb-aa7000a83b4f	b270e6b3-7cbf-4063-ae76-aa7000a83b2b	Draw sigendLine	XH	active	4.05		\N		1	2	Draw sigendLine	5026346_12110646_46430355
4bd99460-c3c4-4368-aec9-aa7000a83b5c	b270e6b3-7cbf-4063-ae76-aa7000a83b2b	IFK Berga -1	BH	active	3.3		\N		1	3	IFK Berga -1	5026346_12110646_46430358
906817cc-7a20-45aa-8518-aa7000a83b7d	ea815e8b-cff9-49b0-b0a4-aa7000a83b67	IFO Bromolla IF -1	AH	active	7.6		\N		1	1	IFO Bromolla IF -1	5026346_12110626_46430310
8a85b131-3835-4469-9165-aa7000a83b90	ea815e8b-cff9-49b0-b0a4-aa7000a83b67	Draw sigendLine	XH	active	5.45		\N		1	2	Draw sigendLine	5026346_12110626_46430314
3960ea93-cd2f-4862-95ef-aa7000a83ba0	ea815e8b-cff9-49b0-b0a4-aa7000a83b67	IFK Berga +1	BH	active	1.27		\N		1	3	IFK Berga +1	5026346_12110626_46430319
e3ec455b-413f-4112-8b6c-aa7000a83bba	8e89bdd8-0cd7-4758-9e44-aa7000a83bad	IFO Bromolla IF -2	AH	active	18.75		\N		1	1	IFO Bromolla IF -2	5026346_12110614_46430269
08549549-7393-4dfb-b88c-aa7000a83bc6	8e89bdd8-0cd7-4758-9e44-aa7000a83bad	Draw sigendLine	XH	active	9.15		\N		1	2	Draw sigendLine	5026346_12110614_46430276
1d1871c8-8eef-4ac3-b061-aa7000a83bd3	8e89bdd8-0cd7-4758-9e44-aa7000a83bad	IFK Berga +2	BH	active	1.07		\N		1	3	IFK Berga +2	5026346_12110614_46430281
e2d1dec8-7486-49e1-a4fc-aa7000a83bf0	10691b06-f504-448a-a514-aa7000a83be2	2-1	2-1	active	14.25		\N		1	1	2-1	5026346_12111270_46432941
c98f4899-5fc6-41fe-8ae7-aa7000a83bfe	10691b06-f504-448a-a514-aa7000a83be2	1-0	1-0	active	16		\N		1	2	1-0	5026346_12111270_46432948
4a2536e7-7ad4-41a0-8b3a-aa7000a83c0b	10691b06-f504-448a-a514-aa7000a83be2	2-0	2-0	active	25.5		\N		1	3	2-0	5026346_12111270_46432955
511713e7-1326-426a-bba7-aa7000a83c1a	10691b06-f504-448a-a514-aa7000a83be2	3-0	3-0	active	60		\N		2	1	3-0	5026346_12111270_46432963
4ca47cbc-c618-447a-89fc-aa7000a83c2b	10691b06-f504-448a-a514-aa7000a83be2	0-3	0-3	active	20.5		\N		2	2	0-3	5026346_12111270_46432970
92814804-6dfe-450a-b91b-aa7000a83c39	10691b06-f504-448a-a514-aa7000a83be2	Any Other	M1	active	25		\N		2	3	Any Other	5026346_12111270_46432973
9aa10d78-4290-4052-a214-aa7000a83c46	10691b06-f504-448a-a514-aa7000a83be2	3-1	3-1	active	35		\N		3	1	3-1	5026346_12111270_46432978
0b9e689f-4243-4ddc-a3f6-aa7000a83c53	10691b06-f504-448a-a514-aa7000a83be2	6-0	6-0	active	250		\N		3	2	6-0	5026346_12111270_46432986
676b1376-7bc0-4cb0-80fe-aa7000a83c61	10691b06-f504-448a-a514-aa7000a83be2	0-0	0-0	active	18.25		\N		3	3	0-0	5026346_12111270_46432994
4bf4aa88-6789-449a-8375-aa7000a83c6e	10691b06-f504-448a-a514-aa7000a83be2	1-4	1-4	active	35		\N		4	1	1-4	5026346_12111270_46432997
2776429e-9792-4abf-9b2a-aa7000a83c7b	10691b06-f504-448a-a514-aa7000a83be2	3-2	3-2	active	35		\N		4	2	3-2	5026346_12111270_46433004
b0618f90-4549-44f7-8cef-aa7000a83c8c	10691b06-f504-448a-a514-aa7000a83be2	2-2	2-2	active	14		\N		4	3	2-2	5026346_12111270_46433008
ed127f04-d3f4-4292-821e-aa7000a83ca1	10691b06-f504-448a-a514-aa7000a83be2	3-3	3-3	active	55		\N		5	1	3-3	5026346_12111270_46433013
852873f8-d7a9-4e62-9a26-aa7000a83cb3	10691b06-f504-448a-a514-aa7000a83be2	1-2	1-2	active	9.9		\N		5	2	1-2	5026346_12111270_46433020
970fd719-b562-4b13-af64-aa7000a83cc0	10691b06-f504-448a-a514-aa7000a83be2	0-6	0-6	active	250		\N		5	3	0-6	5026346_12111270_46433022
0f6914c9-495a-4321-9d67-aa7000a83cd3	10691b06-f504-448a-a514-aa7000a83be2	4-0	4-0	active	150		\N		6	1	4-0	5026346_12111270_46433030
eb4bc658-dcb5-40af-993a-aa7000a83ce9	10691b06-f504-448a-a514-aa7000a83be2	0-1	0-1	active	11.25		\N		6	2	0-1	5026346_12111270_46433034
9142331a-adc1-4e1c-91a2-aa7000a83d06	10691b06-f504-448a-a514-aa7000a83be2	4-1	4-1	active	100		\N		6	3	4-1	5026346_12111270_46433037
8c65f844-04da-44fc-a97f-aa7000a83d1a	10691b06-f504-448a-a514-aa7000a83be2	4-2	4-2	active	125		\N		7	1	4-2	5026346_12111270_46433044
e409de1a-e416-4474-8aeb-aa7000a83d2b	10691b06-f504-448a-a514-aa7000a83be2	5-0	5-0	active	250		\N		7	2	5-0	5026346_12111270_46433054
03776033-5c3f-4a7c-8c67-aa7000a83d3a	10691b06-f504-448a-a514-aa7000a83be2	0-2	0-2	active	12.5		\N		7	3	0-2	5026346_12111270_46433062
a4c1022c-3f8a-42b6-94b1-aa7000a83d49	10691b06-f504-448a-a514-aa7000a83be2	1-3	1-3	active	16.25		\N		8	1	1-3	5026346_12111270_46433067
a3e277d5-2942-483c-9735-aa7000a83d56	10691b06-f504-448a-a514-aa7000a83be2	1-1	1-1	active	8.1		\N		8	2	1-1	5026346_12111270_46433074
f009a25b-7bf2-40fa-b0cc-aa7000a83d63	10691b06-f504-448a-a514-aa7000a83be2	0-5	0-5	active	125		\N		8	3	0-5	5026346_12111270_46433082
1ddf865d-4726-4f79-bb37-aa7000a83d71	10691b06-f504-448a-a514-aa7000a83be2	5-1	5-1	active	250		\N		9	1	5-1	5026346_12111270_46433089
fb456d05-3a1d-4bc3-80ea-aa7000a83d80	10691b06-f504-448a-a514-aa7000a83be2	1-5	1-5	active	100		\N		9	2	1-5	5026346_12111270_46433093
2de2cbbe-2d73-487e-a673-aa7000a83d90	10691b06-f504-448a-a514-aa7000a83be2	2-3	2-3	active	26		\N		9	3	2-3	5026346_12111270_46433098
3b4cee15-3315-464b-97f0-aa7000a83da0	10691b06-f504-448a-a514-aa7000a83be2	2-4	2-4	active	55		\N		10	1	2-4	5026346_12111270_46433105
87a1e6e3-0a7e-43dc-9b19-aa7000a83db4	10691b06-f504-448a-a514-aa7000a83be2	0-4	0-4	active	45		\N		10	2	0-4	5026346_12111270_46433113
0f17e8e5-0546-4813-91ec-aa7000a83dd1	e316910c-598e-4de3-8c2c-aa7000a83dc3	Under 0.5	Under	active	1.97		\N		1	1	Under 0.5	5026346_12110318_46429544
6ddbc878-a1ed-4723-adf9-aa7000a83de0	e316910c-598e-4de3-8c2c-aa7000a83dc3	Over 0.5	Over	active	1.69		\N		1	2	Over 0.5	5026346_12110318_46429539
43a7d25d-978a-4650-854b-aa7000a83e0d	b61c58e6-d62b-4afc-86eb-aa7000a83df3	Under 0.5	Under	active	1.59		\N		1	1	Under 0.5	5026346_12110286_46429450
5a661554-2269-47a6-80e3-aa7000a83e1d	b61c58e6-d62b-4afc-86eb-aa7000a83df3	Over 0.5	Over	active	2.12		\N		1	2	Over 0.5	5026346_12110286_46429447
0a897b09-96c7-4e75-9d09-aa7000a83e38	c366da1b-903a-4688-ad4c-aa7000a83e2b	1-0	1-0	active	7.05		\N		1	1	1-0	5026346_12110948_46431232
c480b63b-2e15-44c5-a83d-aa7000a83e4f	c366da1b-903a-4688-ad4c-aa7000a83e2b	2-0	2-0	active	19.5		\N		1	2	2-0	5026346_12110948_46431237
0790fe51-a3c6-4503-9e86-aa7000a83e6d	c366da1b-903a-4688-ad4c-aa7000a83e2b	2-1	2-1	active	19.5		\N		1	3	2-1	5026346_12110948_46431243
1daa37a7-0316-463e-aad8-aa7000a83e7c	c366da1b-903a-4688-ad4c-aa7000a83e2b	0-0	0-0	active	5.2		\N		2	1	0-0	5026346_12110948_46431251
59a92a6f-4e50-4106-8e58-aa7000a83e91	c366da1b-903a-4688-ad4c-aa7000a83e2b	1-1	1-1	active	6.9		\N		2	2	1-1	5026346_12110948_46431253
40f5357c-a6f5-4ecd-88b5-aa7000a83ea0	c366da1b-903a-4688-ad4c-aa7000a83e2b	2-2	2-2	active	40		\N		2	3	2-2	5026346_12110948_46431259
652d125c-b93a-4230-b060-aa7000a83eae	c366da1b-903a-4688-ad4c-aa7000a83e2b	0-1	0-1	active	5.05		\N		3	1	0-1	5026346_12110948_46431261
44e6e045-abdc-48a4-8bd5-aa7000a83ebd	c366da1b-903a-4688-ad4c-aa7000a83e2b	0-2	0-2	active	9.8		\N		3	2	0-2	5026346_12110948_46431264
2ec6e4aa-0c6c-4ea9-8b8d-aa7000a83ecb	c366da1b-903a-4688-ad4c-aa7000a83e2b	1-2	1-2	active	14		\N		3	3	1-2	5026346_12110948_46431269
22becd6a-c452-4c58-a865-aa7000a83eda	c366da1b-903a-4688-ad4c-aa7000a83e2b	Any Other	M1	active	8.25		\N		4	1	Any Other	5026346_12110948_46431275
6e4549b9-71ea-4e21-b37b-aa7000a83efa	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	Any Other	M1	active	13.5		\N		1	1	Any Other	5026346_12110917_46431086
395e62e4-259e-4b1e-a5ac-aa7000a83f0c	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	1-0	1-0	active	6.5		\N		1	2	1-0	5026346_12110917_46431092
6d3dafaf-6345-4bac-92ae-aa7000a83f1c	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	2-0	2-0	active	22.5		\N		1	3	2-0	5026346_12110917_46431097
881023d4-49ac-4311-a885-aa7000a83f2a	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	2-1	2-1	active	27.5		\N		2	1	2-1	5026346_12110917_46431100
23204eb4-89ae-4952-bd9d-aa7000a83f37	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	0-0	0-0	active	3.45		\N		2	2	0-0	5026346_12110917_46431106
c75092aa-922e-40c7-b64c-aa7000a83f4e	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	1-1	1-1	active	8		\N		2	3	1-1	5026346_12110917_46431111
19308de4-e202-425a-b6f4-aa7000a83f61	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	2-2	2-2	active	70		\N		3	1	2-2	5026346_12110917_46431115
7e4774ce-1982-4e16-ac74-aa7000a83f71	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	0-1	0-1	active	4.6		\N		3	2	0-1	5026346_12110917_46431119
10270a1a-61a6-4871-9fdf-aa7000a83f81	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	0-2	0-2	active	11		\N		3	3	0-2	5026346_12110917_46431122
7ae0ea1e-3e9e-4031-9578-aa7000a83f91	b49086b5-2ef2-4950-a2d9-aa7000a83ee9	1-2	1-2	active	19.5		\N		4	1	1-2	5026346_12110917_46431127
403b7bc4-30f2-4e26-9871-aa7000a83fcc	10d81ac1-175f-4ede-9d32-aa7000a83fa8	IFO Bromolla IF/IFO Bromolla IF	A/A	active	7.3		\N		1	1	IFO Bromolla IF/IFO Bromolla IF	5026346_12110239_46429264
4d31a5bf-215e-473c-ba68-aa7000a844c4	c2284a44-bee7-4239-bc16-aa7000a8448b	3	3	active	4.2		\N		2	1	3	5026346_12111381_46433544
a35cf163-1a65-452c-b634-aa7000a83fdb	10d81ac1-175f-4ede-9d32-aa7000a83fa8	IFO Bromolla IF/Draw	A/X	active	17.5		\N		1	2	IFO Bromolla IF/Draw	5026346_12110239_46429273
4508b90d-6db5-400d-bf28-aa7000a83fe8	10d81ac1-175f-4ede-9d32-aa7000a83fa8	IFO Bromolla IF/IFK Berga	A/B	active	28.5		\N		1	3	IFO Bromolla IF/IFK Berga	5026346_12110239_46429282
361b6188-d73a-4fb0-a98d-aa7000a83ff5	10d81ac1-175f-4ede-9d32-aa7000a83fa8	Draw/IFO Bromolla IF	X/A	active	10.25		\N		2	1	Draw/IFO Bromolla IF	5026346_12110239_46429267
5904726e-0e78-40a3-9b84-aa7000a84002	10d81ac1-175f-4ede-9d32-aa7000a83fa8	Draw/Draw	X/X	active	7.5		\N		2	2	Draw/Draw	5026346_12110239_46429276
0fc49e93-b026-410d-93ff-aa7000a84011	10d81ac1-175f-4ede-9d32-aa7000a83fa8	Draw/IFK Berga	X/B	active	6.05		\N		2	3	Draw/IFK Berga	5026346_12110239_46429285
e4209b30-25b3-4c81-8dab-aa7000a8401d	10d81ac1-175f-4ede-9d32-aa7000a83fa8	IFK Berga/IFO Bromolla IF	B/A	active	40		\N		3	1	IFK Berga/IFO Bromolla IF	5026346_12110239_46429270
9e714dd8-5c3a-42f2-8a0e-aa7000a84029	10d81ac1-175f-4ede-9d32-aa7000a83fa8	IFK Berga/Draw	B/X	active	17		\N		3	2	IFK Berga/Draw	5026346_12110239_46429279
4a9614ed-7b7f-4a04-97a7-aa7000a84037	10d81ac1-175f-4ede-9d32-aa7000a83fa8	IFK Berga/IFK Berga	B/B	active	3.45		\N		3	3	IFK Berga/IFK Berga	5026346_12110239_46429291
164f87fc-7e71-4d0b-be53-aa7000a84054	f2a7764a-c0e3-4e4b-92d6-aa7000a84044	Ifo Bromolla If	A	active	3.9		\N		1	1	Ifo Bromolla If	5026346_12111721_46436306
583e602a-31fe-4657-9c8b-aa7000a84062	f2a7764a-c0e3-4e4b-92d6-aa7000a84044	Draw	X	active	2.31		\N		1	2	Draw	5026346_12111721_46436310
81b739f1-9eb5-4b48-a1ef-aa7000a8406f	f2a7764a-c0e3-4e4b-92d6-aa7000a84044	IFK Berga	B	active	2.44		\N		1	3	IFK Berga	5026346_12111721_46436313
377fb07a-ec64-432f-b18a-aa7000a84086	feac09d6-844b-4432-b522-aa7000a84078	IFO Bromolla IF or Draw	AX	active	1.4		\N		1	1	IFO Bromolla IF or Draw	5026346_12110890_46430955
9af3cd31-1911-48cd-ae51-aa7000a84093	feac09d6-844b-4432-b522-aa7000a84078	IFO Bromolla IF or IFK Berga	AB	active	1.44		\N		1	2	IFO Bromolla IF or IFK Berga	5026346_12110890_46430965
7c2b5ed6-5d7c-4a1a-bb0f-aa7000a840a1	feac09d6-844b-4432-b522-aa7000a84078	Draw or IFK Berga	BX	active	1.19		\N		1	3	Draw or IFK Berga	5026346_12110890_46430968
e775a5f0-e7f2-413b-9e13-aa7000a840c5	f5a46194-a5e9-4fa5-bde9-aa7000a840b3	Ifo Bromolla If	A	active	3.55		\N		1	1	Ifo Bromolla If	5026346_12111436_46433743
196b94e6-a40a-4bed-bac5-aa7000a840d4	f5a46194-a5e9-4fa5-bde9-aa7000a840b3	Draw	X	active	2.7		\N		1	2	Draw	5026346_12111436_46433748
38c37bed-f4ed-4247-98f8-aa7000a840e2	f5a46194-a5e9-4fa5-bde9-aa7000a840b3	IFK Berga	B	active	2.21		\N		1	3	IFK Berga	5026346_12111436_46433752
dc847829-f47c-49c6-b967-aa7000a840fc	3de36dd4-cbea-46a8-be3b-aa7000a840ee	IFO Bromolla IF or Draw	AX	active	1.47		\N		1	1	IFO Bromolla IF or Draw	5026346_12111410_46433629
b1490c41-aa52-41ba-b3d9-aa7000a84113	3de36dd4-cbea-46a8-be3b-aa7000a840ee	IFO Bromolla IF or IFK Berga	AB	active	1.33		\N		1	2	IFO Bromolla IF or IFK Berga	5026346_12111410_46433635
8c9c75d2-3c6b-4487-ab80-aa7000a84130	3de36dd4-cbea-46a8-be3b-aa7000a840ee	Draw or IFK Berga	BX	active	1.22		\N		1	3	Draw or IFK Berga	5026346_12111410_46433638
105c3407-03fa-4ce0-b2f0-aa7000a8414d	43efaa49-af8f-4370-8343-aa7000a8413e	Under 0.5	Under	active	2.39		\N		1	1	Under 0.5	5026346_12110407_46429784
1a1f6f9e-698c-4214-af2d-aa7000a8415d	43efaa49-af8f-4370-8343-aa7000a8413e	Over 0.5	Over	active	1.47		\N		1	2	Over 0.5	5026346_12110407_46429781
0e9a6630-419d-4256-a8cc-aa7000a8417a	8950c041-59a2-4147-93f3-aa7000a8416b	Ifo Bromolla If	A	active	1.79		\N		1	1	Ifo Bromolla If	5026346_12111167_46432294
c0b135fa-eb09-4e6b-86a9-aa7000a84189	8950c041-59a2-4147-93f3-aa7000a8416b	Draw	X	active	1.85		\N		1	2	Draw	5026346_12111167_46432298
e4e8d69c-dbf5-4235-b9fa-aa7000a841a8	8beaa90f-cf34-4f54-a580-aa7000a84197	Draw	X	active	2.55		\N		1	1	Draw	5026346_12111070_46431855
8f7bf54c-8be4-403c-aea9-aa7000a841b7	8beaa90f-cf34-4f54-a580-aa7000a84197	IFK Berga	B	active	1.41		\N		1	2	IFK Berga	5026346_12111070_46431859
4ecfcda9-8975-4ef6-a0dc-aa7000a841d4	d9638888-4e56-496f-857c-aa7000a841c7	Under 0.5	Under	active	1.85		\N		1	1	Under 0.5	5026346_12110383_46429720
e7beae69-0236-4e19-b1cf-aa7000a841e1	d9638888-4e56-496f-857c-aa7000a841c7	Over 0.5	Over	active	1.79		\N		1	2	Over 0.5	5026346_12110383_46429714
8f5b683d-a06d-43c9-97d3-aa7000a841fd	ca07abcb-c5f6-4f91-877c-aa7000a841ef	IFO Bromolla IF	A	active	2.9		\N		1	1	IFO Bromolla IF	5026346_12095213_46379403
2741de62-be48-41c2-8edd-aa7000a84222	ca07abcb-c5f6-4f91-877c-aa7000a841ef	IFK Berga	B	active	1.53		\N		1	2	IFK Berga	5026346_12095213_46379404
b3097ac9-aefe-4ced-a983-aa7000a84245	bbfd89ad-3dde-4d98-9670-aa7000a84237	Yes	Yes	active	3		\N		1	1	Yes	5026346_12111706_46436233
9e6e724a-52c0-4d99-830f-aa7000a84254	bbfd89ad-3dde-4d98-9670-aa7000a84237	No	No	active	1.3		\N		1	2	No	5026346_12111706_46436238
ba34e3ef-0df8-4613-9705-aa7000a84280	7a6659f8-e448-47bc-860f-aa7000a84260	Yes	Yes	active	4.55		\N		1	1	Yes	5026346_12111698_46436203
e596f60d-d9ba-465b-b9f6-aa7000a84294	7a6659f8-e448-47bc-860f-aa7000a84260	No	No	active	1.14		\N		1	2	No	5026346_12111698_46436209
863912f4-7878-48be-b805-aa7000a842b3	864bc62f-9ca9-472f-8679-aa7000a842a2	Yes	Yes	active	3.55		\N		1	1	Yes	5026346_12111186_46432382
a957f79b-997f-42ed-9235-aa7000a842c2	864bc62f-9ca9-472f-8679-aa7000a842a2	No	No	active	1.22		\N		1	2	No	5026346_12111186_46432389
88b3a569-8962-48a2-a16e-aa7000a842db	78a8eff1-1748-4b9e-9144-aa7000a842cf	Yes	Yes	active	5.9		\N		1	1	Yes	5026346_12111178_46432341
74464d83-5b5f-482d-b211-aa7000a842eb	78a8eff1-1748-4b9e-9144-aa7000a842cf	No	No	active	1.07		\N		1	2	No	5026346_12111178_46432347
c92c6a69-d612-48d7-a0e3-aa7000a84305	bc19d5c5-8315-4501-9b62-aa7000a842f7	Yes	Yes	active	3.45		\N		1	1	Yes	5026346_12111046_46431754
561e0348-7d67-48ef-bd10-aa7000a84312	bc19d5c5-8315-4501-9b62-aa7000a842f7	No	No	active	1.23		\N		1	2	No	5026346_12111046_46431761
52ce8e4d-5d44-4c2a-9fbd-aa7000a8432e	3f587055-37ba-4e77-8861-aa7000a8431e	Under 2.5	Under	active	1.13		\N		1	1	Under 2.5	5026346_12110790_46430685
85a9367e-de9d-49c3-a1ee-aa7000a8433c	3f587055-37ba-4e77-8861-aa7000a8431e	Over 2.5	Over	active	4.65		\N		1	2	Over 2.5	5026346_12110790_46430683
dd375e0c-5a24-44fb-b98f-aa7000a84358	ab3f2e12-9bd0-43bb-a56e-aa7000a8434c	Under 1.5	Under	active	1.52		\N		1	1	Under 1.5	5026346_12110776_46430656
cb38c472-5ee2-41da-94da-aa7000a84365	ab3f2e12-9bd0-43bb-a56e-aa7000a8434c	Over 1.5	Over	active	2.26		\N		1	2	Over 1.5	5026346_12110776_46430654
76168645-d827-4393-bf62-aa7000a84398	2bccceb8-e66e-4220-bd97-aa7000a84378	Under 0.5	Under	active	3.1		\N		1	1	Under 0.5	5026346_12110763_46430627
02f276e4-8537-47a8-9945-aa7000a843a8	2bccceb8-e66e-4220-bd97-aa7000a84378	Over 0.5	Over	active	1.29		\N		1	2	Over 0.5	5026346_12110763_46430624
2dd691f1-fc06-4225-b29b-aa7000a843d4	1b714eff-3ecc-4b34-bb28-aa7000a843b7	Yes	Yes	active	2.7		\N		1	1	Yes	5026346_12111157_46432256
c99b4dd9-e0fe-4be9-8600-aa7000a843f2	1b714eff-3ecc-4b34-bb28-aa7000a843b7	No	No	active	1.37		\N		1	2	No	5026346_12111157_46432260
8249a2cd-05bb-4be0-a8c0-aa7000a8440f	35082bfb-583c-441c-932f-aa7000a84402	Under 2.5	Under	active	1.24		\N		1	1	Under 2.5	5026346_12110826_46430777
a6d0da81-c28f-457b-99a2-aa7000a8441d	35082bfb-583c-441c-932f-aa7000a84402	Over 2.5	Over	active	3.4		\N		1	2	Over 2.5	5026346_12110826_46430774
f6f418b7-f1e2-4d96-9eb3-aa7000a8443b	ada6e91c-2714-45f2-8ec5-aa7000a8442b	Under 1.5	Under	active	1.86		\N		1	1	Under 1.5	5026346_12110814_46430742
04281fdc-57dc-4999-bbf3-aa7000a84449	ada6e91c-2714-45f2-8ec5-aa7000a8442b	Over 1.5	Over	active	1.78		\N		1	2	Over 1.5	5026346_12110814_46430739
86bef2df-7fe0-4084-92f1-aa7000a84469	e63175d8-f332-4294-b06c-aa7000a8445b	Under 0.5	Under	active	4.25		\N		1	1	Under 0.5	5026346_12110803_46430718
c9bded58-829d-4b52-abff-aa7000a8447c	e63175d8-f332-4294-b06c-aa7000a8445b	Over 0.5	Over	active	1.16		\N		1	2	Over 0.5	5026346_12110803_46430714
83d41869-d65a-4011-bba5-aa7000a84498	c2284a44-bee7-4239-bc16-aa7000a8448b	0	0	active	17.5		\N		1	1	0	5026346_12111381_46433526
fd9e384b-e2df-4d61-b8b9-aa7000a844a7	c2284a44-bee7-4239-bc16-aa7000a8448b	1	1	active	6.5		\N		1	2	1	5026346_12111381_46433533
203c4ea1-13db-43d0-be40-aa7000a844e7	c2284a44-bee7-4239-bc16-aa7000a8448b	4	4	active	5.25		\N		2	2	4	5026346_12111381_46433546
6a67c068-04b7-4abe-92af-aa7000a844f9	c2284a44-bee7-4239-bc16-aa7000a8448b	5	5	active	8.75		\N		2	3	5	5026346_12111381_46433551
7639e213-2e0f-426f-b627-aa7000a84506	c2284a44-bee7-4239-bc16-aa7000a8448b	6+	6+	active	9.9		\N		3	1	6+	5026346_12111381_46433557
33382a0d-6051-4286-8880-aa7000a84540	aaaee55c-a0f2-45c4-b2fd-aa7000a84514	0	0	active	3.35		\N		1	1	0	5026346_12110274_46429420
e5e2ce4f-0942-496c-89f0-aa7000a8455d	aaaee55c-a0f2-45c4-b2fd-aa7000a84514	1	1	active	2.65		\N		1	2	1	5026346_12110274_46429424
c629dffe-de93-475e-859a-aa7000a84575	aaaee55c-a0f2-45c4-b2fd-aa7000a84514	2+	2+	active	2.35		\N		1	3	2+	5026346_12110274_46429430
e86f42e7-b3b5-4e2d-9b08-aa7000a84592	5a568c5a-7b6d-4ee8-b43b-aa7000a84585	0	0	active	4.95		\N		1	1	0	5026346_12110296_46429509
efd953c9-d25f-4764-8f40-aa7000a845a9	5a568c5a-7b6d-4ee8-b43b-aa7000a84585	1	1	active	2.9		\N		1	2	1	5026346_12110296_46429514
3cd21569-9ce7-4e8d-87f8-aa7000a845bd	5a568c5a-7b6d-4ee8-b43b-aa7000a84585	2+	2+	active	1.81		\N		1	3	2+	5026346_12110296_46429519
a0eef291-4b77-4160-a667-aa7000a845e1	3a2bfbcd-7b66-4a74-9329-aa7000a845cf	Odd	Odd	active	1.86		\N		1	1	Odd	5026346_12110245_46429316
9873ec4d-fe43-47da-9d12-aa7000a845f1	3a2bfbcd-7b66-4a74-9329-aa7000a845cf	Even	Even	active	1.78		\N		1	2	Even	5026346_12110245_46429320
733bf105-5be1-4d76-89cb-aa7000a8460a	08c9fe47-1b58-4c9d-86c4-aa7000a845fd	Odd	Odd	active	1.97		\N		1	1	Odd	5026346_12111628_46435712
4ff717b0-1b44-480e-a8cc-aa7000a84616	08c9fe47-1b58-4c9d-86c4-aa7000a845fd	Even	Even	active	1.69		\N		1	2	Even	5026346_12111628_46435716
d41008b1-58bc-42fe-b6e2-aa7000a84638	b9f0af0d-2d48-4578-87b3-aa7000a84626	Odd	Odd	active	1.87		\N		1	1	Odd	5026346_12111350_46433422
d033c08f-eaeb-4ddb-9679-aa7000a8464a	b9f0af0d-2d48-4578-87b3-aa7000a84626	Even	Even	active	1.77		\N		1	2	Even	5026346_12111350_46433428
4cd346f5-42d1-4e98-a831-aa7000a84677	6073b6fb-4f86-4aa1-af6b-aa7000a84669	Yes	Yes	active	3.8		\N		1	1	Yes	5026346_12110465_46429922
c376c385-11a7-489e-813d-aa7000a84686	6073b6fb-4f86-4aa1-af6b-aa7000a84669	No	No	active	1.2		\N		1	2	No	5026346_12110465_46429928
1f1bf871-e899-4f2a-a0a7-aa7000a846b0	ac87ced2-a0b2-44a1-b5be-aa7000a846a1	Yes	Yes	active	2.53		\N		1	1	Yes	5026346_12110839_46430801
48bc33f5-d7b4-4c16-87a7-aa7000a846c0	ac87ced2-a0b2-44a1-b5be-aa7000a846a1	No	No	active	1.42		\N		1	2	No	5026346_12110839_46430805
ed5821de-bcea-4c6e-9762-aa7000a846de	8ef0ade3-0c16-43c2-ae64-aa7000a846cf	Under 1.5	Under	active	1.94		\N		1	1	Under 1.5	5026346_12110357_46429649
183c56f1-c52f-400d-8d1d-aa7000a846ed	8ef0ade3-0c16-43c2-ae64-aa7000a846cf	Over 1.5	Over	active	1.71		\N		1	2	Over 1.5	5026346_12110357_46429645
6bfe93f5-8f7f-4da8-9b35-aa7000a8470c	fca4c349-3a05-463e-8dcf-aa7000a846fc	Under 1.5	Under	active	1.45		\N		1	1	Under 1.5	5026346_12110397_46429755
f17cd90a-ac5b-478c-979f-aa7000a84722	fca4c349-3a05-463e-8dcf-aa7000a846fc	Over 1.5	Over	active	2.44		\N		1	2	Over 1.5	5026346_12110397_46429752
88eaeacd-6585-4a05-81dc-aa7000a84742	45a65a93-b802-4320-8fcc-aa7000a84731	0	0	active	5.4		\N		1	1	0	5026346_12110267_46429374
ad74bf96-ed61-463d-8ff1-aa7000a8474f	45a65a93-b802-4320-8fcc-aa7000a84731	1	1	active	3.05		\N		1	2	1	5026346_12110267_46429378
b0c0b017-5d85-4fae-831c-aa7000a8475e	45a65a93-b802-4320-8fcc-aa7000a84731	2	2	active	3.4		\N		1	3	2	5026346_12110267_46429384
f5a094ad-e810-4deb-bf61-aa7000a8476c	45a65a93-b802-4320-8fcc-aa7000a84731	3+	3+	active	3.4		\N		2	1	3+	5026346_12110267_46429386
d06d0358-2741-4959-a2fd-aa7000a8478b	0a486951-b543-4043-a75c-aa7000a8477c	0	0	active	3.25		\N		1	1	0	5026346_12110257_46429343
c8c0f504-bf7a-4a5c-8259-aa7000a8479b	0a486951-b543-4043-a75c-aa7000a8477c	1	1	active	2.56		\N		1	2	1	5026346_12110257_46429348
59892953-d32a-4b53-9ed7-aa7000a847a9	0a486951-b543-4043-a75c-aa7000a8477c	2	2	active	4		\N		1	3	2	5026346_12110257_46429350
c9da206a-1c8c-4de4-bc22-aa7000a847be	0a486951-b543-4043-a75c-aa7000a8477c	3+	3+	active	6.7		\N		2	1	3+	5026346_12110257_46429352
65f3847c-44dd-4ad0-af12-aa7000a847eb	1558ff2f-703e-4ea1-a2bb-aa7000a847d2	0-1	R_0-1	active	4.7		\N		1	1	0-1	5026346_12110878_46430913
a74bb3ae-b766-46e3-8ca5-aa7000a8480c	1558ff2f-703e-4ea1-a2bb-aa7000a847d2	2-3	R_2-3	active	2.1		\N		1	2	2-3	5026346_12110878_46430917
17e73932-6495-46f5-ac9b-aa7000a8481e	1558ff2f-703e-4ea1-a2bb-aa7000a847d2	4-5	R_4-5	active	3.25		\N		1	3	4-5	5026346_12110878_46430924
a43e4d5f-76a5-406b-9f7f-aa7000a8482c	1558ff2f-703e-4ea1-a2bb-aa7000a847d2	6+	6+	active	9.6		\N		2	1	6+	5026346_12110878_46430907
ea4c012b-1cb6-4cb8-b011-aa7000a84849	e419db2a-0952-4b15-ba7b-aa7000a8483b	1st Half	H1	active	3.05		\N		1	1	1st Half	5026346_12111058_46431809
08b304ee-c9a1-4d74-808a-aa7000a84857	e419db2a-0952-4b15-ba7b-aa7000a8483b	2nd	H2	active	1.99		\N		1	2	2nd	5026346_12111058_46431817
48f13302-d9a4-4170-bf88-aa7000a84865	e419db2a-0952-4b15-ba7b-aa7000a8483b	Equal	Equal	active	3.7		\N		1	3	Equal	5026346_12111058_46431823
c2e6e98d-8d1f-4179-8a11-aa7000a84882	e6cba78f-9f15-404d-88bd-aa7000a84874	IFO Bromolla IF +1	AH	active	1.52		\N		1	1	IFO Bromolla IF +1	5026346_12110343_46429613
5225feb1-e2fd-4e86-bc65-aa7000a84891	e6cba78f-9f15-404d-88bd-aa7000a84874	Draw sigendLine	XH	active	3.5		\N		1	2	Draw sigendLine	5026346_12110343_46429617
aeb88268-3338-4c52-806e-aa7000a848a5	e6cba78f-9f15-404d-88bd-aa7000a84874	IFK Berga -1	BH	active	6.35		\N		1	3	IFK Berga -1	5026346_12110343_46429622
743b4f74-6aac-4987-bb81-aa7000a848c6	504ea9c1-894b-4460-aa7c-aa7000a848b6	Yes	Yes	active	8.25		\N		1	1	Yes	5026346_12110442_46429852
213dcea1-0155-44e9-8043-aa7000a848d5	504ea9c1-894b-4460-aa7c-aa7000a848b6	No	No	active	1.02		\N		1	2	No	5026346_12110442_46429857
d8c4c1a8-e391-43e8-83f2-aa7000a848f5	a04c557e-a3ba-4628-af65-aa7000a848e6	Yes	Yes	active	2.85		\N		1	1	Yes	5026346_12110862_46430870
6429c118-4667-480d-aac3-aa7000a84901	a04c557e-a3ba-4628-af65-aa7000a848e6	No	No	active	1.33		\N		1	2	No	5026346_12110862_46430875
e499fcd4-662e-4d1c-a674-aa7000a84926	29fa23d7-8d2a-470d-aaba-aa7000a84914	Yes	Yes	active	3.9		\N		1	1	Yes	5026346_12110850_46430834
a2b74aa8-b05b-43cc-a63b-aa7000a8493a	29fa23d7-8d2a-470d-aaba-aa7000a84914	No	No	active	1.18		\N		1	2	No	5026346_12110850_46430839
0814f06a-26ba-45d9-9fae-aa7000a84976	c359fc7c-7e50-4f9a-a3d6-aa7000a8495c	IFO Bromolla IF and Under 4.5	AUnder	active	4.4		\N		1	1	IFO Bromolla IF and Under 4.5	5026346_12111081_46431920
c131e850-10e3-405f-b1e8-aa7000a84986	c359fc7c-7e50-4f9a-a3d6-aa7000a8495c	Draw and Under 4.5	XUnder	active	3.95		\N		1	2	Draw and Under 4.5	5026346_12111081_46431926
f3fbf36f-9bdc-463c-9d70-aa7000a8499b	c359fc7c-7e50-4f9a-a3d6-aa7000a8495c	IFK Berga and Under 4.5	BUnder	active	2.5		\N		1	3	IFK Berga and Under 4.5	5026346_12111081_46431930
4a413091-3e06-4370-99e0-aa7000a849ab	c359fc7c-7e50-4f9a-a3d6-aa7000a8495c	IFO Bromolla IF and Over 4.5	AOver	active	16		\N		2	1	IFO Bromolla IF and Over 4.5	5026346_12111081_46431936
d392b7fc-08a2-4b0f-bd42-aa7000a849b8	c359fc7c-7e50-4f9a-a3d6-aa7000a8495c	Draw and Over 4.5	XOver	active	45		\N		2	2	Draw and Over 4.5	5026346_12111081_46431943
a727c56e-9a54-467f-9184-aa7000a849c8	c359fc7c-7e50-4f9a-a3d6-aa7000a8495c	IFK Berga and Over 4.5	BOver	active	7.45		\N		2	3	IFK Berga and Over 4.5	5026346_12111081_46431950
0b426293-038f-4f53-abdf-aa7000a849ee	2a5d3316-5aca-4322-b221-aa7000a849d8	IFO Bromolla IF and Under 2.5	AUnder	active	9.6		\N		1	1	IFO Bromolla IF and Under 2.5	5026346_12111123_46432111
4fef136c-e59f-4157-9b4f-aa7000a84a02	2a5d3316-5aca-4322-b221-aa7000a849d8	Draw and Under 2.5	XUnder	active	5.45		\N		1	2	Draw and Under 2.5	5026346_12111123_46432115
46cfd1b8-76ed-4c10-b25a-aa7000a84a12	2a5d3316-5aca-4322-b221-aa7000a849d8	IFK Berga and Under 2.5	BUnder	active	5.75		\N		1	3	IFK Berga and Under 2.5	5026346_12111123_46432118
a641847c-e048-4f53-b94d-aa7000a84a21	2a5d3316-5aca-4322-b221-aa7000a849d8	IFO Bromolla IF and Over 2.5	AOver	active	5.45		\N		2	1	IFO Bromolla IF and Over 2.5	5026346_12111123_46432121
85115041-4106-4eff-98ef-aa7000a84a32	2a5d3316-5aca-4322-b221-aa7000a849d8	Draw and Over 2.5	XOver	active	10.5		\N		2	2	Draw and Over 2.5	5026346_12111123_46432133
ecfa481c-4236-4fbe-b26d-aa7000a84a42	2a5d3316-5aca-4322-b221-aa7000a849d8	IFK Berga and Over 2.5	BOver	active	2.75		\N		2	3	IFK Berga and Over 2.5	5026346_12111123_46432137
bbd2073c-9c1f-46c6-a885-aa7000a84a62	b1cca54a-17a2-4496-ad18-aa7000a84a52	IFO Bromolla IF and Under 3.5	AUnder	active	5.25		\N		1	1	IFO Bromolla IF and Under 3.5	5026346_12111142_46432198
747e3128-77c3-41f6-961a-aa7000a84ac6	b1cca54a-17a2-4496-ad18-aa7000a84a52	Draw and Under 3.5	XUnder	active	5.5		\N		1	2	Draw and Under 3.5	5026346_12111142_46432201
84707773-c5d8-446b-836b-aa7000a84ae1	b1cca54a-17a2-4496-ad18-aa7000a84a52	IFK Berga and Under 3.5	BUnder	active	3.15		\N		1	3	IFK Berga and Under 3.5	5026346_12111142_46432206
a76e3e9c-e52f-499a-9670-aa7000a84aef	b1cca54a-17a2-4496-ad18-aa7000a84a52	IFO Bromolla IF and Over 3.5	AOver	active	10.25		\N		2	1	IFO Bromolla IF and Over 3.5	5026346_12111142_46432213
88f595f7-a88f-4e77-a986-aa7000a84aff	b1cca54a-17a2-4496-ad18-aa7000a84a52	Draw and Over 3.5	XOver	active	10.5		\N		2	2	Draw and Over 3.5	5026346_12111142_46432218
f1885c56-0bd2-41b3-b7e6-aa7000a84b0f	b1cca54a-17a2-4496-ad18-aa7000a84a52	IFK Berga and Over 3.5	BOver	active	4.65		\N		2	3	IFK Berga and Over 3.5	5026346_12111142_46432221
217e0e74-0509-437e-8073-aa7000a84b32	9222f643-daf2-4ccb-8f87-aa7000a84b22	IFO Bromolla IF and Under 1.5	AUnder	active	15.25		\N		1	1	IFO Bromolla IF and Under 1.5	5026346_12111103_46432013
bf7d28a3-4a87-4f43-b254-aa7000a84b44	9222f643-daf2-4ccb-8f87-aa7000a84b22	Draw and Under 1.5	XUnder	active	17.25		\N		1	2	Draw and Under 1.5	5026346_12111103_46432019
cdf6ecac-652b-421e-94a1-aa7000a84b53	9222f643-daf2-4ccb-8f87-aa7000a84b22	IFK Berga and Under 1.5	BUnder	active	10.75		\N		1	3	IFK Berga and Under 1.5	5026346_12111103_46432026
4e96f410-c4b0-41ca-aef5-aa7000a84b61	9222f643-daf2-4ccb-8f87-aa7000a84b22	IFO Bromolla IF and Over 1.5	AOver	active	4.45		\N		2	1	IFO Bromolla IF and Over 1.5	5026346_12111103_46432036
fdc162ae-f876-46b8-abd2-aa7000a84b70	9222f643-daf2-4ccb-8f87-aa7000a84b22	Draw and Over 1.5	XOver	active	4.55		\N		2	2	Draw and Over 1.5	5026346_12111103_46432042
9b080f87-022f-46ad-9d4c-aa7000a84b80	9222f643-daf2-4ccb-8f87-aa7000a84b22	IFK Berga and Over 1.5	BOver	active	2.28		\N		2	3	IFK Berga and Over 1.5	5026346_12111103_46432044
e88af3bf-7c60-409f-a73d-aa7000a84ba3	72bc4dfe-8d83-4861-a9ba-aa7000a84b94	1st Half	H1	active	3.6		\N		1	1	1st Half	5026346_12111229_46432618
4f31d64f-d20b-4748-9833-aa7000a84bb3	72bc4dfe-8d83-4861-a9ba-aa7000a84b94	2nd	H2	active	2.62		\N		1	2	2nd	5026346_12111229_46432624
26e18243-a075-453b-9c25-aa7000a84bbf	72bc4dfe-8d83-4861-a9ba-aa7000a84b94	Equal	Equal	active	2.28		\N		1	3	Equal	5026346_12111229_46432632
3a0852c1-fa83-4088-a976-aa7000a84be5	6c382bc3-7569-4e94-bfd3-aa7000a84bd1	Yes	Yes	active	2.1		\N		1	1	Yes	5026346_12110454_46429883
07ca474e-ea41-47a0-90ba-aa7000a84bf8	6c382bc3-7569-4e94-bfd3-aa7000a84bd1	No	No	active	1.61		\N		1	2	No	5026346_12110454_46429888
4be06733-a505-4b61-8414-aa7000a84c27	b1bfa6be-999f-47d8-9f17-aa7000a84c0b	IFO Bromolla IF/Yes	AYes	active	6.2		\N		1	1	IFO Bromolla IF/Yes	5026346_12111636_46435770
35a91633-119d-4c36-9942-aa7000a84c41	b1bfa6be-999f-47d8-9f17-aa7000a84c0b	Draw/Yes	XYes	active	4.55		\N		1	2	Draw/Yes	5026346_12111636_46435778
65a607ca-e566-42b1-9b9b-aa7000a84c50	b1bfa6be-999f-47d8-9f17-aa7000a84c0b	IFK Berga/Yes	BYes	active	3.55		\N		1	3	IFK Berga/Yes	5026346_12111636_46435790
24e45d0f-decb-405f-8a8f-aa7000a84c5f	b1bfa6be-999f-47d8-9f17-aa7000a84c0b	IFO Bromolla IF/No	ANo	active	7.85		\N		2	1	IFO Bromolla IF/No	5026346_12111636_46435773
be6bc13d-3d63-4813-b98c-aa7000a84c70	b1bfa6be-999f-47d8-9f17-aa7000a84c0b	Draw/No	XNo	active	17.75		\N		2	2	Draw/No	5026346_12111636_46435784
32ac43f6-bc91-4ea4-8973-aa7000a84c80	b1bfa6be-999f-47d8-9f17-aa7000a84c0b	IFK Berga/No	BNo	active	3.95		\N		2	3	IFK Berga/No	5026346_12111636_46435795
24aab0a6-84cd-44c8-91ec-aa7000a84ca4	26317c99-113c-4a7a-84d7-aa7000a84c91	IFO Bromolla IF by exactly 1	A1	active	5.95		\N		1	1	IFO Bromolla IF by exactly 1	5026346_12111690_46436158
c513e21a-ee2d-4b32-9fcb-aa7000a84cb4	26317c99-113c-4a7a-84d7-aa7000a84c91	Draw	X	active	3.7		\N		1	2	Draw	5026346_12111690_46436142
9bf6279a-3df7-4ebc-b409-aa7000a84cc4	26317c99-113c-4a7a-84d7-aa7000a84c91	IFK Berga by exactly 1	B1	active	4.2		\N		1	3	IFK Berga by exactly 1	5026346_12111690_46436164
505aaa8f-c7c4-460b-981b-aa7000a84cd2	26317c99-113c-4a7a-84d7-aa7000a84c91	IFO Bromolla IF by exactly 2	A2	active	12.25		\N		2	1	IFO Bromolla IF by exactly 2	5026346_12111690_46436152
0c8e1e92-fde9-491f-968d-aa7000a84ce0	26317c99-113c-4a7a-84d7-aa7000a84c91	IFK Berga by exactly 2	B2	active	6.05		\N		2	3	IFK Berga by exactly 2	5026346_12111690_46436169
a82e36ab-7523-4483-805a-aa7000a84cf0	26317c99-113c-4a7a-84d7-aa7000a84c91	IFO Bromolla IF by greater than 2	A>2	active	25		\N		3	1	IFO Bromolla IF by greater than 2	5026346_12111690_46436148
72704f0c-c726-4bec-9609-aa7000a84d00	26317c99-113c-4a7a-84d7-aa7000a84c91	IFK Berga by greater than 2	B>2	active	7.35		\N		3	3	IFK Berga by greater than 2	5026346_12111690_46436172
7ec4271a-1c3c-482d-b311-aa7000a84d22	8defc450-86c7-4d63-8169-aa7000a84d11	Yes	Yes	active	1.44		\N		1	1	Yes	5026346_12110501_46429991
c6a4b8ab-12c3-4f79-ba5e-aa7000a84d38	8defc450-86c7-4d63-8169-aa7000a84d11	No	No	active	2.46		\N		1	2	No	5026346_12110501_46429998
67344064-54ed-401e-b177-aa7000a84d61	1ee20b8c-78a8-4701-ac26-aa7000a84d4c	IFO Bromolla IF/Draw  Under 3.5	AXUnder	active	2.52		\N		1	1	IFO Bromolla IF/Draw  Under 3.5	5026346_12111029_46431672
15ab99e4-9641-494c-a4ca-aa7000a84d7a	1ee20b8c-78a8-4701-ac26-aa7000a84d4c	IFO Bromolla IF/IFK Berga - Under 3.5	ABUnder	active	1.89		\N		1	2	IFO Bromolla IF/IFK Berga - Under 3.5	5026346_12111029_46431681
8352364f-16e9-48a5-b366-aa7000a84d94	1ee20b8c-78a8-4701-ac26-aa7000a84d4c	Draw/IFK Berga  Under 3.5	XBUnder	active	1.92		\N		1	3	Draw/IFK Berga  Under 3.5	5026346_12111029_46431686
67075d04-6497-4810-9c6a-aa7000a84db0	1ee20b8c-78a8-4701-ac26-aa7000a84d4c	IFO Bromolla IF/Draw  Over 3.5	AXOver	active	4.6		\N		2	1	IFO Bromolla IF/Draw  Over 3.5	5026346_12111029_46431700
f21def4a-fa00-401f-9649-aa7000a84dbf	1ee20b8c-78a8-4701-ac26-aa7000a84d4c	IFO Bromolla IF/IFK Berga  Over 3.5	ABOver	active	2.95		\N		2	2	IFO Bromolla IF/IFK Berga  Over 3.5	5026346_12111029_46431704
f669232f-58a8-4cf9-aecb-aa7000a84dce	1ee20b8c-78a8-4701-ac26-aa7000a84d4c	Draw/IFK Berga  Over 3.5	XBOver	active	2.95		\N		2	3	Draw/IFK Berga  Over 3.5	5026346_12111029_46431707
3933f8f1-e8f2-47de-97cb-aa7000a84e1d	05924d5f-3f5c-43d3-bd15-aa7000a84de0	0	MR_0	active	9.45		\N		1	1	0	5026346_12111309_46433232
dd0e65f0-3c52-4bcf-963c-aa7000a84e2f	05924d5f-3f5c-43d3-bd15-aa7000a84de0	1-2	MR_1-2	active	1.99		\N		1	2	1-2	5026346_12111309_46433224
4554ef0d-8a34-426c-ae5b-aa7000a84e42	05924d5f-3f5c-43d3-bd15-aa7000a84de0	1-3	MR_1-3	active	1.42		\N		1	3	1-3	5026346_12111309_46433237
2540fb84-cd53-4f26-a618-aa7000a84e52	05924d5f-3f5c-43d3-bd15-aa7000a84de0	1-4	MR_1-4	active	1.18		\N		2	1	1-4	5026346_12111309_46433245
2cf086cd-acaf-4757-82ef-aa7000a84e60	05924d5f-3f5c-43d3-bd15-aa7000a84de0	1-5	MR_1-5	active	1.09		\N		2	2	1-5	5026346_12111309_46433250
bc911863-2b36-4930-94b1-aa7000a84e70	05924d5f-3f5c-43d3-bd15-aa7000a84de0	1-6	MR_1-6	active	1.05		\N		2	3	1-6	5026346_12111309_46433257
8b029ac3-11a9-46af-9f22-aa7000a84e80	05924d5f-3f5c-43d3-bd15-aa7000a84de0	2-3	MR_2-3	active	1.71		\N		3	1	2-3	5026346_12111309_46433263
6081b1b9-0910-423e-857a-aa7000a84e92	05924d5f-3f5c-43d3-bd15-aa7000a84de0	2-4	MR_2-4	active	1.35		\N		3	2	2-4	5026346_12111309_46433281
52639df4-4b25-4583-b513-aa7000a84eaa	05924d5f-3f5c-43d3-bd15-aa7000a84de0	2-5	MR_2-5	active	1.22		\N		3	3	2-5	5026346_12111309_46433292
0d478c72-3a25-43ce-bdbd-aa7000a84ebf	05924d5f-3f5c-43d3-bd15-aa7000a84de0	2-6	MR_2-6	active	1.16		\N		4	1	2-6	5026346_12111309_46433310
aaaf518d-0dbf-48cd-8c60-aa7000a84ed1	05924d5f-3f5c-43d3-bd15-aa7000a84de0	3-4	MR_3-4	active	1.88		\N		4	2	3-4	5026346_12111309_46433336
5b5ff3a7-aaec-49d9-9beb-aa7000a84efb	05924d5f-3f5c-43d3-bd15-aa7000a84de0	3-5	MR_3-5	active	1.59		\N		4	3	3-5	5026346_12111309_46433300
9ad2bab9-d10d-41bf-930f-aa7000a84f10	05924d5f-3f5c-43d3-bd15-aa7000a84de0	3-6	MR_3-6	active	1.48		\N		5	1	3-6	5026346_12111309_46433321
3a72b79f-3535-4bab-8427-aa7000a84f1f	05924d5f-3f5c-43d3-bd15-aa7000a84de0	4-5	MR_4-5	active	2.46		\N		5	2	4-5	5026346_12111309_46433328
556dca7e-51b4-4ceb-8b85-aa7000a84f2e	05924d5f-3f5c-43d3-bd15-aa7000a84de0	4-6	MR_4-6	active	2.14		\N		5	3	4-6	5026346_12111309_46433272
0c9a72f1-5dcb-4f05-957b-aa7000a84f3f	05924d5f-3f5c-43d3-bd15-aa7000a84de0	5-6	MR_5-6	active	3.9		\N		6	2	5-6	5026346_12111309_46433305
cad048bd-ac59-4a72-8034-aa7000a84f4f	05924d5f-3f5c-43d3-bd15-aa7000a84de0	7+	MR_7+	active	12		\N		6	3	7+	5026346_12111309_46433285
19dcce86-a6f5-4ee7-a3fb-aa7000a84f73	21c26772-6738-4d39-b7c1-aa7000a84f63	Ifo Bromolla If	A	active	2.33		\N		1	1	Ifo Bromolla If	5026346_12111399_46433592
b8fdea0c-a838-4116-a9f6-aa7000a84f84	21c26772-6738-4d39-b7c1-aa7000a84f63	IFK Berga	B	active	1.49		\N		1	2	IFK Berga	5026346_12111399_46433596
bde59fde-f09e-4b04-97c3-aa7000a84fa4	ca1eb805-93d4-4dae-8949-aa7000a84f94	IFO Bromolla IF/Draw and No	AXNo	active	2.22		\N		1	1	IFO Bromolla IF/Draw and No	5026346_12111471_46433951
82069251-58e1-4e85-9a67-aa7000a84fb5	ca1eb805-93d4-4dae-8949-aa7000a84f94	IFO Bromolla IF/IFK Berga and Yes	ABYes	active	4.6		\N		1	2	IFO Bromolla IF/IFK Berga and Yes	5026346_12111471_46433956
97aef06a-1de0-4537-b0e7-aa7000a84fc7	ca1eb805-93d4-4dae-8949-aa7000a84f94	Draw/IFK Berga and Yes	BXYes	active	4.4		\N		1	3	Draw/IFK Berga and Yes	5026346_12111471_46433967
55a76bdc-e12a-45bc-96dc-aa7000a84fd8	ca1eb805-93d4-4dae-8949-aa7000a84f94	IFO Bromolla IF/IFK Berga and No	ABNo	active	1.55		\N		2	2	IFO Bromolla IF/IFK Berga and No	5026346_12111471_46433961
4a63baf6-8a63-4367-bc38-aa7000a84fe8	ca1eb805-93d4-4dae-8949-aa7000a84f94	Draw/IFK Berga and No	BXNo	active	1.59		\N		2	3	Draw/IFK Berga and No	5026346_12111471_46433973
ea0c8c3e-c47a-41ca-a70b-aa7000a8500f	9b686565-3f24-4585-83cc-aa7000a84ffc	IFO Bromolla IF/Draw and No	AXNo	active	2.54		\N		1	1	IFO Bromolla IF/Draw and No	5026346_12111481_46434079
e71902fe-54cb-472e-b249-aa7000a85024	9b686565-3f24-4585-83cc-aa7000a84ffc	IFO Bromolla IF/IFK Berga and Yes	ABYes	active	3.55		\N		1	2	IFO Bromolla IF/IFK Berga and Yes	5026346_12111481_46434082
966b130f-fcc6-4796-8897-aa7000a85036	9b686565-3f24-4585-83cc-aa7000a84ffc	Draw/IFK Berga and Yes	BXYes	active	3.4		\N		1	3	Draw/IFK Berga and Yes	5026346_12111481_46434095
8b082883-7c4d-4746-8d99-aa7000a8504f	9b686565-3f24-4585-83cc-aa7000a84ffc	IFO Bromolla IF/IFK Berga and No	ABNo	active	1.71		\N		2	2	IFO Bromolla IF/IFK Berga and No	5026346_12111481_46434088
09bf44ad-91fc-4cf4-9c26-aa7000a85060	9b686565-3f24-4585-83cc-aa7000a84ffc	Draw/IFK Berga and No	BXNo	active	1.78		\N		2	3	Draw/IFK Berga and No	5026346_12111481_46434101
c33069b8-f69c-4290-a843-aa7000a8508b	d7644492-504a-47c6-91c7-aa7000a8507a	Ifo Bromolla If	A	active	7.45		\N		1	1	Ifo Bromolla If	5026346_12111711_46436271
038fdfa8-8b7a-4e43-bafe-aa7000a850a0	d7644492-504a-47c6-91c7-aa7000a8507a	Both	Both	active	1.56		\N		1	2	Both	5026346_12111711_46436281
0b491934-125f-4b78-b58f-aa7000a850b4	d7644492-504a-47c6-91c7-aa7000a8507a	IFK Berga	B	active	3.8		\N		1	3	IFK Berga	5026346_12111711_46436277
92de7596-b560-4373-a51d-aa7000a850c5	d7644492-504a-47c6-91c7-aa7000a8507a	None	None	active	16.5		\N		2	1	None	5026346_12111711_46436267
a57a555a-4fc4-4e59-866d-aa7000a850e7	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 1-0	0-0 1-0	active	26.5		\N		1	1	0-0 1-0	5026346_12111506_46434444
1b975e74-201c-4373-a1ce-aa7000a850fc	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 0-0	0-0 0-0	active	18.25		\N		1	2	0-0 0-0	5026346_12111506_46434441
262a8854-3da3-4ea0-a5ea-aa7000a8510d	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 0-1	0-0 0-1	active	18.75		\N		1	3	0-0 0-1	5026346_12111506_46434451
be5921f1-ca08-4ac4-a3ac-aa7000a8511e	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 2-1	0-0 2-1	active	80		\N		2	1	0-0 2-1	5026346_12111506_46434622
23c61882-53ef-4db3-b524-aa7000a8512f	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 1-1	0-0 1-1	active	24.5		\N		2	2	0-0 1-1	5026346_12111506_46434434
4f508112-6f38-42ee-8d7e-aa7000a85140	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 0-2	0-0 0-2	active	35		\N		2	3	0-0 0-2	5026346_12111506_46434538
67a41a68-ebe7-405a-9705-aa7000a8515a	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 3-0	0-0 3-0	active	250		\N		3	1	0-0 3-0	5026346_12111506_46434615
03a48391-f13c-4b0d-8df9-aa7000a85172	974185d5-8fec-4349-bec0-aa7000a850d8	1-0 1-1	1-0 1-1	active	35		\N		3	2	1-0 1-1	5026346_12111506_46434704
aaae6812-a87a-4527-9c31-aa7000a85188	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 1-2	0-0 1-2	active	55		\N		3	3	0-0 1-2	5026346_12111506_46434656
53995bd0-9b92-4942-a522-aa7000a851a2	974185d5-8fec-4349-bec0-aa7000a850d8	1-0 1-0	1-0 1-0	active	40		\N		4	1	1-0 1-0	5026346_12111506_46434672
1ad18120-a4d2-4edf-9abf-aa7000a851be	974185d5-8fec-4349-bec0-aa7000a850d8	0-1 1-1	0-1 1-1	active	35		\N		4	2	0-1 1-1	5026346_12111506_46434457
baedeb43-61a3-46ff-8563-aa7000a851d2	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 0-3	0-0 0-3	active	125		\N		4	3	0-0 0-3	5026346_12111506_46434693
912a9d17-d51c-412a-bffa-aa7000a851e2	974185d5-8fec-4349-bec0-aa7000a850d8	1-0 2-0	1-0 2-0	active	55		\N		5	1	1-0 2-0	5026346_12111506_46434578
6823f619-0752-47e5-af25-aa7000a851f1	974185d5-8fec-4349-bec0-aa7000a850d8	1-1 1-1	1-1 1-1	active	40		\N		5	2	1-1 1-1	5026346_12111506_46434687
558e0824-a4bf-43a2-9b84-aa7000a85201	974185d5-8fec-4349-bec0-aa7000a850d8	0-1 0-1	0-1 0-1	active	27.5		\N		5	3	0-1 0-1	5026346_12111506_46434583
a2ab7124-eb68-4a45-8623-aa7000a85210	974185d5-8fec-4349-bec0-aa7000a850d8	1-0 2-1	1-0 2-1	active	50		\N		6	1	1-0 2-1	5026346_12111506_46434637
52d149cc-d7a5-4a83-b8ca-aa7000a85222	974185d5-8fec-4349-bec0-aa7000a850d8	0-0 4plus	0-0 4plus	active	40		\N		6	2	0-0 4plus	5026346_12111506_46434699
c2890fd2-6581-423b-bb85-aa7000a85235	974185d5-8fec-4349-bec0-aa7000a850d8	0-1 0-2	0-1 0-2	active	25.5		\N		6	3	0-1 0-2	5026346_12111506_46434643
107b0b46-1586-470c-a20e-aa7000a85246	974185d5-8fec-4349-bec0-aa7000a850d8	1-0 1-2	1-0 1-2	active	70		\N		7	1	1-0 1-2	5026346_12111506_46434630
15a6e352-0966-4b91-8143-aa7000a85254	974185d5-8fec-4349-bec0-aa7000a850d8	1-0 4plus	1-0 4plus	active	25.5		\N		7	2	1-0 4plus	5026346_12111506_46434545
69ad0bc3-ee6d-419c-881d-aa7000a85263	974185d5-8fec-4349-bec0-aa7000a850d8	1-0 3-0	1-0 3-0	active	150		\N		8	1	1-0 3-0	5026346_12111506_46434531
f084b4a4-de1f-4ecb-9aa5-aa7000a8527f	974185d5-8fec-4349-bec0-aa7000a850d8	0-1 1-2	0-1 1-2	active	35		\N		7	3	0-1 1-2	5026346_12111506_46434549
cb4ff13c-ae49-4293-9ee1-aa7000a8528f	974185d5-8fec-4349-bec0-aa7000a850d8	0-1 4plus	0-1 4plus	active	18		\N		8	2	0-1 4plus	5026346_12111506_46434681
fda54d47-c7c8-4cb2-9e5a-aa7000a8529d	974185d5-8fec-4349-bec0-aa7000a850d8	1-1 2-1	1-1 2-1	active	60		\N		9	1	1-1 2-1	5026346_12111506_46434565
8f1c067b-8a80-4103-9818-aa7000a852ae	974185d5-8fec-4349-bec0-aa7000a850d8	0-1 2-1	0-1 2-1	active	100		\N		8	3	0-1 2-1	5026346_12111506_46434513
8e2ffe0d-4aaf-4b0d-8a07-aa7000a852c1	974185d5-8fec-4349-bec0-aa7000a850d8	1-1 4plus	1-1 4plus	active	16.5		\N		9	2	1-1 4plus	5026346_12111506_46434602
a2cb606e-5919-4246-bf19-aa7000a852d8	974185d5-8fec-4349-bec0-aa7000a850d8	0-1 0-3	0-1 0-3	active	50		\N		9	3	0-1 0-3	5026346_12111506_46434660
0e89b064-5311-4802-a40a-aa7000a852f1	974185d5-8fec-4349-bec0-aa7000a850d8	2-0 2-0	2-0 2-0	active	150		\N		10	1	2-0 2-0	5026346_12111506_46434709
73a57571-95f3-4fad-b572-aa7000a8530b	974185d5-8fec-4349-bec0-aa7000a850d8	2-0 4plus	2-0 4plus	active	45		\N		10	2	2-0 4plus	5026346_12111506_46434569
92d92759-0404-49c9-89c3-aa7000a85323	974185d5-8fec-4349-bec0-aa7000a850d8	1-1 1-2	1-1 1-2	active	45		\N		10	3	1-1 1-2	5026346_12111506_46434667
19784c99-e142-4702-9377-aa7000a8533a	974185d5-8fec-4349-bec0-aa7000a850d8	2-0 2-1	2-0 2-1	active	125		\N		11	1	2-0 2-1	5026346_12111506_46434588
938fb2d5-9eb3-45be-9a02-aa7000a8534b	974185d5-8fec-4349-bec0-aa7000a850d8	0-2 4plus	0-2 4plus	active	21.5		\N		11	2	0-2 4plus	5026346_12111506_46434474
e37daffe-b65a-4a12-8410-aa7000a8535a	974185d5-8fec-4349-bec0-aa7000a850d8	2-1 2-1	2-1 2-1	active	150		\N		12	1	2-1 2-1	5026346_12111506_46434496
36656974-d4d2-4d7a-bc13-aa7000a8536a	974185d5-8fec-4349-bec0-aa7000a850d8	0-2 0-2	0-2 0-2	active	70		\N		11	3	0-2 0-2	5026346_12111506_46434525
ec604a3c-1623-419c-bb72-aa7000a8537a	974185d5-8fec-4349-bec0-aa7000a850d8	2-1 4plus	2-1 4plus	active	35		\N		12	2	2-1 4plus	5026346_12111506_46434503
8ec35e84-e8c8-4feb-aca8-aa7000a8538b	974185d5-8fec-4349-bec0-aa7000a850d8	2-0 3-0	2-0 3-0	active	150		\N		13	1	2-0 3-0	5026346_12111506_46434463
8182751a-4006-4c14-9703-aa7000a8539f	974185d5-8fec-4349-bec0-aa7000a850d8	0-2 1-2	0-2 1-2	active	90		\N		12	3	0-2 1-2	5026346_12111506_46434508
985ab76f-7c53-4a66-a16c-aa7000a853b4	974185d5-8fec-4349-bec0-aa7000a850d8	1-2 4plus	1-2 4plus	active	24.5		\N		13	2	1-2 4plus	5026346_12111506_46434558
df755276-2009-4c6d-a742-aa7000a853ce	974185d5-8fec-4349-bec0-aa7000a850d8	1-2 1-2	1-2 1-2	active	125		\N		13	3	1-2 1-2	5026346_12111506_46434481
d8d7f42b-997c-4320-aebb-aa7000a853e5	974185d5-8fec-4349-bec0-aa7000a850d8	3-0 3-0	3-0 3-0	active	250		\N		14	1	3-0 3-0	5026346_12111506_46434469
88741d43-5a6c-4ebc-a8af-aa7000a853f7	974185d5-8fec-4349-bec0-aa7000a850d8	3-0 4plus	3-0 4plus	active	150		\N		14	2	3-0 4plus	5026346_12111506_46434490
3631812d-5405-49a4-9f40-aa7000a8540a	974185d5-8fec-4349-bec0-aa7000a850d8	0-2 0-3	0-2 0-3	active	60		\N		14	3	0-2 0-3	5026346_12111506_46434679
3d013a1c-0158-4c40-bc82-aa7000a8541a	974185d5-8fec-4349-bec0-aa7000a850d8	0-3 4plus	0-3 4plus	active	50		\N		15	2	0-3 4plus	5026346_12111506_46434596
93c3bd9e-c349-4c69-a0bb-aa7000a8542c	974185d5-8fec-4349-bec0-aa7000a850d8	0-3 0-3	0-3 0-3	active	200		\N		15	3	0-3 0-3	5026346_12111506_46434650
f5fc5963-631d-4ec4-8e5f-aa7000a85442	974185d5-8fec-4349-bec0-aa7000a850d8	4plus 4plus	4plus 4plus	active	18.5		\N		16	2	4plus 4plus	5026346_12111506_46434608
49702904-3762-4d68-9889-aa7000a85472	068c1fa5-00ff-46ea-982e-aa7000a85456	No/Over 2.5	YUnder	active	7.6		\N		1	1	No/Over 2.5	5026346_12111462_46433881
dc84004c-5d3a-4502-bb11-aa7000a85489	068c1fa5-00ff-46ea-982e-aa7000a85456	Yes/Over 2.5	YOver	active	1.91		\N		1	2	Yes/Over 2.5	5026346_12111462_46433876
4d3614c0-3e58-4dd4-9ece-aa7000a8549a	068c1fa5-00ff-46ea-982e-aa7000a85456	No/Under 2.5	NUnder	active	3		\N		2	1	No/Under 2.5	5026346_12111462_46433890
86c46a32-e22b-47f0-a56d-aa7000a854ab	068c1fa5-00ff-46ea-982e-aa7000a85456	Yes/Under 2.5	NOver	active	9		\N		2	2	Yes/Under 2.5	5026346_12111462_46433886
dad48118-3ffd-4f6a-8739-aa7000a854ca	5f493e60-9677-4261-b54f-aa7000a854ba	IFO Bromolla IF/Yes	AYes	active	18.25		\N		1	1	IFO Bromolla IF/Yes	5026346_12111451_46433805
73a28e01-8898-4768-a9ce-aa7000a854df	5f493e60-9677-4261-b54f-aa7000a854ba	Draw/Yes	XYes	active	7		\N		1	2	Draw/Yes	5026346_12111451_46433819
21f102de-47cb-4062-be05-aa7000a854f3	5f493e60-9677-4261-b54f-aa7000a854ba	IFK Berga/Yes	BYes	active	12.5		\N		1	3	IFK Berga/Yes	5026346_12111451_46433829
4766f485-4879-4c1c-8385-aa7000a85505	5f493e60-9677-4261-b54f-aa7000a854ba	IFO Bromolla IF/No	ANo	active	4.9		\N		2	1	IFO Bromolla IF/No	5026346_12111451_46433812
7dff5f36-d120-4231-9d8b-aa7000a85515	5f493e60-9677-4261-b54f-aa7000a854ba	Draw/No	XNo	active	3.45		\N		2	2	Draw/No	5026346_12111451_46433824
f9e716c1-3983-435c-a4a9-aa7000a85527	5f493e60-9677-4261-b54f-aa7000a854ba	IFK Berga/No	BNo	active	3.05		\N		2	3	IFK Berga/No	5026346_12111451_46433836
e9f99951-7066-43e0-9682-aa7000a85547	63805347-fbd2-45f1-bbe0-aa7000a85537	0	MR_0	active	3.75		\N		1	1	0	5026346_12111426_46433680
fec0ab40-b239-4a55-9cbb-aa7000a85558	63805347-fbd2-45f1-bbe0-aa7000a85537	1-2	MR_1-2	active	1.44		\N		1	2	1-2	5026346_12111426_46433686
6c683d88-651a-417c-bdea-aa7000a8556a	63805347-fbd2-45f1-bbe0-aa7000a85537	1-3	MR_1-3	active	1.21		\N		1	3	1-3	5026346_12111426_46433695
7df65517-d1c7-46e8-a642-aa7000a8557b	63805347-fbd2-45f1-bbe0-aa7000a85537	2-3	MR_2-3	active	1.77		\N		2	1	2-3	5026346_12111426_46433698
0b4af97b-0319-4ab0-96c7-aa7000a85593	63805347-fbd2-45f1-bbe0-aa7000a85537	4+	MR_4+	active	5.3		\N		3	1	4+	5026346_12111426_46433702
37f62643-c9e2-4259-9290-aa7000a855bc	05773e36-4423-4e8f-963f-aa7000a855aa	Odd	Odd	active	1.86		\N		1	1	Odd	5026346_12111361_46433458
6dd0caf0-ae95-4de3-86b0-aa7000a855db	05773e36-4423-4e8f-963f-aa7000a855aa	Even	Even	active	1.78		\N		1	2	Even	5026346_12111361_46433466
c8290cc4-a8b0-44ee-b898-aa7000a85608	87e8e790-3fe9-495c-a540-aa7000a855f6	Odd	Odd	active	1.95		\N		1	1	Odd	5026346_12111335_46433371
6cfc671a-dde1-4985-810d-aa7000a8561b	87e8e790-3fe9-495c-a540-aa7000a855f6	Even	Even	active	1.7		\N		1	2	Even	5026346_12111335_46433377
39f91300-ecbb-4b12-8f95-aa7000a8563f	1b1bc5ad-2e74-4436-9003-aa7000a8562c	1st Half	H1	active	3.25		\N		1	1	1st Half	5026346_12111240_46432710
fdba6d7f-30b1-4a59-9e83-aa7000a8564e	1b1bc5ad-2e74-4436-9003-aa7000a8562c	2nd	H2	active	2.31		\N		1	2	2nd	5026346_12111240_46432717
6b960816-2d4a-436f-b8c2-aa7000a85661	1b1bc5ad-2e74-4436-9003-aa7000a8562c	Equal	Equal	active	2.8		\N		1	3	Equal	5026346_12111240_46432725
05abd738-47c2-4864-8c01-aa7000a85684	a75def2c-8df0-43e7-86de-aa7000a85671	IFO Bromolla IF/Draw and Yes	AXYes	active	3.95		\N		1	1	IFO Bromolla IF/Draw and Yes	5026346_12111220_46432532
9a758ca0-3d3d-4d5e-a9cd-aa7000a85695	a75def2c-8df0-43e7-86de-aa7000a85671	IFO Bromolla IF/IFK Berga and Yes	ABYes	active	5.75		\N		1	2	IFO Bromolla IF/IFK Berga and Yes	5026346_12111220_46432543
81756fef-8e69-42cc-93b3-aa7000a856a5	a75def2c-8df0-43e7-86de-aa7000a85671	Draw/IFK Berga and Yes	BXYes	active	3.5		\N		1	3	Draw/IFK Berga and Yes	5026346_12111220_46432558
ae0f3cb0-a5c0-4791-91f7-aa7000a856ba	a75def2c-8df0-43e7-86de-aa7000a85671	IFO Bromolla IF/Draw and No	AXNo	active	1.74		\N		2	1	IFO Bromolla IF/Draw and No	5026346_12111220_46432538
325a2488-d983-4418-b045-aa7000a856d6	a75def2c-8df0-43e7-86de-aa7000a85671	IFO Bromolla IF/IFK Berga and No	ABNo	active	1.64		\N		2	2	IFO Bromolla IF/IFK Berga and No	5026346_12111220_46432553
1238880f-369a-4a14-93cc-aa7000a856ec	a75def2c-8df0-43e7-86de-aa7000a85671	Draw/IFK Berga and No	BXNo	active	1.46		\N		2	3	Draw/IFK Berga and No	5026346_12111220_46432566
12a2e2b3-b58e-456b-bdb1-aa7000a85718	832e35b0-b393-49cf-bcb6-aa7000a85706	IFO Bromolla IF/Draw and Yes	AXYes	active	2.47		\N		1	1	IFO Bromolla IF/Draw and Yes	5026346_12111204_46432445
15919ffa-3414-470a-8a43-aa7000a8573c	832e35b0-b393-49cf-bcb6-aa7000a85706	IFO Bromolla IF/IFK Berga and Yes	ABYes	active	2.15		\N		1	2	IFO Bromolla IF/IFK Berga and Yes	5026346_12111204_46432457
15167d72-be6e-4e7e-ad04-aa7000a85754	832e35b0-b393-49cf-bcb6-aa7000a85706	Draw/IFK Berga and Yes	BXYes	active	1.93		\N		1	3	Draw/IFK Berga and Yes	5026346_12111204_46432467
9627d24a-df75-46bf-9efe-aa7000a8576b	832e35b0-b393-49cf-bcb6-aa7000a85706	IFO Bromolla IF/Draw and No	AXNo	active	4.75		\N		2	1	IFO Bromolla IF/Draw and No	5026346_12111204_46432450
42585b20-7bb1-4a4a-b037-aa7000a8577c	832e35b0-b393-49cf-bcb6-aa7000a85706	IFO Bromolla IF/IFK Berga and No	ABNo	active	2.47		\N		2	2	IFO Bromolla IF/IFK Berga and No	5026346_12111204_46432462
dab65562-cf39-4d67-ad77-aa7000a8578d	832e35b0-b393-49cf-bcb6-aa7000a85706	Draw/IFK Berga and No	BXNo	active	2.95		\N		2	3	Draw/IFK Berga and No	5026346_12111204_46432472
6f9368d1-0aa8-4fa2-a07c-aa7000a857b2	855811b2-337f-485d-957a-aa7000a857a0	IFO Bromolla IF/Draw  Under 2.5	AXUnder	active	3.2		\N		1	1	IFO Bromolla IF/Draw  Under 2.5	5026346_12111007_46431580
5872dc8d-7c82-4956-8747-aa7000a857c2	855811b2-337f-485d-957a-aa7000a857a0	IFO Bromolla IF/IFK Berga - Under 2.5	ABUnder	active	3.3		\N		1	2	IFO Bromolla IF/IFK Berga - Under 2.5	5026346_12111007_46431589
c2cbd3ef-368d-4809-8fe6-aa7000a857d2	855811b2-337f-485d-957a-aa7000a857a0	Draw/IFK Berga  Under 2.5	XBUnder	active	2.63		\N		1	3	Draw/IFK Berga  Under 2.5	5026346_12111007_46431596
54a0b9fa-5707-493b-b6a4-aa7000a857e3	855811b2-337f-485d-957a-aa7000a857a0	IFO Bromolla IF/Draw  Over 2.5	AXOver	active	3.3		\N		2	1	IFO Bromolla IF/Draw  Over 2.5	5026346_12111007_46431602
173f2962-b4ea-457f-8b14-aa7000a86b9d	d89e8d79-efe0-4523-b98d-aa7000a869e5	2-3	2-3	active	80		\N		7	3	2-3	5026360_12111233_46432743
69ba7414-6c1d-4ab4-b2a1-aa7000a857f6	855811b2-337f-485d-957a-aa7000a857a0	IFO Bromolla IF/IFK Berga  Over 2.5	ABOver	active	1.79		\N		2	2	IFO Bromolla IF/IFK Berga  Over 2.5	5026346_12111007_46431608
e4318885-07d4-4bd4-a867-aa7000a8580a	855811b2-337f-485d-957a-aa7000a857a0	Draw/IFK Berga  Over 2.5	XBOver	active	2.09		\N		2	3	Draw/IFK Berga  Over 2.5	5026346_12111007_46431609
d0e821f5-01fb-46ce-8128-aa7000a8582d	1ae79100-0359-4169-b26d-aa7000a8581d	IFO Bromolla IF/Draw  Under 1.5	AXUnder	active	6.55		\N		1	1	IFO Bromolla IF/Draw  Under 1.5	5026346_12110989_46431486
6bda7d42-19d5-4dca-808f-aa7000a8583d	1ae79100-0359-4169-b26d-aa7000a8581d	IFO Bromolla IF/IFK Berga - Under 1.5	ABUnder	active	5.3		\N		1	2	IFO Bromolla IF/IFK Berga - Under 1.5	5026346_12110989_46431492
b227de29-a8f2-48a7-a1bc-aa7000a85851	1ae79100-0359-4169-b26d-aa7000a8581d	Draw/IFK Berga  Under 1.5	XBUnder	active	5.5		\N		1	3	Draw/IFK Berga  Under 1.5	5026346_12110989_46431498
ba957364-71e7-4fa5-ba17-aa7000a85869	1ae79100-0359-4169-b26d-aa7000a8581d	IFO Bromolla IF/Draw  Over 1.5	AXOver	active	2.11		\N		2	1	IFO Bromolla IF/Draw  Over 1.5	5026346_12110989_46431505
1e1bbf86-0a5d-445f-a8ea-aa7000a8587e	1ae79100-0359-4169-b26d-aa7000a8581d	IFO Bromolla IF/IFK Berga  Over 1.5	ABOver	active	1.49		\N		2	2	IFO Bromolla IF/IFK Berga  Over 1.5	5026346_12110989_46431512
14b43c84-b8fc-4f22-b3eb-aa7000a85898	1ae79100-0359-4169-b26d-aa7000a8581d	Draw/IFK Berga  Over 1.5	XBOver	active	1.49		\N		2	3	Draw/IFK Berga  Over 1.5	5026346_12110989_46431520
00c10a78-018d-4da2-bc3d-aa7000a858ce	9f599a46-e2ec-477f-bb9a-aa7000a858bc	IFO Bromolla IF/Draw  Under 4.5	AXUnder	active	1.98		\N		1	1	IFO Bromolla IF/Draw  Under 4.5	5026346_12110975_46431393
35deb7fd-3360-475c-9020-aa7000a858da	9f599a46-e2ec-477f-bb9a-aa7000a858bc	IFO Bromolla IF/IFK Berga - Under 4.5	ABUnder	active	1.56		\N		1	2	IFO Bromolla IF/IFK Berga - Under 4.5	5026346_12110975_46431401
fb70397b-d7bb-4f94-928e-aa7000a858ee	9f599a46-e2ec-477f-bb9a-aa7000a858bc	Draw/IFK Berga  Under 4.5	XBUnder	active	1.51		\N		1	3	Draw/IFK Berga  Under 4.5	5026346_12110975_46431408
7ee1d80e-7933-48d7-9541-aa7000a858ff	9f599a46-e2ec-477f-bb9a-aa7000a858bc	IFO Bromolla IF/Draw  Over 4.5	AXOver	active	8.95		\N		2	1	IFO Bromolla IF/Draw  Over 4.5	5026346_12110975_46431411
a836ead0-5bbc-4211-aede-aa7000a85914	9f599a46-e2ec-477f-bb9a-aa7000a858bc	IFO Bromolla IF/IFK Berga  Over 4.5	ABOver	active	4.4		\N		2	2	IFO Bromolla IF/IFK Berga  Over 4.5	5026346_12110975_46431418
f68d8214-ef4e-4a7c-bc80-aa7000a8592a	9f599a46-e2ec-477f-bb9a-aa7000a858bc	Draw/IFK Berga  Over 4.5	XBOver	active	5.35		\N		2	3	Draw/IFK Berga  Over 4.5	5026346_12110975_46431425
25169ac1-3176-4fa9-b581-aa7000a85950	247dad56-0f0a-4507-97df-aa7000a8593f	IFO Bromolla IF/Yes	AYes	active	13.75		\N		1	1	IFO Bromolla IF/Yes	5026346_12110963_46431310
1b46daef-39ea-458a-a080-aa7000a85961	247dad56-0f0a-4507-97df-aa7000a8593f	Draw/Yes	XYes	active	5.8		\N		1	2	Draw/Yes	5026346_12110963_46431326
bc8153bb-e692-4603-a95e-aa7000a85973	247dad56-0f0a-4507-97df-aa7000a8593f	IFK Berga/Yes	BYes	active	8.85		\N		1	3	IFK Berga/Yes	5026346_12110963_46431339
67224e9d-65db-4976-b78c-aa7000a85984	247dad56-0f0a-4507-97df-aa7000a8593f	IFO Bromolla IF/No	ANo	active	4.85		\N		2	1	IFO Bromolla IF/No	5026346_12110963_46431316
0cf4ff09-b6ba-4ea3-aa7a-aa7000a85997	247dad56-0f0a-4507-97df-aa7000a8593f	Draw/No	XNo	active	5.1		\N		2	2	Draw/No	5026346_12110963_46431329
d60426c5-07e2-4e03-b856-aa7000a859b6	247dad56-0f0a-4507-97df-aa7000a8593f	IFK Berga/No	BNo	active	2.95		\N		2	3	IFK Berga/No	5026346_12110963_46431344
c3aea856-f78c-4a64-ba70-aa7000a859e3	50086a70-c9b3-422f-a349-aa7000a859d3	Ifo Bromolla If	A	active	2.31		\N		1	1	Ifo Bromolla If	5026346_12110904_46430997
0055f589-374c-4ddc-b7d3-aa7000a859ff	50086a70-c9b3-422f-a349-aa7000a859d3	IFK Berga	B	active	1.5		\N		1	2	IFK Berga	5026346_12110904_46431006
3e66f8a3-6541-4fb8-980f-aa7000a85a35	9c318995-42cd-41cb-82d9-aa7000a85a1c	Yes	Yes	active	4.8		\N		1	1	Yes	5026346_12110486_46429954
5fb1f334-f404-4577-98a6-aa7000a85a46	9c318995-42cd-41cb-82d9-aa7000a85a1c	No	No	active	1.12		\N		1	2	No	5026346_12110486_46429960
f22b9402-f95a-41fb-9b7c-aa7000a85a85	e89f9010-8864-4f36-aed7-aa7000a85a70	2-1	2-1	active	10.75		\N		1	1	2-1	5026360_12111639_46435782
1156b408-59a0-41d9-9d33-aa7000a85a97	e89f9010-8864-4f36-aed7-aa7000a85a70	1-0	1-0	active	14		\N		1	2	1-0	5026360_12111639_46435785
e3cd649d-41c9-4a0f-9d55-aa7000a85aaa	e89f9010-8864-4f36-aed7-aa7000a85a70	0-2	0-2	active	100		\N		1	3	0-2	5026360_12111639_46435788
53e9f227-4034-46b4-b397-aa7000a85abc	e89f9010-8864-4f36-aed7-aa7000a85a70	2-0	2-0	active	9.7		\N		2	1	2-0	5026360_12111639_46435793
c8d45ef0-d23d-4060-927c-aa7000a85acc	e89f9010-8864-4f36-aed7-aa7000a85a70	1-3	1-3	active	125		\N		2	2	1-3	5026360_12111639_46435797
95b31b87-6a6c-41ff-8992-aa7000a85add	e89f9010-8864-4f36-aed7-aa7000a85a70	4-4	4-4	active	250		\N		2	3	4-4	5026360_12111639_46435802
b8e060c5-bdac-4738-a513-aa7000a85aeb	e89f9010-8864-4f36-aed7-aa7000a85a70	0-4	0-4	active	250		\N		3	1	0-4	5026360_12111639_46435806
d7bf7840-b5ef-4e3c-97b7-aa7000a85aff	e89f9010-8864-4f36-aed7-aa7000a85a70	3-0	3-0	active	10		\N		3	2	3-0	5026360_12111639_46435809
7b9ceef4-34f3-42de-993c-aa7000a85b1a	e89f9010-8864-4f36-aed7-aa7000a85a70	3-1	3-1	active	11.25		\N		3	3	3-1	5026360_12111639_46435813
e84ff1ae-5e74-40ba-8ebd-aa7000a85b30	e89f9010-8864-4f36-aed7-aa7000a85a70	3-2	3-2	active	25		\N		4	1	3-2	5026360_12111639_46435821
ff3958ab-62a6-434a-9453-aa7000a85b44	e89f9010-8864-4f36-aed7-aa7000a85a70	1-4	1-4	active	250		\N		4	2	1-4	5026360_12111639_46435826
db5338bc-5ab6-4ae6-a64f-aa7000a85b67	e89f9010-8864-4f36-aed7-aa7000a85a70	3-4	3-4	active	250		\N		4	3	3-4	5026360_12111639_46435833
91146443-6224-41db-b178-aa7000a85b83	e89f9010-8864-4f36-aed7-aa7000a85a70	4-0	4-0	active	14		\N		5	1	4-0	5026360_12111639_46435841
598b4691-c2fc-4f8b-a603-aa7000a85b98	e89f9010-8864-4f36-aed7-aa7000a85a70	4-1	4-1	active	15.5		\N		5	2	4-1	5026360_12111639_46435847
7cdbd7e9-5ae2-4ea5-8e74-aa7000a85bae	e89f9010-8864-4f36-aed7-aa7000a85a70	3-3	3-3	active	80		\N		5	3	3-3	5026360_12111639_46435851
05ef22b7-07b7-4f84-bd79-aa7000a85bc0	e89f9010-8864-4f36-aed7-aa7000a85a70	4-3	4-3	active	125		\N		6	1	4-3	5026360_12111639_46435856
b9c30bee-cf0f-45ed-b4e0-aa7000a85bd4	e89f9010-8864-4f36-aed7-aa7000a85a70	2-3	2-3	active	80		\N		6	2	2-3	5026360_12111639_46435860
d6f4cd7b-c5cb-4dd3-a01e-aa7000a85bf2	e89f9010-8864-4f36-aed7-aa7000a85a70	2-2	2-2	active	24		\N		6	3	2-2	5026360_12111639_46435864
55f7fd4a-0c2d-43c2-8979-aa7000a85c07	e89f9010-8864-4f36-aed7-aa7000a85a70	0-1	0-1	active	45		\N		7	1	0-1	5026360_12111639_46435868
92345ce0-7ea4-4d37-82f8-aa7000a85c18	e89f9010-8864-4f36-aed7-aa7000a85a70	Any Other	M1	active	5.5		\N		7	2	Any Other	5026360_12111639_46435874
8c9e1147-1e44-401e-923b-aa7000a85c2a	e89f9010-8864-4f36-aed7-aa7000a85a70	4-2	4-2	active	35		\N		7	3	4-2	5026360_12111639_46435877
f1d948b0-4166-4511-80bd-aa7000a85c3c	e89f9010-8864-4f36-aed7-aa7000a85a70	0-0	0-0	active	40		\N		8	1	0-0	5026360_12111639_46435886
11a389b9-12c4-4d94-b86f-aa7000a85c4f	e89f9010-8864-4f36-aed7-aa7000a85a70	1-1	1-1	active	15.5		\N		8	2	1-1	5026360_12111639_46435889
c9b7a053-f064-4709-a42d-aa7000a85c62	e89f9010-8864-4f36-aed7-aa7000a85a70	0-3	0-3	active	200		\N		8	3	0-3	5026360_12111639_46435895
b9dd2b2f-6761-4d5f-b4ae-aa7000a85c7a	e89f9010-8864-4f36-aed7-aa7000a85a70	2-4	2-4	active	250		\N		9	1	2-4	5026360_12111639_46435902
b2ad80bb-28dd-4b0c-b118-aa7000a85c91	e89f9010-8864-4f36-aed7-aa7000a85a70	1-2	1-2	active	35		\N		9	2	1-2	5026360_12111639_46435914
b0053cdc-ac71-4ebc-ba74-aa7000a85cbe	4426a461-22dc-4a08-a502-aa7000a85ca3	Fk Karlskrona/Fk Karlskrona and over +4.5	A/AOver	active	4.05		\N		1	1	Fk Karlskrona/Fk Karlskrona and over +4.5	5026360_12111530_46434739
3ee0a9ec-9892-483e-87b5-aa7000a85ce5	4426a461-22dc-4a08-a502-aa7000a85ca3	Fk Karlskrona/Fk Karlskrona and under +4.5	A/AUnder	active	2.9		\N		1	2	Fk Karlskrona/Fk Karlskrona and under +4.5	5026360_12111530_46434822
610f84b0-b30d-48f3-9e32-aa7000a85cf7	4426a461-22dc-4a08-a502-aa7000a85ca3	Fk Karlskrona/Hassleholms If and over +4.5	A/BOver	active	150		\N		2	1	Fk Karlskrona/Hassleholms If and over +4.5	5026360_12111530_46434751
7355dd6d-3f74-4dfc-aa57-aa7000a85d09	4426a461-22dc-4a08-a502-aa7000a85ca3	Fk Karlskrona/Hassleholms If and under +4.5	A/BUnder	active	150		\N		2	2	Fk Karlskrona/Hassleholms If and under +4.5	5026360_12111530_46434770
369270cd-5cf5-4d7e-ac07-aa7000a85d1b	4426a461-22dc-4a08-a502-aa7000a85ca3	Fk Karlskrona/Draw and over +4.5	A/XOver	active	150		\N		3	1	Fk Karlskrona/Draw and over +4.5	5026360_12111530_46434746
dc728f16-af18-4e77-8c65-aa7000a85d2d	4426a461-22dc-4a08-a502-aa7000a85ca3	Fk Karlskrona/Draw and under +4.5	A/XUnder	active	35		\N		3	2	Fk Karlskrona/Draw and under +4.5	5026360_12111530_46434831
2e6a3dd4-56c5-4a43-a0e3-aa7000a85d3e	4426a461-22dc-4a08-a502-aa7000a85ca3	Hassleholms If/Fk Karlskrona and over +4.5	B/AOver	active	45		\N		4	1	Hassleholms If/Fk Karlskrona and over +4.5	5026360_12111530_46434793
59c2ca21-8c94-48e2-b346-aa7000a85d51	4426a461-22dc-4a08-a502-aa7000a85ca3	Hassleholms If/Fk Karlskrona and under +4.5	B/AUnder	active	50		\N		4	2	Hassleholms If/Fk Karlskrona and under +4.5	5026360_12111530_46434805
13af323c-7b68-4e62-977d-aa7000a85d63	4426a461-22dc-4a08-a502-aa7000a85ca3	Hassleholms If/Hassleholms If and over +4.5	B/BOver	active	80		\N		5	1	Hassleholms If/Hassleholms If and over +4.5	5026360_12111530_46434811
e04caf31-e3ea-43d1-919f-aa7000a85d75	4426a461-22dc-4a08-a502-aa7000a85ca3	Hassleholms If/Hassleholms If and under +4.5	B/BUnder	active	26		\N		5	2	Hassleholms If/Hassleholms If and under +4.5	5026360_12111530_46434761
f90f946f-30df-45ba-a370-aa7000a85d86	4426a461-22dc-4a08-a502-aa7000a85ca3	Hassleholms If/Draw and over +4.5	B/XOver	active	150		\N		6	1	Hassleholms If/Draw and over +4.5	5026360_12111530_46434800
e9f89358-3e99-4779-aa2b-aa7000a85d99	4426a461-22dc-4a08-a502-aa7000a85ca3	Hassleholms If/Draw and under +4.5	B/XUnder	active	35		\N		6	2	Hassleholms If/Draw and under +4.5	5026360_12111530_46434837
90100e7f-9d5c-488c-a143-aa7000a85dae	4426a461-22dc-4a08-a502-aa7000a85ca3	Draw/{0} and over	X/AOver	active	21.5		\N		7	1	Draw/{0} and over	5026360_12111530_46434776
b0c5561b-26af-47cf-874d-aa7000a85dc1	4426a461-22dc-4a08-a502-aa7000a85ca3	Draw/{0} and under	X/AUnder	active	6.3		\N		7	2	Draw/{0} and under	5026360_12111530_46434813
5d073de9-1c31-49b0-bfdd-aa7000a85dd9	4426a461-22dc-4a08-a502-aa7000a85ca3	Draw/Hassleholms If and over +4.5	X/BOver	active	125		\N		8	1	Draw/Hassleholms If and over +4.5	5026360_12111530_46434786
7bb8712e-41a1-43c1-9806-aa7000a85ded	4426a461-22dc-4a08-a502-aa7000a85ca3	Draw/Hassleholms If and under +4.5	X/BUnder	active	30		\N		8	2	Draw/Hassleholms If and under +4.5	5026360_12111530_46434842
598c8bcd-9361-42d1-a51b-aa7000a85dfe	4426a461-22dc-4a08-a502-aa7000a85ca3	Draw/Draw and over	X/XOver	active	150		\N		9	1	Draw/Draw and over	5026360_12111530_46434780
5e83c4a6-4ef1-43c3-9f71-aa7000a85e0e	4426a461-22dc-4a08-a502-aa7000a85ca3	Draw/Draw and under	X/XUnder	active	13.25		\N		9	2	Draw/Draw and under	5026360_12111530_46434754
923b5974-7dcd-42d7-a220-aa7000a85e48	60e46020-8224-4994-8481-aa7000a85e2d	Fk Karlskrona/Fk Karlskrona and over +1.5	A/AOver	active	1.8		\N		1	1	Fk Karlskrona/Fk Karlskrona and over +1.5	5026360_12111554_46434951
dc029c1b-40f2-498d-acc4-aa7000a85e5b	60e46020-8224-4994-8481-aa7000a85e2d	Fk Karlskrona/Fk Karlskrona and under +1.5	A/AUnder	active	30		\N		1	2	Fk Karlskrona/Fk Karlskrona and under +1.5	5026360_12111554_46435024
81f86283-58dc-4162-8230-aa7000a85e6c	60e46020-8224-4994-8481-aa7000a85e2d	Fk Karlskrona/Hassleholms If and over +1.5	A/BOver	active	100		\N		2	1	Fk Karlskrona/Hassleholms If and over +1.5	5026360_12111554_46434962
1456a2c7-218e-4f31-8378-aa7000a85e7e	60e46020-8224-4994-8481-aa7000a85e2d	Fk Karlskrona/Draw and over +1.5	A/XOver	active	27.5		\N		3	1	Fk Karlskrona/Draw and over +1.5	5026360_12111554_46434957
a8b745fe-e9cd-4670-8477-aa7000a85e90	60e46020-8224-4994-8481-aa7000a85e2d	Hassleholms If/Fk Karlskrona and over +1.5	B/AOver	active	22.5		\N		4	1	Hassleholms If/Fk Karlskrona and over +1.5	5026360_12111554_46434991
ef969c95-9564-4d9c-b311-aa7000a85ea3	60e46020-8224-4994-8481-aa7000a85e2d	Hassleholms If/Hassleholms If and under +1.5	B/BUnder	active	100		\N		4	2	Hassleholms If/Hassleholms If and under +1.5	5026360_12111554_46435010
4412952a-fd59-4be8-9bea-aa7000a85eb6	60e46020-8224-4994-8481-aa7000a85e2d	Hassleholms If/Hassleholms If and over +1.5	B/BOver	active	23.5		\N		5	1	Hassleholms If/Hassleholms If and over +1.5	5026360_12111554_46435003
cd79f954-e827-4c1c-ba2a-aa7000a85ec6	60e46020-8224-4994-8481-aa7000a85e2d	Hassleholms If/Draw and over +1.5	B/XOver	active	28.5		\N		6	1	Hassleholms If/Draw and over +1.5	5026360_12111554_46434997
74e80221-443c-4b63-8745-aa7000a85ed6	60e46020-8224-4994-8481-aa7000a85e2d	Draw/{0} and under	X/AUnder	active	22.5		\N		6	2	Draw/{0} and under	5026360_12111554_46435041
dc3a8988-42ab-4075-aad7-aa7000a85ee4	60e46020-8224-4994-8481-aa7000a85e2d	Draw/{0} and over	X/AOver	active	5.95		\N		7	1	Draw/{0} and over	5026360_12111554_46434971
543b7275-b733-4bee-a73d-aa7000a85ef1	60e46020-8224-4994-8481-aa7000a85e2d	Draw/Hassleholms If and under +1.5	X/BUnder	active	70		\N		7	2	Draw/Hassleholms If and under +1.5	5026360_12111554_46435017
45325f68-9fa0-4682-af26-aa7000a85eff	60e46020-8224-4994-8481-aa7000a85e2d	Draw/Hassleholms If and over +1.5	X/BOver	active	40		\N		8	1	Draw/Hassleholms If and over +1.5	5026360_12111554_46434984
7646f4ad-97e9-428f-b83f-aa7000a85f0e	60e46020-8224-4994-8481-aa7000a85e2d	Draw/Draw and under	X/XUnder	active	35		\N		8	2	Draw/Draw and under	5026360_12111554_46435032
34104090-b153-4d96-8841-aa7000a85f1e	60e46020-8224-4994-8481-aa7000a85e2d	Draw/Draw and over	X/XOver	active	18		\N		9	1	Draw/Draw and over	5026360_12111554_46434979
f3bd0ff3-ea12-4ed1-a369-aa7000a85f46	23578c77-7b22-482e-8e0b-aa7000a85f34	ФК Карлскрона -2.5	AH	active	2.34		\N		1	1	ФК Карлскрона -2.5	5026360_12111887_46437277
768a5930-3856-471a-b868-aa7000a85f57	23578c77-7b22-482e-8e0b-aa7000a85f34	Хеслехолм ИФ +2.5	BH	active	1.49		\N		1	2	Хеслехолм ИФ +2.5	5026360_12111887_46437278
724b6421-c5be-434e-90e3-aa7000a85f77	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Fk Karlskrona/Fk Karlskrona and over +3.5	A/AOver	active	2.7		\N		1	1	Fk Karlskrona/Fk Karlskrona and over +3.5	5026360_12111594_46435382
7be47754-ba35-4c71-ba7d-aa7000a85f98	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Fk Karlskrona/Fk Karlskrona and under +3.5	A/AUnder	active	4.4		\N		1	2	Fk Karlskrona/Fk Karlskrona and under +3.5	5026360_12111594_46435449
7099174f-5b27-4632-90c1-aa7000a85fb2	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Fk Karlskrona/Hassleholms If and over +3.5	A/BOver	active	150		\N		2	1	Fk Karlskrona/Hassleholms If and over +3.5	5026360_12111594_46435390
81fd35d9-cda5-4281-b39d-aa7000a85fc5	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Fk Karlskrona/Hassleholms If and under +3.5	A/BUnder	active	150		\N		2	2	Fk Karlskrona/Hassleholms If and under +3.5	5026360_12111594_46435453
198d8c0d-08ed-45e7-9ac2-aa7000a85fd8	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Fk Karlskrona/Draw and over +3.5	A/XOver	active	50		\N		3	1	Fk Karlskrona/Draw and over +3.5	5026360_12111594_46435386
4f47649d-f3d1-467a-87db-aa7000a85fe9	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Fk Karlskrona/Draw and under +3.5	A/XUnder	active	60		\N		3	2	Fk Karlskrona/Draw and under +3.5	5026360_12111594_46435471
b8836d9e-4016-46ee-803d-aa7000a85ffe	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Hassleholms If/Fk Karlskrona and over +3.5	B/AOver	active	35		\N		4	1	Hassleholms If/Fk Karlskrona and over +3.5	5026360_12111594_46435414
420a6d47-1c35-4a0a-91a6-aa7000a8600d	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Hassleholms If/Fk Karlskrona and under +3.5	B/AUnder	active	80		\N		4	2	Hassleholms If/Fk Karlskrona and under +3.5	5026360_12111594_46435467
089edb61-77c3-4a45-9131-aa7000a8601e	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Hassleholms If/Hassleholms If and over +3.5	B/BOver	active	55		\N		5	1	Hassleholms If/Hassleholms If and over +3.5	5026360_12111594_46435432
63e61549-6821-4d8f-86e6-aa7000a86032	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Hassleholms If/Hassleholms If and under +3.5	B/BUnder	active	30		\N		5	2	Hassleholms If/Hassleholms If and under +3.5	5026360_12111594_46435464
576fab85-557f-4032-8ac7-aa7000a86043	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Hassleholms If/Draw and over +3.5	B/XOver	active	55		\N		6	1	Hassleholms If/Draw and over +3.5	5026360_12111594_46435428
46b3f18d-0ce2-4b06-8fcc-aa7000a86056	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Hassleholms If/Draw and under +3.5	B/XUnder	active	60		\N		6	2	Hassleholms If/Draw and under +3.5	5026360_12111594_46435419
a104c395-a13f-44da-887a-aa7000a86069	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Draw/{0} and over	X/AOver	active	12.75		\N		7	1	Draw/{0} and over	5026360_12111594_46435396
9d0ebf50-c40a-4040-ade0-aa7000a8607b	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Draw/{0} and under	X/AUnder	active	7.7		\N		7	2	Draw/{0} and under	5026360_12111594_46435476
a79b1e97-359f-4cbe-8d6d-aa7000a86092	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Draw/Hassleholms If and over +3.5	X/BOver	active	125		\N		8	1	Draw/Hassleholms If and over +3.5	5026360_12111594_46435404
c7a5cd3c-e4b4-43a7-9e0c-aa7000a860a5	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Draw/Hassleholms If and under +3.5	X/BUnder	active	35		\N		8	2	Draw/Hassleholms If and under +3.5	5026360_12111594_46435441
06427c43-d751-4b5e-a619-aa7000a860bb	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Draw/Draw and over	X/XOver	active	50		\N		9	1	Draw/Draw and over	5026360_12111594_46435374
4c98d91a-e794-475f-ab2d-aa7000a860ce	ef21ce7d-ceac-4396-bc90-aa7000a85f69	Draw/Draw and under	X/XUnder	active	16.5		\N		9	2	Draw/Draw and under	5026360_12111594_46435457
fc53b0fe-4b4c-4add-82a0-aa7000a8610a	7614df88-2ca9-46e6-b797-aa7000a860ed	Fk Karlskrona/Fk Karlskrona and over +2.5	A/AOver	active	2.05		\N		1	1	Fk Karlskrona/Fk Karlskrona and over +2.5	5026360_12111573_46435169
72530140-8eef-4eac-b6c0-aa7000a8611b	7614df88-2ca9-46e6-b797-aa7000a860ed	Fk Karlskrona/Fk Karlskrona and under +2.5	A/AUnder	active	9.65		\N		1	2	Fk Karlskrona/Fk Karlskrona and under +2.5	5026360_12111573_46435235
e048f8bc-d479-4fac-aa83-aa7000a8612e	7614df88-2ca9-46e6-b797-aa7000a860ed	Fk Karlskrona/Hassleholms If and over +2.5	A/BOver	active	100		\N		2	1	Fk Karlskrona/Hassleholms If and over +2.5	5026360_12111573_46435179
63733563-76af-4fc8-ae77-aa7000a86142	7614df88-2ca9-46e6-b797-aa7000a860ed	Fk Karlskrona/Draw and under +2.5	A/XUnder	active	60		\N		2	2	Fk Karlskrona/Draw and under +2.5	5026360_12111573_46435243
64c5814f-07eb-43b7-bd17-aa7000a86153	7614df88-2ca9-46e6-b797-aa7000a860ed	Fk Karlskrona/Draw and over +2.5	A/XOver	active	50		\N		3	1	Fk Karlskrona/Draw and over +2.5	5026360_12111573_46435175
625725df-abc4-42ae-b36b-aa7000a86165	7614df88-2ca9-46e6-b797-aa7000a860ed	Hassleholms If/Fk Karlskrona and over +2.5	B/AOver	active	23		\N		4	1	Hassleholms If/Fk Karlskrona and over +2.5	5026360_12111573_46435196
f0b9ca7a-7089-4b70-b18f-aa7000a86178	7614df88-2ca9-46e6-b797-aa7000a860ed	Hassleholms If/Hassleholms If and under +2.5	B/BUnder	active	60		\N		4	2	Hassleholms If/Hassleholms If and under +2.5	5026360_12111573_46435208
6e74e036-e80a-4608-8f28-aa7000a8618e	7614df88-2ca9-46e6-b797-aa7000a860ed	Hassleholms If/Hassleholms If and over +2.5	B/BOver	active	28.5		\N		5	1	Hassleholms If/Hassleholms If and over +2.5	5026360_12111573_46435223
5f9abe0e-9c3e-4a16-bcbf-aa7000a861a3	7614df88-2ca9-46e6-b797-aa7000a860ed	Hassleholms If/Draw and under +2.5	B/XUnder	active	60		\N		5	2	Hassleholms If/Draw and under +2.5	5026360_12111573_46435228
f34883c0-8e5c-42d3-b80c-aa7000a861b6	7614df88-2ca9-46e6-b797-aa7000a860ed	Hassleholms If/Draw and over +2.5	B/XOver	active	55		\N		6	1	Hassleholms If/Draw and over +2.5	5026360_12111573_46435211
9d37c9b6-cbe6-42cb-8091-aa7000a861cb	7614df88-2ca9-46e6-b797-aa7000a860ed	Draw/{0} and under	X/AUnder	active	12.75		\N		6	2	Draw/{0} and under	5026360_12111573_46435203
8b2d3757-4a24-4cf8-888c-aa7000a86208	7614df88-2ca9-46e6-b797-aa7000a860ed	Draw/{0} and over	X/AOver	active	7.5		\N		7	1	Draw/{0} and over	5026360_12111573_46435184
fb582441-31f8-4d2b-813d-aa7000a8621e	7614df88-2ca9-46e6-b797-aa7000a860ed	Draw/Hassleholms If and under +2.5	X/BUnder	active	60		\N		7	2	Draw/Hassleholms If and under +2.5	5026360_12111573_46435249
2c6ad7e9-ee6d-4181-80a4-aa7000a86231	7614df88-2ca9-46e6-b797-aa7000a860ed	Draw/Hassleholms If and over +2.5	X/BOver	active	50		\N		8	1	Draw/Hassleholms If and over +2.5	5026360_12111573_46435162
9185cc1c-b406-4a60-ad10-aa7000a8624b	7614df88-2ca9-46e6-b797-aa7000a860ed	Draw/Draw and under	X/XUnder	active	16.25		\N		8	2	Draw/Draw and under	5026360_12111573_46435217
8bb598d3-0a95-428b-8ff3-aa7000a8626d	7614df88-2ca9-46e6-b797-aa7000a860ed	Draw/Draw and over	X/XOver	active	50		\N		9	1	Draw/Draw and over	5026360_12111573_46435190
8843a21d-44e0-4270-9d88-aa7000a86295	dfd45dec-f9e3-4632-89d6-aa7000a86280	0	0	active	4.85		\N		1	1	0	5026360_12111521_46434563
bf8d5956-4475-4727-b9a6-aa7000a862a8	dfd45dec-f9e3-4632-89d6-aa7000a86280	1	1	active	2.95		\N		1	2	1	5026360_12111521_46434571
d65d11cf-cb7a-494c-bb73-aa7000a862bb	dfd45dec-f9e3-4632-89d6-aa7000a86280	2	2	active	3.45		\N		1	3	2	5026360_12111521_46434577
3ddfe552-e434-4a4c-bf48-aa7000a862cd	dfd45dec-f9e3-4632-89d6-aa7000a86280	3+	3+	active	3.75		\N		2	1	3+	5026360_12111521_46434586
04d5900c-3cd8-447f-a1b6-aa7000a862f2	3c7cdb20-80af-431f-85cd-aa7000a862dd	Yes	Yes	active	3.95		\N		1	1	Yes	5026360_12110895_46430972
856e3ef4-5a34-4caf-a35e-aa7000a86304	3c7cdb20-80af-431f-85cd-aa7000a862dd	No	No	active	1.19		\N		1	2	No	5026360_12110895_46430983
f8d40278-7c4c-4751-8664-aa7000a86328	d922abfb-8820-4a26-8277-aa7000a86317	Under 1.25	Under	active	2.25		\N		1	1	Under 1.25	5026360_12110568_46430148
b500972f-e1e9-4fbf-bb96-aa7000a8633c	d922abfb-8820-4a26-8277-aa7000a86317	Over 1.25	Over	active	1.53		\N		1	2	Over 1.25	5026360_12110568_46430143
1df14157-c723-43bf-80d6-aa7000a8637f	51b2382b-dc60-4f59-b1c5-aa7000a8635a	Under 1.5	Under	active	1.82		\N		1	1	Under 1.5	5026360_12110554_46430119
ec515f3c-d35a-442e-904d-aa7000a86393	51b2382b-dc60-4f59-b1c5-aa7000a8635a	Over 1.5	Over	active	1.82		\N		1	2	Over 1.5	5026360_12110554_46430113
66d87505-9ed6-4d5f-8180-aa7000a863ec	7e6f2ea5-51ea-44dc-92f5-aa7000a863d7	Under 1.75	Under	active	1.6		\N		1	1	Under 1.75	5026360_12110544_46430092
aa72e58e-9f94-46b7-a2f1-aa7000a8640a	7e6f2ea5-51ea-44dc-92f5-aa7000a863d7	Over 1.75	Over	active	2.1		\N		1	2	Over 1.75	5026360_12110544_46430085
423eaac9-1174-4763-87d5-aa7000a86448	461d14b6-22ef-493d-b841-aa7000a8642d	ФК Карлскрона -1.5	AH	active	1.58		\N		1	1	ФК Карлскрона -1.5	5026360_12110532_46430059
e06473b6-9a37-4270-b5a0-aa7000a8645f	461d14b6-22ef-493d-b841-aa7000a8642d	Хеслехолм ИФ +1.5	BH	active	2.14		\N		1	2	Хеслехолм ИФ +1.5	5026360_12110532_46430066
d752a165-9c93-4190-b3b0-aa7000a86482	d2b7e28e-7180-4816-897b-aa7000a86472	ФК Карлскрона -2.25	AH	active	2.12		\N		1	1	ФК Карлскрона -2.25	5026360_12110516_46430027
ace9ccf2-5c8e-4b64-b430-aa7000a86499	d2b7e28e-7180-4816-897b-aa7000a86472	Хеслехолм ИФ +2.25	BH	active	1.59		\N		1	2	Хеслехолм ИФ +2.25	5026360_12110516_46430030
5303dc36-1f1a-41b4-97c5-aa7000a864d6	8967dd59-5047-4377-82f0-aa7000a864bf	ФК Карлскрона -1.75	AH	active	1.71		\N		1	1	ФК Карлскрона -1.75	5026360_12110488_46429953
19b8bc43-3dcc-422e-bb57-aa7000a8650d	8967dd59-5047-4377-82f0-aa7000a864bf	Хеслехолм ИФ +1.75	BH	active	1.95		\N		1	2	Хеслехолм ИФ +1.75	5026360_12110488_46429957
08a38e90-800c-4636-a3ed-aa7000a8654c	2c9d5c87-795f-40b6-89cb-aa7000a8653a	ФК Карлскрона -2	AH	active	1.9		\N		1	1	ФК Карлскрона -2	5026360_12110467_46429923
88806f56-30ed-4d31-87d2-aa7000a8655f	2c9d5c87-795f-40b6-89cb-aa7000a8653a	Хеслехолм ИФ +2	BH	active	1.74		\N		1	2	Хеслехолм ИФ +2	5026360_12110467_46429929
70361c2c-3b4e-42aa-be12-aa7000a8658d	0120e5cf-93e2-45e0-8af0-aa7000a86577	No/No	NN	active	1.79		\N		1	1	No/No	5026360_12110400_46429756
d270cd2e-3869-40a6-b83b-aa7000a865ad	0120e5cf-93e2-45e0-8af0-aa7000a86577	Yes/No	YN	active	5.3		\N		1	2	Yes/No	5026360_12110400_46429760
78ef7da2-43ba-4b84-8d50-aa7000a865cd	0120e5cf-93e2-45e0-8af0-aa7000a86577	Yes/Yes	YY	active	11.75		\N		1	3	Yes/Yes	5026360_12110400_46429765
3c74c3b6-3d3f-4315-9cd0-aa7000a865e4	0120e5cf-93e2-45e0-8af0-aa7000a86577	No/Yes	NY	active	3.75		\N		2	1	No/Yes	5026360_12110400_46429772
3251a62a-ef57-44f6-b5c0-aa7000a86608	ca818b51-3da5-4fad-888e-aa7000a865f5	Yes	Yes	active	1.39		\N		1	1	Yes	5026360_12110311_46429525
9ab731fb-7975-4c82-b882-aa7000a86629	ca818b51-3da5-4fad-888e-aa7000a865f5	No	No	active	2.61		\N		1	2	No	5026360_12110311_46429529
e24a6f83-ac25-41e5-a984-aa7000a86652	94cf73ab-7248-4f8d-9d66-aa7000a8663f	Under 3.5	Under	active	2.1		\N		1	1	Under 3.5	5026360_12110682_46430439
c707e97d-efda-459e-a740-aa7000a86671	94cf73ab-7248-4f8d-9d66-aa7000a8663f	Over 3.5	Over	active	1.91		\N		1	2	Over 3.5	5026360_12110682_46430435
e391c145-9bef-42bf-bc36-aa7000a866aa	29a700ff-74a5-4304-bc15-aa7000a8669a	Under 2.5	Under	active	3.7		\N		1	1	Under 2.5	5026360_12110659_46430405
d65a4718-1281-4f3e-94b3-aa7000a866bd	29a700ff-74a5-4304-bc15-aa7000a8669a	Over 2.5	Over	active	1.37		\N		1	2	Over 2.5	5026360_12110659_46430400
034afc90-1fab-4188-8c1b-aa7000a866e6	9a9eb947-b6e8-4eff-8bd1-aa7000a866d2	Under 1.5	Under	active	9.55		\N		1	1	Under 1.5	5026360_12110648_46430359
8fab3f60-c5a6-42ba-918f-aa7000a866f7	9a9eb947-b6e8-4eff-8bd1-aa7000a866d2	Over 1.5	Over	active	1.12		\N		1	2	Over 1.5	5026360_12110648_46430354
48e871d7-8de8-4d12-a181-aa7000a86723	1cc2c7d8-6d42-4702-8c59-aa7000a8670a	Under 5.5	Under	active	1.22		\N		1	1	Under 5.5	5026360_12110633_46430325
8cebc159-3855-4252-8880-aa7000a86735	1cc2c7d8-6d42-4702-8c59-aa7000a8670a	Over 5.5	Over	active	5.6		\N		1	2	Over 5.5	5026360_12110633_46430322
0dc9ddb1-52f1-4609-bad9-aa7000a86758	22095b3e-7b5d-480e-a0b7-aa7000a86746	Under 4.5	Under	active	1.49		\N		1	1	Under 4.5	5026360_12110620_46430296
0974febc-0458-43b4-956b-aa7000a86771	22095b3e-7b5d-480e-a0b7-aa7000a86746	Over 4.5	Over	active	3.05		\N		1	2	Over 4.5	5026360_12110620_46430291
4e834790-dc28-4985-bb0c-aa7000a8679f	8e4a2826-6c05-4804-92a7-aa7000a8678b	FK Karlskrona	A	active	1.22		\N		1	1	FK Karlskrona	5026360_12095460_46380256
0b16990d-b87f-4e52-baa5-aa7000a867b1	8e4a2826-6c05-4804-92a7-aa7000a8678b	Draw	X	active	5.85		\N		1	2	Draw	5026360_12095460_46380257
3e5abe35-7c86-4a3e-a57e-aa7000a867d4	8e4a2826-6c05-4804-92a7-aa7000a8678b	Хеслехолм ИФ	B	active	9		\N		1	3	Хеслехолм ИФ	5026360_12095460_46380258
ae45d073-3734-47ac-a70f-aa7000a86802	ddc5e58f-69af-478b-9c7b-aa7000a867f0	ФК Карлскрона or Draw	AX	active	1.04		\N		1	1	ФК Карлскрона or Draw	5026360_12095456_46380246
3d6be6c8-6bac-4348-999f-aa7000a86818	ddc5e58f-69af-478b-9c7b-aa7000a867f0	ФК Карлскрона or Хеслехолм ИФ	AB	active	1.08		\N		1	2	ФК Карлскрона or Хеслехолм ИФ	5026360_12095456_46380247
734832a6-02e8-4af5-91da-aa7000a8682b	ddc5e58f-69af-478b-9c7b-aa7000a867f0	Draw or Хеслехолм ИФ	BX	active	2.75		\N		1	3	Draw or Хеслехолм ИФ	5026360_12095456_46380248
f8e37a26-c578-440a-a39b-aa7000a86852	91ba917d-de45-41de-ad33-aa7000a8683d	Yes	Yes	active	1.65		\N		1	1	Yes	5026360_12111703_46436223
911e0f21-4ce7-48bc-8b1d-aa7000a86865	91ba917d-de45-41de-ad33-aa7000a8683d	No	No	active	2.03		\N		1	2	No	5026360_12111703_46436228
599c4264-b783-44f2-a962-aa7000a8688f	c5a09bd2-6350-4d4d-82aa-aa7000a8687a	ФК Карлскрона -1	AH	active	1.6		\N		1	1	ФК Карлскрона -1	5026360_12111515_46434507
8179f292-418b-46a0-9521-aa7000a868a2	c5a09bd2-6350-4d4d-82aa-aa7000a8687a	Draw sigendLine	XH	active	4.45		\N		1	2	Draw sigendLine	5026360_12111515_46434512
cb29801d-47d5-4c80-a900-aa7000a868b9	c5a09bd2-6350-4d4d-82aa-aa7000a8687a	Хеслехолм ИФ +1	BH	active	4		\N		1	3	Хеслехолм ИФ +1	5026360_12111515_46434518
af5df665-d409-43f1-96dd-aa7000a868ed	34ecd8bf-6739-4067-bd56-aa7000a868d1	ФК Карлскрона +1	AH	active	1.05		\N		1	1	ФК Карлскрона +1	5026360_12110611_46430255
adb5d91e-cf26-4f05-a659-aa7000a86904	34ecd8bf-6739-4067-bd56-aa7000a868d1	Draw sigendLine	XH	active	9.9		\N		1	2	Draw sigendLine	5026360_12110611_46430261
cbcbb0f1-ad55-4577-8e27-aa7000a86916	34ecd8bf-6739-4067-bd56-aa7000a868d1	Хеслехолм ИФ -1	BH	active	23		\N		1	3	Хеслехолм ИФ -1	5026360_12110611_46430265
0f239a88-b39c-4a5c-9237-aa7000a86955	dae0d61c-d26d-4c4b-b6ca-aa7000a8693c	ФК Карлскрона -1	AH	active	1.6		\N		1	1	ФК Карлскрона -1	5026360_12110595_46430215
8b696019-ea15-477a-836c-aa7000a86967	dae0d61c-d26d-4c4b-b6ca-aa7000a8693c	Draw sigendLine	XH	active	4.45		\N		1	2	Draw sigendLine	5026360_12110595_46430218
0e07e193-fdb2-4028-b8d8-aa7000a8697a	dae0d61c-d26d-4c4b-b6ca-aa7000a8693c	Хеслехолм ИФ +1	BH	active	4		\N		1	3	Хеслехолм ИФ +1	5026360_12110595_46430224
bd972ded-f5e9-4a7b-bed0-aa7000a869a5	161b45df-6db9-4d70-8f66-aa7000a86991	ФК Карлскрона -2	AH	active	2.42		\N		1	1	ФК Карлскрона -2	5026360_12110583_46430178
07a4ea81-f86a-4153-9e93-aa7000a869be	161b45df-6db9-4d70-8f66-aa7000a86991	Draw sigendLine	XH	active	4.25		\N		1	2	Draw sigendLine	5026360_12110583_46430183
8c9cc677-a940-4e50-b576-aa7000a869d4	161b45df-6db9-4d70-8f66-aa7000a86991	Хеслехолм ИФ +2	BH	active	2.21		\N		1	3	Хеслехолм ИФ +2	5026360_12110583_46430187
bfe904df-41da-41af-804d-aa7000a869f8	d89e8d79-efe0-4523-b98d-aa7000a869e5	3-0	3-0	active	10.25		\N		1	1	3-0	5026360_12111233_46432642
8f851ce0-43cf-4544-8315-aa7000a86a14	d89e8d79-efe0-4523-b98d-aa7000a869e5	1-0	1-0	active	14.25		\N		1	2	1-0	5026360_12111233_46432646
71d214dc-a98c-4b84-bfdb-aa7000a86a26	d89e8d79-efe0-4523-b98d-aa7000a869e5	2-0	2-0	active	9.85		\N		1	3	2-0	5026360_12111233_46432653
9c538bf0-2398-4aad-b423-aa7000a86a40	d89e8d79-efe0-4523-b98d-aa7000a869e5	2-1	2-1	active	11		\N		2	1	2-1	5026360_12111233_46432657
6726e211-99a0-407b-af09-aa7000a86a57	d89e8d79-efe0-4523-b98d-aa7000a869e5	3-3	3-3	active	80		\N		2	2	3-3	5026360_12111233_46432662
56a310df-e8e6-4be7-b24e-aa7000a86a67	d89e8d79-efe0-4523-b98d-aa7000a869e5	0-2	0-2	active	100		\N		2	3	0-2	5026360_12111233_46432667
ffaf3f1c-72d9-4afe-87a0-aa7000a86a7b	d89e8d79-efe0-4523-b98d-aa7000a869e5	1-1	1-1	active	15.75		\N		3	1	1-1	5026360_12111233_46432672
058a8800-d02f-4f82-b264-aa7000a86a9a	d89e8d79-efe0-4523-b98d-aa7000a869e5	2-2	2-2	active	24		\N		3	2	2-2	5026360_12111233_46432678
075e259e-8b8b-4552-83e8-aa7000a86ab9	d89e8d79-efe0-4523-b98d-aa7000a869e5	0-6	0-6	active	250		\N		3	3	0-6	5026360_12111233_46432684
e7305413-c200-4f1b-a89d-aa7000a86acc	d89e8d79-efe0-4523-b98d-aa7000a869e5	1-3	1-3	active	125		\N		4	1	1-3	5026360_12111233_46432689
88e72023-746c-47ba-8d3f-aa7000a86ae3	d89e8d79-efe0-4523-b98d-aa7000a869e5	2-4	2-4	active	250		\N		4	2	2-4	5026360_12111233_46432693
07ee9dd9-d383-429b-ac84-aa7000a86af8	d89e8d79-efe0-4523-b98d-aa7000a869e5	3-1	3-1	active	11.5		\N		4	3	3-1	5026360_12111233_46432698
032f84f4-ea65-4c5c-af78-aa7000a86b0a	d89e8d79-efe0-4523-b98d-aa7000a869e5	0-3	0-3	active	250		\N		5	1	0-3	5026360_12111233_46432701
3ff309c4-6abe-40b7-8875-aa7000a86b1e	d89e8d79-efe0-4523-b98d-aa7000a869e5	1-4	1-4	active	250		\N		5	2	1-4	5026360_12111233_46432703
7290da76-e207-4dca-b393-aa7000a86b31	d89e8d79-efe0-4523-b98d-aa7000a869e5	1-2	1-2	active	35		\N		5	3	1-2	5026360_12111233_46432704
5ed053cc-0027-4678-9b6f-aa7000a86b3f	d89e8d79-efe0-4523-b98d-aa7000a869e5	3-2	3-2	active	25		\N		6	1	3-2	5026360_12111233_46432705
8dda0de8-d1c1-45ea-821c-aa7000a86b50	d89e8d79-efe0-4523-b98d-aa7000a869e5	4-0	4-0	active	14		\N		6	2	4-0	5026360_12111233_46432712
10742b7a-2922-4fa6-a8ae-aa7000a86b62	d89e8d79-efe0-4523-b98d-aa7000a869e5	4-1	4-1	active	15.75		\N		6	3	4-1	5026360_12111233_46432720
d2161b24-482a-44fa-b487-aa7000a86b77	d89e8d79-efe0-4523-b98d-aa7000a869e5	4-2	4-2	active	35		\N		7	1	4-2	5026360_12111233_46432726
f1173233-8160-4e66-98ec-aa7000a86b87	d89e8d79-efe0-4523-b98d-aa7000a869e5	Any Other	M1	active	10.5		\N		7	2	Any Other	5026360_12111233_46432731
b31f0431-3f5b-4354-8776-aa7000a86bb1	d89e8d79-efe0-4523-b98d-aa7000a869e5	5-0	5-0	active	24		\N		8	1	5-0	5026360_12111233_46432747
32f2f70b-5b77-4450-b8e8-aa7000a86bc5	d89e8d79-efe0-4523-b98d-aa7000a869e5	0-0	0-0	active	40		\N		8	2	0-0	5026360_12111233_46432753
75db8f86-0612-4f33-b663-aa7000a86bda	d89e8d79-efe0-4523-b98d-aa7000a869e5	5-1	5-1	active	27		\N		8	3	5-1	5026360_12111233_46432761
abe50bbe-bf13-4356-8423-aa7000a86bf3	d89e8d79-efe0-4523-b98d-aa7000a869e5	0-5	0-5	active	250		\N		9	1	0-5	5026360_12111233_46432769
4c423c13-f54d-4917-a6e9-aa7000a86c13	d89e8d79-efe0-4523-b98d-aa7000a869e5	1-5	1-5	active	250		\N		9	2	1-5	5026360_12111233_46432777
a54d8a3d-001a-4743-8bfe-aa7000a86c2a	d89e8d79-efe0-4523-b98d-aa7000a869e5	6-0	6-0	active	50		\N		9	3	6-0	5026360_12111233_46432782
1923169f-b338-4162-b6d9-aa7000a86c40	d89e8d79-efe0-4523-b98d-aa7000a869e5	0-1	0-1	active	45		\N		10	1	0-1	5026360_12111233_46432789
92dec76e-6988-4f82-a6ce-aa7000a86c62	d89e8d79-efe0-4523-b98d-aa7000a869e5	0-4	0-4	active	250		\N		10	2	0-4	5026360_12111233_46432799
dae271b4-3ba2-4468-8878-aa7000a86c83	e6ea93f8-1677-4c34-9e8a-aa7000a86c73	Under 0.5	Under	active	1.39		\N		1	1	Under 0.5	5026360_12110304_46429500
59c814a0-6ab2-44fa-a45d-aa7000a86c94	e6ea93f8-1677-4c34-9e8a-aa7000a86c73	Over 0.5	Over	active	2.62		\N		1	2	Over 0.5	5026360_12110304_46429495
dd1f2763-ec4d-4daf-a82a-aa7000a86cb9	dc5c63fd-4ff4-47dc-8c05-aa7000a86ca6	Under 1.5	Under	active	1.48		\N		1	1	Under 1.5	5026360_12110284_46429445
40da5862-f2f6-4ae4-81fa-aa7000a86ccb	dc5c63fd-4ff4-47dc-8c05-aa7000a86ca6	Over 1.5	Over	active	2.36		\N		1	2	Over 1.5	5026360_12110284_46429442
a6171327-1b5f-4749-b716-aa7000a86cf7	840c6df7-ca66-4d07-ba88-aa7000a86cdf	1-0	1-0	active	4.65		\N		1	1	1-0	5026360_12110912_46431058
71ad5130-dded-4f7b-ab11-aa7000a86d10	840c6df7-ca66-4d07-ba88-aa7000a86cdf	2-0	2-0	active	5.7		\N		1	2	2-0	5026360_12110912_46431063
f675eaa6-339f-4703-8e93-aa7000a86d24	840c6df7-ca66-4d07-ba88-aa7000a86cdf	2-1	2-1	active	11.5		\N		1	3	2-1	5026360_12110912_46431066
ce4c8927-a35f-4f83-82b2-aa7000a86d34	840c6df7-ca66-4d07-ba88-aa7000a86cdf	0-0	0-0	active	7.6		\N		2	1	0-0	5026360_12110912_46431071
9bf3e042-8dd9-4e92-b5d3-aa7000a86d44	840c6df7-ca66-4d07-ba88-aa7000a86cdf	1-1	1-1	active	9.25		\N		2	2	1-1	5026360_12110912_46431075
60afad18-066f-42cd-9559-aa7000a86d60	840c6df7-ca66-4d07-ba88-aa7000a86cdf	2-2	2-2	active	45		\N		2	3	2-2	5026360_12110912_46431081
3f7df419-6fa1-486b-91ec-aa7000a86d84	840c6df7-ca66-4d07-ba88-aa7000a86cdf	0-1	0-1	active	14.5		\N		3	1	0-1	5026360_12110912_46431087
2a70ff4b-1f84-4d50-a2ac-aa7000a86d9a	840c6df7-ca66-4d07-ba88-aa7000a86cdf	0-2	0-2	active	55		\N		3	2	0-2	5026360_12110912_46431091
d44e44d2-f9b4-45c2-89a6-aa7000a86db0	840c6df7-ca66-4d07-ba88-aa7000a86cdf	1-2	1-2	active	35		\N		3	3	1-2	5026360_12110912_46431098
bf50f152-e195-47c5-a92f-aa7000a86dc4	840c6df7-ca66-4d07-ba88-aa7000a86cdf	Any Other	M1	active	4.05		\N		4	1	Any Other	5026360_12110912_46431104
0fd69181-5373-4113-be15-aa7000a86de8	ebae7078-67fe-4209-8d22-aa7000a86dd6	Any Other	M1	active	6.15		\N		1	1	Any Other	5026360_12110874_46430898
1d76a7f0-6994-4e2e-aa72-aa7000a86dfa	ebae7078-67fe-4209-8d22-aa7000a86dd6	1-0	1-0	active	3.9		\N		1	2	1-0	5026360_12110874_46430902
8c20ed41-c185-47e4-8b9b-aa7000a86e0f	ebae7078-67fe-4209-8d22-aa7000a86dd6	2-0	2-0	active	5.95		\N		1	3	2-0	5026360_12110874_46430908
71d75041-37a7-44dc-a6cb-aa7000a86e23	ebae7078-67fe-4209-8d22-aa7000a86dd6	2-1	2-1	active	14.5		\N		2	1	2-1	5026360_12110874_46430912
7fddcd4d-8f49-48e0-a5f2-aa7000a86e35	ebae7078-67fe-4209-8d22-aa7000a86dd6	0-0	0-0	active	4.95		\N		2	2	0-0	5026360_12110874_46430916
0ba0a643-1724-40a2-8895-aa7000a86e46	ebae7078-67fe-4209-8d22-aa7000a86dd6	1-1	1-1	active	9.45		\N		2	3	1-1	5026360_12110874_46430920
18a59481-5a26-45aa-bb17-aa7000a86e63	ebae7078-67fe-4209-8d22-aa7000a86dd6	2-2	2-2	active	70		\N		3	1	2-2	5026360_12110874_46430925
4a090e30-7894-4ab5-9352-aa7000a86e7d	ebae7078-67fe-4209-8d22-aa7000a86dd6	0-1	0-1	active	12.25		\N		3	2	0-1	5026360_12110874_46430931
318c2446-6b17-4351-a1d5-aa7000a86e92	ebae7078-67fe-4209-8d22-aa7000a86dd6	0-2	0-2	active	60		\N		3	3	0-2	5026360_12110874_46430936
4a1fdde3-a4e7-481d-af14-aa7000a86ea9	ebae7078-67fe-4209-8d22-aa7000a86dd6	1-2	1-2	active	45		\N		4	1	1-2	5026360_12110874_46430943
327d7ba3-9720-4319-a115-aa7000a86ee9	48b69a9b-dda5-4b4b-8742-aa7000a86ecf	ФК Карлскрона/ФК Карлскрона	A/A	active	1.85		\N		1	1	ФК Карлскрона/ФК Карлскрона	5026360_12110236_46429265
4ffd3df7-8798-428d-b44a-aa7000a86eff	48b69a9b-dda5-4b4b-8742-aa7000a86ecf	ФК Карлскрона/Draw	A/X	active	26		\N		1	2	ФК Карлскрона/Draw	5026360_12110236_46429275
e3c1a86f-9f9f-408c-b1e3-aa7000a86f13	48b69a9b-dda5-4b4b-8742-aa7000a86ecf	ФК Карлскрона/Хеслехолм ИФ	A/B	active	80		\N		1	3	ФК Карлскрона/Хеслехолм ИФ	5026360_12110236_46429286
aae4532c-41f6-4896-a374-aa7000a86f27	48b69a9b-dda5-4b4b-8742-aa7000a86ecf	Draw/ФК Карлскрона	X/A	active	5		\N		2	1	Draw/ФК Карлскрона	5026360_12110236_46429268
3d4ba8ed-8509-40c4-a99a-aa7000a86f3e	48b69a9b-dda5-4b4b-8742-aa7000a86ecf	Draw/Draw	X/X	active	16.25		\N		2	2	Draw/Draw	5026360_12110236_46429278
c32f989a-471a-4c7d-b1ee-aa7000a86f51	48b69a9b-dda5-4b4b-8742-aa7000a86ecf	Draw/Хеслехолм ИФ	X/B	active	30		\N		2	3	Draw/Хеслехолм ИФ	5026360_12110236_46429288
e29c5387-9fa2-454e-933f-aa7000a86f64	48b69a9b-dda5-4b4b-8742-aa7000a86ecf	Хеслехолм ИФ/ФК Карлскрона	B/A	active	25.5		\N		3	1	Хеслехолм ИФ/ФК Карлскрона	5026360_12110236_46429272
118bd57c-ae0b-45db-91b7-aa7000a86f78	48b69a9b-dda5-4b4b-8742-aa7000a86ecf	Хеслехолм ИФ/Draw	B/X	active	30		\N		3	2	Хеслехолм ИФ/Draw	5026360_12110236_46429280
53a89d29-65e1-4f89-9d95-aa7000a86f8b	48b69a9b-dda5-4b4b-8742-aa7000a86ecf	Хеслехолм ИФ/Хеслехолм ИФ	B/B	active	23.5		\N		3	3	Хеслехолм ИФ/Хеслехолм ИФ	5026360_12110236_46429294
9acbaff6-94d9-45ba-9bfb-aa7000a86fbf	12f3bc16-0ec9-4db5-9262-aa7000a86f9f	Fk Karlskrona	A	active	1.57		\N		1	1	Fk Karlskrona	5026360_12111696_46436187
5ba89e7e-98ed-4e9a-bac0-aa7000a86fd5	12f3bc16-0ec9-4db5-9262-aa7000a86f9f	Draw	X	active	3.05		\N		1	2	Draw	5026360_12111696_46436192
2d9bd027-2c86-4d0e-9fde-aa7000a86ff2	12f3bc16-0ec9-4db5-9262-aa7000a86f9f	Хеслехолм ИФ	B	active	7.5		\N		1	3	Хеслехолм ИФ	5026360_12111696_46436197
800997e3-c799-42e2-b1b4-aa7000a87037	6e7614ac-babf-4602-9b9e-aa7000a87006	ФК Карлскрона or Draw	AX	active	1.08		\N		1	1	ФК Карлскрона or Draw	5026360_12110836_46430795
f0457be6-8742-44a1-94d6-aa7000a8704d	6e7614ac-babf-4602-9b9e-aa7000a87006	ФК Карлскрона or Хеслехолм ИФ	AB	active	1.26		\N		1	2	ФК Карлскрона or Хеслехолм ИФ	5026360_12110836_46430798
abd4446b-4951-40b3-9ec1-aa7000a87062	6e7614ac-babf-4602-9b9e-aa7000a87006	Draw or Хеслехолм ИФ	BX	active	1.89		\N		1	3	Draw or Хеслехолм ИФ	5026360_12110836_46430803
f611d6f5-0db6-4810-80da-aa7000a8708b	9a2a2c3b-3e0d-4f0f-a58f-aa7000a87076	Fk Karlskrona	A	active	1.45		\N		1	1	Fk Karlskrona	5026360_12111391_46433562
28ff65e3-f850-4b44-945c-aa7000a870a2	9a2a2c3b-3e0d-4f0f-a58f-aa7000a87076	Draw	X	active	3.65		\N		1	2	Draw	5026360_12111391_46433568
0ef8f976-807f-4a13-a823-aa7000a870b6	9a2a2c3b-3e0d-4f0f-a58f-aa7000a87076	Хеслехолм ИФ	B	active	7.35		\N		1	3	Хеслехолм ИФ	5026360_12111391_46433574
5f6bc0e0-254b-449e-9c46-aa7000a870df	0aeb8842-40c6-4443-b1ee-aa7000a870cc	ФК Карлскрона or Draw	AX	active	1.07		\N		1	1	ФК Карлскрона or Draw	5026360_12111355_46433437
8d8062de-e4e2-48a3-90ee-aa7000a870f4	0aeb8842-40c6-4443-b1ee-aa7000a870cc	ФК Карлскрона or Хеслехолм ИФ	AB	active	1.19		\N		1	2	ФК Карлскрона or Хеслехолм ИФ	5026360_12111355_46433446
e340e201-6047-4736-85e9-aa7000a87b6a	f8104716-9cad-48c8-8a81-aa7000a87b13	Over 0.5	Over	active	1.56		\N		1	2	Over 0.5	5026360_12110339_46429602
6d8f86ce-4bf0-45a5-8d7c-aa7000a87106	0aeb8842-40c6-4443-b1ee-aa7000a870cc	Draw or Хеслехолм ИФ	BX	active	2.1		\N		1	3	Draw or Хеслехолм ИФ	5026360_12111355_46433451
5ed0ef31-1743-4350-93a3-aa7000a87139	d44a6ca8-cfe0-4731-88aa-aa7000a8711f	Fk Karlskrona	A	active	1.11		\N		1	1	Fk Karlskrona	5026360_12111122_46432108
c422bbed-7367-4fff-bd5f-aa7000a8714f	d44a6ca8-cfe0-4731-88aa-aa7000a8711f	Draw	X	active	5.05		\N		1	2	Draw	5026360_12111122_46432113
4157e1ee-efcd-4894-afb4-aa7000a8718e	9ea57d12-4b05-4385-8712-aa7000a87163	Draw	X	active	1.54		\N		1	1	Draw	5026360_12111025_46431656
d81458f4-fd21-4b3c-853a-aa7000a871a6	9ea57d12-4b05-4385-8712-aa7000a87163	Хеслехолм ИФ	B	active	2.23		\N		1	2	Хеслехолм ИФ	5026360_12111025_46431661
73dfaf7c-647c-421c-98d3-aa7000a871cc	de79b621-17c9-4dd7-a034-aa7000a871b9	Under 0.5	Under	active	1.52		\N		1	1	Under 0.5	5026360_12110382_46429722
408dcbe7-559a-4468-99d7-aa7000a871e1	de79b621-17c9-4dd7-a034-aa7000a871b9	Over 0.5	Over	active	2.26		\N		1	2	Over 0.5	5026360_12110382_46429715
c9e83c3e-4f9c-4eee-8fe1-aa7000a87207	9e6b8ca0-8b65-4898-8c24-aa7000a871f3	Under 1.5	Under	active	1.75		\N		1	1	Under 1.5	5026360_12110351_46429638
584fc98b-ff06-43ad-9320-aa7000a8721f	9e6b8ca0-8b65-4898-8c24-aa7000a871f3	Over 1.5	Over	active	1.9		\N		1	2	Over 1.5	5026360_12110351_46429633
c1d7f14e-c392-4481-88fd-aa7000a87248	4ec59b53-7516-4186-ab37-aa7000a87233	FK Karlskrona	A	active	1.11		\N		1	1	FK Karlskrona	5026360_12095458_46380251
31c145e5-870b-4dfe-8b3c-aa7000a8725d	4ec59b53-7516-4186-ab37-aa7000a87233	Хеслехолм ИФ	B	active	10.5		\N		1	2	Хеслехолм ИФ	5026360_12095458_46380252
df59f3c5-8665-49d1-b04d-aa7000a87291	2bcf8872-5afb-4202-98c7-aa7000a87277	Yes	Yes	active	2.17		\N		1	1	Yes	5026360_12111674_46436049
2369ebb3-f2b0-4015-94db-aa7000a872aa	2bcf8872-5afb-4202-98c7-aa7000a87277	No	No	active	1.57		\N		1	2	No	5026360_12111674_46436053
f77a1457-b205-47fc-991c-aa7000a872de	60dbbe43-d89d-4cd8-a71e-aa7000a872be	Yes	Yes	active	8.25		\N		1	1	Yes	5026360_12111680_46436083
b68f7d0d-dc35-4d71-922c-aa7000a872fd	60dbbe43-d89d-4cd8-a71e-aa7000a872be	No	No	active	1.02		\N		1	2	No	5026360_12111680_46436089
80bcdc86-dc21-46b6-ba5c-aa7000a8732b	5ae56285-8384-443e-a223-aa7000a87314	Yes	Yes	active	2.29		\N		1	1	Yes	5026360_12111131_46432149
db1c5c7d-c9da-41d3-9cea-aa7000a8733e	5ae56285-8384-443e-a223-aa7000a87314	No	No	active	1.51		\N		1	2	No	5026360_12111131_46432153
c597606b-047a-4a8e-a2a2-aa7000a8736e	c929da6e-ffe1-4c40-a7c4-aa7000a87353	Yes	Yes	active	3.4		\N		1	1	Yes	5026360_12111003_46431558
cd5853a3-3594-408d-b7da-aa7000a87383	c929da6e-ffe1-4c40-a7c4-aa7000a87353	No	No	active	1.24		\N		1	2	No	5026360_12111003_46431565
27c232f9-93e9-4a8e-8933-aa7000a873ae	139c16d4-cf10-4901-bb87-aa7000a87398	Under 2.5	Under	active	1.24		\N		1	1	Under 2.5	5026360_12110718_46430527
2c0896b8-0a57-4be7-b8d4-aa7000a873c3	139c16d4-cf10-4901-bb87-aa7000a87398	Over 2.5	Over	active	3.4		\N		1	2	Over 2.5	5026360_12110718_46430523
0e4bc22d-9d50-4a69-8ffe-aa7000a87401	d6b4f97b-101d-42fd-8b00-aa7000a873e6	Under 1.5	Under	active	1.83		\N		1	1	Under 1.5	5026360_12110707_46430497
adc1978d-43b5-47be-9828-aa7000a87416	d6b4f97b-101d-42fd-8b00-aa7000a873e6	Over 1.5	Over	active	1.8		\N		1	2	Over 1.5	5026360_12110707_46430494
7cd85347-f784-4a2b-b7f9-aa7000a8744b	8c4512f0-b3df-4880-a5b2-aa7000a87429	Under 0.5	Under	active	4.1		\N		1	1	Under 0.5	5026360_12110695_46430468
f0fc5569-45e8-46d5-a182-aa7000a87467	8c4512f0-b3df-4880-a5b2-aa7000a87429	Over 0.5	Over	active	1.17		\N		1	2	Over 0.5	5026360_12110695_46430464
ed4e2ea6-3296-491c-88a1-aa7000a8748d	17681076-a825-4ebd-b5eb-aa7000a8747a	Yes	Yes	active	2.8		\N		1	1	Yes	5026360_12111114_46432067
393bc781-7a1d-4d33-af1f-aa7000a874a3	17681076-a825-4ebd-b5eb-aa7000a8747a	No	No	active	1.35		\N		1	2	No	5026360_12111114_46432074
9ffb47ca-076b-4944-8f38-aa7000a874cb	8fb0f63e-938e-47f9-aa55-aa7000a874b9	Under 2.5	Under	active	1.43		\N		1	1	Under 2.5	5026360_12110761_46430625
03465bfa-2ad6-4e2d-a9a0-aa7000a874df	8fb0f63e-938e-47f9-aa55-aa7000a874b9	Over 2.5	Over	active	2.49		\N		1	2	Over 2.5	5026360_12110761_46430622
1dd5c20c-34db-47bc-9469-aa7000a87505	a8a2a438-bdbd-4fed-961f-aa7000a874f3	Under 1.5	Under	active	2.32		\N		1	1	Under 1.5	5026360_12110747_46430593
1bb57dc1-5d7e-4f20-8684-aa7000a8751a	a8a2a438-bdbd-4fed-961f-aa7000a874f3	Over 1.5	Over	active	1.5		\N		1	2	Over 1.5	5026360_12110747_46430588
9bf745a6-1deb-42fd-be0c-aa7000a8754b	df085db6-a2ab-42bd-a9fa-aa7000a87533	Under 0.5	Under	active	5.5		\N		1	1	Under 0.5	5026360_12110731_46430561
ede894a8-8e25-47a4-b22e-aa7000a87564	df085db6-a2ab-42bd-a9fa-aa7000a87533	Over 0.5	Over	active	1.09		\N		1	2	Over 0.5	5026360_12110731_46430556
d01975da-d564-42c5-83e3-aa7000a87589	2ed26782-47ce-4f2b-94cf-aa7000a87575	0	0	active	40		\N		1	1	0	5026360_12111324_46433313
34780209-7c50-4898-9184-aa7000a875ac	2ed26782-47ce-4f2b-94cf-aa7000a87575	1	1	active	10.5		\N		1	2	1	5026360_12111324_46433320
71863ad5-d2ff-40bf-860f-aa7000a875be	2ed26782-47ce-4f2b-94cf-aa7000a87575	2	2	active	5.6		\N		1	3	2	5026360_12111324_46433327
697ee9c3-33a2-4a8d-9fc3-aa7000a877f7	2ed26782-47ce-4f2b-94cf-aa7000a87575	3	3	active	4.45		\N		2	1	3	5026360_12111324_46433335
473f058f-a7d7-4463-bbe2-aa7000a8780d	2ed26782-47ce-4f2b-94cf-aa7000a87575	4	4	active	4.7		\N		2	2	4	5026360_12111324_46433339
e35e4b6b-6cca-4689-84ec-aa7000a8781f	2ed26782-47ce-4f2b-94cf-aa7000a87575	5	5	active	6.15		\N		2	3	5	5026360_12111324_46433344
c888b018-c9b7-4615-8447-aa7000a87835	2ed26782-47ce-4f2b-94cf-aa7000a87575	6+	6+	active	5		\N		3	1	6+	5026360_12111324_46433352
87607d5f-8bba-4468-b3a0-aa7000a8785e	c7f20ef1-a360-4657-9ea4-aa7000a87849	0	0	active	4.75		\N		1	1	0	5026360_12110273_46429415
45e71102-27ed-44c0-8963-aa7000a87873	c7f20ef1-a360-4657-9ea4-aa7000a87849	1	1	active	2.9		\N		1	2	1	5026360_12110273_46429421
e94cef9b-7b58-47b2-a1d0-aa7000a87888	c7f20ef1-a360-4657-9ea4-aa7000a87849	2+	2+	active	1.84		\N		1	3	2+	5026360_12110273_46429427
f5239542-63df-412f-a1e7-aa7000a878b2	46c4477f-3253-4838-b5c7-aa7000a8789d	0	0	active	7.15		\N		1	1	0	5026360_12110294_46429470
057ec178-1d54-4797-ad25-aa7000a878c6	46c4477f-3253-4838-b5c7-aa7000a8789d	1	1	active	3.35		\N		1	2	1	5026360_12110294_46429473
31738bcb-9bd8-44c3-bb7d-aa7000a878d7	46c4477f-3253-4838-b5c7-aa7000a8789d	2+	2+	active	1.51		\N		1	3	2+	5026360_12110294_46429474
c1f8c0a2-69c1-4121-a8f3-aa7000a8790d	cc6e37f9-6240-4875-b0e4-aa7000a878ef	Odd	Odd	active	1.82		\N		1	1	Odd	5026360_12110246_46429314
f4786159-e907-4664-818c-aa7000a8794a	cc6e37f9-6240-4875-b0e4-aa7000a878ef	Even	Even	active	1.82		\N		1	2	Even	5026360_12110246_46429318
3e1eb2b7-7aee-4303-bde3-aa7000a87973	8bb0ecd5-2f2d-4c59-ab7e-aa7000a8795e	Odd	Odd	active	1.88		\N		1	1	Odd	5026360_12111607_46435509
c4bd94df-7e03-479d-b3d4-aa7000a87991	8bb0ecd5-2f2d-4c59-ab7e-aa7000a8795e	Even	Even	active	1.76		\N		1	2	Even	5026360_12111607_46435513
96016148-5e28-449e-9f13-aa7000a879bb	3aa6206c-55ee-4607-a21c-aa7000a879a8	Odd	Odd	active	1.84		\N		1	1	Odd	5026360_12111298_46433151
0321fcce-80ba-4e1d-b885-aa7000a879d1	3aa6206c-55ee-4607-a21c-aa7000a879a8	Even	Even	active	1.8		\N		1	2	Even	5026360_12111298_46433162
9bba7a28-ff4d-4d64-b302-aa7000a879fc	e41ecd83-88b2-4e16-9bdf-aa7000a879e7	Yes	Yes	active	5.55		\N		1	1	Yes	5026360_12110775_46430652
57136fdf-9321-4e5a-93a5-aa7000a87a10	e41ecd83-88b2-4e16-9bdf-aa7000a879e7	No	No	active	1.09		\N		1	2	No	5026360_12110775_46430655
6b3ad37d-95ec-43ad-9005-aa7000a87a3b	ae9ef4ab-73c9-488c-8d51-aa7000a87a27	Yes	Yes	active	1.59		\N		1	1	Yes	5026360_12110439_46429850
799d7d14-3c90-48ef-8442-aa7000a87a50	ae9ef4ab-73c9-488c-8d51-aa7000a87a27	No	No	active	2.13		\N		1	2	No	5026360_12110439_46429854
e690cb3d-01d1-4031-be89-aa7000a87ad0	6f9a1a41-ea09-4880-bf28-aa7000a87a96	Under 2.5	Under	active	2		\N		1	1	Under 2.5	5026360_12110364_46429666
7741e07e-e814-4f1f-aa47-aa7000a87aeb	6f9a1a41-ea09-4880-bf28-aa7000a87a96	Over 2.5	Over	active	1.67		\N		1	2	Over 2.5	5026360_12110364_46429661
08861dff-20bd-413f-b5e5-aa7000a87b2e	f8104716-9cad-48c8-8a81-aa7000a87b13	Under 0.5	Under	active	2.17		\N		1	1	Under 0.5	5026360_12110339_46429607
079f0fea-f26b-4c87-a161-aa7000a87b92	6a535827-d67e-47b2-a003-aa7000a87b7e	0	0	active	2.26		\N		1	1	0	5026360_12110266_46429372
1a4ac6ad-754a-4b4b-8957-aa7000a87baa	6a535827-d67e-47b2-a003-aa7000a87b7e	1	1	active	2.5		\N		1	2	1	5026360_12110266_46429377
f9d120e3-64f9-41a1-bfbd-aa7000a87c04	6a535827-d67e-47b2-a003-aa7000a87b7e	2	2	active	5.4		\N		1	3	2	5026360_12110266_46429379
80c771fc-a9b4-4db2-9892-aa7000a87c1a	6a535827-d67e-47b2-a003-aa7000a87b7e	3+	3+	active	13.75		\N		2	1	3+	5026360_12110266_46429382
8c8aadae-6429-4d45-9a91-aa7000a87c43	e136d19f-5352-4dd2-8824-aa7000a87c2f	0	0	active	15.25		\N		1	1	0	5026360_12110258_46429341
130cc8a9-e3fa-4c90-885b-aa7000a87c58	e136d19f-5352-4dd2-8824-aa7000a87c2f	1	1	active	5.45		\N		1	2	1	5026360_12110258_46429344
4629cda3-a98a-4db0-905f-aa7000a87c6d	e136d19f-5352-4dd2-8824-aa7000a87c2f	2	2	active	3.8		\N		1	3	2	5026360_12110258_46429346
ca405dd1-1e33-452e-a013-aa7000a87c82	e136d19f-5352-4dd2-8824-aa7000a87c2f	3+	3+	active	1.7		\N		2	1	3+	5026360_12110258_46429349
c6bdd4e7-5266-4175-85eb-aa7000a87cac	5be4e386-129f-406f-b87e-aa7000a87c96	0-1	R_0-1	active	8.1		\N		1	1	0-1	5026360_12110817_46430750
26a6f5c8-0b97-4050-a3a3-aa7000a87cc2	5be4e386-129f-406f-b87e-aa7000a87c96	2-3	R_2-3	active	2.5		\N		1	2	2-3	5026360_12110817_46430755
bf6d80fd-364f-47f1-8809-aa7000a87cda	5be4e386-129f-406f-b87e-aa7000a87c96	4-5	R_4-5	active	2.7		\N		1	3	4-5	5026360_12110817_46430759
adfc46a0-19de-4746-8f71-aa7000a87ced	5be4e386-129f-406f-b87e-aa7000a87c96	6+	6+	active	4.9		\N		2	1	6+	5026360_12110817_46430746
64eb2b6b-21af-4ca5-a5b1-aa7000a87d1d	c3317e05-028f-44fc-8c81-aa7000a87d05	1st Half	H1	active	2.9		\N		1	1	1st Half	5026360_12111014_46431603
20cc0cc3-5874-4e3f-a81f-aa7000a87d5d	c3317e05-028f-44fc-8c81-aa7000a87d05	2nd	H2	active	1.93		\N		1	2	2nd	5026360_12111014_46431611
614be7c9-911c-46d9-836d-aa7000a87d75	c3317e05-028f-44fc-8c81-aa7000a87d05	Equal	Equal	active	4.25		\N		1	3	Equal	5026360_12111014_46431617
86cfaa64-8d74-4164-aea2-aa7000a87da5	d17bf49e-2502-419d-bcdf-aa7000a87d8d	ФК Карлскрона -1	AH	active	3.1		\N		1	1	ФК Карлскрона -1	5026360_12110324_46429569
5f4dc656-3a7f-418c-a2a4-aa7000a87dbe	d17bf49e-2502-419d-bcdf-aa7000a87d8d	Draw sigendLine	XH	active	2.95		\N		1	2	Draw sigendLine	5026360_12110324_46429575
574b4649-cab9-46bb-99d5-aa7000a87dd7	d17bf49e-2502-419d-bcdf-aa7000a87d8d	Хеслехолм ИФ +1	BH	active	2.27		\N		1	3	Хеслехолм ИФ +1	5026360_12110324_46429579
5b5b9d76-2a62-488c-a8e1-aa7000a87e02	84a42b03-e112-4c8f-a35d-aa7000a87dec	Yes	Yes	active	2.29		\N		1	1	Yes	5026360_12110415_46429795
97a85468-1a5d-4d1b-bda6-aa7000a87e23	84a42b03-e112-4c8f-a35d-aa7000a87dec	No	No	active	1.51		\N		1	2	No	5026360_12110415_46429800
8beca936-46d8-4364-84a3-aa7000a87e50	fdc2461c-e8be-430a-8f38-aa7000a87e3c	Yes	Yes	active	4.1		\N		1	1	Yes	5026360_12110802_46430707
468e23dc-45cc-4dea-93ee-aa7000a87e66	fdc2461c-e8be-430a-8f38-aa7000a87e3c	No	No	active	1.17		\N		1	2	No	5026360_12110802_46430711
205d7807-86c9-4600-82b6-aa7000a87ea4	2181a23f-5805-454f-8104-aa7000a87e7a	Yes	Yes	active	2.75		\N		1	1	Yes	5026360_12110788_46430677
6361d2ea-c728-461f-9eaf-aa7000a87ed0	2181a23f-5805-454f-8104-aa7000a87e7a	No	No	active	1.36		\N		1	2	No	5026360_12110788_46430680
9b2d6e48-8285-4b82-b629-aa7000a87efc	d4afe5c4-877b-40ce-bf63-aa7000a87ee7	ФК Карлскрона and Under 3.5	AUnder	active	2.7		\N		1	1	ФК Карлскрона and Under 3.5	5026360_12111101_46432007
719974ab-3153-4a15-ba95-aa7000a87f11	d4afe5c4-877b-40ce-bf63-aa7000a87ee7	Draw and Under 3.5	XUnder	active	10.75		\N		1	2	Draw and Under 3.5	5026360_12111101_46432014
3edca977-1356-4076-9537-aa7000a87f28	d4afe5c4-877b-40ce-bf63-aa7000a87ee7	Хеслехолм ИФ and Under 3.5	BUnder	active	14.75		\N		1	3	Хеслехолм ИФ and Under 3.5	5026360_12111101_46432020
a4306c80-b676-45b3-a7ae-aa7000a87f3c	d4afe5c4-877b-40ce-bf63-aa7000a87ee7	ФК Карлскрона and Over 3.5	AOver	active	2.1		\N		2	1	ФК Карлскрона and Over 3.5	5026360_12111101_46432024
39cc902b-7af5-470a-a58e-aa7000a87f57	d4afe5c4-877b-40ce-bf63-aa7000a87ee7	Draw and Over 3.5	XOver	active	16.75		\N		2	2	Draw and Over 3.5	5026360_12111101_46432032
76eb257d-e6f3-4f20-b27e-aa7000a87f6a	d4afe5c4-877b-40ce-bf63-aa7000a87ee7	Хеслехолм ИФ and Over 3.5	BOver	active	30		\N		2	3	Хеслехолм ИФ and Over 3.5	5026360_12111101_46432040
e1dfd754-01b9-4bcb-b15b-aa7000a87f95	2cb5ad81-8405-4aeb-9e65-aa7000a87f7f	ФК Карлскрона and Under 2.5	AUnder	active	5.45		\N		1	1	ФК Карлскрона and Under 2.5	5026360_12111082_46431925
0b79f679-f0ed-4596-8c05-aa7000a87fac	2cb5ad81-8405-4aeb-9e65-aa7000a87f7f	Draw and Under 2.5	XUnder	active	10.5		\N		1	2	Draw and Under 2.5	5026360_12111082_46431931
a621fd1e-543d-4629-bb3a-aa7000a87fc1	2cb5ad81-8405-4aeb-9e65-aa7000a87f7f	Хеслехолм ИФ and Under 2.5	BUnder	active	28		\N		1	3	Хеслехолм ИФ and Under 2.5	5026360_12111082_46431937
0cf4fbf5-4195-4439-ae8a-aa7000a87fda	2cb5ad81-8405-4aeb-9e65-aa7000a87f7f	ФК Карлскрона and Over 2.5	AOver	active	1.53		\N		2	1	ФК Карлскрона and Over 2.5	5026360_12111082_46431946
c1863787-126d-440a-b097-aa7000a87ffa	2cb5ad81-8405-4aeb-9e65-aa7000a87f7f	Draw and Over 2.5	XOver	active	16.5		\N		2	2	Draw and Over 2.5	5026360_12111082_46431953
283dc855-9b0e-465d-a0c3-aa7000a88027	2cb5ad81-8405-4aeb-9e65-aa7000a87f7f	Хеслехолм ИФ and Over 2.5	BOver	active	14.5		\N		2	3	Хеслехолм ИФ and Over 2.5	5026360_12111082_46431957
9db530c4-614e-4f9a-9535-aa7000a88058	f2c80bfe-94ce-45f7-8b94-aa7000a88044	ФК Карлскрона and Under 4.5	AUnder	active	1.93		\N		1	1	ФК Карлскрона and Under 4.5	5026360_12111040_46431724
e4512d51-970d-4e24-bae2-aa7000a8806f	f2c80bfe-94ce-45f7-8b94-aa7000a88044	Draw and Under 4.5	XUnder	active	7.3		\N		1	2	Draw and Under 4.5	5026360_12111040_46431732
5f7e3b89-b1bc-4b9d-9a86-aa7000a88087	f2c80bfe-94ce-45f7-8b94-aa7000a88044	Хеслехолм ИФ and Under 4.5	BUnder	active	12.75		\N		1	3	Хеслехолм ИФ and Under 4.5	5026360_12111040_46431740
87138c22-eed9-49a6-8d1c-aa7000a8809e	f2c80bfe-94ce-45f7-8b94-aa7000a88044	ФК Карлскрона and Over 4.5	AOver	active	3.05		\N		2	1	ФК Карлскрона and Over 4.5	5026360_12111040_46431747
ab10e35c-ad0f-4b69-ae18-aa7000a880b5	f2c80bfe-94ce-45f7-8b94-aa7000a88044	Draw and Over 4.5	XOver	active	70		\N		2	2	Draw and Over 4.5	5026360_12111040_46431751
353165e9-d597-46b4-a673-aa7000a880cb	f2c80bfe-94ce-45f7-8b94-aa7000a88044	Хеслехолм ИФ and Over 4.5	BOver	active	40		\N		2	3	Хеслехолм ИФ and Over 4.5	5026360_12111040_46431762
dcec655c-6e65-4c02-b129-aa7000a880f7	74be2285-b310-4d21-9653-aa7000a880e2	ФК Карлскрона and Under 1.5	AUnder	active	12.5		\N		1	1	ФК Карлскрона and Under 1.5	5026360_12111061_46431826
2070f3b0-b176-45a2-abe4-aa7000a8810d	74be2285-b310-4d21-9653-aa7000a880e2	Draw and Under 1.5	XUnder	active	35		\N		1	2	Draw and Under 1.5	5026360_12111061_46431831
962240ad-f43d-414a-bac2-aa7000a88127	74be2285-b310-4d21-9653-aa7000a880e2	Хеслехолм ИФ and Under 1.5	BUnder	active	40		\N		1	3	Хеслехолм ИФ and Under 1.5	5026360_12111061_46431834
dde23eed-e1a1-4518-9107-aa7000a8813d	74be2285-b310-4d21-9653-aa7000a880e2	ФК Карлскрона and Over 1.5	AOver	active	1.33		\N		2	1	ФК Карлскрона and Over 1.5	5026360_12111061_46431840
67da8583-c06d-4d50-b3e6-aa7000a881e8	74be2285-b310-4d21-9653-aa7000a880e2	Draw and Over 1.5	XOver	active	7.55		\N		2	2	Draw and Over 1.5	5026360_12111061_46431848
99f972e3-2f24-434e-8abb-aa7000a881fd	74be2285-b310-4d21-9653-aa7000a880e2	Хеслехолм ИФ and Over 1.5	BOver	active	12.25		\N		2	3	Хеслехолм ИФ and Over 1.5	5026360_12111061_46431854
42bec3d2-1d93-4985-b3fc-aa7000a88228	83fd16ed-b9be-4e38-8146-aa7000a88213	1st Half	H1	active	2.95		\N		1	1	1st Half	5026360_12111182_46432355
2f14e051-56be-45e5-803d-aa7000a88241	83fd16ed-b9be-4e38-8146-aa7000a88213	2nd	H2	active	2.07		\N		1	2	2nd	5026360_12111182_46432362
aecd5b50-c581-475a-88b5-aa7000a8825b	83fd16ed-b9be-4e38-8146-aa7000a88213	Equal	Equal	active	3.6		\N		1	3	Equal	5026360_12111182_46432368
6d88638b-8f25-4645-ae81-aa7000a88292	059aa3e5-ed85-40f8-aec0-aa7000a88271	Yes	Yes	active	1.12		\N		1	1	Yes	5026360_12110426_46429822
58e8691e-24f3-4e3f-8d3d-aa7000a882a6	059aa3e5-ed85-40f8-aec0-aa7000a88271	No	No	active	4.9		\N		1	2	No	5026360_12110426_46429823
c248650b-b48c-4af8-8bce-aa7000a882d0	a94dc409-5caf-42a3-9728-aa7000a882ba	No/Over 2.5	YUnder	active	14.5		\N		1	1	No/Over 2.5	5026360_12111445_46433786
3760874a-f6c8-4c4c-be3d-aa7000a882e6	a94dc409-5caf-42a3-9728-aa7000a882ba	Yes/Over 2.5	YOver	active	1.86		\N		1	2	Yes/Over 2.5	5026360_12111445_46433781
c2399322-9544-49f4-9416-aa7000a882ff	a94dc409-5caf-42a3-9728-aa7000a882ba	No/Under 2.5	NUnder	active	4.2		\N		2	1	No/Under 2.5	5026360_12111445_46433795
6ba1b6c9-77e0-4906-8ec7-aa7000a8832f	a94dc409-5caf-42a3-9728-aa7000a882ba	Yes/Under 2.5	NOver	active	3.9		\N		2	2	Yes/Under 2.5	5026360_12111445_46433790
6a749e9b-58ed-44a0-b4fa-aa7000a88359	0e941709-e23e-4e14-af4d-aa7000a88343	ФК Карлскрона/Draw and Yes	AXYes	active	2.9		\N		1	1	ФК Карлскрона/Draw and Yes	5026360_12111460_46433856
6ecd10da-6430-4815-bc62-aa7000a8836f	0e941709-e23e-4e14-af4d-aa7000a88343	ФК Карлскрона/Хеслехолм ИФ and Yes	ABYes	active	3.1		\N		1	2	ФК Карлскрона/Хеслехолм ИФ and Yes	5026360_12111460_46433868
15fdc09e-48f3-41a4-9eed-aa7000a88387	0e941709-e23e-4e14-af4d-aa7000a88343	Draw/Хеслехолм ИФ and Yes	BXYes	active	8.1		\N		1	3	Draw/Хеслехолм ИФ and Yes	5026360_12111460_46433883
28216922-5761-495b-9f17-aa7000a883a9	0e941709-e23e-4e14-af4d-aa7000a88343	ФК Карлскрона/Хеслехолм ИФ and No	ABNo	active	1.49		\N		2	2	ФК Карлскрона/Хеслехолм ИФ and No	5026360_12111460_46433874
4094d789-62cd-4088-afbf-aa7000a883c3	0e941709-e23e-4e14-af4d-aa7000a88343	Draw/Хеслехолм ИФ and No	BXNo	active	5.4		\N		2	3	Draw/Хеслехолм ИФ and No	5026360_12111460_46433889
fce35cd6-c37d-45e9-8e50-aa7000a883f6	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 2-0	0-0 2-0	active	30		\N		1	1	0-0 2-0	5026360_12111492_46434235
57c93810-b628-4865-8fa1-aa7000a88409	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 0-0	0-0 0-0	active	40		\N		1	2	0-0 0-0	5026360_12111492_46434186
d1405440-d9f0-457d-b2ff-aa7000a8841e	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 0-1	0-0 0-1	active	80		\N		1	3	0-0 0-1	5026360_12111492_46434179
c6c7a3f8-4dbc-40fe-afe3-aa7000a88435	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 2-1	0-0 2-1	active	70		\N		2	1	0-0 2-1	5026360_12111492_46434328
383125a3-008c-45c6-8480-aa7000a8844c	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 1-1	0-0 1-1	active	50		\N		2	2	0-0 1-1	5026360_12111492_46434261
4e8c2766-e18d-4690-a456-aa7000a8846f	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 3-0	0-0 3-0	active	60		\N		3	1	0-0 3-0	5026360_12111492_46434322
880e9cd6-8b15-49bb-82b2-aa7000a8849b	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 0-2	0-0 0-2	active	250		\N		2	3	0-0 0-2	5026360_12111492_46434267
ac6065f6-2f2c-4170-a564-aa7000a884b0	c53d55c5-2fe3-4006-b634-aa7000a883de	1-0 1-1	1-0 1-1	active	60		\N		3	2	1-0 1-1	5026360_12111492_46434220
8bac5913-1fa7-48c4-a8ac-aa7000a884c7	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 1-2	0-0 1-2	active	200		\N		3	3	0-0 1-2	5026360_12111492_46434380
539b66f0-3d59-4184-9277-aa7000a884dd	c53d55c5-2fe3-4006-b634-aa7000a883de	1-0 1-0	1-0 1-0	active	35		\N		4	1	1-0 1-0	5026360_12111492_46434214
27bd982b-0a7c-404c-bbab-aa7000a884ff	c53d55c5-2fe3-4006-b634-aa7000a883de	0-1 1-1	0-1 1-1	active	70		\N		4	2	0-1 1-1	5026360_12111492_46434337
a597a2d0-90b7-43d4-917e-aa7000a88518	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 0-3	0-0 0-3	active	250		\N		4	3	0-0 0-3	5026360_12111492_46434387
6f5a353d-b130-4280-9971-aa7000a88531	c53d55c5-2fe3-4006-b634-aa7000a883de	1-0 2-0	1-0 2-0	active	20		\N		5	1	1-0 2-0	5026360_12111492_46434374
c9eab792-ec2c-4761-9a3a-aa7000a88547	c53d55c5-2fe3-4006-b634-aa7000a883de	1-1 1-1	1-1 1-1	active	80		\N		5	2	1-1 1-1	5026360_12111492_46434349
2e2bf3fa-3b9b-4da7-ade9-aa7000a88561	c53d55c5-2fe3-4006-b634-aa7000a883de	0-1 0-1	0-1 0-1	active	100		\N		5	3	0-1 0-1	5026360_12111492_46434274
a56d0987-660b-4efb-9229-aa7000a88573	c53d55c5-2fe3-4006-b634-aa7000a883de	1-0 2-1	1-0 2-1	active	40		\N		6	1	1-0 2-1	5026360_12111492_46434297
fda406eb-7707-48cc-ba62-aa7000a88589	c53d55c5-2fe3-4006-b634-aa7000a883de	0-0 4plus	0-0 4plus	active	35		\N		6	2	0-0 4plus	5026360_12111492_46434447
351ca8ac-8640-4b4a-92b9-aa7000a885a1	c53d55c5-2fe3-4006-b634-aa7000a883de	0-1 0-2	0-1 0-2	active	200		\N		6	3	0-1 0-2	5026360_12111492_46434355
be4cc5ed-dfc8-4d40-ba55-aa7000a885ba	c53d55c5-2fe3-4006-b634-aa7000a883de	1-0 1-2	1-0 1-2	active	200		\N		7	1	1-0 1-2	5026360_12111492_46434200
f16c7b59-6a1c-4a77-8c91-aa7000a88609	c53d55c5-2fe3-4006-b634-aa7000a883de	1-0 4plus	1-0 4plus	active	11.25		\N		7	2	1-0 4plus	5026360_12111492_46434456
0df515a5-0fae-4092-8f3f-aa7000a88622	c53d55c5-2fe3-4006-b634-aa7000a883de	0-1 1-2	0-1 1-2	active	125		\N		7	3	0-1 1-2	5026360_12111492_46434364
5db49c7a-d2f3-4c23-a5c9-aa7000a8863f	c53d55c5-2fe3-4006-b634-aa7000a883de	1-0 3-0	1-0 3-0	active	24.5		\N		8	1	1-0 3-0	5026360_12111492_46434452
fc61eee6-604d-47c2-a4e0-aa7000a8882e	c53d55c5-2fe3-4006-b634-aa7000a883de	0-1 4plus	0-1 4plus	active	35		\N		8	2	0-1 4plus	5026360_12111492_46434462
52c6ce3f-040a-49dd-a6bb-aa7000a88840	c53d55c5-2fe3-4006-b634-aa7000a883de	0-1 2-1	0-1 2-1	active	80		\N		8	3	0-1 2-1	5026360_12111492_46434241
d937060a-cb76-4d1a-9a0d-aa7000a88856	c53d55c5-2fe3-4006-b634-aa7000a883de	1-1 2-1	1-1 2-1	active	50		\N		9	1	1-1 2-1	5026360_12111492_46434282
38cb2ad0-9b63-490d-9921-aa7000a8886c	c53d55c5-2fe3-4006-b634-aa7000a883de	1-1 4plus	1-1 4plus	active	16.25		\N		9	2	1-1 4plus	5026360_12111492_46434343
4e82eeb9-32ce-474b-9ebb-aa7000a8887e	c53d55c5-2fe3-4006-b634-aa7000a883de	0-1 0-3	0-1 0-3	active	250		\N		9	3	0-1 0-3	5026360_12111492_46434311
e9ba2625-a277-446a-867b-aa7000a8888c	c53d55c5-2fe3-4006-b634-aa7000a883de	2-0 2-0	2-0 2-0	active	55		\N		10	1	2-0 2-0	5026360_12111492_46434423
a757811c-67b0-4e32-8696-aa7000a8889d	c53d55c5-2fe3-4006-b634-aa7000a883de	2-0 4plus	2-0 4plus	active	9.65		\N		10	2	2-0 4plus	5026360_12111492_46434433
1a44feff-a52c-4a26-b404-aa7000a888af	c53d55c5-2fe3-4006-b634-aa7000a883de	1-1 1-2	1-1 1-2	active	150		\N		10	3	1-1 1-2	5026360_12111492_46434192
b99632ba-a4a0-419b-ad40-aa7000a888c0	c53d55c5-2fe3-4006-b634-aa7000a883de	2-0 2-1	2-0 2-1	active	100		\N		11	1	2-0 2-1	5026360_12111492_46434428
c9a041b2-6e84-4458-b50e-aa7000a888cf	c53d55c5-2fe3-4006-b634-aa7000a883de	0-2 4plus	0-2 4plus	active	100		\N		11	2	0-2 4plus	5026360_12111492_46434291
55e4487d-ea6f-48c5-9b8b-aa7000a888dd	c53d55c5-2fe3-4006-b634-aa7000a883de	0-2 0-2	0-2 0-2	active	250		\N		11	3	0-2 0-2	5026360_12111492_46434317
4c95382c-c478-4b4f-ab89-aa7000a888ed	c53d55c5-2fe3-4006-b634-aa7000a883de	2-1 2-1	2-1 2-1	active	125		\N		12	1	2-1 2-1	5026360_12111492_46434226
9f37c6cc-ef7a-4f14-88d3-aa7000a88908	c53d55c5-2fe3-4006-b634-aa7000a883de	2-1 4plus	2-1 4plus	active	17.25		\N		12	2	2-1 4plus	5026360_12111492_46434303
65fbcb4b-bc35-4869-9fd1-aa7000a8891c	c53d55c5-2fe3-4006-b634-aa7000a883de	0-2 1-2	0-2 1-2	active	250		\N		12	3	0-2 1-2	5026360_12111492_46434205
52c48106-e827-4535-8d9a-aa7000a88932	c53d55c5-2fe3-4006-b634-aa7000a883de	2-0 3-0	2-0 3-0	active	30		\N		13	1	2-0 3-0	5026360_12111492_46434467
4389f19f-a9b4-46a5-9fdf-aa7000a88948	c53d55c5-2fe3-4006-b634-aa7000a883de	1-2 4plus	1-2 4plus	active	55		\N		13	2	1-2 4plus	5026360_12111492_46434396
071a4a60-aff6-4998-8da1-aa7000a88984	c53d55c5-2fe3-4006-b634-aa7000a883de	1-2 1-2	1-2 1-2	active	250		\N		13	3	1-2 1-2	5026360_12111492_46434418
4779ac85-afb7-4ab6-a9ea-aa7000a8899d	c53d55c5-2fe3-4006-b634-aa7000a883de	3-0 3-0	3-0 3-0	active	125		\N		14	1	3-0 3-0	5026360_12111492_46434412
e1c966b0-c6f5-4b16-a725-aa7000a889b2	c53d55c5-2fe3-4006-b634-aa7000a883de	3-0 4plus	3-0 4plus	active	16		\N		14	2	3-0 4plus	5026360_12111492_46434369
d1124e26-2302-471b-9f22-aa7000a889c7	c53d55c5-2fe3-4006-b634-aa7000a883de	0-2 0-3	0-2 0-3	active	250		\N		14	3	0-2 0-3	5026360_12111492_46434247
6b386057-c99e-48ae-9f3f-aa7000a889de	c53d55c5-2fe3-4006-b634-aa7000a883de	0-3 4plus	0-3 4plus	active	250		\N		15	2	0-3 4plus	5026360_12111492_46434440
88a97f40-8fad-4b07-9885-aa7000a889f5	c53d55c5-2fe3-4006-b634-aa7000a883de	0-3 0-3	0-3 0-3	active	250		\N		15	3	0-3 0-3	5026360_12111492_46434254
9ac2af76-0800-4464-898a-aa7000a88a09	c53d55c5-2fe3-4006-b634-aa7000a883de	4plus 4plus	4plus 4plus	active	10.25		\N		16	2	4plus 4plus	5026360_12111492_46434406
fa15a727-4df3-4ec2-b396-aa7000a88a43	e92a642d-7c9f-454a-96c9-aa7000a88a22	Fk Karlskrona	A	active	2.33		\N		1	1	Fk Karlskrona	5026360_12111687_46436134
aca45958-00f9-44b4-b290-aa7000a88a58	e92a642d-7c9f-454a-96c9-aa7000a88a22	Both	Both	active	1.66		\N		1	2	Both	5026360_12111687_46436141
58a653c9-98c3-45f5-b6d3-aa7000a88a70	e92a642d-7c9f-454a-96c9-aa7000a88a22	Хеслехолм ИФ	B	active	24.5		\N		1	3	Хеслехолм ИФ	5026360_12111687_46436138
5d3b7908-8c51-4dbc-a69d-aa7000a88a84	e92a642d-7c9f-454a-96c9-aa7000a88a22	None	None	active	35		\N		2	1	None	5026360_12111687_46436130
7f273916-8fa4-48cd-8e79-aa7000a88ac6	26ccf8a4-95bf-48df-953e-aa7000a88a98	ФК Карлскрона by exactly 1	A1	active	4.6		\N		1	1	ФК Карлскрона by exactly 1	5026360_12111667_46436002
6fb164d8-a633-47e9-a85d-aa7000a88aec	26ccf8a4-95bf-48df-953e-aa7000a88a98	Draw	X	active	6.75		\N		1	2	Draw	5026360_12111667_46435981
2dd38223-e989-4f19-8955-aa7000a88b01	26ccf8a4-95bf-48df-953e-aa7000a88a98	Хеслехолм ИФ by exactly 1	B1	active	14.5		\N		1	3	Хеслехолм ИФ by exactly 1	5026360_12111667_46436005
e03ae610-1cb3-424d-9975-aa7000a88b16	26ccf8a4-95bf-48df-953e-aa7000a88a98	ФК Карлскрона by exactly 2	A2	active	4.35		\N		2	1	ФК Карлскрона by exactly 2	5026360_12111667_46435994
268c038c-e100-4d18-9954-aa7000a88b2d	26ccf8a4-95bf-48df-953e-aa7000a88a98	Хеслехолм ИФ by exactly 2	B2	active	45		\N		2	3	Хеслехолм ИФ by exactly 2	5026360_12111667_46436011
62bc3b58-fbf7-468a-9c18-aa7000a88b43	26ccf8a4-95bf-48df-953e-aa7000a88a98	ФК Карлскрона by greater than 2	A>2	active	2.47		\N		3	1	ФК Карлскрона by greater than 2	5026360_12111667_46435987
32a3edee-5a8c-49a9-bd2a-aa7000a88b57	26ccf8a4-95bf-48df-953e-aa7000a88a98	Хеслехолм ИФ by greater than 2	B>2	active	125		\N		3	3	Хеслехолм ИФ by greater than 2	5026360_12111667_46436017
ddcae1bb-3c6b-431b-bde2-aa7000a88b82	15cc2b42-e090-46dc-8220-aa7000a88b6d	ФК Карлскрона/Yes	AYes	active	2.33		\N		1	1	ФК Карлскрона/Yes	5026360_12111613_46435570
731ef2ec-265d-4884-9290-aa7000a88b96	15cc2b42-e090-46dc-8220-aa7000a88b6d	Draw/Yes	XYes	active	8.05		\N		1	2	Draw/Yes	5026360_12111613_46435577
306cf0d1-0613-4e92-86b9-aa7000a88bb0	15cc2b42-e090-46dc-8220-aa7000a88b6d	Хеслехолм ИФ/Yes	BYes	active	16.25		\N		1	3	Хеслехолм ИФ/Yes	5026360_12111613_46435588
c5a1038a-f3b0-49bd-9881-aa7000a88bc5	15cc2b42-e090-46dc-8220-aa7000a88b6d	ФК Карлскрона/No	ANo	active	2.38		\N		2	1	ФК Карлскрона/No	5026360_12111613_46435573
e5f3d5eb-095a-4b65-a49e-aa7000a88bd9	15cc2b42-e090-46dc-8220-aa7000a88b6d	Draw/No	XNo	active	40		\N		2	2	Draw/No	5026360_12111613_46435583
8caac04a-b979-4683-bf9e-aa7000a88bf3	15cc2b42-e090-46dc-8220-aa7000a88b6d	Хеслехолм ИФ/No	BNo	active	26.5		\N		2	3	Хеслехолм ИФ/No	5026360_12111613_46435603
542c1df5-a6af-4f14-baa5-aa7000a88c47	78094ba7-f7b2-4832-9c36-aa7000a88c0c	ФК Карлскрона/Draw and Yes	AXYes	active	3.55		\N		1	1	ФК Карлскрона/Draw and Yes	5026360_12111431_46433707
6481ac73-5c30-4128-9c48-aa7000a88c69	78094ba7-f7b2-4832-9c36-aa7000a88c0c	ФК Карлскрона/Хеслехолм ИФ and Yes	ABYes	active	3.85		\N		1	2	ФК Карлскрона/Хеслехолм ИФ and Yes	5026360_12111431_46433719
cf318e6a-2038-4843-87d7-aa7000a88c83	78094ba7-f7b2-4832-9c36-aa7000a88c0c	Draw/Хеслехолм ИФ and Yes	BXYes	active	9.9		\N		1	3	Draw/Хеслехолм ИФ and Yes	5026360_12111431_46433731
9ba130ff-2b2b-4390-8ae2-aa7000a88c9b	78094ba7-f7b2-4832-9c36-aa7000a88c0c	ФК Карлскрона/Хеслехолм ИФ and No	ABNo	active	1.37		\N		2	2	ФК Карлскрона/Хеслехолм ИФ and No	5026360_12111431_46433724
f64969db-f58d-4d4d-b6a5-aa7000a88caf	78094ba7-f7b2-4832-9c36-aa7000a88c0c	Draw/Хеслехолм ИФ and No	BXNo	active	4.75		\N		2	3	Draw/Хеслехолм ИФ and No	5026360_12111431_46433737
a3bb38ba-c896-4e19-b838-aa7000a88cdc	7c3c8755-f7b3-4716-9c1c-aa7000a88cc3	ФК Карлскрона/Yes	AYes	active	8.05		\N		1	1	ФК Карлскрона/Yes	5026360_12111411_46433632
404851c7-97f4-438f-88f6-aa7000a88cf1	7c3c8755-f7b3-4716-9c1c-aa7000a88cc3	Draw/Yes	XYes	active	8		\N		1	2	Draw/Yes	5026360_12111411_46433640
cd4fa3f6-8fde-4d70-995d-aa7000a88d06	7c3c8755-f7b3-4716-9c1c-aa7000a88cc3	Хеслехолм ИФ/Yes	BYes	active	28		\N		1	3	Хеслехолм ИФ/Yes	5026360_12111411_46433650
6fa5141b-a107-41b6-851d-aa7000a88d1e	7c3c8755-f7b3-4716-9c1c-aa7000a88cc3	ФК Карлскрона/No	ANo	active	1.98		\N		2	1	ФК Карлскрона/No	5026360_12111411_46433637
93ffa15b-27e6-4d45-b15f-aa7000a88d35	7c3c8755-f7b3-4716-9c1c-aa7000a88cc3	Draw/No	XNo	active	4.9		\N		2	2	Draw/No	5026360_12111411_46433643
6ee6742c-a5cd-482e-8a39-aa7000a88d4b	7c3c8755-f7b3-4716-9c1c-aa7000a88cc3	Хеслехолм ИФ/No	BNo	active	9.35		\N		2	3	Хеслехолм ИФ/No	5026360_12111411_46433655
588cedcb-3ec0-4d7d-b0c3-aa7000a88d7d	101eef35-8e96-4730-bec8-aa7000a88d63	0	MR_0	active	1.86		\N		1	1	0	5026360_12111374_46433497
5d9f9c21-c47b-4829-95bd-aa7000a88db6	101eef35-8e96-4730-bec8-aa7000a88d63	1-2	MR_1-2	active	1.54		\N		1	2	1-2	5026360_12111374_46433500
5b5be9ea-4c38-401b-ae9d-aa7000a88ddd	101eef35-8e96-4730-bec8-aa7000a88d63	1-3	MR_1-3	active	1.44		\N		1	3	1-3	5026360_12111374_46433504
9fcad2b1-b4aa-4959-aff4-aa7000a88dfb	101eef35-8e96-4730-bec8-aa7000a88d63	2-3	MR_2-3	active	3.15		\N		2	1	2-3	5026360_12111374_46433509
83bb3413-f137-42b7-8bb9-aa7000a88e14	101eef35-8e96-4730-bec8-aa7000a88d63	4+	MR_4+	active	25.5		\N		3	1	4+	5026360_12111374_46433516
de671d2f-1593-4d1b-9f8c-aa7000a88e3d	c33a936f-b5a7-434a-9e48-aa7000a88e28	Fk Karlskrona	A	active	1.12		\N		1	1	Fk Karlskrona	5026360_12111340_46433390
c5e0164b-260a-47e6-8433-aa7000a88e53	c33a936f-b5a7-434a-9e48-aa7000a88e28	Хеслехолм ИФ	B	active	4.8		\N		1	2	Хеслехолм ИФ	5026360_12111340_46433396
ff50f33f-38b0-436c-9908-aa7000a88e84	d12389a4-486d-4404-9d4e-aa7000a88e6a	Odd	Odd	active	2.13		\N		1	1	Odd	5026360_12111311_46433230
2918334f-d7d0-44c0-bb64-aa7000a88e9b	d12389a4-486d-4404-9d4e-aa7000a88e6a	Even	Even	active	1.58		\N		1	2	Even	5026360_12111311_46433238
3d146495-9a40-4c0e-b1d1-aa7000a88ec4	59b42541-a5c3-4134-9ab6-aa7000a88eaf	Odd	Odd	active	1.82		\N		1	1	Odd	5026360_12111289_46433099
87919c11-6f32-4076-a22b-aa7000a88ef0	59b42541-a5c3-4134-9ab6-aa7000a88eaf	Even	Even	active	1.81		\N		1	2	Even	5026360_12111289_46433107
f1db71f9-6e2c-40ab-b090-aa7000a88f3e	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	0	MR_0	active	17.25		\N		1	1	0	5026360_12111268_46432943
4b64947d-f642-4434-bb55-aa7000a88f51	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	1-2	MR_1-2	active	2.75		\N		1	2	1-2	5026360_12111268_46432951
55f4ff0d-5bf9-401b-92eb-aa7000a89209	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	1-4	MR_1-4	active	1.32		\N		2	1	1-4	5026360_12111268_46432965
c82b971e-fb1e-4357-8746-aa7000a89220	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	1-3	MR_1-3	active	1.71		\N		1	3	1-3	5026360_12111268_46432940
41cb7797-200e-4a89-a449-aa7000a8923f	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	1-5	MR_1-5	active	1.16		\N		2	2	1-5	5026360_12111268_46432971
2fa930ca-4c51-4c5a-b2eb-aa7000a89258	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	2-3	MR_2-3	active	2		\N		3	1	2-3	5026360_12111268_46432983
61603d14-7a0c-4e02-9a56-aa7000a8926d	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	1-6	MR_1-6	active	1.07		\N		2	3	1-6	5026360_12111268_46432976
9befa1bb-ac98-4fac-a02d-aa7000a8927e	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	2-4	MR_2-4	active	1.46		\N		3	2	2-4	5026360_12111268_46433005
f23053b8-e619-440d-b8bf-aa7000a89294	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	2-6	MR_2-6	active	1.15		\N		4	1	2-6	5026360_12111268_46433025
98641cbf-8e3c-4aa4-8d27-aa7000a892a9	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	2-5	MR_2-5	active	1.24		\N		3	3	2-5	5026360_12111268_46433016
9555cec9-8ab0-47f2-adc5-aa7000a892bf	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	3-4	MR_3-4	active	1.89		\N		4	2	3-4	5026360_12111268_46433055
8020abdf-ff4b-437d-be61-aa7000a892d5	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	3-5	MR_3-5	active	1.5		\N		4	3	3-5	5026360_12111268_46433041
091828f4-4955-41bf-98bd-aa7000a892eb	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	3-6	MR_3-6	active	1.34		\N		5	1	3-6	5026360_12111268_46433048
f19497be-02f2-44ba-9e93-aa7000a89305	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	4-5	MR_4-5	active	2.13		\N		5	2	4-5	5026360_12111268_46432959
daa4dae8-4357-4760-96ca-aa7000a89330	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	4-6	MR_4-6	active	1.77		\N		5	3	4-6	5026360_12111268_46433001
bf9058a2-d8ab-45d7-9a67-aa7000a89351	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	5-6	MR_5-6	active	2.8		\N		6	2	5-6	5026360_12111268_46432991
b8574ad8-52ef-45f9-9da1-aa7000a89366	f0647b1d-cf1d-42b3-9b59-aa7000a88f2a	7+	MR_7+	active	6.3		\N		6	3	7+	5026360_12111268_46433035
3e99e091-67bb-4063-ba19-aa7000a89399	fb5ca877-595d-4feb-8f05-aa7000a89384	1st Half	H1	active	4		\N		1	1	1st Half	5026360_12111193_46432406
c163a4f5-5b6f-4e4b-a014-aa7000a893b1	fb5ca877-595d-4feb-8f05-aa7000a89384	2nd	H2	active	3.15		\N		1	2	2nd	5026360_12111193_46432417
fdb623af-1b5c-4a7b-af42-aa7000a893c8	fb5ca877-595d-4feb-8f05-aa7000a89384	Equal	Equal	active	1.88		\N		1	3	Equal	5026360_12111193_46432422
f20a9954-1383-4917-9b4d-aa7000a893f0	478b8d2e-6948-4775-b6eb-aa7000a893de	ФК Карлскрона/Draw and Yes	AXYes	active	3.15		\N		1	1	ФК Карлскрона/Draw and Yes	5026360_12111166_46432292
d92a83a5-10d1-4ea7-b89e-aa7000a89405	478b8d2e-6948-4775-b6eb-aa7000a893de	ФК Карлскрона/Хеслехолм ИФ and Yes	ABYes	active	4.8		\N		1	2	ФК Карлскрона/Хеслехолм ИФ and Yes	5026360_12111166_46432300
fbddf8a2-6d2e-4f4c-8189-aa7000a89437	478b8d2e-6948-4775-b6eb-aa7000a893de	Draw/Хеслехолм ИФ and Yes	BXYes	active	4.75		\N		1	3	Draw/Хеслехолм ИФ and Yes	5026360_12111166_46432309
eba87ecd-2ea8-4924-82e8-aa7000a89473	478b8d2e-6948-4775-b6eb-aa7000a893de	ФК Карлскрона/Draw and No	AXNo	active	1.3		\N		2	1	ФК Карлскрона/Draw and No	5026360_12111166_46432295
d3047203-97e0-4c8b-a63a-aa7000a894ad	478b8d2e-6948-4775-b6eb-aa7000a893de	ФК Карлскрона/Хеслехолм ИФ and No	ABNo	active	1.45		\N		2	2	ФК Карлскрона/Хеслехолм ИФ and No	5026360_12111166_46432303
c71de57b-4084-43b0-b1f1-aa7000a894c9	478b8d2e-6948-4775-b6eb-aa7000a893de	Draw/Хеслехолм ИФ and No	BXNo	active	2.58		\N		2	3	Draw/Хеслехолм ИФ and No	5026360_12111166_46432315
830417be-f6bd-4842-93b1-aa7000a894f4	e1d614a0-fa06-4836-b3ec-aa7000a894df	ФК Карлскрона/Draw and Yes	AXYes	active	1.76		\N		1	1	ФК Карлскрона/Draw and Yes	5026360_12111147_46432214
92735df6-04b2-4bf9-8195-aa7000a89509	e1d614a0-fa06-4836-b3ec-aa7000a894df	ФК Карлскрона/Хеслехолм ИФ and Yes	ABYes	active	1.94		\N		1	2	ФК Карлскрона/Хеслехолм ИФ and Yes	5026360_12111147_46432223
2de886fd-910c-4881-b89d-aa7000a8951e	e1d614a0-fa06-4836-b3ec-aa7000a894df	Draw/Хеслехолм ИФ and Yes	BXYes	active	4.7		\N		1	3	Draw/Хеслехолм ИФ and Yes	5026360_12111147_46432232
38bf5d46-c6fa-4d11-bf44-aa7000a89535	e1d614a0-fa06-4836-b3ec-aa7000a894df	ФК Карлскрона/Draw and No	AXNo	active	2.11		\N		2	1	ФК Карлскрона/Draw and No	5026360_12111147_46432219
bd47bad1-a415-4340-95d0-aa7000a8954c	e1d614a0-fa06-4836-b3ec-aa7000a894df	ФК Карлскрона/Хеслехолм ИФ and No	ABNo	active	2.06		\N		2	2	ФК Карлскрона/Хеслехолм ИФ and No	5026360_12111147_46432227
d9d9f59f-b147-45c4-ac27-aa7000a89584	e1d614a0-fa06-4836-b3ec-aa7000a894df	Draw/Хеслехолм ИФ and No	BXNo	active	11.5		\N		2	3	Draw/Хеслехолм ИФ and No	5026360_12111147_46432237
4eec90a4-d2ef-468e-8227-aa7000a895b0	fa4c07fa-d08d-4a54-917f-aa7000a89599	ФК Карлскрона/Draw  Under 3.5	AXUnder	active	2.07		\N		1	1	ФК Карлскрона/Draw  Under 3.5	5026360_12110990_46431485
1c4261a7-1504-4a52-9887-aa7000a895c8	fa4c07fa-d08d-4a54-917f-aa7000a89599	ФК Карлскрона/Хеслехолм ИФ - Under 3.5	ABUnder	active	2.17		\N		1	2	ФК Карлскрона/Хеслехолм ИФ - Under 3.5	5026360_12110990_46431490
83e39bd6-d1c2-4d3b-8374-aa7000a895ff	fa4c07fa-d08d-4a54-917f-aa7000a89599	Draw/Хеслехолм ИФ  Under 3.5	XBUnder	active	5.4		\N		1	3	Draw/Хеслехолм ИФ  Under 3.5	5026360_12110990_46431497
779f6940-d9d6-4953-bca3-aa7000a89616	fa4c07fa-d08d-4a54-917f-aa7000a89599	ФК Карлскрона/Draw  Over 3.5	AXOver	active	1.79		\N		2	1	ФК Карлскрона/Draw  Over 3.5	5026360_12110990_46431504
9c5f52f6-0bb9-4b0f-873d-aa7000a8962b	fa4c07fa-d08d-4a54-917f-aa7000a89599	ФК Карлскрона/Хеслехолм ИФ  Over 3.5	ABOver	active	1.87		\N		2	2	ФК Карлскрона/Хеслехолм ИФ  Over 3.5	5026360_12110990_46431511
5883e472-20b8-4981-9c85-aa7000a89641	fa4c07fa-d08d-4a54-917f-aa7000a89599	Draw/Хеслехолм ИФ  Over 3.5	XBOver	active	8.65		\N		2	3	Draw/Хеслехолм ИФ  Over 3.5	5026360_12110990_46431518
a79a3dba-22a6-41fe-9d7b-aa7000a8966e	e8bc3aaa-db43-4464-8030-aa7000a89656	ФК Карлскрона/Draw  Under 2.5	AXUnder	active	3.25		\N		1	1	ФК Карлскрона/Draw  Under 2.5	5026360_12110972_46431387
1dd9ac9c-2717-41d3-a531-aa7000a89686	e8bc3aaa-db43-4464-8030-aa7000a89656	ФК Карлскрона/Хеслехолм ИФ - Under 2.5	ABUnder	active	4		\N		1	2	ФК Карлскрона/Хеслехолм ИФ - Under 2.5	5026360_12110972_46431391
e9297d87-8d72-4c49-acb2-aa7000a8969f	e8bc3aaa-db43-4464-8030-aa7000a89656	Draw/Хеслехолм ИФ  Under 2.5	XBUnder	active	6.35		\N		1	3	Draw/Хеслехолм ИФ  Under 2.5	5026360_12110972_46431400
b996cc84-8b4e-4b3f-8f48-aa7000a896b7	e8bc3aaa-db43-4464-8030-aa7000a89656	ФК Карлскрона/Draw  Over 2.5	AXOver	active	1.37		\N		2	1	ФК Карлскрона/Draw  Over 2.5	5026360_12110972_46431405
4744db4a-3db8-4a33-a11f-aa7000a896d3	e8bc3aaa-db43-4464-8030-aa7000a89656	ФК Карлскрона/Хеслехолм ИФ  Over 2.5	ABOver	active	1.35		\N		2	2	ФК Карлскрона/Хеслехолм ИФ  Over 2.5	5026360_12110972_46431412
7526f119-d3f6-4066-b097-aa7000a896e9	e8bc3aaa-db43-4464-8030-aa7000a89656	Draw/Хеслехолм ИФ  Over 2.5	XBOver	active	6.45		\N		2	3	Draw/Хеслехолм ИФ  Over 2.5	5026360_12110972_46431422
5b5c97ee-6a5f-4817-bb00-aa7000a89717	514e7a2c-80e9-46e8-b16d-aa7000a89701	ФК Карлскрона/Draw  Under 1.5	AXUnder	active	6.95		\N		1	1	ФК Карлскрона/Draw  Under 1.5	5026360_12110958_46431303
111114bf-c663-427e-ac3c-aa7000a89739	514e7a2c-80e9-46e8-b16d-aa7000a89701	ФК Карлскрона/Хеслехолм ИФ - Under 1.5	ABUnder	active	7.1		\N		1	2	ФК Карлскрона/Хеслехолм ИФ - Under 1.5	5026360_12110958_46431306
52e5e5d1-d818-49d8-95a2-aa7000a8976c	514e7a2c-80e9-46e8-b16d-aa7000a89701	Draw/Хеслехолм ИФ  Under 1.5	XBUnder	active	11.75		\N		1	3	Draw/Хеслехолм ИФ  Under 1.5	5026360_12110958_46431309
319ce7d7-1c21-45e5-bf2c-aa7000a89783	514e7a2c-80e9-46e8-b16d-aa7000a89701	ФК Карлскрона/Draw  Over 1.5	AXOver	active	1.14		\N		2	1	ФК Карлскрона/Draw  Over 1.5	5026360_12110958_46431315
55c5004e-a51c-4c70-be94-aa7000a89798	514e7a2c-80e9-46e8-b16d-aa7000a89701	ФК Карлскрона/Хеслехолм ИФ  Over 1.5	ABOver	active	1.19		\N		2	2	ФК Карлскрона/Хеслехолм ИФ  Over 1.5	5026360_12110958_46431323
fe8b781b-e7ff-4feb-9b94-aa7000a897b0	514e7a2c-80e9-46e8-b16d-aa7000a89701	Draw/Хеслехолм ИФ  Over 1.5	XBOver	active	3.95		\N		2	3	Draw/Хеслехолм ИФ  Over 1.5	5026360_12110958_46431328
49ec6c0f-080a-422c-8ab8-aa7000a897dc	9461c0c0-8867-4834-8a0b-aa7000a897c6	ФК Карлскрона/Draw  Under 4.5	AXUnder	active	1.51		\N		1	1	ФК Карлскрона/Draw  Under 4.5	5026360_12110946_46431228
88251344-6858-4dfa-9502-aa7000a897f6	9461c0c0-8867-4834-8a0b-aa7000a897c6	ФК Карлскрона/Хеслехолм ИФ - Under 4.5	ABUnder	active	1.63		\N		1	2	ФК Карлскрона/Хеслехолм ИФ - Under 4.5	5026360_12110946_46431234
a84bfc71-8781-4118-9191-aa7000a8980e	9461c0c0-8867-4834-8a0b-aa7000a897c6	Draw/Хеслехолм ИФ  Under 4.5	XBUnder	active	4.15		\N		1	3	Draw/Хеслехолм ИФ  Under 4.5	5026360_12110946_46431239
10aa7051-4bb4-42f3-8ce9-aa7000a89840	9461c0c0-8867-4834-8a0b-aa7000a897c6	ФК Карлскрона/Draw  Over 4.5	AXOver	active	2.65		\N		2	1	ФК Карлскрона/Draw  Over 4.5	5026360_12110946_46431245
70c72690-1df0-4fed-979a-aa7000a8985b	9461c0c0-8867-4834-8a0b-aa7000a897c6	ФК Карлскрона/Хеслехолм ИФ  Over 4.5	ABOver	active	2.61		\N		2	2	ФК Карлскрона/Хеслехолм ИФ  Over 4.5	5026360_12110946_46431252
79559bbd-c272-416a-a7ad-aa7000a89873	9461c0c0-8867-4834-8a0b-aa7000a897c6	Draw/Хеслехолм ИФ  Over 4.5	XBOver	active	16.5		\N		2	3	Draw/Хеслехолм ИФ  Over 4.5	5026360_12110946_46431255
0b4a468e-58c5-4111-8d17-aa7000a898ca	80b72081-ab04-4c30-b7eb-aa7000a8988c	ФК Карлскрона/Yes	AYes	active	5.6		\N		1	1	ФК Карлскрона/Yes	5026360_12110931_46431148
49d4946a-c88a-4288-ad7b-aa7000a898eb	80b72081-ab04-4c30-b7eb-aa7000a8988c	Draw/Yes	XYes	active	7.45		\N		1	2	Draw/Yes	5026360_12110931_46431162
b8c286b6-1169-43ef-a11f-aa7000a89905	80b72081-ab04-4c30-b7eb-aa7000a8988c	Хеслехолм ИФ/Yes	BYes	active	26		\N		1	3	Хеслехолм ИФ/Yes	5026360_12110931_46431173
093b20ad-d622-4c1c-acb1-aa7000a8991b	80b72081-ab04-4c30-b7eb-aa7000a8988c	ФК Карлскрона/No	ANo	active	1.91		\N		2	1	ФК Карлскрона/No	5026360_12110931_46431159
0516fb8e-777d-41ee-b099-aa7000a89931	80b72081-ab04-4c30-b7eb-aa7000a8988c	Draw/No	XNo	active	7.4		\N		2	2	Draw/No	5026360_12110931_46431167
cfb43542-be18-463d-afb6-aa7000a8994c	80b72081-ab04-4c30-b7eb-aa7000a8988c	Хеслехолм ИФ/No	BNo	active	11		\N		2	3	Хеслехолм ИФ/No	5026360_12110931_46431177
f2fde9f0-77ac-4c33-b42a-aa7000a8997a	58cae90a-3ca1-4852-98da-aa7000a89960	Fk Karlskrona	A	active	1.14		\N		1	1	Fk Karlskrona	5026360_12110849_46430830
7812c93a-be8e-4ce6-8f05-aa7000a89991	58cae90a-3ca1-4852-98da-aa7000a89960	Хеслехолм ИФ	B	active	4.55		\N		1	2	Хеслехолм ИФ	5026360_12110849_46430835
75784e13-d2cb-49e3-9ed5-aa7000a899c0	11211fa9-a0b2-427a-bcc7-aa7000a899a9	Yes	Yes	active	3.75		\N		1	1	Yes	5026360_12110453_46429881
61f36b71-f0de-4ad5-8feb-aa7000a899d1	11211fa9-a0b2-427a-bcc7-aa7000a899a9	No	No	active	1.2		\N		1	2	No	5026360_12110453_46429886
0a54ebe4-c0dd-4d87-b219-aa7000a89a26	31ed6a99-f86c-46a6-a682-aa7000a89a00	Asarums IF FK	A	active	2.37		\N		1	1	Asarums IF FK	5029984_12095355_46379846
5cbc81b5-d981-4ceb-a314-aa7000a89a44	31ed6a99-f86c-46a6-a682-aa7000a89a00	Draw	X	active	3.55		\N		1	2	Draw	5029984_12095355_46379848
ac20d365-090e-4c13-8cf4-aa7000a89a5a	31ed6a99-f86c-46a6-a682-aa7000a89a00	Dalstorps If	B	active	2.51		\N		1	3	Dalstorps If	5029984_12095355_46379849
66e7ad64-8bac-4791-9f10-aa7000a89a8b	545eaceb-138b-456b-b441-aa7000a89a71	Асарумс ИФ ФК or Draw	AX	active	1.38		\N		1	1	Асарумс ИФ ФК or Draw	5029984_12095350_46379817
b2a01f66-ba84-42e5-9109-aa7000a89aa9	545eaceb-138b-456b-b441-aa7000a89a71	Асарумс ИФ ФК or Dalstorps If	AB	active	1.22		\N		1	2	Асарумс ИФ ФК or Dalstorps If	5029984_12095350_46379819
982fe6fe-4418-4935-afb2-aa7000a89ac3	545eaceb-138b-456b-b441-aa7000a89a71	Draw or Dalstorps If	BX	active	1.42		\N		1	3	Draw or Dalstorps If	5029984_12095350_46379821
ce2a9991-23d6-40f7-b2f9-aa7000a89afa	2e690cea-1c7a-4334-841c-aa7000a89adf	Asarums IF FK	A	active	1.94		\N		1	1	Asarums IF FK	5029984_12095352_46379833
a975bcb3-66c1-475f-94de-aa7000a89b13	2e690cea-1c7a-4334-841c-aa7000a89adf	Dalstorps If	B	active	2.06		\N		1	2	Dalstorps If	5029984_12095352_46379835
36433d42-7b23-4184-98f6-aa7000a89b63	8e786953-1da8-4e8f-b27f-aa7000a89b44	Raslatts Sk or Draw	AX	active	1.53		\N		1	1	Raslatts Sk or Draw	5029982_12095283_46379584
c958c64a-9fab-42ca-aa85-aa7000a89b87	8e786953-1da8-4e8f-b27f-aa7000a89b44	Raslatts Sk or Rappe Goif	AB	active	1.23		\N		1	2	Raslatts Sk or Rappe Goif	5029982_12095283_46379585
883d8a27-248e-4dcb-b2b0-aa7000a89ba9	8e786953-1da8-4e8f-b27f-aa7000a89b44	Draw or Rappe Goif	BX	active	1.27		\N		1	3	Draw or Rappe Goif	5029982_12095283_46379588
321613e0-0b00-4116-b5b8-aa7000a89bdb	5526f50e-2d21-412a-94e0-aa7000a89bbe	Raslatts SK	A	active	3.05		\N		1	1	Raslatts SK	5029982_12095291_46379610
721f68f5-5f8f-46c6-b56b-aa7000a89bf2	5526f50e-2d21-412a-94e0-aa7000a89bbe	Draw	X	active	3.45		\N		1	2	Draw	5029982_12095291_46379613
46e6c696-9acc-4751-bfe5-aa7000a89c22	5526f50e-2d21-412a-94e0-aa7000a89bbe	Rappe Goif	B	active	2.08		\N		1	3	Rappe Goif	5029982_12095291_46379614
10a5aa91-2345-4bb9-b93e-aa7000a89c4d	7541aaed-e471-4332-a2da-aa7000a89c37	Raslatts SK	A	active	2.51		\N		1	1	Raslatts SK	5029982_12095289_46379597
294ac021-ed91-403e-91fb-aa7000a89c65	7541aaed-e471-4332-a2da-aa7000a89c37	Rappe Goif	B	active	1.66		\N		1	2	Rappe Goif	5029982_12095289_46379599
\.


--
-- TOC entry 3124 (class 0 OID 16635)
-- Dependencies: 186
-- Data for Name: sports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sports (id, name, priority, sportid, highlight, long_name, short_name, very_short_name, num_events, num_inplay_events) FROM stdin;
a11acee2-1213-4435-8e2e-aa70008304a2	Football	0	s-SOCCER	f	\N	\N	\N	143	0
16778d3f-b38b-4238-a735-aa70008309f8	Speedway	0	s-SPEEDWAY	f	\N	\N	\N	1	0
bfc73eee-6fd7-4fca-90ff-aa7000830a17	Motor Bikes	0	s-MOTOR_BIKES	f	\N	\N	\N	1	0
28b1b040-fbd9-4f9b-b1b4-aa7000830a32	Basketball	0	s-BASKETBALL	f	\N	\N	\N	15	0
ee013ec2-2f30-4f5d-bb57-aa7000830b28	Baseball	0	s-BASEBALL	f	\N	\N	\N	16	0
73b1ba5a-d825-4b17-9bd4-aa7000830b79	Aussie rules	0	s-AUSSIE_RULES	f	\N	\N	\N	4	0
dd57cf5d-fbdf-4d4d-ba36-aa7000830b9c	Bowls	0	s-BOWLS	f	\N	\N	\N	2	0
9436ab37-fd10-418a-865c-aa7000830bb4	Darts	0	s-DARTS	f	\N	\N	\N	2	0
2bc46c68-1cd1-41fa-b371-aa7000830bf6	Cricket	0	s-CRICKET	f	\N	\N	\N	11	0
0098ac51-2fe8-4cb0-9fe3-aa7000830c2b	Boxing	0	s-BOXING	f	\N	\N	\N	2	0
68f3f8e7-0645-4e43-bf0b-aa7000830c4c	Rugby L	0	s-RUGBY_LEAGUE	f	\N	\N	\N	5	0
fdad9769-fc6d-45ed-b978-aa7000830c83	Golf	0	s-GOLF	f	\N	\N	\N	2	0
51c7f35e-5e0a-4653-8675-aa7000830cba	Handball	0	s-HANDBALL	f	\N	\N	\N	1	0
1b0c27bc-72fd-4719-a01d-aa7000830cd5	Ice Hockey	0	s-ICE_HOCKEY	f	\N	\N	\N	2	0
4babc53b-c7c2-4383-8453-aa7000830d03	Rugby U	0	s-RUGBY_UNION	f	\N	\N	\N	10	0
c2dc0253-bb6b-400a-8a99-aa7000830d83	Snooker	0	s-SNOOKER	f	\N	\N	\N	1	0
9ccb0da6-9ae6-4775-a7ad-aa7000830d9e	Tennis	0	s-TENNIS	f	\N	\N	\N	58	0
47b7a86b-c57e-4b14-9f70-aa7000830ee6	Table tennis	0	s-TABLE_TENNIS	f	\N	\N	\N	4	0
2781c87e-3d05-4b9e-8593-aa7000830f00	Volleyball	0	s-VOLLEYBALL	f	\N	\N	\N	5	0
a3dfb978-54a7-4557-8ef0-aa7000830f1d	Formula	0	s-F1	f	\N	\N	\N	2	0
bafb88af-79e2-4cdd-a6ec-aa7000830f38	Cycling	0	s-CYCLING	f	\N	\N	\N	2	0
35322432-d1c2-49eb-b577-aa7000830f6a	American Football	0	s-AMERICAN_FOOTBALL	f	\N	\N	\N	11	0
f255645d-5b83-41f5-9b75-aa7000830f97	MMA	0	s-MMA	f	\N	\N	\N	9	0
0487ad9b-8369-43c7-a06a-aa7000830fc8	Biathlon	0	s-BIATHLON	f	\N	\N	\N	2	0
a2b0a504-c77d-450f-9a97-aa7000831023	Basketball 3x3	0	s-BASKETBALL_3X3	f	\N	\N	\N	1	0
3cad8ff6-0223-4f62-a478-aa7000831041	Waterpolo	0	s-WATER_POLO	f	\N	\N	\N	1	0
\.


--
-- TOC entry 3129 (class 0 OID 16715)
-- Dependencies: 191
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY teams (id, name, event_id, ishome) FROM stdin;
cfaa9af0-364e-4823-b242-aa70008e5a51	Депортиво Ла Коруня	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	t
c8e9f127-25c1-40e5-a6c2-aa70008e5a5c	РКД Майорка	4bfa0917-8e46-4cfc-b5fd-aa70008e5a3f	f
f798c86b-4b47-4df0-add2-aa7000a76ccc	Gottne IF	37cffcfe-7e06-47a5-8664-aa7000a76cb9	t
7a130d6f-c50e-4745-8655-aa7000a76cdd	IFK Umea	37cffcfe-7e06-47a5-8664-aa7000a76cb9	f
fe3240fe-fa8b-48d0-a9a0-aa7000a76dae	Sandviks Ik	d07c331d-b8c9-45aa-9dfd-aa7000a76dae	t
55324471-2ac9-4bd6-933f-aa7000a76db1	Anundsjo If	d07c331d-b8c9-45aa-9dfd-aa7000a76dae	f
d5d38fc9-ba92-40dd-8aa6-aa7000a76dec	ИФК Йостерсунд	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	t
b1dea8be-452f-4c26-a2e3-aa7000a76df1	Kramfors-alliansen	2f5b7a88-9d78-44b8-b3ec-aa7000a76dec	f
50641d80-cfed-45bf-bdf6-aa7000a79482	ИФК Лулеа	6522de53-ee92-4402-8e31-aa7000a79482	t
22aabaf6-86b3-49be-9776-aa7000a79485	Питеаа ИФ	6522de53-ee92-4402-8e31-aa7000a79482	f
60de7e22-6dfd-4977-beb8-aa7000a81311	Ifk Hassleholm	5ad382fc-576b-4e90-a686-aa7000a81301	t
d1bf215b-4d15-4f92-bc54-aa7000a8132c	Носаби ИФ	5ad382fc-576b-4e90-a686-aa7000a81301	f
d953c020-cda2-4aa2-9ad5-aa7000a83053	IFO Bromolla IF	8b713c8a-cc4c-44fa-84e8-aa7000a83053	t
14129eec-b923-4463-9040-aa7000a83057	IFK Berga	8b713c8a-cc4c-44fa-84e8-aa7000a83053	f
abb8671a-b314-497a-bb08-aa7000a85a57	ФК Карлскрона	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	t
f9056fe8-5f2e-4bf9-bfb7-aa7000a85a5b	Хеслехолм ИФ	aa3f0dcc-a5b0-4e0f-8c1e-aa7000a85a57	f
2f3ae039-ad98-459b-bac3-aa7000a899e1	Асарумс ИФ ФК	b1047e8a-811e-4116-a030-aa7000a899e1	t
71dafefd-6a75-4325-886f-aa7000a899e5	Dalstorps If	b1047e8a-811e-4116-a030-aa7000a899e1	f
5cbda708-5aa2-45b4-996c-aa7000a89b25	Raslatts Sk	7d2b2470-78af-4d07-8d1b-aa7000a89b25	t
c4bd183d-2b43-4171-a4bc-aa7000a89b29	Rappe Goif	7d2b2470-78af-4d07-8d1b-aa7000a89b25	f
\.


--
-- TOC entry 3125 (class 0 OID 16643)
-- Dependencies: 187
-- Data for Name: tournaments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tournaments (id, name, priority, tournamentid, highlight, long_name, short_name, very_short_name, num_events, num_outright_events, "order", category_id) FROM stdin;
fbfdd2c8-4c48-4678-865c-aa7000830537	A-League	0	t-4322471	f	\N	\N	\N	0	1	0	907fb203-10ae-489f-a16c-aa7000830521
899ee3be-08c7-44ea-906d-aa7000830541	NPL, Queensland	0	t-4693007	f	\N	\N	\N	2	0	0	907fb203-10ae-489f-a16c-aa7000830521
a14b5410-d3f0-429c-8477-aa7000830553	Brasileiro Serie D, Knockout Stage	0	t-4276186	f	\N	\N	\N	1	0	0	477beb9f-f300-4b27-8903-aa700083054a
00c39491-ff96-411a-b8e2-aa7000830566	China League 2, South	0	t-4419524	f	\N	\N	\N	1	0	0	df19dc38-aacb-40a4-8a71-aa700083055c
17ec4ac6-6189-44fa-b7de-aa700083056e	Chinese Super League	0	t-4289809	f	\N	\N	\N	0	1	0	df19dc38-aacb-40a4-8a71-aa700083055c
6ed5eb6c-3766-4440-949d-aa7000830581	Superligaen	0	t-4282794	f	\N	\N	\N	0	1	0	95c01573-f7ca-427f-8f55-aa7000830579
9385a4f6-09b6-4a9d-b21d-aa7000830595	Championship	0	t-4216328	f	\N	\N	\N	0	3	0	3bb5fbf6-cfd0-4069-a2c6-aa700083058c
49a9d787-ae57-4bb0-93d7-aa700083059e	EFL Cup	0	t-4292896	f	\N	\N	\N	0	1	0	3bb5fbf6-cfd0-4069-a2c6-aa700083058c
b9689eba-5519-4878-8ba3-aa70008305a6	FA Cup	0	t-4240670	f	\N	\N	\N	0	1	0	3bb5fbf6-cfd0-4069-a2c6-aa700083058c
85e49b99-4097-4292-9ee8-aa70008305b4	Premier League	0	t-4216330	f	\N	\N	\N	0	1	0	3bb5fbf6-cfd0-4069-a2c6-aa700083058c
b3d7a04e-13c4-43c7-82ab-aa70008305ca	Bundesliga	0	t-4216347	f	\N	\N	\N	0	1	0	7fee2e5e-ad5f-45bf-8dbc-aa70008305bf
660c6492-bc6d-4d9a-adb7-aa70008305dd	Urvalsdeild	0	t-4238828	f	\N	\N	\N	1	0	0	fb937c98-7b67-418c-8809-aa70008305d3
1a9e7ba6-a588-4a49-aa84-aa70008305f0	Africa Cup of Nations 2019 - Group B	0	t-5005348	f	\N	\N	\N	2	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
c98f98a9-b6ad-4a53-bcda-aa70008305f9	Africa Cup of Nations 2019 - Group C	0	t-5005355	f	\N	\N	\N	2	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
932ab615-9dc0-4aa0-a24a-aa70008306cf	Africa Cup of Nations 2019 - Group D	0	t-5005350	f	\N	\N	\N	2	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
22f49bb9-f5d7-4f9b-9933-aa70008306d9	Africa Cup of Nations 2019 - Group E	0	t-5005354	f	\N	\N	\N	1	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
7c608e33-4032-466e-99fd-aa70008306e2	Africa Cup of Nations 2019 - Group F	0	t-5005356	f	\N	\N	\N	1	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
faa69a66-1ac6-4dc7-978b-aa70008306ea	Africa Cup of Nations, Group A	0	t-5005349	f	\N	\N	\N	1	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
7c568264-58b8-4406-a2aa-aa70008306f3	CONCACAF Gold Cup, Group A	0	t-5018417	f	\N	\N	\N	1	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
faa9c724-c9d2-4156-a461-aa70008306fb	CONCACAF Gold Cup, Group B	0	t-5018685	f	\N	\N	\N	2	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
205fbf19-a875-4793-bb3b-aa7000830705	CONCACAF Gold Cup, Group C	0	t-5022357	f	\N	\N	\N	1	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
2ba93b2c-0e4d-4c1c-aa66-aa7000830711	CONCACAF Gold Cup, Group D	0	t-5023817	f	\N	\N	\N	3	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
45c56864-6189-4019-ba9e-aa700083071b	Copa America 2019	0	t-4322466	f	\N	\N	\N	0	2	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
b75331e0-2bb4-4840-8e38-aa700083072a	Copa America 2019 - Group B	0	t-4782281	f	\N	\N	\N	4	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
6e4043d9-440c-40e0-81a0-aa7000830737	Copa America 2019 - Group C	0	t-4782280	f	\N	\N	\N	1	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
c3a4458b-75d9-44ec-b6e3-aa7000830742	Copa America, Group A	0	t-4782279	f	\N	\N	\N	4	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
dacce38a-0e00-42c4-b317-aa700083074b	European Championship, Qualification Group A	0	t-4585950	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
f8dddaaf-35f7-45ba-a873-aa7000830754	European Championship, Qualification Group B	0	t-4585962	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
d190e3a1-1c48-4a04-89a3-aa700083075d	European Championship, Qualification Group C	0	t-4585955	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
e566e6b7-9ef5-49fa-bc00-aa7000830767	European Championship, Qualification Group D	0	t-4585967	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
906148e4-d4c0-43f6-b67b-aa7000830770	European Championship, Qualification Group E	0	t-4585968	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
66f08909-095e-4ca9-9866-aa7000830778	European Championship, Qualification Group F	0	t-4585966	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
81e0f85a-2a65-405c-ad9b-aa7000830780	European Championship, Qualification Group G	0	t-4585970	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
e2857a36-c4d5-424a-96a7-aa7000830789	European Championship, Qualification Group H	0	t-4585957	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
62b77e2e-23ce-4f2b-bfd6-aa7000830793	FIFAWomen World Cup 2019	0	t-4322465	f	\N	\N	\N	0	3	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
2a5c0997-a645-49cf-826e-aa700083079c	International Friendly Games, Women	0	t-4276346	f	\N	\N	\N	1	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
c57aa83a-4560-40c2-9c47-aa70008307ac	UEFAEuro 2020	0	t-4322469	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
68783574-fc12-43f0-a20a-aa70008307b6	World Cup, Knockout stage	0	t-4274954	f	\N	\N	\N	0	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
50202e4b-a8c3-4755-b499-aa70008307cd	World Cup, Women, Group C	0	t-4784367	f	\N	\N	\N	1	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
a781f451-5b89-4cdb-82d0-aa70008307e1	World Cup, Women, Group D	0	t-4784371	f	\N	\N	\N	1	1	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
d3c7a8e6-bd86-4c4c-9c29-aa70008307eb	World Cup, Women, Group E	0	t-4784365	f	\N	\N	\N	2	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
23d9d296-b236-4497-9a03-aa70008307f6	World Cup, Women, Group F	0	t-4784370	f	\N	\N	\N	2	0	0	ac65b8ee-f0fb-46c5-9fde-aa70008305e7
fb432f93-b412-4ba4-8eac-aa700083080a	AFC Champions League, Knockout stage	0	t-4216372	f	\N	\N	\N	3	0	0	75efbf55-60a1-4528-ab2f-aa7000830800
9e0cda8b-3096-4d48-b821-aa7000830813	AFC Cup, Knockout stage	0	t-4359038	f	\N	\N	\N	1	0	0	75efbf55-60a1-4528-ab2f-aa7000830800
94a80c31-bfff-4d8b-8a6c-aa700083081d	Club Friendly Games	0	t-4216367	f	\N	\N	\N	4	0	0	75efbf55-60a1-4528-ab2f-aa7000830800
b26bc2c4-2bbb-4e73-85a7-aa7000830827	Copa Libertadores, Knockout stage	0	t-4289241	f	\N	\N	\N	0	1	0	75efbf55-60a1-4528-ab2f-aa7000830800
58b9ca38-0fca-463e-960c-aa700083082f	UEFA Champions League, Knockout stage	0	t-4216368	f	\N	\N	\N	0	1	0	75efbf55-60a1-4528-ab2f-aa7000830800
a5716389-da44-44f7-9682-aa7000830844	U21 European Championship, Group A	0	t-4782149	f	\N	\N	\N	1	1	0	60ef3406-95f3-46e9-a54b-aa700083083a
ba6c61c8-2fd7-46c8-a35d-aa700083084e	U21 European Championship, Group B	0	t-4782150	f	\N	\N	\N	2	0	0	60ef3406-95f3-46e9-a54b-aa700083083a
e3572abe-ad3d-445c-a0dc-aa700083085a	U21 European Championship, Group C	0	t-4782151	f	\N	\N	\N	0	1	0	60ef3406-95f3-46e9-a54b-aa700083083a
9da924ef-e41e-45f3-a4c9-aa7000830874	Serie A	0	t-4216349	f	\N	\N	\N	0	1	0	1c25a799-f3ff-4609-88a4-aa7000830865
3adf882d-783a-4f74-abea-aa7000830892	J.League	0	t-4238958	f	\N	\N	\N	0	1	0	d8d52412-b357-4d4d-a6d5-aa7000830882
1bf0aeca-11e9-44dc-a445-aa70008308aa	Eredivisie	0	t-4216034	f	\N	\N	\N	0	1	0	90010aff-50f3-4f32-b8b3-aa70008308a1
7a9f2bcc-b985-49b1-b120-aa70008308bd	1st Division	0	t-4238895	f	\N	\N	\N	0	1	0	6aca7813-d1c2-4644-8bb7-aa70008308b3
2f60d568-454a-476b-8204-aa70008308c5	3rd Division, Group 1	0	t-4238898	f	\N	\N	\N	1	0	0	6aca7813-d1c2-4644-8bb7-aa70008308b3
4fd94b09-0922-46a6-a0c8-aa70008308ce	Eliteserien	0	t-4216336	f	\N	\N	\N	4	2	0	6aca7813-d1c2-4644-8bb7-aa70008308b3
3154084e-19e7-4121-bddb-aa70008308d7	NM Cup	0	t-4238892	f	\N	\N	\N	10	0	0	6aca7813-d1c2-4644-8bb7-aa70008308b3
d3d824f0-0b10-41a7-80c4-aa70008308e2	Toppserien, Women	0	t-4343499	f	\N	\N	\N	0	1	0	6aca7813-d1c2-4644-8bb7-aa70008308b3
b247172f-3419-428d-9ae9-aa70008308f9	Ekstraklasa	0	t-4284030	f	\N	\N	\N	0	1	0	fa0f1ef9-4527-42a5-a065-aa70008308f0
c424ec42-eeb8-4140-aa46-aa7000830902	III Liga, Group 1	0	t-4327407	f	\N	\N	\N	5	0	0	fa0f1ef9-4527-42a5-a065-aa70008308f0
49da8789-b013-4357-8ef3-aa7000830926	League Cup 2018/19	0	t-4312785	f	\N	\N	\N	0	1	0	a1cb2657-2463-46d4-9ca3-aa7000830919
62630ffd-27af-426a-88a7-aa7000830946	LaLiga	0	t-4216356	f	\N	\N	\N	0	1	0	8687a299-8e67-4d94-a2a3-aa700083093c
29f682e6-45e0-43da-bdd1-aa700083094f	LaLiga 2, Promotion Playoffs	0	t-4275780	f	\N	\N	\N	1	0	0	8687a299-8e67-4d94-a2a3-aa700083093c
f5bdec70-48a3-4ef8-b063-aa7000830961	Allsvenskan	0	t-4238920	f	\N	\N	\N	1	4	0	bd3c1623-8748-41b6-b92d-aa7000830958
9c20b86a-1180-498e-be95-aa700083096a	Division 1, Norra	0	t-4322455	f	\N	\N	\N	1	0	0	bd3c1623-8748-41b6-b92d-aa7000830958
a109a71d-fe5a-4d25-b751-aa7000830973	Division 1, Sodra	0	t-4322454	f	\N	\N	\N	3	0	0	bd3c1623-8748-41b6-b92d-aa7000830958
ba4ddee7-4f94-4c01-a64d-aa700083097c	Division 2, Norra Gotaland	0	t-4419515	f	\N	\N	\N	2	0	0	bd3c1623-8748-41b6-b92d-aa7000830958
c0421675-3f01-440c-946e-aa7000830986	Division 2, Norrland	0	t-4419510	f	\N	\N	\N	4	0	0	bd3c1623-8748-41b6-b92d-aa7000830958
92513671-ee93-43c1-9e01-aa700083098f	Division 2, Ostra Gotaland	0	t-4419509	f	\N	\N	\N	5	0	0	bd3c1623-8748-41b6-b92d-aa7000830958
8ab69be1-9812-4652-a3a2-aa7000830997	Division 2, Sodra Svealand	0	t-4419517	f	\N	\N	\N	1	0	0	bd3c1623-8748-41b6-b92d-aa7000830958
e8ccdb47-8c8d-4445-8c79-aa70008309a0	Division 2, Vastra Gotaland	0	t-4419514	f	\N	\N	\N	1	0	0	bd3c1623-8748-41b6-b92d-aa7000830958
1c372847-dcb7-40e8-9aff-aa70008309aa	Superettan	0	t-4238921	f	\N	\N	\N	3	0	0	bd3c1623-8748-41b6-b92d-aa7000830958
5de6535b-0798-450e-9f8f-aa70008309bb	U21, Allsvenskan Norra	0	t-4747129	f	\N	\N	\N	1	0	0	17fbf622-9d54-4608-b94d-aa70008309b3
213d6617-98fd-4244-ae23-aa70008309d0	Major League Soccer	0	t-4239108	f	\N	\N	\N	2	0	0	1360ce31-c053-47d5-b944-aa70008309c4
5504a19b-9afd-436e-ba7d-aa70008309de	Major League Soccer 2018	0	t-4315290	f	\N	\N	\N	0	3	0	1360ce31-c053-47d5-b944-aa70008309c4
0d72a02b-f00f-4a08-a39d-aa70008309ec	US Open Cup	0	t-4246993	f	\N	\N	\N	2	0	0	1360ce31-c053-47d5-b944-aa70008309c4
d332cd7d-134f-4340-acc0-aa7000830a0e	FIM Speedway of Nations 2019	0	t-4974905	f	\N	\N	\N	0	1	0	9a18d433-271a-46ac-a433-aa7000830a04
93510128-6f8d-4b08-9328-aa7000830a2a	SBK - Portugal (Algarve) - Race 1	0	t-4393108	f	\N	\N	\N	0	1	0	6038440e-b254-45e1-bc5c-aa7000830a21
7646b8f9-aa84-48bd-8447-aa7000830a47	NBL 2018/19	0	t-4365392	f	\N	\N	\N	0	1	0	879dcb38-0f9e-42e0-8242-aa7000830a3c
e6d9d63b-fe7b-45a3-a25d-aa7000830a5d	Pro B, Playoffs	0	t-5044944	f	\N	\N	\N	1	0	0	53f18181-121b-4265-8801-aa7000830a51
213f3b17-033b-442e-9fc2-aa7000830a8d	BBL	0	t-4322479	f	\N	\N	\N	0	1	0	7febb20e-84e7-44d4-bd5a-aa7000830a75
03d1a988-fb25-4bf8-9713-aa7000830aa5	BBL, Playoffs	0	t-4216439	f	\N	\N	\N	1	0	0	7febb20e-84e7-44d4-bd5a-aa7000830a75
e33ad1a1-df6c-4e3f-887a-aa7000830abb	Eurobasket Women 2019	0	t-5060253	f	\N	\N	\N	0	1	0	306d159a-d15f-43c2-a73c-aa7000830ab2
549dafdc-6ec5-4aea-98ed-aa7000830ac4	Euroleague, Playoffs	0	t-4216427	f	\N	\N	\N	0	1	0	306d159a-d15f-43c2-a73c-aa7000830ab2
c214abfc-118e-45cc-8cc7-aa7000830acd	European Championship, Women Group A	0	t-5055151	f	\N	\N	\N	0	1	0	306d159a-d15f-43c2-a73c-aa7000830ab2
9a95a47c-a4b4-462f-a73b-aa7000830ad7	European Championship, Women Group B	0	t-5055150	f	\N	\N	\N	0	1	0	306d159a-d15f-43c2-a73c-aa7000830ab2
bf30e5bd-9eac-42c0-89ba-aa7000830ae1	European Championship, Women Group C	0	t-5055152	f	\N	\N	\N	0	1	0	306d159a-d15f-43c2-a73c-aa7000830ab2
9fa99d12-9897-4f45-9abd-aa7000830aea	European Championship, Women Group D	0	t-5058384	f	\N	\N	\N	0	1	0	306d159a-d15f-43c2-a73c-aa7000830ab2
328b2700-23da-48f0-a79f-aa7000830af3	Fiba World Cup 2019	0	t-4947009	f	\N	\N	\N	0	1	0	306d159a-d15f-43c2-a73c-aa7000830ab2
6b955383-b415-4924-80e2-aa7000830b05	Serie A, Playoffs	0	t-4247049	f	\N	\N	\N	1	0	0	bcf61580-18ea-47a0-8a3c-aa7000830afc
4d49018c-ed9a-4cbe-9a30-aa7000830b16	NCAA(B) 2018/19	0	t-4322474	f	\N	\N	\N	0	1	0	77227329-c4ae-42cd-908c-aa7000830b0d
c660d9ed-2c56-432c-b020-aa7000830b20	WNBA	0	t-4289473	f	\N	\N	\N	1	1	0	77227329-c4ae-42cd-908c-aa7000830b0d
5d9a49a0-0057-4282-85a5-aa7000830b44	Professional Baseball, Interleague	0	t-4265547	f	\N	\N	\N	5	0	0	cf934873-24e2-4316-a32b-aa7000830b36
58515e9c-c41f-4d70-b111-aa7000830b5e	KBO League	0	t-4239140	f	\N	\N	\N	2	0	0	c911874e-b2ac-48e3-9d0d-aa7000830b52
0a87c154-0613-4c81-ad7c-aa7000830b71	MLB	0	t-4216463	f	\N	\N	\N	9	0	0	19e6a30a-d573-4b8c-b550-aa7000830b68
f57c5b58-4273-44d7-a9f9-aa7000830b8a	AFL	0	t-4769273	f	\N	\N	\N	3	0	0	853189f2-c179-435d-aca1-aa7000830b81
c2cee8d2-5c08-4fd4-b548-aa7000830b93	AFL Premiership 2019 Grand Final	0	t-4762855	f	\N	\N	\N	0	1	0	853189f2-c179-435d-aca1-aa7000830b81
b6196465-afb7-4011-b4f1-aa7000830bae	Grand Prix Bowls	0	t-4670671	f	\N	\N	\N	2	0	0	79885aa6-e24f-4489-80a2-aa7000830ba5
33e4f3ef-5c52-4eb4-933b-aa7000830bc6	PDC World Championship 2020	0	t-4625513	f	\N	\N	\N	0	1	0	62906227-01dd-43c5-b612-aa7000830bbd
fe70c047-f669-4bb4-aca2-aa7000830bda	World Matchplay 2019	0	t-4795532	f	\N	\N	\N	0	1	0	62906227-01dd-43c5-b612-aa7000830bbd
aaef243d-c75c-4c52-b243-aa7000830c07	T20 Series England vs. West Indies, Women	0	t-5086911	f	\N	\N	\N	1	0	0	027e3db1-7b07-44c6-b249-aa7000830bff
01af75d7-06fc-4908-b36f-aa7000830c0f	The Ashes Series - England vs. Australia 2019	0	t-4553990	f	\N	\N	\N	0	1	0	027e3db1-7b07-44c6-b249-aa7000830bff
17bd1429-13b4-42d5-83e5-aa7000830c18	World Cup 2019	0	t-4453966	f	\N	\N	\N	0	3	0	027e3db1-7b07-44c6-b249-aa7000830bff
4c8b6832-30e2-45e7-b37e-aa7000830c22	World Cup, Group Stage	0	t-4974881	f	\N	\N	\N	4	2	0	027e3db1-7b07-44c6-b249-aa7000830bff
749b1567-ad0a-4c07-a4c1-aa7000830c3c	World Super Series 2018/19 Bantamweight	0	t-4383206	f	\N	\N	\N	0	1	0	3938ed5c-d64b-41b1-a558-aa7000830c34
c913a130-ba89-450f-80ff-aa7000830c45	World Super Series 2018/19 Super Lightweight	0	t-4383216	f	\N	\N	\N	0	1	0	3938ed5c-d64b-41b1-a558-aa7000830c34
55abef24-c5f1-4e40-b54e-aa7000830c5e	NRL	0	t-4251441	f	\N	\N	\N	0	2	0	303cea4f-606e-4d82-a85e-aa7000830c55
ef047c34-1c90-4d5c-8a26-aa7000830c68	RFL Challenge Cup	0	t-4319358	f	\N	\N	\N	0	1	0	303cea4f-606e-4d82-a85e-aa7000830c55
3efc0cc1-a60b-4cf6-9b6d-aa7000830c71	State of Origin	0	t-4554836	f	\N	\N	\N	1	0	0	303cea4f-606e-4d82-a85e-aa7000830c55
d35c5ce8-f60a-4b33-be97-aa7000830c7b	Super League	0	t-4251483	f	\N	\N	\N	1	0	0	303cea4f-606e-4d82-a85e-aa7000830c55
9855d080-4259-47a7-9da0-aa7000830c9f	Champions Tour Money List 2019	0	t-4647785	f	\N	\N	\N	0	1	0	f1ed2ec2-c35d-4d7d-a457-aa7000830c92
cf898742-57cc-44e9-89ed-aa7000830cae	Ryder Cup 2020	0	t-4423361	f	\N	\N	\N	0	1	0	f1ed2ec2-c35d-4d7d-a457-aa7000830c92
55663e72-b85b-4940-a35c-aa7000830ccd	World Championship Women 2019	0	t-4730953	f	\N	\N	\N	0	1	0	84143249-f7c0-405f-846b-aa7000830cc4
3ae00ad2-8c56-49d6-9d34-aa7000830ce6	Champions Hockey League 2018/19	0	t-4322497	f	\N	\N	\N	0	1	0	98c15501-f093-43c5-be7d-aa7000830cdd
242d292d-9ede-4f89-ba80-aa7000830cf9	NHL	0	t-4316194	f	\N	\N	\N	0	1	0	3a4ae80a-3892-486e-9316-aa7000830cef
3f8533e9-5796-4053-aff8-aa7000830d18	Pro 14, Playoffs	0	t-4251475	f	\N	\N	\N	0	1	0	160c9ab0-de52-4734-bef0-aa7000830d0d
5206312a-8cf6-4183-86a2-aa7000830d23	Rugby Union World Cup 2019	0	t-4313348	f	\N	\N	\N	0	1	0	160c9ab0-de52-4734-bef0-aa7000830d0d
430d5979-b4b8-4200-b3c1-aa7000830d35	Rugby Union World Cup 2019 - Pool A	0	t-4322486	f	\N	\N	\N	0	1	0	160c9ab0-de52-4734-bef0-aa7000830d0d
3a97bed5-2502-442b-ae5e-aa7000830d4b	Rugby Union World Cup 2019 - Pool B	0	t-4322489	f	\N	\N	\N	0	1	0	160c9ab0-de52-4734-bef0-aa7000830d0d
2176d35a-83e3-4e48-bbab-aa7000830d5c	Rugby Union World Cup 2019 - Pool C	0	t-4322483	f	\N	\N	\N	0	1	0	160c9ab0-de52-4734-bef0-aa7000830d0d
26f0e695-785e-4f7e-a75f-aa7000830d66	Rugby Union World Cup 2019 - Pool D	0	t-4322487	f	\N	\N	\N	0	1	0	160c9ab0-de52-4734-bef0-aa7000830d0d
a9256061-4606-4033-badf-aa7000830d70	Super Rugby	0	t-4251471	f	\N	\N	\N	0	1	0	160c9ab0-de52-4734-bef0-aa7000830d0d
05102d59-b4ff-46ce-b8d3-aa7000830d7b	Super Rugby, Playoffs	0	t-4300601	f	\N	\N	\N	2	1	0	160c9ab0-de52-4734-bef0-aa7000830d0d
18ea5ed8-fb8d-4529-931c-aa7000830d96	UK Championship 2019	0	t-4664907	f	\N	\N	\N	0	1	0	d6eca926-c325-4438-8ce0-aa7000830d8d
579098a7-fcec-4a02-a762-aa7000830dad	ATP - French Open 2020	0	t-5098744	f	\N	\N	\N	0	1	0	882bba70-3dd3-45a5-b047-aa7000830da5
abbaf285-7ed9-4316-9656-aa7000830db6	ATP - US Open 2019	0	t-4390068	f	\N	\N	\N	0	1	0	882bba70-3dd3-45a5-b047-aa7000830da5
d5976b67-19fd-4dc0-8a49-aa7000830dc0	ATP - Wimbledon 2019	0	t-4319194	f	\N	\N	\N	0	1	0	882bba70-3dd3-45a5-b047-aa7000830da5
5986e0fe-f48a-44b5-8400-aa7000830dca	Halle, Germany	0	t-5107748	f	\N	\N	\N	8	0	0	882bba70-3dd3-45a5-b047-aa7000830da5
5b402343-1dc3-47ee-9781-aa7000830dd2	London, Great Britain	0	t-5107466	f	\N	\N	\N	5	0	0	882bba70-3dd3-45a5-b047-aa7000830da5
f06fcebd-3f1a-4ec6-b782-aa7000830ddc	London, Great Britain, Doubles	0	t-5108780	f	\N	\N	\N	1	0	0	882bba70-3dd3-45a5-b047-aa7000830da5
d942f3d8-c2fb-400f-b84d-aa7000830df2	Blois, France	0	t-5108545	f	\N	\N	\N	3	0	0	78e2a03d-f356-4f8e-be15-aa7000830de4
cb082c77-15a5-4c13-8cb7-aa7000830dff	Bratislava, Slovakia	0	t-5107614	f	\N	\N	\N	6	0	0	78e2a03d-f356-4f8e-be15-aa7000830de4
8ffc048e-8d6f-477c-8ff6-aa7000830e0a	Fergana, Uzbekistan	0	t-5108629	f	\N	\N	\N	1	0	0	78e2a03d-f356-4f8e-be15-aa7000830de4
c1413ee5-9b89-46e4-8be4-aa7000830e18	Ilkley, Great Britain	0	t-5109220	f	\N	\N	\N	2	0	0	78e2a03d-f356-4f8e-be15-aa7000830de4
fdb8f3e2-1329-4720-b84c-aa7000830e22	Parma, Italy	0	t-5107500	f	\N	\N	\N	2	0	0	78e2a03d-f356-4f8e-be15-aa7000830de4
94c7aad7-18ef-4779-9ea4-aa7000830e34	Balatonalmadi, Singles Qualifying M-ITF-HUN-02A	0	t-5108970	f	\N	\N	\N	2	0	0	10fbf687-c687-467e-895f-aa7000830e2b
bd22b2c0-d70e-4dfc-b590-aa7000830e3f	Harare, Singles M-ITF-ZIM-01A	0	t-5111075	f	\N	\N	\N	1	0	0	10fbf687-c687-467e-895f-aa7000830e2b
a0c7e08e-d7fb-47ab-b95b-aa7000830e49	Netanya, Singles M-ITF-ISR-03A	0	t-5110701	f	\N	\N	\N	1	0	0	10fbf687-c687-467e-895f-aa7000830e2b
91e20f08-abc7-4de8-9d30-aa7000830e54	Toulouse, Singles M-ITF-FRA-09A	0	t-5111673	f	\N	\N	\N	1	0	0	10fbf687-c687-467e-895f-aa7000830e2b
cda3775a-ff1c-445b-b197-aa7000830e66	Klosters, Singles W-ITF-SUI-02A	0	t-5110405	f	\N	\N	\N	1	0	0	96bda641-4528-48b7-a714-aa7000830e5d
7d46061a-c04f-4ccf-aa32-aa7000830e70	Netanya, Singles W-ITF-ISR-04A	0	t-5110699	f	\N	\N	\N	1	0	0	96bda641-4528-48b7-a714-aa7000830e5d
10f1bfe3-4455-45f1-82ba-aa7000830e84	Birmingham, Great Britain	0	t-5107502	f	\N	\N	\N	7	0	0	d025688d-8366-4fc3-a9af-aa7000830e7a
f997414b-f7b5-4570-b386-aa7000830e98	Mallorca, Spain	0	t-5108896	f	\N	\N	\N	5	0	0	d025688d-8366-4fc3-a9af-aa7000830e7a
36fefcf9-ae25-428f-88b0-aa7000830eb6	Mallorca, Spain, Doubles	0	t-5110199	f	\N	\N	\N	5	0	0	d025688d-8366-4fc3-a9af-aa7000830e7a
4b2ae538-c7d0-4069-8817-aa7000830ec4	WTA - Australian Open 2020	0	t-4691651	f	\N	\N	\N	0	1	0	d025688d-8366-4fc3-a9af-aa7000830e7a
b4f87666-36d1-4c53-b603-aa7000830ed5	WTA - US Open 2019	0	t-4389646	f	\N	\N	\N	0	1	0	d025688d-8366-4fc3-a9af-aa7000830e7a
8b559fdf-aa30-44aa-8960-aa7000830ede	WTA - Wimbledon 2019	0	t-4319190	f	\N	\N	\N	0	1	0	d025688d-8366-4fc3-a9af-aa7000830e7a
925fd096-3084-4e9a-8ad4-aa7000830ef9	Challenger Series 2019, Week 25, Session 1	0	t-5096025	f	\N	\N	\N	4	0	0	7026671d-6fd8-4f59-a0fd-aa7000830eef
4cf1aa01-64ca-4b68-9165-aa7000830f16	Nations League, Women	0	t-4216494	f	\N	\N	\N	5	0	0	60a3729a-5064-4ce6-8445-aa7000830f0a
8796e98e-f171-4c0f-8e4d-aa7000830f31	Constructors Championship 2018	0	t-4312900	f	\N	\N	\N	0	2	0	3a9e9e58-5ca0-48ce-b147-aa7000830f27
54c47e4d-c487-4fd3-9b2b-aa7000830f51	Tour De France 2018	0	t-4312787	f	\N	\N	\N	0	1	0	a622b246-d147-40a3-bec9-aa7000830f42
da36179b-2f1f-4c66-b300-aa7000830f60	Tour de Suisse 2019	0	t-5103356	f	\N	\N	\N	0	1	0	a622b246-d147-40a3-bec9-aa7000830f42
779ca9be-55c6-4301-a50d-aa7000830f83	NCAA(F) Championship 2018/19	0	t-4312965	f	\N	\N	\N	0	2	0	a4844c11-ac71-4b4f-8ce1-aa7000830f75
59b0048f-f588-4263-98b4-aa7000830f8e	NFL	0	t-4302687	f	\N	\N	\N	0	9	0	a4844c11-ac71-4b4f-8ce1-aa7000830f75
1f9b5878-a406-49f7-b1a6-aa7000830fa9	Bellator London	0	t-5048876	f	\N	\N	\N	2	0	0	af56c0d2-7145-4f7c-bb72-aa7000830fa0
461192dd-081f-4248-b8b0-aa7000830fbf	UFC Fight Night - Greenville	0	t-5045966	f	\N	\N	\N	7	0	0	2bb32c06-8664-4c3c-8698-aa7000830fb3
a7010415-d482-4117-a2c2-aa7000830fde	World Cup 2019/20	0	t-4879511	f	\N	\N	\N	0	1	0	3855b454-c2c5-49e5-bc95-aa7000830fd4
74fe957d-a376-48d2-b57a-aa7000831039	World Cup, Women, Pool C	0	t-5084888	f	\N	\N	\N	1	0	0	f7b42754-02c5-43f4-8bbc-aa700083102f
b19f77fb-17db-4bcb-bc02-aa7000831056	World League, Group B	0	t-5110495	f	\N	\N	\N	1	0	0	a3c0e0cc-46ae-41ea-a0eb-aa700083104b
\.


--
-- TOC entry 2990 (class 2606 OID 16665)
-- Name: events Events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT "Events_pkey" PRIMARY KEY (id);


--
-- TOC entry 2982 (class 2606 OID 16632)
-- Name: categories categories_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pk PRIMARY KEY (id);


--
-- TOC entry 2994 (class 2606 OID 16694)
-- Name: markets markets_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY markets
    ADD CONSTRAINT markets_pk PRIMARY KEY (id);


--
-- TOC entry 2997 (class 2606 OID 16707)
-- Name: odds odds_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odds
    ADD CONSTRAINT odds_pk PRIMARY KEY (id);


--
-- TOC entry 2984 (class 2606 OID 16640)
-- Name: sports sports_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sports
    ADD CONSTRAINT sports_pk PRIMARY KEY (id);


--
-- TOC entry 2999 (class 2606 OID 16719)
-- Name: teams teams_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pk PRIMARY KEY (id);


--
-- TOC entry 2987 (class 2606 OID 16648)
-- Name: tournaments tournaments_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tournaments
    ADD CONSTRAINT tournaments_pk PRIMARY KEY (id);


--
-- TOC entry 2980 (class 1259 OID 16852)
-- Name: categories_categoryid_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX categories_categoryid_uindex ON public.categories USING btree (categoryid);


--
-- TOC entry 2991 (class 1259 OID 16855)
-- Name: events_match_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX events_match_id_uindex ON public.events USING btree (matchid);


--
-- TOC entry 2992 (class 1259 OID 16681)
-- Name: events_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX events_name_uindex ON public.events USING btree (name);


--
-- TOC entry 2995 (class 1259 OID 16908)
-- Name: odds_oddid_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX odds_oddid_uindex ON public.odds USING btree (oddid);


--
-- TOC entry 2985 (class 1259 OID 16854)
-- Name: sports_sportid_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sports_sportid_uindex ON public.sports USING btree (sportid);


--
-- TOC entry 2988 (class 1259 OID 16853)
-- Name: tournaments_tournamentid_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tournaments_tournamentid_uindex ON public.tournaments USING btree (tournamentid);


--
-- TOC entry 3000 (class 2606 OID 16816)
-- Name: categories categories_sports_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_sports_id_fk FOREIGN KEY (sport_id) REFERENCES sports(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3002 (class 2606 OID 16671)
-- Name: events events_tournaments_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_tournaments_id_fk FOREIGN KEY (tournament_id) REFERENCES tournaments(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3003 (class 2606 OID 16695)
-- Name: markets markets_events_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY markets
    ADD CONSTRAINT markets_events_id_fk FOREIGN KEY (event_id) REFERENCES events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3004 (class 2606 OID 17005)
-- Name: odds odds_markets_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odds
    ADD CONSTRAINT odds_markets_id_fk FOREIGN KEY (market_id) REFERENCES markets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3005 (class 2606 OID 16896)
-- Name: teams teams_events_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_events_id_fk FOREIGN KEY (event_id) REFERENCES events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3001 (class 2606 OID 16778)
-- Name: tournaments tournaments_categories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tournaments
    ADD CONSTRAINT tournaments_categories_id_fk FOREIGN KEY (category_id) REFERENCES categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-06-18 14:45:09

--
-- PostgreSQL database dump complete
--

