USE NETFLIX

-- --------------------------------------
-- DATA EXPLORATION
-- --------------------------------------

-- Q1: Preview the dataset
SELECT * FROM NETFLIX
LIMIT 5;

-- Q2: How many total records are there in the dataset?
SELECT COUNT(*) AS TOTAL_RECORDS FROM NETFLIX;

-- Q3: What are the unique types of content?
SELECT DISTINCT TYPE FROM NETFLIX;

-- Q4: List all unique genres/categories.
SELECT DISTINCT GENRE  FROM NETFLIX
LIMIT 10;

-- Q5: What are the top countries with the most Netflix content?
SELECT COUNTRY, COUNT(TYPE) AS TOTAL_CONTENT FROM NETFLIX
GROUP BY COUNTRY
ORDER BY TOTAL_CONTENT DESC
LIMIT 5;

-- --------------------------------------
-- DATE & TIME-BASED ANALYSIS
-- --------------------------------------

-- Q6: How many shows/movies were released each year?
SELECT RELEASE_YEAR , COUNT(TYPE) AS CONTENTS FROM NETFLIX
GROUP BY RELEASE_YEAR
ORDER BY CONTENTS DESC
LIMIT 5;

-- Q7: Which year had the most content added to Netflix?
SELECT YEAR(str_to_date(DATE_ADDED, '%d-%m-%y')) as YEAR , COUNT(*) AS CONTENTS FROM NETFLIX
GROUP BY YEAR
ORDER BY CONTENTS;

-- Q8: What are the most popular months for adding new content?
SELECT monthname(str_to_date(DATE_ADDED, '%d-%m-%y')) AS MONTH_ADDED , count(TYPE) as CONTENTS FROM NETFLIX
WHERE date_added IS NOT NULL
GROUP BY MONTH_ADDED
ORDER BY CONTENTS desc 
LIMIT 5;

-- Q9: Which day of the week is content most commonly added to Netflix?
SELECT DAYNAME(STR_TO_DATE(DATE_ADDED, '%d-%m-%Y')) as WEEK_DAY , COUNT(*) AS CONTENTS FROM NETFLIX
WHERE DATE_ADDED IS NOT NULL
GROUP BY WEEK_DAY
ORDER BY CONTENTS DESC
LIMIT 5;

-- Q10: Which month and year combination had the most content added?
SELECT CONCAT(monthname(STR_TO_DATE(DATE_ADDED, '%d-%m-%Y')) , ' ' , year(str_to_date(date_added,'%d-%m-%Y'))) as MONTH_YEAR , COUNT(TYPE) AS CONTENTS FROM NETFLIX
WHERE DATE_ADDED IS NOT NULL
GROUP BY MONTH_YEAR
ORDER BY CONTENTS DESC
LIMIT 5;

-- Q11: How many titles were added each month across all years?
SELECT YEAR(STR_TO_DATE(DATE_ADDED, '%d-%m-%Y')) as YEAR , COUNT(*) AS TITLES FROM NETFLIX
WHERE DATE_ADDED IS NOT NULL
GROUP BY YEAR
ORDER BY TITLES DESC
lIMIT 5;

-- Q12: How many Movies vs TV Shows were added each year?
SELECT year(str_to_date(DATE_aDDED, '%d-%m-%Y')) as YEAR , TYPE, COUNT(*) AS TOTAL FROM NETFLIX
WHERE DATE_ADDED IS NOT NULL
GROUP BY YEAR, TYPE
ORDER BY TYPE, TOTAL DESC
LIMIT 5;

-- --------------------------------------
-- CONTENT-BASED INSIGHTS
-- --------------------------------------

-- Q13: What are the top 10 most common titles on Netflix?
SELECT DISTINCT TITLE , TYPE , COUNT(*) AS TOTAL FROM NETFLIX
GROUP BY TITLE , TYPE
ORDER BY TOTAL DESC
LIMIT 10;

-- Q14: What are the most frequent genres in the dataset?

SELECT GENRE , COUNT(*) AS FREQUENT FROM NETFLIX
WHERE GENRE IS not NULL
GROUP BY GENRE 
ORDER BY FREQUENT DESC
LIMIT 5;

-- Q15: What are the longest-running contents?
SELECT TITLE, TYPE, DURATION  FROM NETFLIX
WHERE DURATION > 200 
Order by duration desc
LIMIT 5;

-- Q16: Are there any duplicate titles in the dataset?
SELECT DISTINCT TITLE , COUNT(*) FROM NETFLIX
GROUP BY TITLE
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Q17: Which genres are more associated with Movies vs TV Shows?
SELECT GENRE, COUNT(CASE WHEN TYPE = 'MOVIE' THEN 1 END) AS MOVIE_COUNTS , 
COUNT(CASE WHEN TYPE = 'TV SHOW' THEN 1 END) AS TV_SHOWS
FROM NETFLIX
WHERE GENRE IS NOT NULL
GROUP BY GENRE
ORDER BY MOVIE_COUNTS DESC , TV_SHOWS DESC
LIMIT 3;

-- Q18: What are the most commonly used ratings?
SELECT RATING , COUNT(*) AS COUNT FROM NETFLIX 
GROUP BY RATING
ORDER BY COUNT DESC
LIMIT 5;

-- Q19: What is the average movie duration?
SELECT TYPE,
 COUNT(*) AS TOTAL_COUNT ,
 AVG(CAST(SUBSTRING_INDEX(DURATION, ' ', 1) AS UNSIGNED)) AS AVG_DURATION
 FROM NETFLIX
 GROUP BY TYPE
 ORDER BY AVG_DURATION;

-- Q20: How many short films (< 40 mins) or TV series with few episodes are there?
SELECT DISTINCT(TITLE) , DURATION FROM NETFLIX 
WHERE TYPE = 'MOVIE' AND CAST(SUBSTRING_INDEX(DURATION, ' ', 1) AS UNSIGNED)< 40 
ORDER BY CAST(SUBSTRING_INDEX(DURATION, ' ', 1) AS UNSIGNED) DESC
LIMIT 10;

-- --------------------------------------
-- COUNTRY & GENRE-BASED ANALYSIS
-- --------------------------------------

-- Q21: Which countries produce the most Netflix content?
SELECT COUNTRY , COUNT(*) AS CONTENTS FROM NETFLIX
WHERE COUNTRY IS NOT NULL
GROUP BY COUNTRY
ORDER BY CONTENTS DESC
LIMIT 5;

-- Q22: What type of content (Movie/TV Show) is more common in each country?
SELECT COUNTRY , COUNT(CASE WHEN TYPE = 'MOVIE' THEN 1 END) AS MOVIE , COUNT( CASE WHEN TYPE = 'TV SHOW' THEN 1 END ) AS TV_SHOW
FROM NETFLIX
WHERE COUNTRY IS NOT NULL
GROUP BY COUNTRY
ORDER BY MOVIE DESC, TV_SHOW DESC
LIMIT 5;

-- Q23: Find countries with very few titles, potentially untapped markets.
SELECT COUNTRY , COUNT(TITLE) AS TOTAL_TITLES FROM NETFLIX 
WHERE COUNTRY IS NOT NULL
GROUP BY COUNTRY
ORDER BY TOTAL_TITLES ASC
LIMIT 5;

-- Q24: Detect content saturation — genres that are overrepresented.
SELECT GENRE , COUNT(*) AS COUNT FROM NETFLIX
WHERE GENRE IS NOT NULL
GROUP BY GENRE
ORDER BY COUNT DESC
LIMIT 5;
