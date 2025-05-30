select * from netflix
select count (*) from netflix -- to check total number of rows
select count(*) from netflix -- to check null values
where casts is null
or country is null
or director is null;

DELETE FROM netflix -- dropping nulls values from the columns
where casts is null
or country is null
or director is null;

alter table netflix --dropping unwanted columns
drop column description;

alter table netflix     --converting 'date_added' to date format
alter column date_added type DATE
using TO_DATE(date_added,'MONTH DD,YYYY');
select * from netflix

--q1 what kind of content is trending on netflix in recent years?
select release_year,type,count(*) as total_titles
from netflix
where release_year>=2015
group by release_year,type
order by release_year;

--q2 which countries dominate netflix content production?
select country,count(*)as total
from netflix
where country is not null
group by country
order by  total desc
limit 5;

--q3what are most watched genre and how do they differ between movies and tv shows
select type,
trim(SPLIT_PART(listed_in,',',1 )) as primary_genre,
count(*) as total
from netflix
group by type,primary_genre
order by total desc
limit 10;

--q4who are top 10 directors with most content on netflix and what genre do they focus on?
select director ,count(*) as total 
from netflix 
where director is not null
group by director
order by total desc
limit 10;

--q5 in which month and years saw the highest content addition on netflix?
select extract (year from date_added)as year,
extract (month from date_added) as month,
count(*)as total 
from netflix 
where date_added is not null
group by year,month
order by year ,month;

--q6how many netflix shows or movies were released each year?
select release_year ,count(*) as total
from netflix
group by release_year 
order by release_year desc;

--q7what type of content is more prevalent on netflix:movies or tv shows?
SELECT type, COUNT(*) AS count
FROM netflix
GROUP BY type
ORDER BY count DESC;

--q8which genres have seen consistent growth over the past 5 years
select 
release_year,
trim (SPLIT_PART(listed_in,',',1)) as primary_genre,
count(*) as total
from netflix
where release_year >= 2018
group by release_year,primary_genre
order by primary_genre, release_year;

-- q9who are the most versatile directors 
select 
director,
count(distinct type ) as type_count,
count(*) as total_titles
from netflix 
where director is not null 
group by director 
having count (distinct type)>1
order by total_titles desc
limit 10;

-- q10which are shows produced most between the adult shows and children's show?
 select 
 case 
 when rating ILIKE  '%G%' OR rating ILIKE '%TV-Y%'  OR rating ILIKE '%PG%' THEN 'Family/Kids'
 WHEN rating ILIKE '%PG-13%' OR rating ILIKE '%TV-14%' THEN 'Teens'
 ELSE 'ADULTS' 
 END AS audience_type,
 count(*) as total 
 from netflix
 group by audience_type
 order by total desc;













 SELECT * FROM netflix;















