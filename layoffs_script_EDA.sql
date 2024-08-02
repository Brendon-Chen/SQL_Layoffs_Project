-- Layoffs Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Companies that went under, ordered by total laid off
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Sum of all people laid off per (company, industry, date, and country) ordered by amount DESC
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Time period of entries
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- rolling total layoffs by year
SELECT YEAR(`date`), MONTH(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY YEAR(`date`), MONTH(`date`)
ORDER BY 1 DESC;

WITH rolling_total AS (
SELECT YEAR(`date`) as `year`, MONTH(`date`) as `month`, SUM(total_laid_off) AS total_layoff
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY `year`, `month`
ORDER BY 1 DESC
)
SELECT `year`, `month`, total_layoff, SUM(total_layoff) OVER(PARTITION BY `year` ORDER BY `year`, `month`) as roll_total
FROM rolling_total;

-- Company Layoffs
WITH company_year AS (
SELECT company, YEAR(`date`) as `year`, SUM(total_laid_off) as total_laid_off
FROM layoffs_staging2
GROUP BY company, `year`
), company_year_rank AS (
SELECT *, DENSE_RANK() OVER(PARTITION BY `year` ORDER BY total_laid_off DESC) as ranking
FROM company_year
WHERE `year` IS NOT NULL
ORDER BY ranking ASC
)
SELECT * FROM company_year_rank
WHERE ranking <= 5;