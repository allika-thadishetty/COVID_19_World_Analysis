# COVID-19 World Analysis: A Data Analysis SQL Project

## Project Overview
This project involves analyzing global COVID-19 data using SQL on MySQL Workbench. The project uses two datasets, "Deaths" and "Vaccinations," sourced from [Our World in Data](https://ourworldindata.org/covid-deaths). The datasets cover worldwide COVID-19 statistics for continents and countries from February 2020 to May 2021.

The analysis includes importing data, exploring individual datasets, and performing advanced SQL queries on a joined dataset for comprehensive insights into the pandemic.

---

## Project Structure
- **Data Folder:** Contains the raw datasets:
  - `Deaths.csv`
  - `Vaccinations.csv`

- **SQL Queries Folder:** Contains SQL files for:
  - Data import scripts for the "Deaths" and "Vaccinations" tables
  - Analysis of individual datasets
  - Combined table analyses using advanced SQL techniques

---

## Datasets Overview

### Data 1: Deaths
This dataset includes the following fields for each continent, country (location), and date:
- `population`
- `total_cases`
- `new_cases`
- `total_deaths`
- `new_deaths`
- `icu_patients`
- `hospital_patients`

#### Analysis 1: Deaths Table Analysis
1. **Data Import:**
   - Script to create and populate the `deaths` table.

2. **SQL Analysis:**
   - Breakdown of data by continents and countries.
   - Time-based analysis (year, month-year).
   - Insights derived using:
     - **Basic SQL:** WHERE and GROUP BY clauses.
     - **Advanced SQL:** JOINS, SUB-QUERIES, and Common Table Expressions (CTEs).

### Data 2: Vaccinations
This dataset includes the following fields for each continent, country (location), and date:
- `population`
- `new_vaccinations`
- `total_vaccinations`
- `people_fully_vaccinated`
- `new_tests`
- `total_tests`
- `stringency_index`
- `positive_rate`
- Health and demographic stats (e.g., `smokers`, `diabetes_prevalence`, `age_60_older`, `cardiovascular_death_rate`).

#### Analysis 2: Vaccinations Table Analysis
1. **Data Import:**
   - Script to create and populate the `vaccinations` table.

2. **SQL Analysis:**
   - Breakdown of data by countries and time (year, month-year).
   - Medical and demographic statistics.
   - Time series analysis of vaccination trends.
   - Queries use:
     - WHERE and GROUP BY clauses.
     - Complex SQL: JOINS, SUB-QUERIES, and CTEs.

### Combined Analysis
#### Analysis 3: Deaths and Vaccinations Joined Analysis
1. **Data Join:**
   - Combining the `deaths` and `vaccinations` tables using JOIN operations on `location` and `date` fields.

2. **SQL Analysis:**
   - Comparative analysis of factors such as cases, deaths, and vaccination rates.
   - Insights into correlations between medical and socio-economic factors.
   - Queries include:
     - Complex TEMPORARY TABLES and VIEWS.
     - Advanced use of CTEs and SUB-QUERIES.

---

## Key Features
- Comprehensive SQL-based data analysis on COVID-19 datasets.
- Exploration of trends, patterns, and correlations.
- Insights derived using:
  - Aggregations and time-series analysis.
  - Advanced SQL techniques like CTEs, TEMP TABLES, and VIEWS.

---

## Getting Started
1. Clone the repository:
   ```bash
   git clone https://github.com/allika-thadishetty/COVID_19_World_Analysis.git
