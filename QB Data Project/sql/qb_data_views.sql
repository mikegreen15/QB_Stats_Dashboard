--Please View README Before Continuing
--Creates the Views Needed For Graphs
1.
--Top 30 QBs by total passing yards from 2015-2024
CREATE VIEW top_30_pass_yards
AS
	SELECT player_name AS "Player",
		   SUM(passing_yards) AS "Total Passing Yards 2015-2024",
		   SUM(pass_touchdown) AS "Total passing TDs 2015-2024",
		   SUM(interception) AS "Total Interceptions 2015-2024",
		   SUM(games_played_season) AS "Total Games Played 2015-2024",
		   ROUND(AVG(completion_pct):: NUMERIC,2) AS "Completion Pct 2015-2024",
		   ROUND(AVG(yards_per_att):: NUMERIC, 2) AS "Yards per att 2015-2024",
		   ROUND(AVG (passer_rating):: NUMERIC,2) AS "Passer Rating 2015-2024"
	FROM qb_data
	WHERE season_type = 'REG'
	GROUP BY player_id, player_name
	ORDER BY SUM(passing_yards) DESC
	LIMIT 30;

--Proof it works
SELECT * FROM top_30_pass_yards;

2.
--Shows the difference in Avg passing yards for qbs who played at least 8 games over 2015-2024
--Look into adding avg air yards pass attempts and interceptions
CREATE VIEW avg_yards_season
AS
	SELECT ROUND(AVG(passing_yards)::NUMERIC,2) AS "Average Passing Yards",
		   season AS "Season"
	FROM qb_data
	WHERE season_type = 'REG' AND games_played_season >= 8
	GROUP BY season
	ORDER BY season ASC;

--Proof it works
SELECT * FROM avg_yards_season;

3.
--Shows stats of QBs with the top 30 passer ratings in a single season (players can repeat)
--Minimum 6 games played and 1500 yards thrown
CREATE VIEW top_30_passer_rating
AS
	SELECT player_name AS "Player",
	       passer_rating AS "Passer Rating",
		   passing_yards AS "Passing Yards",
		   pass_touchdown AS "Passing TDs",
		   interception AS "Interceptions",
		   completion_pct AS "Completion Pct",
		   yards_per_att AS "Yards Per Att",
		   games_played_season AS "Games Played",
		   team AS "Current Team",
		   season AS "Season"
	 FROM qb_data
	 WHERE season_type = 'REG' 
	 	   AND games_played_season >= 6 
		   AND passing_yards >=1500	
	 ORDER BY (passer_rating) DESC
	 LIMIT 30;
	 
--Proof it works
SELECT * FROM top_30_passer_rating;
		   
4.
--Data does not show much 
--Shows the average of all qbs yards thrown down the field per pass per season
CREATE VIEW avg_yds_thrown_downfield
AS
	SELECT ROUND(AVG (air_yds_att):: NUMERIC, 2) AS "AVG Yards Thrown Downfield",
		   season AS "Season"
	FROM qb_data
	WHERE season_type = 'REG'
	GROUP BY season
	ORDER BY (season) DESC;

--Prood it works
SELECT * FROM avg_yds_thrown_downfield;

5. 
--Top 30 in total yards (rushing and passing) from 2015-2024
CREATE VIEW top_30_total_yards
AS
	SELECT player_name AS "Player",
		   SUM(total_yards) AS "Total Yards",
		   SUM(total_tds) AS "Total TDs",
		   SUM(passing_yards) AS "Total Passing Yards",
		   SUM(rushing_yards) AS "Total Rushing Yards",
		   SUM(pass_touchdown) AS "Total Pass TDs",
		   SUM(rush_touchdown) AS "Total Rush TDs",
		   COUNT(season) AS "Seasons Played from 2015-2024"
	FROM qb_data
	WHERE season_type = 'REG'
	GROUP BY player_id, player_name
	ORDER BY SUM(total_yards) DESC
	LIMIT 30;

--Proof it works
SELECT * FROM top_30_total_yards;

6.
--Shows the average rushing yards per season by all qbs combined
--Must have had over 5 attemps
CREATE VIEW avg_qb_rush_yards_season
AS
	SELECT ROUND(AVG(rushing_yards):: NUMERIC, 2) AS "Average QB Rushing",
		   ROUND(AVG(yds_per_rush):: NUMERIC, 2) AS "Average QB Yards Per Rush",
		   SUM(rush_touchdown) AS "QB Rushing TDs Per Season",
		   ROUND(AVG(rush_attempts):: NUMERIC, 2) AS "AVG QB Rush Attempts",
		   season AS "Season"
	FROM qb_data
	WHERE season_type = 'REG'
		  AND rush_attempts >= 5
	GROUP BY season
	ORDER BY(season) ASC;
		   
SELECT * FROM avg_qb_rush_yards_season;

7.
--Best TD to Int Ratio With a Minimum of 10 starts and 250 attempts
CREATE VIEW best_td_int_per_season
AS
	SELECT player_name AS "Player",
		   td_to_int_ratio AS "TD to INT Ratio",
		   pass_touchdown AS "Passing Toucdowns",
		   interception AS "Interceptions",
		   completion_pct AS "Completion Pct",
		   season AS "Season"
	FROM qb_data
	WHERE season_type = 'REG'
		  AND games_played_season >= 10
		  AND pass_attempts >= 250
	ORDER BY(td_to_int_ratio) DESC
	LIMIT 30;

--Proof it works
SELECT * FROM best_td_int_per_season;

8. 
--Top Playoff Performers
CREATE VIEW top_playoff_performers
AS
	SELECT player_name AS "Player",
		   SUM(passing_yards) AS "Total Playoff Passing Yards",
		   SUM(pass_touchdown) AS "Total Playoff Passing TDs",
		   SUM(interception) AS "Total Playoff Interceptions",
		   SUM(total_yards) AS "Total Playoff Yards",
		   SUM(total_tds) AS "Total Playoff TDs",
		   ROUND(AVG(passer_rating):: NUMERIC, 2) AS "Average Passer Rating",
		   COUNT(season) AS "Playoff Appearances"
	FROM qb_data
	WHERE season_type = 'POST'
	GROUP BY player_id, player_name
	ORDER BY SUM(passing_yards) DESC, SUM(pass_touchdown) DESC
	LIMIT 25;

--Proof it works
SELECT * FROM top_playoff_performers;
	