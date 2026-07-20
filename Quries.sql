CREATE DATABASE Naukri;
use naukri;

DROP TABLE naukri;

CREATE TABLE naukri(
    uniq_id TEXT,
    Crawl_Timestamp TEXT,
    Job_Title TEXT,
    Job_Salary TEXT,
    Job_Experience TEXT,
    Key_Skills TEXT,
    Role_Category TEXT,
    Location TEXT,
    Functional_Area TEXT,
    Industry TEXT,
    Role TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/naukri.csv'
INTO TABLE naukri
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



# Duplicates check
select uniq_id, Crawl_Timestamp, Job_Title, Job_Salary, Job_Experience, Key_Skills, Role_Category,
 Location, Functional_Area, Industry, Role,count(*)
 as occurance
 from naukri
 group by uniq_id, Crawl_Timestamp, Job_Title, Job_Salary, Job_Experience, Key_Skills,
 Role_Category, Location, Functional_Area, Industry, Role
 HAVING COUNT(*) >1;
 
# Null Vlaue Check 
select
	SUM(CASE WHEN uniq_id is null then 1 else 0 end ) as null_uniq_id,
    SUM(CASE WHEN Crawl_Timestamp is null then 1 else 0 end ) as Crawl_Timestamp_null,
    SUM(CASE WHEN Job_Title is null then 1 else 0 end ) as Job_Title_nulls,
    SUM(CASE WHEN Job_Salary is null then 1 else 0 end ) as Job_Salary_nulls,
    SUM(CASE WHEN Job_Experience is null then 1 else 0 end ) as Job_Experience_nulls,
    SUM(CASE WHEN Key_Skills is null then 1 else 0 end ) as Key_Skills_nulls,
    SUM(CASE WHEN Role_Category is null then 1 else 0 end ) as Role_Category_nulls,
    SUM(CASE WHEN Location is null then 1 else 0 end ) as Location_nulls,
    SUM(CASE WHEN Functional_Area is null then 1 else 0 end ) as Functional_Area_nulls,
    SUM(CASE WHEN Industry is null then 1 else 0 end ) as Industry_nulls,
    SUM(CASE WHEN Role is null then 1 else 0 end ) as Role_nulls
    from naukri;
SELECT DISTINCT Job_Experience FROM naukri LIMIT 20;
SELECT DISTINCT Industry FROM naukri LIMIT 20;

UPDATE naukri
SET industry = 'IT-Software' 
WHERE industry IN ('IT-Software / Software Services', 'Software Services');

UPDATE naukri 
SET job_experience = REPLACE(job_experience, 'yrs', 'Years')
WHERE job_experience LIKE '%yrs%';

update naukri 
set job_experience = trim(job_experience);

 update naukri 
set LOCATION = trim(LOCATION);
 update naukri 
 set Job_Experience = 'Fresher'
 where Job_Experience = '0 - 0 Years';

select location,COUNT(*) AS JOBS  
from naukri 
WHERE industry = 'IT-Software'
GROUP BY LOCATION;
ORDER BY JOBS DESC;

#Does location affect the number of job postings in IT industry?  
SELECT Job_Experience, COUNT(*) as jobs
FROM naukri
WHERE Industry = 'IT-Software, Software Services'
GROUP BY Job_Experience
ORDER BY jobs DESC
LIMIT 10;

SELECT * FROM NAUKRI LIMIT 10;

# Which are the most in-demand roles and what is the average experience needed
SELECT ROLE,COUNT(ROLE) AS COUNTING_ROLE ,
ROUND(avg(JOB_EXPERIENCE),2)AS AVERGARES
FROM NAUKRI 
GROUP BY ROLE 
ORDER BY COUNTING_ROLE DESC;

#Which skills appear across the most different industries
select Key_Skills, count(distinct(industry)) as industryiedss_count
from naukri 
group by Key_Skills
order by industryiedss_count desc;

#Do certain industries require more experience than others
select industry,
max(job_experience) AS MAXIMUM, 
MIN(JOB_EXPERIENCE) AS MINIMUM, 
ROUND(AVG(JOB_EXPERIENCE),2) AS AVERGGE,
COUNT(*) AS TOTAL
FROM NAUKRI 
GROUP BY INDUSTRY 
ORDER BY TOTAL DESC;

#Which industries are hiring the most
select Industry,count(*) as job_listing 
from naukri 
group by Industry 
order by job_listing desc;

