USE covideda;

CREATE TABLE Covid_Vaccinations
(
ISOcode VARCHAR(10),
Continent Varchar(20),
Location VARCHAR (50),
`Date` DATE,	
new_tests INT(10),	
total_tests	INT (10),
total_tests_per_thousand DOUBLE,	
new_tests_per_thousand DOUBLE,
new_tests_smoothed DOUBLE,
new_tests_smoothed_per_thousand DOUBLE,	
positive_rate DOUBLE,
tests_per_case DOUBLE,
tests_units	VARCHAR(20),
total_vaccinations INT(10),
people_vaccinated INT(10),
people_fully_vaccinated	INT(10),
new_vaccinations INT(10),
new_vaccinations_smoothed DOUBLE,	
total_vaccinations_per_hundred DOUBLE,
people_vaccinated_per_hundred DOUBLE,
people_fully_vaccinated_per_hundred DOUBLE,	
new_vaccinations_smoothed_per_million DOUBLE,
stringency_index DOUBLE,
population_density DOUBLE,
median_age DOUBLE,
aged_65_older DOUBLE,
aged_70_older DOUBLE,	
gdp_per_capita DOUBLE,
extreme_poverty	DOUBLE,
cardiovasc_death_rate DOUBLE,
diabetes_prevalence DOUBLE,
female_smokers DOUBLE,
male_smokers DOUBLE,
handwashing_facilities DOUBLE,	
hospital_beds_per_thousand DOUBLE,
life_expectancy	DOUBLE,
human_development_index DOUBLE );

SELECT * 
FROM Covid_Vaccinations;
SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidVaccinations.csv' INTO TABLE Covid_Vaccinations
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

SELECT * FROM Covid_Vaccinations LIMIT 5;

