USE covideda;
SELECT * FROM covid_vaccinations;


-- TEST UNITS
SELECT V.tests_units, COUNT(V.tests_units)
FROM Covid_Vaccinations V
GROUP BY V.tests_units;

-- VALUE COUNTS
(SELECT "Total Locations" AS `Value`, COUNT(DISTINCT(V.location))
FROM Covid_Vaccinations V
WHERE V.continent != "")
UNION
(SELECT "Locations without Data" AS `Value`, COUNT(DISTINCT(V.location))
FROM Covid_Vaccinations V
WHERE V.continent != "" AND V.location IN (SELECT DISTINCT(location) FROM Covid_Vaccinations GROUP BY location HAVING MAX(total_tests) =0))
UNION
(SELECT "Locations with Data" AS `Value`, COUNT(DISTINCT(V.location))
FROM Covid_Vaccinations V
WHERE V.continent != "" AND V.location IN (SELECT DISTINCT(location) FROM Covid_Vaccinations GROUP BY location HAVING MAX(total_tests) !=0));

-- LOCATION STATISTICS
SELECT V.location, MAX(V.gdp_per_capita)AS gdp_per_capita, MAX(V.stringency_index) AS stringency_index, MAX(V.human_development_index) AS human_dev_index, MAX(V.population_density) AS population_density
FROM Covid_Vaccinations V
WHERE V.continent != ""
GROUP BY V.location;

-- LOCATION MEDICAL STATISTICS
SELECT V.location, MAX(V.cardiovasc_death_rate) AS cardiovascular_death_rate, MAX(V.diabetes_prevalence) AS diabetes_prevalence, MAX(V.handwashing_facilities) AS handwashing_facilities, MAX(V.life_expectancy) AS life_expectancy
FROM Covid_Vaccinations V
WHERE V.continent != ""
GROUP BY V.location;

-- BREAKDOWN LOCATION-WISE

-- TOTAL TESTS PERFORMED LOCATION-WISE
SELECT V.location, MAX(V.total_tests) AS `Total Tests`
FROM Covid_vaccinations V
WHERE V.continent != ""
GROUP BY V.location;

-- POSITIVE_RATE LOCATION-WISE
SELECT V.location, ROUND(AVG(V.positive_rate)*100,2) AS `Positive Rate`
FROM Covid_vaccinations V
WHERE V.continent != ""
GROUP BY V.location
ORDER BY AVG(V.positive_rate) DESC;

-- TOTAL VACCINATIONS LOCATION-WISE
SELECT V.location, MAX(V.total_vaccinations)
FROM Covid_Vaccinations V
WHERE V.continent != ""
GROUP BY V.location;

-- PPL VACCINATED VS PPL FULLY VACCINATED
SELECT V.location, SUM(people_vaccinated), SUM(people_fully_vaccinated)
FROM Covid_Vaccinations V
WHERE V.continent != ""
GROUP BY V.location;

-- % OF PPL WHO GOT THE SECOND VACCINE AS WELL
SELECT V.location, CONCAT(ROUND((SUM(people_fully_vaccinated)/SUM(people_vaccinated))*100,2),"%") AS fully_vaccinated
FROM Covid_Vaccinations V
WHERE V.continent != ""
GROUP BY V.location
HAVING SUM(people_vaccinated) != 0;

-- AVERAGE POSITIVE RATE FOR EACH LOCATION FOR EACH YEAR
WITH first_year_avg AS
(
	SELECT location, ROUND(AVG(positive_rate)*100,2) AS positive_rate
    FROM Covid_Vaccinations
    WHERE continent != "" AND YEAR(date) = 2020
    GROUP BY location
),
second_year_avg AS
(
	SELECT location, ROUND(AVG(positive_rate)*100,2) AS positive_rate
    FROM Covid_Vaccinations
    WHERE continent != "" AND YEAR(date) = 2021
    GROUP BY location
)
SELECT F.location, F.positive_rate AS 2020_positive_rate, S.positive_rate AS 2021_positive_rate
FROM first_year_avg F JOIN second_year_avg S ON F.location = S.location
WHERE F.positive_rate != 0 AND S.positive_rate != 0;

-- TOTAL TESTS CONDUCTED LOCATION-WISE FOR BOTH YEARS

WITH first_year AS
(
	SELECT location, MAX(total_tests) AS total_tests
    FROM Covid_Vaccinations
    WHERE continent != "" AND YEAR(date) = 2020
    GROUP BY location
),
second_year AS
(
	SELECT location, MAX(total_tests) AS total_tests
    FROM Covid_Vaccinations
    WHERE continent != "" AND YEAR(date) = 2021
    GROUP BY location
)
SELECT F.location, F.total_tests AS 2020_tests, S.total_tests AS 2021_tests
FROM first_year F JOIN second_year S ON F.location = S.location
WHERE F.total_tests != 0 AND S.total_tests != 0;

-- TEST UNITS COUNT LOCATION WISE
SELECT V.location,
SUM(CASE WHEN V.tests_units = "tests performed" THEN 1 ELSE 0 END) AS tets_performed,
SUM(CASE WHEN V.tests_units = "samples tested" THEN 1 ELSE 0 END) AS samples_tested,
SUM(CASE WHEN V.tests_units = "people tested" THEN 1 ELSE 0 END) AS people_tested,
SUM(CASE WHEN V.tests_units = "units unclear" THEN 1 ELSE 0 END) AS units_unclear
FROM Covid_Vaccinations V
GROUP BY V.location;

-- TIME SERIES BREAKDOWN

-- TOTAL TESTS MONTH-YEAR WISE
SELECT CONCAT(MONTHNAME(V.date)," ",YEAR(V.date)) AS `month-year`, SUM(V.new_tests) AS total_tests
FROM Covid_Vaccinations V
WHERE V.continent != ""
GROUP BY CONCAT(MONTHNAME(V.date)," ",YEAR(V.date))
ORDER BY MIN(V.date);

-- AVG POSITIVE RATE MONTH-YEAR WISE
SELECT CONCAT(MONTHNAME(V.date)," ",YEAR(V.date)) AS `month-year`, ROUND(AVG(V.positive_rate)*100,2) AS average_positive_rate
FROM Covid_Vaccinations V
WHERE V.continent != "" 
GROUP BY CONCAT(MONTHNAME(V.date)," ",YEAR(V.date))
ORDER BY MIN(V.date);

-- VACCINATIONS MONTH-YEAR WISE
SELECT CONCAT(MONTHNAME(V.date)," ",YEAR(V.date)) AS `month-year`, SUM(V.new_vaccinations) AS total_vaccinations
FROM Covid_Vaccinations V
GROUP BY CONCAT(MONTHNAME(V.date)," ",YEAR(V.date))
ORDER BY MIN(V.date);

-- FIRST AND SECOND VACCINATIONS TIME
SELECT CONCAT(MONTHNAME(V.date)," ",YEAR(V.date)) AS `month-year`, SUM(V.people_vaccinated) AS first_vaccinations, SUM(V.people_fully_vaccinated) AS second_vaccinations
FROM Covid_Vaccinations V
GROUP BY CONCAT(MONTHNAME(V.date)," ",YEAR(V.date))
ORDER BY MIN(V.date);


SELECT * FROM Covid_Vaccinations;