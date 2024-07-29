-- Create staging table
create table layoffs_staging
like layoffs;

-- Insert data into staging
insert layoffs_staging
select * from layoffs;

-- Display staging
select * from layoffs_staging;

-- lists all entries that are duplicates
with duplicates_cte as
(
select *,
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) row_num
from layoffs_staging
)
select *
from duplicates_cte
where row_num > 1;

create table layoffs_staging2
like layoffs_staging;

ALTER TABLE layoffs_staging2
ADD row_num INT;

select * from layoffs_staging2;

INSERT INTO layoffs_staging2
select *,
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) row_num
from layoffs_staging;

SELECT * FROM layoffs_staging2
WHERE row_num > 1;

-- Delete duplicates in staging2
DELETE FROM layoffs_staging2
WHERE row_num > 1;


-- Standardizing the data
SELECT company, trim(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry FROM layoffs_staging2
WHERE industry like '%Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country FROM layoffs_staging2;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`, str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- looking at nulls
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT * FROM layoffs_staging2 WHERE company = 'Airbnb';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL;

SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * FROM layoffs_staging2;