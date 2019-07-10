/* create from hdfs file */
CREATE EXTERNAL TABLE IF NOT EXISTS world_cups(
    Year CHAR(4),
    Country CHAR(20),
    Winner CHAR(20),
    RunnersUp CHAR(20),
    Third CHAR(20),
    Fourth CHAR(20),
    GoalsScored INT,
    QualifiedTeams CHAR(20),
    MatchesPlayed CHAR(20),
    Attendance INT
  )
COMMENT 'Data about WorldCups'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
location '/data/hive/cups';

-- insert in data
INSERT INTO table_name (Year, Country, Winner,
VALUES ('3000', 'Brasil', 'Brasil',);