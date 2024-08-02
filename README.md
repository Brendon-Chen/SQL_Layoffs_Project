# SQL Layoffs Project

The purpose of this project is to learn SQL syntax and techniques and also data cleaning + exploration. The project features data cleaning and exploratory data analysis on a real data set about layoffs. There are _1995_ entries and _9_ columns _(company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions)_.

## Cleaning

Looking at the data, I removed duplicate entries using _row_number()_ to enumerate unique entries and then deleted entries with count > 1. After that I standardized the data: trim extra spacing/unnecessary characters (such as '.' from 'United States.'), combined industries that were meant to be one (such as Crypto and Crypto Currency), altered the date column to be of _date_ type instead of _text_. I also filled in any null/blank values that I could and removed the rows that did not have layoff information.

## EDA

For the exploratory data analysis: I looked at the companies that went under (100% laid off), I looked at the amount of people laid off by _(company, industry, year, and country)_, I made a rolling total of layoffs by months and paritioned by year, and finally I looked at which companies laid off the most employees by year. For this data set we are missing a few months of data from 2020 and 2023, however, it seems that 2023 will have the greatest total layoffs as the rolling total in month 3 of 2023 _(125677)_ is fast approaching the rolling total of month 12 of 2022 (160661). The earliest date in this set is _2020-03-11_ while the latest is _2023-03-06_. By year, Uber had the most layoffs in 2020, Bytedance in 2021, Meta in 2022, and Google in 2023.

#### You can contact me at brendonchenwork@gmail.com<br>Or visit my website to find me on other platforms such as Linkedin: [Click Here](https://brendon-chen.github.io/BrendonChen/)
