
-- QUERIES FOR VISUALS
--Visual 1

--Showing Cases, infectaion and Death Rate
Select location, max(total_cases) as Tot_Cases, max(cast(total_deaths as int)) As Death_Count, round(max(total_cases/population),3) as Infection_Rate, round(Max(cast(total_deaths as int))/max(total_cases),2) as Death_Percentage
from CovidDeaths
where continent is null and location  not in ('World', 'European Union', 'International')
Group by location
Order by Death_Count desc

--Visual 2
--Showing Cases, infection and Death Rate in African Countries
Select location, max(total_cases) as Tot_Cases, round(max(total_cases/population),3) as Infection_Rate, max(cast(total_deaths as int)) As Death_Count, round(Max(cast(total_deaths as int))/max(total_cases),2) as Death_Percentage
from CovidDeaths
where continent = 'Africa'
Group by location
Order by Death_Count desc

--- Visuals 3
--Showing Cases, infectaion and Death Rate by countries
Select location, isnull(max(total_cases),0) as Tot_Cases, isnull(round(max(total_cases/population),3),0) as Infection_Rate, 
isnull(max(cast(total_deaths as int)),0) As Death_Count, 
isnull(round(Max(cast(total_deaths as int))/max(total_cases)*100,2),0) as Death_Percentage
from CovidDeaths
where continent is not null and continent not in ('Africa')
Group by location
Order by Death_Count desc

--- Visuals 4
--Top 10 countries with the highest death count
Select location, date, isnull(max(total_cases),0) as Tot_Cases, isnull(round(max(total_cases/population),3),0) as Infection_Rate, 
isnull(max(cast(total_deaths as int)),0) As Death_Count, 
isnull(round(Max(cast(total_deaths as int))/max(total_cases),2),0) as Death_Percentage
from CovidDeaths
where location in ('United States', 'Brazil','India','Mexico','Peru','United Kingdom','Italy','Russia','France')
Group by location,date
Order by location desc


-- Visuals 5
--- Total cases, Death and Death Percentage and vacinnation rate world over
Select sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_Deaths,  round(sum(cast(new_deaths as int))/sum(new_cases),2)  as Death_Percent,
sum(cast(b.new_vaccinations as numeric)) as Tot_Vaccination --max(cast(b.people_fully_vaccinated as numeric))
from CovidDeaths as a
inner join CovidVaccination as b
on a.location = b.location and a.date = b.date
Where a.continent is not null
order by Death_Percent  desc


Select location, isnull(max(cast(total_vaccinations as numeric)),0) as Admin_Vaccinnation,  isnull(max(cast(people_fully_vaccinated as numeric)),0) Fully_Vaccinated  from CovidVaccination
where continent is null and location  not in ('World', 'European Union', 'International')
group by location



-- Select Data that we are going to be starting with
Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
Where continent is not null 
order by 1,2

-- Total Cases vs Total Deaths
-- Likelihood of dying if you contract covid in your country

--For US
Select Location, date, isnull(total_cases,0) as Tot_Cases, isnull(total_deaths,0) as Tot_Death, ISNULL((total_deaths/total_cases)*100, 0) as DeathPercentage from CovidDeaths
where location = 'United States' and continent is not null 
Order by 1, 2

---  for UK
Select Location,date, isnull(total_cases,0) as Tot_Cases, isnull(total_deaths,0) as Tot_Death, ISNULL((total_deaths/total_cases)*100, 0) as DeathPercentage from CovidDeaths
where location = 'United kingdom' and continent is not null 
Order by 1, 2

Select  Location, isnull(sum(cast(total_cases as int)),0) as Tot_Cases, isnull(sum(cast(total_deaths as int)),0) as Tot_Death, ISNULL((total_deaths/total_cases)*100, 0) as DeathPercentage 
from CovidDeaths
where location = 'United kingdom'
Group by Location, 
Order by 1, 2

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as Infection_Rate_Percent
From CovidDeaths
where location = 'United states'
order by 1,2

Select Location, date, Population, total_cases,  (total_cases/population)*100 as Infection_Rate_Percent
From CovidDeaths
where location = 'United kingdom'
order by 1,2


-- Countries with Highest Infection and Death rate compared to Population
Select Location, isnull(max(total_cases),0) as Tot_Country_Case,  isnull(round(max(total_cases)/population*100, 2),0) 
as Country_Infection_Rate, round(max(total_deaths)/population*100,2) as Country_Death_Rate
From CovidDeaths
Where continent is not null and continent not in ('Africa')
Group by Location, Population
order by Country_Infection_Rate desc

---- Global Numbers
Select isnull(sum(new_cases),0) as Total_Case, sum(cast(new_deaths as int)) as Total_Death,  sum(cast(new_deaths as int))/sum(new_cases) as Death_Percent
from CovidDeaths
Where continent is not null
order by Death_Percent  desc

Select isnull(max(total_cases),0) as Total_Case, max(cast(total_deaths as int)) as Total_Death,  max(cast(total_deaths as int)/(total_cases)) as Death_Percent
from CovidDeaths
Where location = 'Africa'
order by Death_Percent  desc


---African Countries
Select Location, isnull(max(total_cases),0) as Tot_Country_Case,  isnull(round(max(total_cases)/population*100, 2),0) 
as Country_Infection_Rate, round(max(total_deaths)/population*100,2) as Country_Death_Rate
From CovidDeaths
Where Continent = 'Africa'
Group by Location, Population
order by Country_Infection_Rate desc

-- Showing contintents with the highest death count
Select Location, max(cast(total_deaths as int)) as Tot_Country_Death,  round(max(total_deaths)/population*100,2) as Country_Death_Rate
From CovidDeaths
Where continent is not null
Group by Location, Population
order by Country_Death_Rate desc


Select location, max(total_cases) as Tot_Cases, max(cast(total_deaths as int)) As Death_Count, round(sum(total_cases/population),2) as Infection_Rate, round(max(total_deaths/total_cases),2) as Death_Percentage
from CovidDeaths
where continent is null and location  not in ('World', 'European Union', 'International')
Group by location
Order by Death_Percentage desc


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select a.location, a.population, sum(cast(b.new_vaccinations as int)) as Tot_Vaccination, sum(cast(b.new_vaccinations as int))/a.population *100 as Vaccination_rate
from CovidDeaths as A
inner join CovidVaccination as b
on a.location = b.location and a.date = b.date
where a.continent is not null --and a.location = 'United Kingdom'
group by a.location, a.population
order by Tot_Vaccination desc

Select * from CovidVaccination
Select sum(cast(new_vaccinations as numeric)), MAX(cast(Total_vaccinations as int)) from CovidVaccination

--Using With
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, Cummlative_Vaccinatn)
as
(
Select a.continent, a.location, a.date, a.population, b.new_vaccinations, 
SUM(CONVERT(int, b.new_vaccinations)) Over (partition by a.location order by a.location, a.date) as Cummlative_Vaccinatn
from CovidDeaths as A
inner join CovidVaccination as b
on a.location = b.location and a.date = b.date
where a.continent is not null --and a.location = 'United Kingdom'
--order by 1,2,3,4
) 
Select *, (Cummlative_Vaccinatn/Population)*100
From PopvsVac


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Cummlative_Vaccinatn numeric
)
Insert into #PercentPopulationVaccinated
Select a.continent, a.location, a.date, a.population, b.new_vaccinations
, SUM(CONVERT(int,b.new_vaccinations)) OVER (Partition by a.Location Order by a.location, a.Date) as Cummlative_Vaccinatn
From CovidDeaths as a
Join CovidVaccination as b
	On a.location = b.location
	and a.date = b.date
--where dea.continent is not null 
--order by 2,3
Select *, (Cummlative_Vaccinatn/Population)*100
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select a.continent, a.location, a.date, a.population, b.new_vaccinations, 
SUM(CONVERT(int, b.new_vaccinations)) Over (partition by a.location order by a.location, a.date) as Cummlative_Vaccinatn
from CovidDeaths as A
inner join CovidVaccination as b
on a.location = b.location and a.date = b.date
where a.continent is not null --a.location = 'United Kingdom'
--order by 1,2,3,4

---Death Rate in Nigeria
Select isnull(max(total_cases),0) as Tot_Cases, isnull(max(total_deaths),0) as Tot_Death, round(isnull((total_deaths/total_cases)*100, 0),2) as DeathPercentage from CovidDeaths
where location = 'Nigeria' and continent is not null 
Order by 1, 2


---Death Rate in Africa
Select max(total_cases) as Tot_Cases, max(cast(total_deaths as int)) as Tot_Death, round((total_deaths/total_cases)*100,2) as DeathPercentage from CovidDeaths
where location = 'Africa' and continent is null 
Order by 1, 2

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
Select Location, date, Population, isnull((total_cases),0) as total_Cases, isnull(round((total_cases/population)*100, 2),0) as Infection_Rate_Percent
From CovidDeaths
where location = 'Nigeria' or location = 'Africa'
order by 1,2


Select Location, date, Population, isnull((total_cases),0) as total_Cases,  round((total_cases/population)*100, 2) as Infection_Rate_Percent
From CovidDeaths
where location = 'Africa' and continent is null 
order by 1,2

-- QUERIES FOR VISUALS
--Visual 1

-- BREAKING THINGS DOWN BY CONTINENT
--Showing Cases, infectaion and Death Rate
Select location, max(total_cases) as Tot_Cases, max(cast(total_deaths as int)) As Death_Count, round(max(total_cases/population),3) as Infection_Rate, round(Max(cast(total_deaths as int))/max(total_cases),2) as Death_Percentage
from CovidDeaths
where continent is null and location  not in ('World', 'European Union', 'International')
Group by location
Order by Death_Count desc

--Visual 2
--Showing Cases, infection and Death Rate in African Countries
Select location, max(total_cases) as Tot_Cases, round(max(total_cases/population),3) as Infection_Rate, max(cast(total_deaths as int)) As Death_Count, round(Max(cast(total_deaths as int))/max(total_cases),2) as Death_Percentage
from CovidDeaths
where continent = 'Africa'
Group by location
Order by Death_Count desc

--- Visuals 3
--Showing Cases, infectaion and Death Rate by countries
Select location, isnull(max(total_cases),0) as Tot_Cases, isnull(round(max(total_cases/population),3),0) as Infection_Rate, 
isnull(max(cast(total_deaths as int)),0) As Death_Count, 
isnull(round(Max(cast(total_deaths as int))/max(total_cases)*100,2),0) as Death_Percentage
from CovidDeaths
where continent is not null and continent not in ('Africa')
Group by location
Order by Death_Count desc

--- Visuals 4
--Top 10 countries with the highest death count
Select location, date, isnull(max(total_cases),0) as Tot_Cases, isnull(round(max(total_cases/population),3),0) as Infection_Rate, 
isnull(max(cast(total_deaths as int)),0) As Death_Count, 
isnull(round(Max(cast(total_deaths as int))/max(total_cases),2),0) as Death_Percentage
from CovidDeaths
where location in ('United States', 'Brazil','India','Mexico','Peru','United Kingdom','Italy','Russia','France')
Group by location,date
Order by location desc


-- Visuals 5
--- Total cases, Death and Death Percentage and vacinnation rate world over
Select sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_Deaths,  round(sum(cast(new_deaths as int))/sum(new_cases),2)  as Death_Percent,
sum(cast(b.new_vaccinations as numeric)) as Tot_Vaccination --max(cast(b.people_fully_vaccinated as numeric))
from CovidDeaths as a
inner join CovidVaccination as b
on a.location = b.location and a.date = b.date
Where a.continent is not null
order by Death_Percent  desc


Select location, isnull(max(cast(total_vaccinations as numeric)),0) as Admin_Vaccinnation,  isnull(max(cast(people_fully_vaccinated as numeric)),0) Fully_Vaccinated  from CovidVaccination
where continent is null and location  not in ('World', 'European Union', 'International')
group by location


