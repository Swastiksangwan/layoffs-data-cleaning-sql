-- EXPLORATORY DATA ANALYSIS

select *
from layoffs_staging2;

-- SELECT *
-- FROM layoffs_staging2
-- WHERE total_laid_off = '' OR total_laid_off IS NULL;

-- ALTER TABLE layoffs_staging2
-- MODIFY COLUMN total_laid_off INT;

--  ALTER TABLE layoffs_staging2
--  MODIFY COLUMN funds_raised_millions INT;

select max(total_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc; 

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(date), max(date)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select *
from layoffs_staging2;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select year(date), sum(total_laid_off)
from layoffs_staging2
group by year(date)
order by 1 desc;

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select substring(date, 1, 7) as 'MONTH', sum(total_laid_off)
from layoffs_staging2
where substring(date, 1, 7) is not null
group by MONTH
order by 1 desc;

with Rolling_Total as 
(
select substring(date, 1, 7) as 'MONTH', sum(total_laid_off) as total_off
from layoffs_staging2
where substring(date, 1, 7) is not null
group by MONTH
order by 1 desc
)
select MONTH, total_off, sum(total_off) over(order by MONTH) as rolling_total
from Rolling_Total;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


select company,year(date), sum(total_laid_off)
from layoffs_staging2
group by company, year(date)
order by 3 desc;


with company_total (company, year, total_laid_off) as
(
select company,year(date), sum(total_laid_off)
from layoffs_staging2
group by company, year(date)
order by 3 desc
), company_year_rank as 
(
select *, dense_rank() over(partition by year order by total_laid_off desc) as ranking
from company_total
where year is not null
)
select *
from company_year_rank
where ranking <= 5;