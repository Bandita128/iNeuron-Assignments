
-- ASSIGNMENT 1 : ANALYSING THE WORLD POPULATION 
-- *********************************************

Create database world_population;
Use world_population;

Create table population(
country varchar(60),
area int,
birth_rate decimal(6,2),
death_rate decimal(6,2),
infant_mortality_rate decimal(6,2),
internet_users int,
life_exp_at_birth decimal(6,2),
maternal_mortality_rate int,
net_migration_rate decimal(6,2),
population int,
population_growth_rate decimal(6,2)
);

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = true;
SET GLOBAL local_infile=1;
SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA LOCAL INFILE 'C:/load_data/cia_factbook___FSDA 18th Sept 2022_cleaned.csv'
INTO TABLE population
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

Select count(*) from population;

-- 1. Which country has the highest population?
Select country, max(population)as population from population
group by country,population
order by population desc
limit 1;
 
-- China	1355692576

-- 2. Which country has the least number of people?
Select country, min(population) as population from population
where population != 0
group by country,population
order by population asc
limit 1;

-- Pitcairn Islands	48

-- 3. Which country is witnessing the highest population growth?
Select country, max(population_growth_rate) as 'Highest Population Growth Rate' from population
group by country,population_growth_rate
order by population_growth_rate desc
limit 1;

-- Lebanon	9.37

-- 4. Which country has an extraordinary number for the population?

Assuming : This is country with the highest population

Select country from population where population = (select max(population) from population );

-- China

-- 5. Which is the most densely populated country in the world

Assuming : Population Density = Number of People/Land Area

select country, population/area as 'Population Density' 
from (Select * from population where area != 0 and population != 0) as data
group by 1, 2
order by 2 desc
limit 1;

-- Macau	20996.9286