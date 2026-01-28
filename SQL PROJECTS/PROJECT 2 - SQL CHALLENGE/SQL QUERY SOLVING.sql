------ 1. List Regions and Country Count

select region, COUNT(*) as country_count
from countries
group by region
order by country_count DESC

------ 2. List all of the sub-regions and the total number of cities in each sub-region. Order by sub-region name alphabetically.
select n.sub_region, COUNT(*) as city_count
from cities c
left join countries n
on c.country_code_2 = n.country_code_2
group by n.sub_region 
order by n.sub_region, city_count DESC;

------ 3. List all of the countries and the total number of cities in the Northern Europe sub-region. 
-- List the country names in uppercase and order the list by the length of the country name and alphabetically in ascending order.
select UPPER(TRIM(n.country_name)), COUNT(*) as city_count
from cities c
left join countries n
on c.country_code_2 = n.country_code_2
where n.sub_region = 'Northern Europe'
group by UPPER(TRIM(n.country_name))
order by LEN(UPPER(TRIM(n.country_name))), UPPER(TRIM(n.country_name)), city_count DESC;

------4. List all of the countries and the total number of cities in the Southern Europe sub-region that were inserted in 2021. 
------  Capitalize the country names and order alphabetically by the LAST letter of the country name and the number of cities.
select UPPER(TRIM(n.country_name)), COUNT(*) as city_count
from cities c
left join countries n
on c.country_code_2 = n.country_code_2
where n.sub_region = 'Southern Europe' AND YEAR(c.insert_date) = 2021
group by UPPER(TRIM(n.country_name))
order by RIGHT(UPPER(TRIM(n.country_name)),1), city_count;

---- 5 List all of the countries in the region of Asia that 
---- did NOT have a city with an inserted date from June 2021 through Sept 2021.

SELECT DISTINCT TRIM(n.country_name) as country_name
FROM countries n
LEFT JOIN cities c 
    ON n.country_code_2 = c.country_code_2 
    AND c.insert_date BETWEEN '2021-06-01' AND '2021-09-30'
WHERE n.region = 'Asia' 
AND c.country_code_2 IS NULL
ORDER BY country_name;

------ 6. List the country, city name, population and city name length for the 
----city names that are palindromes in the Western Asia sub-region. 
----Format the population with a thousands separator (1,000) and
----Order by the length of the city name in descending order and alphabetically in ascending order

select n.country_name, c.city_name, FORMAT(c.population, 'N0') as 'population', LEN(c.city_name) as city_name_length
from cities c
left join countries n
on c.country_code_2 = n.country_code_2
where n.sub_region = 'Western Asia' and c.city_name = REVERSE(c.city_name)
order by LEN(c.city_name) DESC, c.city_name;

---- 7. List all of the countries that end in 'stan'.
----Make your query case-insensitive and list whether the total population of the cities
----listed is an odd or even number for cities inserted in 2022. 
----Order by whether the population value is odd or even in ascending order and country name in alphabetical order.

with cte as(
SELECT n.country_name, SUM(c.population) as total_population
from countries n
left join cities c
on n.country_code_2 = c.country_code_2 
where country_name LIKE '%stan' AND YEAR(c.insert_date) = 2022
group by n.country_name)

---- Had a problem here, earlier was using RIGHT(country_name, 4) but Kazakhstan was missing, so used LIKE

select country_name, FORMAT(total_population, 'N0'),  CASE WHEN CAST(total_population AS BIGINT) % 2 = 0 
THEN 'EVEN' ELSE 'ODD' END AS odd_or_even
from cte
order by odd_or_even, country_name;

-- 8. List the third most populated city ranked by region 
-- WITHOUT using limit or offset. List the region name, city name, population and order the results by region.

select region,city_name,FORMAT(population, 'N0') as population
from(
select n.region,c.city_name,c.population,ROW_NUMBER() OVER(PARTITION BY n.region ORDER BY c.population DESC) AS rn
from cities c
left join countries n
on c.country_code_2 = n.country_code_2) a
where rn=3

-- 9. List the bottom third of all countries in the
-- Western Asia sub-region that speak Arabic. Include the row number and country name. Order by row number.

WITH ranked AS (
    SELECT 
        country_name,
        ROW_NUMBER() OVER(ORDER BY country_name) as row_num,
        COUNT(*) OVER() as total_count
    FROM (
        SELECT DISTINCT c.country_name
        FROM languages l
        JOIN countries c ON l.country_code_2 = c.country_code_2
        WHERE c.sub_region = 'Western Asia' AND l.language = 'Arabic'
    ) a
)
SELECT row_num, country_name
FROM ranked
WHERE row_num > (total_count * 2 / 3)
ORDER BY row_num;

-- when using ntile, you cant use distinct - first use distinct then ntile, otherwise no effect
-- of distinct when using ntile

-- 10. Create a query that lists country name, capital name, population, languages spoken and currency 
-- name for countries in the Northen Africa sub-region. 
-- There can be multiple currency names and languages spoken per country. 
-- Add multiple values for the same field into an array.
  
SELECT n.country_name, c.city_name, c.population,
LOWER(STRING_AGG(l.language, ', ')) as languages, MAX(currency_name) as currency
FROM countries n
LEFT JOIN cities c
    ON n.country_code_2 = c.country_code_2
LEFT JOIN languages l
    ON n.country_code_2 = l.country_code_2  -- Join to countries, not cities
LEFT JOIN currencies r
    ON n.country_code_2 = r.country_code_2  -- Join to countries, not languages
WHERE n.sub_region = 'Northern Africa'  
    AND c.capital = 1
GROUP BY n.country_name, c.city_name, c.population

-- Produce a query that returns the city names for cities in the U.S. that were inserted on April, 28th 2022.
--List how many vowels 
--and consonants are present in the city name and 
--concatnate their percentage to the their respective count in parenthesis.

select LOWER(c.city_name)
FROM countries n
LEFT JOIN cities c 
    ON n.country_code_2 = c.country_code_2 
    AND c.insert_date = '2022-04-28'
where country_name = 'United States Of America'


-- TO SEE ALL THE DATASETS FOR REFERNCE
select top 5 *
from cities;

select top 5 * 
from currencies;

select top 20 * 
from languages;

select top 20 * 
from countries;
