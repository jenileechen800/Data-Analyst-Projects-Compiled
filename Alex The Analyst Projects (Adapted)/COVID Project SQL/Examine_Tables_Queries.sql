-- WARM-UP QUERIES

-- SELECT * 
-- FROM covid_project_db.coviddeaths
-- ORDER BY 3, 4;

-- SELECT * 
-- FROM covid_project_db.covidvaccinations
-- ORDER BY 3, 4;

-- ACTUAL PROJECT
-- SELECT location, date, total_cases, new_cases, total_deaths, population
-- FROM covid_project_db.coviddeaths
-- ORDER BY 3, 4;

-- Looking at Total Cases vs Total Deaths
-- SELECT location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as PercentPopulationInfected
-- FROM covid_project_db.coviddeaths
-- WHERE location like '%states%'
-- ORDER BY 1, 2;

-- Looking at Countries With Highest Infection Rates Compared To Population
-- SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)) * 100 as PercentPopulationInfected
-- FROM covid_project_db.coviddeaths
-- GROUP BY location, population
-- -- WHERE location like '%states%'
-- ORDER BY PercentPopulationInfected desc

-- Showing Countries With Highest Death Count Per Population
SELECT location
FROM covid_project_db.coviddeaths
GROUP BY location, population
-- WHERE location like '%states%'
ORDER BY PercentPopulationInfected desc
