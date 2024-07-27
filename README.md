# SQL Layoffs Project

The purpose of this project is to learn SQL syntax and techniques and also data cleaning + exploration. The project features data cleaning and exploratory data analysis on a real data set about layoffs. There are *1995* entries and *9* columns (*company, location, industry, total\_laid\_off, percentage\_laid\_off, date, stage, country, funds\_raised\_millions*).

## Cleaning
Looking at the data, I removed duplicate entries using *row\_number()* to enumerate unique entries and then deleted entries with count > 1. After that I standardized the data: trim extra spacing/unnecessary characters (such as '.' from 'United States.'), combined industries that were meant to be one (such as Crypto and Crypto Currency), altered the date column to be of *date* type instead of *text*. I also filled in any null/blank values that I could and removed the rows that did not have layoff information.

#### You can contact me at brendonchenwork@gmail.com
#### Or visit my website to find me on other platforms such as Linkedin: [Click Here](https://brendon-chen.github.io/BrendonChen/)
