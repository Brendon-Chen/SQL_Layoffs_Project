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

-- rolling total layoffs
SELECT YEAR(`date`), MONTH(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY YEAR(`date`), MONTH(`date`)
ORDER BY 1 DESC;

WITH rolling_total AS (
SELECT YEAR(`date`) as years, MONTH(`date`) as months, SUM(total_laid_off) AS total_layoff
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY YEAR(`date`), MONTH(`date`)
ORDER BY 1 DESC
)
SELECT years, months, total_layoff, SUM(total_layoff) OVER(PARTITION BY years ORDER BY years, months) as roll_total
FROM rolling_total;


