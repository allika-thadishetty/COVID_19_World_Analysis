-- VALUE COUNTS
SELECT "Locations" AS `Values`, COUNT(DISTINCT(C.location)) AS counts
FROM Covid_deaths C
WHERE C.continent != ""
UNION
SELECT "Continents", COUNT(DISTINCT(C.continent))
FROM Covid_deaths C
UNION
SELECT "Duration", CONCAT(COUNT(DISTINCT(YEAR(C.date))), " Years")
FROM Covid_deaths C;


-- BREAKDOWN BY CONTINENTS (continents are locations where continent is blank)

-- TOTAL CASES IN CONTINENTS 
SELECT location, MAX(total_cases) AS total_cases
FROM Covid_deaths
WHERE continent = ""
GROUP BY location
ORDER BY 2 DESC;

-- TOTAL DEATHS IN CONTINENTS
SELECT C.location, MAX(total_deaths) AS total_deaths
FROM Covid_deaths C
WHERE continent = ""
GROUP BY location
ORDER BY 2 DESC;

-- TOTAL RECOVERIES IN CONTINENTS
SELECT location, (MAX(total_cases) - MAX(total_deaths)) AS recoveries
FROM Covid_deaths
WHERE continent = ""
GROUP BY location 
ORDER BY 2 DESC;

-- PERCENTAGE OF POPULATION DIED OFF COVID
SELECT location, CONCAT(ROUND((MAX(total_deaths)/MAX(population))*100,2),"%") AS `total deaths`
FROM Covid_deaths
WHERE continent = ""
GROUP BY location
ORDER BY 2 DESC;

-- 3rd HIGHEST CONTINENT DEATHS-WISE
WITH ranked_total_deaths AS (
	SELECT C.location, MAX(total_deaths) AS total_deaths, ROW_NUMBER() OVER (ORDER BY MAX(C.total_deaths) DESC) AS value_rank
    FROM Covid_deaths C
    WHERE C.continent = ""
    GROUP BY C.location)    
SELECT location, total_deaths, value_rank
FROM ranked_total_deaths
WHERE value_rank =3;


-- BREAKDOWN BY LOCATION

-- TOTAL DEATHS FOR EACH LOCATION
SELECT location, MAX(total_deaths) AS `total deaths`
FROM Covid_deaths
WHERE continent != ""
GROUP BY location
ORDER BY 1 DESC;

-- TOTAL RECOVERIES FOR EACH LOCATION
SELECT location, (MAX(total_cases) - MAX(total_deaths)) AS `total recoveries`
FROM Covid_deaths
WHERE continent != ""
GROUP BY location
ORDER BY 2 DESC;

-- TOTAL CASES Vs TOTAL DEATHS
SELECT C.location, MAX(C.total_cases) AS total_cases, MAX(C.total_deaths) AS total_deaths
FROM Covid_deaths C
WHERE C.continent != ""
GROUP BY C.location;

-- LIKELYHOOD OF DYING IF YOU CONTACT COVID in 2020 and 2021 in each location
SELECT location, YEAR(date) AS year, (AVG(total_deaths)/AVG(total_cases))* 100 AS likelyhood
FROM Covid_deaths
WHERE C.continent != ""
GROUP BY location, YEAR(date);

-- PERCENT OF POPULATION THAT GOT COVID
SELECT C.location, MAX(C.total_cases) AS cases, MAX(C.population) AS population, CONCAT(ROUND((MAX(total_cases)/MAX(population))*100,2), "%") AS `% of population` 
FROM Covid_deaths C
WHERE C.continent != ""
GROUP BY C.location
ORDER BY 4 DESC;

-- PERCENT OF POPULATION THAT DIED OFF COVID
SELECT C.location, MAX(C.total_deaths) AS deaths, C.population AS population, CONCAT(ROUND((MAX(total_deaths)/population)*100,2), "%") AS `% of population` 
FROM Covid_deaths C
WHERE C.continent != ""
GROUP BY C.location, C.population
ORDER BY 4 DESC;

-- TOP 5 LOCATIONS WITH MOST CASES
SELECT location, MAX(total_cases) AS `Total Cases` 
FROM Covid_deaths
WHERE Continent != ""
GROUP BY location
ORDER BY `Total Cases` DESC
LIMIT 5;

-- TOP 5 LOCATIONS WITH MOST DEATH PERCENTAGE
SELECT location, CONCAT(ROUND((MAX(total_deaths)/MAX(total_cases))*100 ,2), "%") AS `Death Percentage`
FROM Covid_deaths
WHERE continent != ""
GROUP BY location
ORDER BY `Death Percentage` DESC
LIMIT 5;

-- TOP 5 LOCATIONS WITH MOST RECOVERY PERCENTAGE
SELECT location, CONCAT(ROUND(((MAX(total_cases) - MAX(total_deaths))/MAX(total_cases))*100 ,2), "%") AS `Recovery Percentage`
FROM Covid_deaths
WHERE continent != ""
GROUP BY location
ORDER BY `Recovery Percentage` DESC
LIMIT 5;

-- START POPULATION VS END POPULATION
WITH MinDate AS (
	SELECT location, MIN(Date) AS start_date, population
	FROM Covid_deaths
    WHERE continent != ""
    GROUP BY location, population
    ),
MaxDate AS (
	SELECT location, MAX(Date) AS end_date, MAX(total_deaths) AS total_death
    FROM Covid_deaths
    WHERE continent != ""
    GROUP BY location
    )
SELECT M1.location, M1.start_date, M1.population AS start_population, M2.end_date, (M1.population - M2.total_death) AS end_population
FROM MinDate M1 JOIN MaxDate M2 ON M1.location = M2.location
GROUP BY M1.location, M1.population;

-- FIRST CASE AND FIRST DEATH TIME DIFFERENCE IN DAYS FOR EACH location
WITH first_case AS 
(
	SELECT location, MIN(C.date) AS first_case_date
	FROM Covid_deaths C
	WHERE total_cases > 0 AND continent != ""
	GROUP BY location),
first_death AS 
(
	SELECT location, MIN(date) AS first_death_date
	FROM Covid_deaths
	WHERE total_deaths > 0 AND continent != ""
	GROUP BY location)
SELECT C.location, C.first_case_date, D.first_death_date, DATEDIFF(D.first_death_date, C.first_case_date) AS `no. of days` 
FROM first_case C JOIN first_death D ON C.location = D.location;


-- BREAKDOWN BY TIME (Viewing at the world)

-- TOTAL CASES AND DEATHS YEAR-WISE
SELECT YEAR(C.date) AS year, SUM(new_cases) AS `total cases`, SUM(new_deaths) AS `total deaths`
FROM Covid_deaths C
GROUP BY YEAR(C.date);

-- TOTAL CASES BY MONTH-WISE
SELECT CONCAT(MONTHNAME(date)," ", YEAR(date)) AS Date, SUM(new_cases) AS `total cases`
 -- used new cases here instead of total as for the 2nd day it will show sum of both 1st and 2nd
FROM Covid_deaths
GROUP BY CONCAT(MONTHNAME(date)," ", YEAR(date))
ORDER BY MIN(Date);

-- TOTAL DEATHS BY MONTH-WISE
SELECT CONCAT(MONTHNAME(date)," ",YEAR(date)) AS Time, SUM(new_deaths) AS `total deaths`
FROM Covid_deaths
GROUP BY CONCAT(MONTHNAME(date), " ", YEAR(date))
ORDER BY MIN(date);

-- TOTAL RECOVERIES BY MONTH-WISE
SELECT CONCAT(MONTHNAME(date)," ",YEAR(date)) AS Time, (SUM(new_cases) - SUM(new_deaths)) AS `total recoveries`
FROM Covid_deaths
GROUP BY CONCAT(MONTHNAME(date), " ", YEAR(date))
ORDER BY MIN(date);

-- DEATH PERCENTAGE THROUGHOUT THE TIME
SELECT CONCAT(MONTHNAME(date), " ", YEAR(date)) AS Time, CONCAT(ROUND((SUM(new_deaths)/SUM(new_cases))*100,2),"%") AS `Death percentage`
FROM Covid_deaths
GROUP BY CONCAT(MONTHNAME(date), " ", YEAR(date))
ORDER BY MIN(date);

-- PEAK TIME OF COVID CASES
SELECT CONCAT(MONTHNAME(date), YEAR(date)) AS Time, SUM(new_cases) AS `Total Cases`
FROM Covid_deaths
GROUP BY CONCAT(MONTHNAME(date), YEAR(date))
ORDER BY `Total Cases` DESC
LIMIT 4;

-- PEAK TIME OF COVID DEATHS
SELECT CONCAT(MONTHNAME(date), YEAR(date)) AS Time, SUM(new_deaths) AS `Total Deaths`
FROM Covid_deaths
GROUP BY CONCAT(MONTHNAME(date), YEAR(date))
ORDER BY `Total Deaths` DESC
LIMIT 4;

-- DAYS WITH HIGHEST CASES
SELECT C.date, SUM(new_cases) AS `total cases`
FROM Covid_deaths C
GROUP BY C.date
ORDER BY SUM(new_cases) DESC
LIMIT 4;

-- DAYS WITH HIGHEST DEATHS
SELECT C.date, SUM(new_deaths) AS `total deaths`
FROM Covid_deaths C
GROUP BY C.date
ORDER BY SUM(new_deaths) DESC
LIMIT 4;






