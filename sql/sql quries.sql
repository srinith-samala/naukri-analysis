UPDATE matches
SET venue = 'Wankhede Stadium'
WHERE venue = 'Wankhede Stadium, Mumbai';

ALTER TABLE cricket MODIFY COLUMN total_runs INT;

SELECT
  SUM(CASE WHEN id               IS NULL THEN 1 ELSE 0 END) AS id_null,
  SUM(CASE WHEN season          IS NULL THEN 1 ELSE 0 END) AS season_null,
  SUM(CASE WHEN city            IS NULL THEN 1 ELSE 0 END) AS city_null,
  SUM(CASE WHEN dates           IS NULL THEN 1 ELSE 0 END) AS dates_null,
  SUM(CASE WHEN match_type      IS NULL THEN 1 ELSE 0 END) AS match_type_null,
  SUM(CASE WHEN venue           IS NULL THEN 1 ELSE 0 END) AS venue_null,
  SUM(CASE WHEN team1           IS NULL THEN 1 ELSE 0 END) AS team1_null,
  SUM(CASE WHEN team2           IS NULL THEN 1 ELSE 0 END) AS team2_null,
  SUM(CASE WHEN toss_winner     IS NULL THEN 1 ELSE 0 END) AS toss_winner_null,
  SUM(CASE WHEN winner          IS NULL THEN 1 ELSE 0 END) AS winner_null,
  SUM(CASE WHEN result          IS NULL THEN 1 ELSE 0 END) AS result_null,
  SUM(CASE WHEN result_margin   IS NULL THEN 1 ELSE 0 END) AS result_margin_null,
  SUM(CASE WHEN target_runs     IS NULL THEN 1 ELSE 0 END) AS target_runs_null,
  SUM(CASE WHEN target_overs    IS NULL THEN 1 ELSE 0 END) AS target_overs_null,
  SUM(CASE WHEN super_over      IS NULL THEN 1 ELSE 0 END) AS super_over_null,
  SUM(CASE WHEN method          IS NULL THEN 1 ELSE 0 END) AS method_null,
  SUM(CASE WHEN umpire1         IS NULL THEN 1 ELSE 0 END) AS umpire1_null,
  SUM(CASE WHEN unpire2         IS NULL THEN 1 ELSE 0 END) AS umpire2_null, 
  SUM(CASE WHEN player_of_match IS NULL THEN 1 ELSE 0 END) AS pom_null
FROM matches;

SELECT id, COUNT(*) AS cnt
FROM matches
GROUP BY id
HAVING cnt > 1;

SELECT match_id, inning, overs, ball, COUNT(*) AS cnt
FROM cricket
GROUP BY match_id, inning, overs, ball
HAVING cnt > 1;

SELECT DISTINCT winner         FROM matches WHERE winner         = 'NA';
SELECT DISTINCT city            FROM matches WHERE city            = 'NA';
SELECT DISTINCT player_of_match FROM matches WHERE player_of_match = 'NA';

-- Count them
SELECT COUNT(*) FROM matches WHERE winner = 'NA'; -- 5 (no-result/rain matches)
SELECT COUNT(*) FROM matches WHERE city   = 'NA'; -- 51 (UAE matches)

UPDATE matches
SET   city = 'Bangalore'
WHERE city = 'Bengaluru'

SELECT id, dates, team1, team2, venue, city
FROM matches
WHERE city = 'NA'
LIMIT 5;

UPDATE matches
SET   city = 'Dubai'
WHERE venue = 'Dubai International Cricket Stadium';

UPDATE matches
SET   city = 'Sharjah'
WHERE venue = 'Sharjah Cricket Stadium'

UPDATE matches
SET season = CASE
  WHEN season = '2007/08' THEN '2007'
  WHEN season = '2009/10' THEN '2009'
  WHEN season = '2020/21' THEN '2020'
  ELSE season
END;

UPDATE matches
SET   season = YEAR(dates)
WHERE season IS NULL;

# Most runs by team:
select batting_team,sum(total_runs) as total 
from cricket 
group by batting_team 
order by total desc;

#Toss vs match result
SELECT 
    SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS toss_won_match,
    SUM(CASE WHEN toss_winner != winner THEN 1 ELSE 0 END) AS toss_lost_match
FROM matches;

#Super overs by team
SELECT team1 AS team_name, COUNT(*) AS superovers_played
FROM matches
WHERE super_over = 'Y'
GROUP BY team1
UNION ALL 
SELECT team2 AS team_name, COUNT(*) AS superovers_played
FROM matches
WHERE super_over = 'Y'
GROUP BY team2
ORDER BY superovers_played DESC;

# player played for multiple francxchisedsd 
SELECT batter, COUNT(DISTINCT batting_team) AS franchises
FROM cricket
GROUP BY batter
HAVING COUNT(DISTINCT batting_team) > 1 
ORDER BY franchises DESC;

SELECT venue, COUNT(*) AS matches_played
FROM matches
GROUP BY venue
ORDER BY matches_played DESC
LIMIT 10;

SELECT COUNT(*) FROM matches
WHERE venue = 'Eden Gardens' 
AND (team1 = 'Kolkata Knight Riders' OR team2 = 'Kolkata Knight Riders');


SELECT COUNT(*) FROM matches
WHERE venue = 'Wankhede Stadium' 
AND (team1 = 'Mumbai Indians' OR team2 = 'Mumbai Indians');
