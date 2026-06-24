CREATE DATABASE champions_league_db;
USE champions_league_db;

CREATE TABLE seasons (
    season_id INT,
    season_year VARCHAR(50)
);
select * from seasons;

CREATE TABLE teams (
    team_id INT,
    team_name VARCHAR(150),
    country_code VARCHAR(20),
    country_name VARCHAR(100),
    city_name VARCHAR(100),
    latitude VARCHAR(50),
    longitude VARCHAR(50)
);
select * from teams;

CREATE TABLE players_list (
    player_id INT,
    player VARCHAR(150),
    nationality VARCHAR(100),
    birth_data VARCHAR(50)
);

select * from players_list;

DROP TABLE IF EXISTS group_stage;

CREATE TABLE group_stage (
    season_id INT,
    team_id INT,
    team_name VARCHAR(150),
    group_name VARCHAR(20),
    group_stage_place VARCHAR(50)
);
select * from group_stage;

CREATE TABLE secound_group_stage (
    season_id INT,
    team_id INT,
    team_name VARCHAR(150),
    secound_group_stage_name VARCHAR(50),
    secound_group_stage_status VARCHAR(50)
);
select * from secound_group_stage;

CREATE TABLE knock_out_stage (
    season_id INT,
    team_id INT,
    team_name VARCHAR(150),
    knock_out_stage VARCHAR(50),
    knock_out_stage_status VARCHAR(50)
);
select * from knock_out_stage;

CREATE TABLE squads (
    season_id INT,
    player_id INT,
    team_id INT,
    player VARCHAR(150),
    player_position VARCHAR(50),
    team_name VARCHAR(150),
    min_played INT
);
select * from squads;

SELECT COUNT(*) FROM seasons;
SELECT COUNT(*) FROM teams;
SELECT COUNT(*) FROM players_list;
SELECT COUNT(*) FROM group_stage;
SELECT COUNT(*) FROM secound_group_stage;
SELECT COUNT(*) FROM knock_out_stage;
SELECT COUNT(*) FROM squads;

ALTER TABLE seasons
ADD PRIMARY KEY (season_id);

ALTER TABLE teams
ADD PRIMARY KEY (team_id);

ALTER TABLE players_list
ADD PRIMARY KEY (player_id);

ALTER TABLE group_stage
ADD CONSTRAINT fk_group_stage_season
FOREIGN KEY (season_id)
REFERENCES seasons(season_id);

ALTER TABLE group_stage
ADD CONSTRAINT fk_group_stage_team
FOREIGN KEY (team_id)
REFERENCES teams(team_id);

ALTER TABLE secound_group_stage
ADD CONSTRAINT fk_second_stage_season
FOREIGN KEY (season_id)
REFERENCES seasons(season_id);

ALTER TABLE secound_group_stage
ADD CONSTRAINT fk_second_stage_team
FOREIGN KEY (team_id)
REFERENCES teams(team_id);


ALTER TABLE knock_out_stage
ADD CONSTRAINT fk_knockout_season
FOREIGN KEY (season_id)
REFERENCES seasons(season_id);

ALTER TABLE knock_out_stage
ADD CONSTRAINT fk_knockout_team
FOREIGN KEY (team_id)
REFERENCES teams(team_id);



ALTER TABLE squads
ADD CONSTRAINT fk_squads_season
FOREIGN KEY (season_id)
REFERENCES seasons(season_id);

ALTER TABLE squads
ADD CONSTRAINT fk_squads_team
FOREIGN KEY (team_id)
REFERENCES teams(team_id);

ALTER TABLE squads
ADD CONSTRAINT fk_squads_player
FOREIGN KEY (player_id)
REFERENCES players_list(player_id);

-- 1. List all teams and their countries
SELECT team_name, country_name
FROM teams
ORDER BY team_name;

-- 2. Find all teams that finished first in the group stage
SELECT season_id, team_name, group_name
FROM group_stage
WHERE group_stage_place = 'first place';

-- 3. Count how many times each team finished first in groups
SELECT team_name,
       COUNT(*) AS first_place_count
FROM group_stage
WHERE group_stage_place = 'first place'
GROUP BY team_name
ORDER BY first_place_count DESC;


-- 4. Find teams that reached the final
SELECT season_id, team_name
FROM knock_out_stage
WHERE knock_out_stage = 'final';
-- 5. Find teams with the most Champions League appearances
SELECT team_name,
       COUNT(DISTINCT season_id) AS appearances
FROM group_stage
GROUP BY team_name
ORDER BY appearances DESC;


-- 6. Top 10 players with highest minutes played
SELECT player,
       team_name,
       SUM(min_played) AS total_minutes
FROM squads
GROUP BY player, team_name
ORDER BY total_minutes DESC
LIMIT 10;


-- 7. Number of players in each team
SELECT team_name,
       COUNT(player_id) AS total_players
FROM squads
GROUP BY team_name
ORDER BY total_players DESC;
-- 8. Countries with the most teams
SELECT country_name,
       COUNT(*) AS total_teams
FROM teams
GROUP BY country_name
ORDER BY total_teams DESC;


-- 9. Teams eliminated in the group stage
SELECT season_id,
       team_name,
       group_name
FROM group_stage
WHERE group_stage_place = 'drop out';
-- 10. Teams reaching knockout stages most often
SELECT team_name,
       COUNT(*) AS knockout_appearances
FROM knock_out_stage
GROUP BY team_name
ORDER BY knockout_appearances DESC;

-- Find the team with the most first-place group finishes.

SELECT team_name,
       COUNT(*) AS first_place_finishes
FROM group_stage
WHERE group_stage_place = 'first place'
GROUP BY team_name
ORDER BY first_place_finishes DESC
LIMIT 1;



















