--Please View README Before Continuing
--Creates the Views Needed For Graphs

--1.
--Top 25 QBs by total passing yards from 2016-2025
CREATE OR REPLACE VIEW top_25_reg_pass_yards
AS
	SELECT player_name AS "Player",
		   player_display_name AS "Full Name",
		   headshot_url AS "Player Image",
		   SUM(passing_yards) AS "Total Passing Yards 2016-202S5",
		   SUM(passing_tds) AS "Total passing TDs 2016-2025",
		   SUM(passing_interceptions) AS "Total Interceptions 2016-2025",
		   ROUND(AVG(td_to_int_ratio):: NUMERIC, 2) AS "Avg TD to INT Ratio 2016-2025",
		   SUM(games) AS "Total Games Played 2016-2025",
		   ROUND(AVG(completion_pct):: NUMERIC,2) AS "Avg Completion Pct 2016-2025",
		   ROUND(AVG(yards_per_att):: NUMERIC, 2) AS "Avg Yards per att 2016-2025",
		   ROUND(AVG(air_yds_att):: NUMERIC, 2) AS "Avg Air Yards per att 2016-2025",
		   ROUND(AVG (passer_rating):: NUMERIC,2) AS "Avg Passer Rating 2016-2025",
		   ROUND(AVG (passing_epa) :: NUMERIC, 2) AS "Avg Passer EPA 2016-2025",
		   ROUND(AVG(fantasy_points_ppr) :: NUMERIC, 2) AS "Avg Fantasy Points (ppr) 2016-2025",
		   SUM(fantasy_points_ppr) AS "Total Fantasy Points (ppr) 2016-2025"
	FROM qb_data
	WHERE season_type = 'REG'
	GROUP BY player_id, player_name, player_display_name, headshot_url
	ORDER BY SUM(passing_yards) DESC
	LIMIT 25;

--Proof it works
SELECT * FROM top_25_reg_pass_yards;

--2.
--Shows the difference in Avg passing yards for qbs who played at least 8 games over 2016-2025
CREATE OR REPLACE VIEW avg_yards_reg_season
AS
	SELECT ROUND(AVG(passing_yards)::NUMERIC,2) AS "Average Passing Yards",
		   ROUND(AVG(air_yds_att):: NUMERIC, 2) AS "Average Air Yards per att",
		   ROUND(AVG(attempts):: NUMERIC, 2) AS "Pass Attempts",
		   ROUND(AVG(completion_pct):: NUMERIC, 2) AS "Completion Percentage",
		   ROUND(AVG(passing_tds):: NUMERIC, 2) AS "Passing Touchdowns",
		   ROUND(AVG(passing_interceptions):: NUMERIC, 2) AS "Interceptions",
		   ROUND(AVG(passer_rating):: NUMERIC, 2) AS "Passer Rating",
		   season AS "Season"
	FROM qb_data
	WHERE season_type = 'REG' 
		AND games >= 6
		AND attempts >= 75
	GROUP BY season
	ORDER BY season ASC;

--Proof it works
SELECT * FROM avg_yards_reg_season;

--3.
--Shows stats of QBs with the top 25 passer ratings in a single season (players can repeat)
--Minimum 6 games played and 1500 yards thrown
CREATE OR REPLACE VIEW top_25_reg_passer_rating
AS
	SELECT player_name AS "Player",
		   player_display_name AS "Full Name",
		   headshot_url AS "Player Image",
	       passer_rating AS "Passer Rating",
		   passing_yards AS "Passing Yards",
		   passing_tds AS "Passing TDs",
		   passing_interceptions AS "Interceptions",
		   completion_pct AS "Completion Pct",
		   yards_per_att AS "Yards Per Att",
		   games AS "Games Played",
		   recent_team AS "Current Team",
		   season AS "Season",
		   td_to_int_ratio AS "TD to INT Ratio"		   
	 FROM qb_data
	 WHERE season_type = 'REG' 
	 	   AND games >= 6 
		   AND passing_yards >=1500	
	 ORDER BY (passer_rating) DESC
	 LIMIT 25;
	 
--Proof it works
SELECT * FROM top_25_reg_passer_rating;
		   
--4.
--Shows the average of all qbs yards thrown down the field per pass per season
CREATE OR REPLACE VIEW avg_yds_thrown_downfield_reg
AS
	SELECT ROUND(AVG (air_yds_att):: NUMERIC, 2) AS "AVG Yards Thrown Downfield",
		   SUM(passing_air_yards) AS "Total Yards Thrown Downfield",
		   SUM(attempts) AS "Pass Attempts",
		   SUM(passing_10) AS "Passes 10 Yards Downfeild",
		   SUM(passing_16) AS "Passes 16 Yards Downfeild",
		   SUM(passing_20) AS "Passes 20 Yards Downfeild",
		   SUM(passing_40) AS "Passes 40 Yards Downfeild",		   
		   season AS "Season",
		   ROUND(AVG (attempts):: NUMERIC, 2) AS "AVG Pass Attempts"
	FROM qb_data
	WHERE season_type = 'REG'
		AND games >=6
		AND attempts >=75
	GROUP BY season
	ORDER BY (season) DESC;

--Proof it works
SELECT * FROM avg_yds_thrown_downfield_reg;

--5. 
--Top 25 in total yards (rushing and passing) from 2016-2025
CREATE OR REPLACE VIEW top_25_reg_total_yards
AS
	SELECT player_name AS "Player",
		   player_display_name AS "Full Name",
		   headshot_url AS "Player Image",
		   SUM(total_yards) AS "Total Yards",
		   SUM(total_tds) AS "Total TDs",
		   SUM(passing_yards) AS "Total Passing Yards",
		   SUM(rushing_yards) AS "Total Rushing Yards",
		   SUM(passing_tds) AS "Total Pass TDs",
		   SUM(rushing_tds) AS "Total Rush TDs",
		   COUNT(season) AS "Seasons Played from 2016-2025"
	FROM qb_data
	WHERE season_type = 'REG'
	GROUP BY player_id, player_name, player_display_name, headshot_url
	ORDER BY SUM(total_yards) DESC
	LIMIT 25;

--Proof it works
SELECT * FROM top_25_reg_total_yards;

--6.
--Shows the average rushing yards per season by all qbs combined
--Must have had over 5 attemps
CREATE OR REPLACE VIEW avg_qb_rush_reg_yards_season
AS
	SELECT ROUND(AVG(rushing_yards):: NUMERIC, 2) AS "Average QB Rushing",
		   ROUND(AVG(yds_per_rush):: NUMERIC, 2) AS "Average QB Yards Per Rush",
		   SUM(rushing_tds) AS "QB Rushing TDs Per Season",
		   ROUND(AVG(carries):: NUMERIC, 2) AS "AVG QB Rush Attempts",
		   season AS "Season"
	FROM qb_data
	WHERE season_type = 'REG'
		AND games >=6
		AND carries >= 20
	GROUP BY season
	ORDER BY(season) ASC;
	
--Proof it works
SELECT * FROM avg_qb_rush_reg_yards_season;

--7.
--Best TD to Int Ratio With a Minimum of 10 starts and 250 attempts
CREATE OR REPLACE VIEW best_td_int_per_reg_season
AS
	SELECT player_name AS "Player",
		   player_display_name AS "Full Name",
		   headshot_url AS "Player Image",
		   td_to_int_ratio AS "TD to INT Ratio",
		   passing_tds AS "Passing Toucdowns",
		   passing_interceptions AS "Interceptions",
		   completion_pct AS "Completion Pct",
		   season AS "Season"
	FROM qb_data
	WHERE season_type = 'REG'
		  AND games >= 10
		  AND attempts >= 250
	ORDER BY(td_to_int_ratio) DESC
	LIMIT 5;

--Proof it works
SELECT * FROM best_td_int_per_reg_season;

--8. 
--Top Playoff Performers
CREATE OR REPLACE VIEW top_playoff_performers
AS
	SELECT player_name AS "Player",
		   player_display_name AS "Full Name",
		   headshot_url AS "Player Image",
		   SUM(passing_yards) AS "Total Playoff Passing Yards",
		   SUM(passing_tds) AS "Total Playoff Passing TDs",
		   SUM(passing_interceptions) AS "Total Playoff Interceptions",
		   SUM(total_yards) AS "Total Playoff Yards",
		   SUM(total_tds) AS "Total Playoff TDs",
		   ROUND(AVG(passer_rating):: NUMERIC, 2) AS "Average Passer Rating",
		   COUNT(season) AS "Playoff Appearances"
	FROM qb_data
	WHERE season_type = 'POST'
	GROUP BY player_id, player_name, player_display_name, headshot_url
	ORDER BY SUM(passing_yards) DESC, SUM(passing_tds) DESC
	LIMIT 25;

--Proof it works
SELECT * FROM top_playoff_performers;	


--9.
--Reg + Post Season Combined
CREATE OR REPLACE VIEW combined_reg_post_stats
AS
	SELECT player_name AS "Player",
		   player_display_name AS "Full Name",
		   headshot_url AS "Player Image",
		   SUM(passing_yards) AS "Total Passing Yards",
		   SUM(passing_tds) AS "Total Passing TDs",
		   SUM(passing_interceptions) AS "Total Interceptions",
		   SUM (total_yards) AS "Total Yards",
		   ROUND(AVG(passer_rating):: NUMERIC, 2) AS "Average Passer Rating",
		   COUNT(DISTINCT season) AS "Total Seasons"
	FROM qb_data
	GROUP BY player_id, player_name, player_display_name, headshot_url
	ORDER BY SUM(passing_yards) DESC, SUM(passing_tds) DESC
	LIMIT 100;

--Proof it works
SELECT * FROM combined_reg_post_stats;

--10.
--Shows the difference in Playoffs Risers vs Playoff Dropers (min 3 playoff games)
CREATE OR REPLACE VIEW reg_vs_post_game_avg
AS
	SELECT player_name AS "Player",
		   player_display_name AS "Full Name",
		   headshot_url AS "Player Image",
		   ROUND(
			   	SUM(passing_yards) FILTER (WHERE season_type = 'REG') :: NUMERIC 
			   	/ NULLIF (SUM(games) FILTER (WHERE season_type = 'REG'), 0), 2)
			   	AS "Reg Season Passing Yards Per Game",
		   ROUND(
		   		SUM(passing_yards) FILTER (WHERE season_type = 'POST') :: NUMERIC
		   		/ NULLIF (SUM(games) FILTER (WHERE season_type = 'POST'), 0), 2)
		   		AS "Post Season Passing Yards Per Game",
		   ROUND(
			   	SUM(passing_tds) FILTER (WHERE season_type = 'REG') :: NUMERIC 
			   	/ NULLIF (SUM(games) FILTER (WHERE season_type = 'REG'), 0), 2)
			   	AS "Reg Season Passing TDs Per Game",
		   ROUND(
		   		SUM(passing_tds) FILTER (WHERE season_type = 'POST') :: NUMERIC
		   		/ NULLIF (SUM(games) FILTER (WHERE season_type = 'POST'), 0), 2)
		   		AS "Post Season Passing TDs Per Game",
		   ROUND(
			   	SUM(passing_interceptions) FILTER (WHERE season_type = 'REG') :: NUMERIC 
			   	/ NULLIF (SUM(games) FILTER (WHERE season_type = 'REG'), 0), 2)
			   	AS "Reg Season INTs Per Game",
		   ROUND(
		   		SUM(passing_interceptions) FILTER (WHERE season_type = 'POST') ::NUMERIC
		   		/ NULLIF (SUM(games) FILTER (WHERE season_type = 'POST'), 0), 2)
		   		AS "Post Season INTs Per Game",
		   ROUND(AVG(completion_pct) FILTER (WHERE season_type = 'REG') :: NUMERIC, 2)
			   	AS "Avg Reg Season Completion Pct",
		   ROUND(AVG(completion_pct) FILTER (WHERE season_type = 'POST') :: NUMERIC, 2)
			   	AS "Avg Post Season Completion Pct",
		   ROUND(AVG(passer_rating) FILTER (WHERE season_type = 'REG') :: NUMERIC, 2)
			   	AS "Avg Reg Season Passer Rating",
		   ROUND(AVG(passer_rating ) FILTER (WHERE season_type = 'POST') :: NUMERIC, 2)
			   	AS "Avg Post Season Passer Rating",
		   ROUND(
		   		(AVG(passer_rating) FILTER (WHERE season_type = 'POST') 
		   		- AVG(passer_rating) FILTER (WHERE season_type = 'REG')) :: NUMERIC, 2)
		   		AS "Passer Rating Difference",
		   ROUND(
			   	SUM(total_yards) FILTER (WHERE season_type = 'REG') :: NUMERIC 
			   	/ NULLIF (SUM(games) FILTER (WHERE season_type = 'REG'), 0), 2)
			   	AS "Reg Season Total Yards Per Game",
		   ROUND(
		   		SUM(total_yards) FILTER (WHERE season_type = 'POST') ::NUMERIC
		   		/ NULLIF (SUM(games) FILTER (WHERE season_type = 'POST'), 0), 2)
		   		AS "Post Season Total Yards Per Game",
		   ROUND(
			   	SUM(total_tds) FILTER (WHERE season_type = 'REG') :: NUMERIC 
			   	/ NULLIF (SUM(games) FILTER (WHERE season_type = 'REG'), 0), 2)
			   	AS "Reg Season Total TDs Per Game",
		   ROUND(
		   		SUM(total_tds) FILTER (WHERE season_type = 'POST') :: NUMERIC
		   		/ NULLIF (SUM(games) FILTER (WHERE season_type = 'POST'), 0), 2)
		   		AS "Post Season Total TDs Per Game",
		   SUM(games) FILTER (WHERE season_type = 'REG') AS "Reg Season Games",
		   SUM(games) FILTER (WHERE season_type = 'POST') AS "Post Season Games"
	FROM qb_data 
	GROUP BY player_id, player_name, player_display_name, headshot_url
	HAVING SUM(games) FILTER (WHERE season_type = 'POST') >= 3
	ORDER BY player_name;

--Proof it works
SELECT * FROM reg_vs_post_game_avg;


--11.
--Shows Expected Points vs. Total TDs
CREATE OR REPLACE VIEW epa_vs_tds_scored
AS
    SELECT player_name AS "Player",
           player_display_name AS "Full Name",
           headshot_url AS "Player Image",
           ROUND(passing_epa :: NUMERIC, 2) AS "Passing EPA",
           passing_tds AS "Passing TDs",
           ROUND(rushing_epa :: NUMERIC, 2) AS "Rushing EPA",
           rushing_tds AS "Rushing TDs",
           total_epa AS "Total EPA",
           total_tds AS "Total TDs",
           total_turnovers AS "Total Turnovers",
           season AS "Season",
           passing_yards AS "Passing Yards",
           total_dropbacks AS "Total Dropbacks",
           epa_per_dropback AS "EPA per Dropback"
    FROM qb_data
    WHERE season_type = 'REG'
            AND games >= 6
           AND attempts >= 100
    ORDER BY(passing_epa) DESC;

--Proof it works
SELECT * FROM epa_vs_tds_scored;