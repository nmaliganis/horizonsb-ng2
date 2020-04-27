DELETE FROM events;

SELECT t.*
FROM tournaments AS t
WHERE t.tournamentid = 't-4983302';

SELECT *
FROM sports AS s;

SELECT *
FROM events AS e
INNER JOIN teams t on e.id = t.event_id
WHERE t.id = '54a923fb-f73a-4122-a9a4-aafd009311b4'
;

SELECT *
FROM events AS e
WHERE e.matchid like '49%'
;

SELECT e.matchid, e.id, e.timestamp, e.code, e.name, e.upcoming_live
FROM events AS e
INNER JOIN tournaments t on e.tournament_id = t.id
INNER JOIN categories c on t.category_id = c.id
INNER JOIN sports s on c.sport_id = s.id
WHERE s.sportid = 's-TENNIS';

--4997530
--42["subscribeEvent","4997530","en","ds"]
SELECT e.matchid, e.id, e.timestamp, e.code, e.name
FROM events AS e
INNER JOIN tournaments t on e.tournament_id = t.id
INNER JOIN categories c on t.category_id = c.id
INNER JOIN sports s on c.sport_id = s.id
WHERE s.sportid = 's-TENNIS' AND e.matchid = '4997530';


SELECT *
FROM events AS e
INNER JOIN teams t on e.id = t.event_id
WHERE t.name = 'Orlova, Natalia'
;

SELECT *
FROM teams AS t
INNER JOIN events e on t.event_id = e.id
WHERE e.id = '0d8c399b-82a7-4fee-adbe-aafd009311b4';

SELECT e.*
FROM events AS e
WHERE e.matchid = '18448426'
;



SELECT
  eventid,
  COUNT(*) as count,
  date_trunc('day', date_event) as day
FROM events
WHERE date_event >= '2019-11-25'
GROUP BY eventid, day
HAVING COUNT(*) > 1;

select count(1)
from events AS e
where e.date_event between '2019-11-25' and '2019-11-26'
AND e.upcoming_live = true
HAVING COUNT(*) > 1;

SELECT e.*
FROM events AS e
WHERE e.eventid = '20443781';

--54a1bb76-1ca8-4278-a0bb-ab1000aacab7
SELECT e.*
FROM events AS e
WHERE e.matchid = '20452519';

SELECT e.*
FROM events AS e
WHERE e.eventid = '5029656';

--a8c628b7-dea4-4fda-b22b-ab1000aae02a
SELECT e.*
FROM events AS e
INNER JOIN teams t on e.id = t.event_id
WHERE t.id = 'a05c02c5-58cf-48d7-a5b1-ab1000aae02a';

--a05c02c5-58cf-48d7-a5b1-ab1000aae02a
SELECT t.*
from teams AS t
WHERE t.name like 'Atyushova, Arina';

SELECT m.*
FROM markets AS m
INNER JOIN events e on m.event_id = e.id
WHERE e.id = 'a8c628b7-dea4-4fda-b22b-ab1000aae02a';


SELECT m.*
FROM markets AS m
INNER JOIN events e on m.event_id = e.id
WHERE e.id = '54a1bb76-1ca8-4278-a0bb-ab1000aacab7';


SELECT o.*
FROM odds AS o
INNER JOIN markets AS m ON o.market_id = m.id
INNER JOIN events AS e ON m.event_id = e.id
WHERE e.id = '54a1bb76-1ca8-4278-a0bb-ab1000aacab7' AND m.type = 'TENNIS:FT:ML';