# QB_Stats_Dashboard
This project analyzes NFL quarterback performance from 2015–2024 using Python, SQL, and Excel.  
The workflow includes cleaning raw Kaggle data, storing and querying it in PostgreSQL, and building an interactive Excel dashboard for analysis.


## DISCLAIMER 
This Project uses a 3rd party data source from Kaggle. Data from this file may be inaccurate or missing. This is solely to demonstrate skills of Python, SQL, and Excel

## Data Source
The dataset used for this project was obtained from Kaggle 
https://www.kaggle.com/datasets/philiphyde1/nfl-stats-1999-2022?resource=download&select=yearly_player_stats_offense.csv
Data includes statistics from NFL offensive skill positions from 2012 to 2024.

## Applications Used / Needed to Replicate
- Python (requirements.txt) has needed packages.
- SQL (PostgreSQL)
- Excel (Pivot Tables)

## Process of Project
1. **Data Collecting & Cleaning (Python)**
  - Downloaded the raw data source from Kaggle.
  - Using Pandas, read in the CSV file in Python.
  - Filter out the data needed. Specific stats from only QBs in the seasons 2015-2024.
  - Remove Nulls.
  - Leverage the data you used to create new stat fields for each QB.
  - Export the data in a CSV file.

2. **Leveraging SQL**
- Create your database, "qbstats"
- Keeping the same order and type as your exported CSV file, create a table.
- Import the CSV into your table.
- Create Views to leverage specific data. (Top passing yards, Average per season, etc.).

3. **Creating an Excel Ready File (Python)**
- Connect Python to your SQL server using psycopg2.
- List out the views you want to use, as well as a location for the Excel file to go.
- Loop using ExcelWriter to create a Workbook with each of the views being a sheet.

4. **Excel Dashboard**
- Create Pivot Tables based on the worksheets you made.
- Create graphs, tables, ect.
- Use Slicers if you can.

## Findings
1. Success in the Regular Season does not correlate to success in the post season. Out of the top 15 passing yard leaders in the regular season, 9 of them appear on the Playoff passing leaders list. The top 2 in Total Passing Yards not appearing at all in the Playoff top 15.
2. The average yards thrown downfield and the average passing yards a season has consistenly dropped since 2016. This shows that defenses have become more adapted to the deep ball ultimately cutting into the total yards a QB throw in a year.
3. Quarterbacks are running the ball more. Ever since 2015 the total average of QB rushing yards has slowly increased, and while not dramatic it shows how offenses are slowly implementing a running QB at the professional level.
4. In the top 15 Passer Rating seasons between 2015-2024, there are multiple repeats, with over half of the list consisting of repeats.
