# QB_Stats_Dashboard
NFL QB Data Analysis project using Python, SQL, and Excel.


## DISCLAIMER 
This Project uses a 3rd party data source from Kaggle. Data from this file may be innacurate or missing. This is soley to demonstrate skills of Python, SQL, and Excel

## Data Source
The dataset used for this project was obtained from Kaggle 
https://www.kaggle.com/datasets/philiphyde1/nfl-stats-1999-2022?resource=download&select=yearly_player_stats_offense.csv
Data includes statistics from NFL offensive skill poistions from 2012 to 2024.

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
- Creat Views to leverage specific data. (Top passing yards, Average per season, ect).

3. **Creating an Excel Ready File (Python)**
- Connect Pyton to your SQL server using psycopg2.
- List out the views you want to use, as well as a location for the Excel file to go.
- Loop using ExcelWriter to create a Workbook with each of the views being a sheet.

4. **Excel Dashboard**
- 
