# QB Stats Dashboard
This project analyzes NFL quarterback performance from 2015–2024 using Python, SQL, and Excel.  
The workflow includes raw data cleaning, storing and querying it in PostgreSQL, and building an interactive Excel dashboard for analysis.


## DISCLAIMER 
This Project uses a 3rd party data source from Kaggle. Data from this file may be inaccurate or missing. This is solely to demonstrate skills of Python, SQL, and Excel

## Applications Used / Needed to Replicate
- Python - see requirements.txt for needed packages
- SQL (PostgreSQL)
- Excel (Pivot Tables + Slicers)



## Data Source
Dataset obtained from Kaggle:
https://www.kaggle.com/datasets/philiphyde1/nfl-stats-1999-2022?resource=download&select=yearly_player_stats_offense.csv
Includes statistics from NFL offensive skill positions. This project filters to QBs only,
seasons 2015-2024



## Process of Project
1. **Data Collecting & Cleaning (Python)**
  - Downloaded the raw data source from Kaggle.
  - Using Pandas, read in the CSV file in Python.
  - Filter out the data needed. Specific stats from only QBs in the seasons 2015-2024.
  - Remove Nulls.
  - Leverages existing data to engineer new stats fields for each QB. (shown below)
  - Exported the cleaned data as a CSV file to upload to our database.

| Stat | Formula |
|---|---|
| Completion % | Completions / Attempts × 100 |
| TD:INT Ratio | Pass TDs / Interceptions |
| Red Zone Completion % | Red Zone Completions / Red Zone Attempts × 100 |
| Total Turnovers | Interceptions + Fumbles Lost |
| Shotgun % | Shotgun Snaps / Offensive Snaps × 100 |
| Dropback % | QB Dropbacks / Offensive Snaps × 100 |
| Yards Per Attempt | Passing Yards / Pass Attempts |
| TD Per Attempt | Pass TDs / Pass Attempts |
| Air Yards Per Attempt | Passing Air Yards / Pass Attempts |
| Yards Per Rush | Rushing Yards / Rush Attempts |
| Passer Rating | Standard NFL formula |


2. **Leveraging SQL**
- Created the database, "qbstats"
- Keeping the same order and type as your exported CSV file, create the qb_data table.
- Import the CSV created from step 1 into your table.
- Created 8 views to pull specific cuts of data for the dashboard:

| View | What It Shows |
|---|---|
| `top_30_pass_yards` | Top 30 QBs by total passing yards, 2015–2024 |
| `avg_yards_season` | Average passing yards per season (min. 8 games) |
| `top_30_passer_rating` | Top 30 single-season passer ratings (min. 6 games, 1,500 yards) |
| `avg_yds_thrown_downfield` | Average air yards per attempt by season |
| `top_30_total_yards` | Top 30 QBs by total yards (passing + rushing) |
| `avg_qb_rush_yards_season` | Average QB rushing stats per season (min. 5 attempts) |
| `best_td_int_per_season` | Best single-season TD:INT ratios (min. 10 starts, 250 attempts) |
| `top_playoff_performers` | Top 25 QBs by total playoff passing yards |


3. **Creating an Excel-Ready File (Python)**
- Connect Python to the SQL server using psycopg2.
- Listed out the views to use and a file path for the Excel output.
- Looped using ExcelWriter to create a Workbook with each of the view as its own sheet.

4. **Excel Dashboard**
- Create Pivot Tables based on the worksheets.
- Built graphs, tables, etc.
- Used slicers where applicable.

## Findings
**1. Regular season success does not guarantee playoff success.**
Out of the top 15 Qbs in regular season passing yards, only 9 appear in the top 15 playoff passing yards leaders. Kirk Cousins led all QBs with 39,699 regular season yards from 2015-2024, but does not show up on the playoff list at all. Patrick Mahomes leads all QBs in playoff passing yards with 5,148 despite ranking 9th in regular season yards. 


**2. QBs are throwing the ball shorter, and total passing yards are declining.**
Average air yards per attempt peaked at 8.54 in 2016 and dropped to 7.51 by 2024. Over the same period, average passing yards per season (min 8+ games) fell from 3,761 in 2016 to 2,874 in 2024 (about a 24% decrease). Defenses have become more adapted to the deep ball, having deeper zone drops. This has caused offenses to look toward shorter throws and decreased overall yardage totals.

**3. Quarterbacks are running more.**
Among QBs with at least 5 rush attempts, average rushing yards per season jumped from 123.9 in 2015 to 178.3 in 2024 (a 44% increase). Yards per carry also increased from 2.93 to 3.86 over the same time span. Offenses are not just using their QBs as runners more often, they are adapting the offense around it.

**4. Elite passer rating seasons come from the same handful of QBs.**
In the top 15 single-season passer ratings from 2015-2024 (min 6 games and 1,500 yards), Aaron Rodgers, Lamar Jackson, Drew Brees, and Russell Wilson each appear twice. Aaron Rodgers' 2020 season leads the list 122.68. Over half of the list is made up of repeat appearances, showing how big the gap is between truly elite QBs and everyone else.

---

## File Structure

```
├── yearly_player_stats_offense.csv      # Raw Kaggle Data
├── qb_data.ipynb                        # Main Python notebook (cleaning + export)
├── requirements.txt                     # Modules required to replicate Python code
├── cleaned_qb_stats.csv                 # Cleaned data output
├── qb_data_table.sql                    # Table creation script
├── qb_data_views.sql                    # All 8 SQL views
├── qb_data_created.xlsx                 # Excel Files wih Views as sheets, pre dashboard creation
├── qb_data_analysis.xlsx                # Final Excel dashboard
└── README.md
```
