DROP TABLE IF EXISTS OLYMPICS_HISTORY;
CREATE TABLE IF NOT EXISTS OLYMPICS_HISTORY(
	ID 		INT,
    NAME 	nVARCHAR(64),
    SEX		VARCHAR(32),
    AGE		VARCHAR(32),
    HEIGHT	varchar(32),
    WEIGHT	varchar(32),
    TEAM	nvarchar(64),
    NOC		varchar(32),
    GAMES	varchar(32),
    YEAR	INT,
    SEASON	varchar(32),
    CITY	varchar(64),
    SPORT	nvarchar(64),
    EVENT	nvarchar(128),
    MEDAL	varchar(32)
);
DROP TABLE IF EXISTS NOC_REGIONS;
CREATE TABLE IF NOT EXISTS NOC_REGIONS(
	NOC VARCHAR(64),
    REGION VARCHAR(64),
    NOTES VARCHAR(128)
);
-- olympics_history
-- LOAD DATA
--     INFILE '"E:\SQL Dataset\Olympics\athlete_eventsnew.csv"'
--     INTO TABLE olympics_history
 
set global local_infile=true; 
LOAD DATA LOCAL INFILE 'E:\SQL Dataset\Olympics\athlete_eventsnew.csv' INTO TABLE olympics_history
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(ID,NAME,SEX,AGE,HEIGHT,WEIGHT,TEAM,NOC,GAMES,YEAR,SEASON,CITY,SPORT,EVENT,MEDAL);

show variables LIKE "local_infile";
