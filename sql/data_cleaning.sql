DROP TABLE IF EXISTS layoffs;

CREATE TABLE layoffs (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off TEXT,
    percentage_laid_off TEXT,
    date TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions TEXT
); 

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

USE world_layoffs;

LOAD DATA LOCAL INFILE '/Users/swastiksangwan/Downloads/layoffs.csv'
INTO TABLE layoffs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions);

select * 
from layoffs;


-- DATA CLEANING 
	-- 1. Remove Duplicates
    -- 2. Standardize data
    -- 3. Null values or blank values 
    -- 4. Remove any columns 
    


-- REMOVING DUPLICATES 

create table layoffs_staging
like layoffs;

insert layoffs_staging
select * 
from layoffs;

select * from layoffs_staging;


with duplicates_cte as 
(
select *, 
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from layoffs_staging
) 
select * 
from duplicates_cte
where row_num > 1; 

select * 
from layoffs_staging
where company = 'Casper';


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` int
) 


select * 
from layoffs_staging2;

insert into layoffs_staging2
select *, 
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select * 
from layoffs_staging2;

delete from
layoffs_staging2 
where row_num > 1;

SET SQL_SAFE_UPDATES = 0;

delete from
layoffs_staging2 
where row_num > 1;

select * 
from layoffs_staging2
where row_num > 2;


-- STANDARDISING DATA

select * 
from layoffs_staging2;

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select * 
from layoffs_staging2;

select distinct industry
from layoffs_staging2
order by 1;

select * 
from layoffs_staging2 
where industry like 'Crypto%';

update layoffs_staging2 
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct location 
from layoffs_staging2;

select *
from layoffs_staging2
where country = 'United States';

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United%';

select date,
str_to_date(date, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set date = str_to_date(date, '%m/%d/%Y');

alter table layoffs_staging2
modify date date;


-- NULL VALUES OR BLANK VALUES 

select * 
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

select *
from layoffs_staging2 
where industry is NULL 
or industry = '';

select *
from layoffs_staging2 
where company = 'Airbnb';

update layoffs_staging2
set industry = NULL 
where industry = '';

select * 
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company 
    and t1.location = t2.location
where t1.industry is NULL
and t2.industry is NOT NULL;

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company 
    and t1.location = t2.location
where t1.industry is NULL
and t2.industry is NOT NULL;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company 
set t1.industry = t2.industry
where t1.industry is NULL
and t2.industry is not null;  

select *
from layoffs_staging2;

select * 
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

delete
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;


-- DROP COLUMNS IF NEEDED 

alter table layoffs_staging2
drop column row_num;


-- END

select *
from layoffs_staging2;