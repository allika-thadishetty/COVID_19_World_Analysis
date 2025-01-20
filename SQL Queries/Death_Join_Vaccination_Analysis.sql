USE covideda;
-- COVID DEATH VACCINATIONS
SELECT * 
FROM Covid_deaths D JOIN Covid_Vaccinations V ON D.location = V.location AND D.date = V.date;

-- PEOPLE VACCINATED TIME-SERIES
SELECT D.continent, V.location, V.date, D.population, SUM(V.new_vaccinations) OVER(PARTITION BY V.location ORDER BY V.date) AS `rolling total` 
FROM Covid_deaths D JOIN Covid_Vaccinations V ON D.location = V.location AND D.date = V.date
WHERE D.continent!= "";

-- PEOPLE VACCINATED VS POPULATION
WITH Rolling_total_vaccinations AS
(
	SELECT D.continent, V.location, V.date, D.population, SUM(V.new_vaccinations) OVER(PARTITION BY V.location ORDER BY V.date) AS rolling_total 
	FROM Covid_deaths D JOIN Covid_Vaccinations V ON D.location = V.location AND D.date = V.date
	WHERE D.continent!= "")
SELECT R.location, R.population, ROUND((MAX(R.rolling_total)*100)/MAX(R.population),2) AS `% of ppl vaccinated`
FROM rolling_total_vaccinations R
GROUP BY R.location, R.population
ORDER BY 3 DESC;

-- CREATING TEMP TABLE FOR EASY USE OF JOINED TABLE
DROP TEMPORARY TABLE IF EXISTS Death_Vaccinations_Join_Table;
CREATE TEMPORARY TABLE Death_Vaccinations_Join_Table AS
SELECT D.continent, D.location, D.date, D.population, D.total_cases, D.new_cases, D.total_deaths, D.new_deaths, D.icu_patients, D.hosp_patients, V.new_tests, V.total_tests, V.positive_rate, V.total_vaccinations, V.people_vaccinated, V.people_fully_vaccinated, V.new_vaccinations, V.stringency_index, V.population_density, V.median_age, V.aged_65_older, V.aged_70_older, V.gdp_per_capita, V.extreme_poverty, V.cardiovasc_death_rate, V.diabetes_prevalence, V.female_smokers, V.male_smokers, V.handwashing_facilities, V.life_expectancy, V.human_development_index
FROM Covid_deaths D JOIN Covid_Vaccinations V ON D.location = V.location AND D.date = V.date;


-- DEATHS VS Stringency Index
SELECT J.location, ROUND((MAX(J.total_deaths)*100)/MAX(J.population),2) AS total_death_percentage, MAX(J.stringency_index) AS stringency_index
FROM Death_Vaccinations_Join_Table J
GROUP BY J.location;

SELECT *
FROM Death_Vaccinations_Join_Table;





