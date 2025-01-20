USE covideda;

CREATE TABLE Covid_Deaths
(
ISOcode VARCHAR(10),
Continent Varchar(20),
Location VARCHAR (50),
Population BIGINT,
`Date` DATE,
total_cases	BIGINT,
new_cases	BIGINT,
new_cases_smoothed	DOUBLE,
total_deaths	BIGINT,
new_deaths	BIGINT,
new_deaths_smoothed	DOUBLE,
total_cases_per_million	DOUBLE,
new_cases_per_million	DOUBLE,
new_cases_smoothed_per_million	DOUBLE,
total_deaths_per_million	DOUBLE,
new_deaths_per_million	DOUBLE,
new_deaths_smoothed_per_million	DOUBLE,
reproduction_rate	DOUBLE,
icu_patients	INT,
icu_patients_per_million	DOUBLE,
hosp_patients	BIGINT,
hosp_patients_per_million	DOUBLE,
weekly_icu_admissions	BIGINT,
weekly_icu_admissions_per_million	DOUBLE,
weekly_hosp_admissions	BIGINT,
weekly_hosp_admissions_per_million	DOUBLE);

SELECT * 
FROM Covid_Deaths;
SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidDeaths.csv' INTO TABLE Covid_Deaths
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

SELECT * FROM Covid_Deaths LIMIT 5;

