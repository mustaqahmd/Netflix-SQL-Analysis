USE NETFLIX

-- --------------------------------------
-- DATA EXPLORATION
-- --------------------------------------

-- Q1: Preview the dataset
 
SELECT * FROM NETFLIX
LIMIT 5;

+---------+---------+-------------------------------+---------------------+-----------------------------------------------------------------------+------------+--------------+------------------+--------+-----------+
| Show_id | type    | title                         | director            | country                                                               | date_added | release_year | genre            | rating | duration  |
+---------+---------+-------------------------------+---------------------+-----------------------------------------------------------------------+------------+--------------+------------------+--------+-----------+
|       1 | Movie   | Dick Johnson Is Dead          | Kirsten Johnson     | United States                                                         | 25-09-2021 |         2020 | Documentaries    | PG-13  | 90 min    |
|       2 | Movie   | Sankofa                       | Haile Gerima        | United States, Ghana, Burkina Faso, United Kingdom, Germany, Ethiopia | 24-09-2021 |         1993 | Dramas           | TV-MA  | 125 min   |
|       3 | TV Show | The Great British Baking Show | Andy Devonshire     | United Kingdom                                                        | 24-09-2021 |         2021 | British TV Shows | TV-14  | 9 Seasons |
|       4 | Movie   | The Starling                  | Theodore Melfi      | United States                                                         | 24-09-2021 |         2021 | Comedies         | PG-13  | 104 min   |
|       5 | Movie   | Je Suis Karl                  | Christian Schwochow | Germany, Czech Republic                                               | 23-09-2021 |         2021 | Dramas           | TV-MA  | 127 min   |
+---------+---------+-------------------------------+---------------------+-----------------------------------------------------------------------+------------+--------------+------------------+--------+-----------+
5 rows in set (0.00 sec)

-- Q2: How many total records are there in the dataset?
 
SELECT COUNT(*) AS TOTAL_RECORDS FROM NETFLIX;

+---------------+
| TOTAL_RECORDS |
+---------------+
|         21931 |
+---------------+
1 row in set (0.01 sec)

-- Q3: What are the unique types of content?
 
SELECT DISTINCT TYPE FROM NETFLIX;

+---------+
| TYPE    |
+---------+
| Movie   |
| TV Show |
+---------+
2 rows in set (0.05 sec)

-- Q4: List all unique genres/categories.
 
SELECT DISTINCT GENRE  FROM NETFLIX
LIMIT 10;

+--------------------------+
| GENRE                    |
+--------------------------+
| Documentaries            |
| Dramas                   |
| British TV Shows         |
| Comedies                 |
| Horror Movies            |
| Thrillers                |
| Action & Adventure       |
| Sci-Fi & Fantasy         |
| Children & Family Movies |
| Classic Movies           |
+--------------------------+
10 rows in set (0.00 sec)

-- Q5: What are the top countries with the most Netflix content?
 
SELECT COUNTRY, COUNT(TYPE) AS TOTAL_CONTENT FROM NETFLIX
GROUP BY COUNTRY
ORDER BY TOTAL_CONTENT DESC
LIMIT 5;

+----------------+---------------+
| COUNTRY        | TOTAL_CONTENT |
+----------------+---------------+
| United States  |          8665 |
| India          |          2917 |
| United Kingdom |           859 |
| Canada         |           487 |
| Spain          |           367 |
+----------------+---------------+
5 rows in set (0.07 sec)

-- --------------------------------------
-- DATE & TIME-BASED ANALYSIS
-- --------------------------------------

-- Q6: How many shows/movies were released each year?
 
SELECT RELEASE_YEAR , COUNT(TYPE) AS CONTENTS FROM NETFLIX
GROUP BY RELEASE_YEAR
ORDER BY CONTENTS DESC
LIMIT 5;

+--------------+----------+
| RELEASE_YEAR | CONTENTS |
+--------------+----------+
|         2017 |     2910 |
|         2018 |     2699 |
|         2016 |     2479 |
|         2019 |     2189 |
|         2020 |     1885 |
+--------------+----------+
5 rows in set (0.03 sec)

-- Q7: Which year had the most content added to Netflix?
 
SELECT YEAR(str_to_date(DATE_ADDED, '%d-%m-%y')) as YEAR , COUNT(*) AS CONTENTS FROM NETFLIX
GROUP BY YEAR
ORDER BY CONTENTS;

+------+----------+
| YEAR | CONTENTS |
+------+----------+
| 2020 |    21931 |
+------+----------+
1 row in set, 21932 warnings (0.06 sec)

-- Q8: What are the most popular months for adding new content?
 
SELECT monthname(str_to_date(DATE_ADDED, '%d-%m-%y')) AS MONTH_ADDED , count(TYPE) as CONTENTS FROM NETFLIX
WHERE date_added IS NOT NULL
GROUP BY MONTH_ADDED
ORDER BY CONTENTS desc 
LIMIT 5;

+-------------+----------+
| MONTH_ADDED | CONTENTS |
+-------------+----------+
| January     |     2021 |
| October     |     2007 |
| December    |     1980 |
| April       |     1951 |
| March       |     1931 |
+-------------+----------+
5 rows in set, 21943 warnings (0.07 sec)

-- Q9: Which day of the week is content most commonly added to Netflix?
 
SELECT DAYNAME(STR_TO_DATE(DATE_ADDED, '%d-%m-%Y')) as WEEK_DAY , COUNT(*) AS CONTENTS FROM NETFLIX
WHERE DATE_ADDED IS NOT NULL
GROUP BY WEEK_DAY
ORDER BY CONTENTS DESC
LIMIT 5;

+-----------+----------+
| WEEK_DAY  | CONTENTS |
+-----------+----------+
| Friday    |     5548 |
| Thursday  |     3626 |
| Wednesday |     3243 |
| Tuesday   |     3168 |
| Monday    |     2255 |
+-----------+----------+
5 rows in set (0.05 sec)

-- Q10: Which month and year combination had the most content added?
 
SELECT CONCAT(monthname(STR_TO_DATE(DATE_ADDED, '%d-%m-%Y')) , ' ' , year(str_to_date(date_added,'%d-%m-%Y'))) as MONTH_YEAR , COUNT(TYPE) AS CONTENTS FROM NETFLIX
WHERE DATE_ADDED IS NOT NULL
GROUP BY MONTH_YEAR
ORDER BY CONTENTS DESC
LIMIT 5;

+---------------+----------+
| MONTH_YEAR    | CONTENTS |
+---------------+----------+
| November 2019 |      692 |
| January 2020  |      583 |
| December 2019 |      558 |
| March 2018    |      506 |
| October 2018  |      487 |
+---------------+----------+
5 rows in set (0.07 sec)

-- Q11: How many titles were added each month across all years?
 
SELECT YEAR(STR_TO_DATE(DATE_ADDED, '%d-%m-%Y')) as YEAR , COUNT(*) AS TITLES FROM NETFLIX
WHERE DATE_ADDED IS NOT NULL
GROUP BY YEAR
ORDER BY TITLES DESC
lIMIT 5;

+------+--------+
| YEAR | TITLES |
+------+--------+
| 2019 |   5113 |
| 2020 |   4728 |
| 2018 |   4405 |
| 2017 |   3230 |
| 2021 |   3038 |
+------+--------+
5 rows in set (0.04 sec)

-- Q12: How many Movies vs TV Shows were added each year?
 
SELECT year(str_to_date(DATE_aDDED, '%d-%m-%Y')) as YEAR , TYPE, COUNT(*) AS TOTAL FROM NETFLIX
WHERE DATE_ADDED IS NOT NULL
GROUP BY YEAR, TYPE
ORDER BY TYPE, TOTAL DESC
LIMIT 5;

+------+-------+-------+
| YEAR | TYPE  | TOTAL |
+------+-------+-------+
| 2019 | Movie |  4989 |
| 2020 | Movie |  4529 |
| 2018 | Movie |  4329 |
| 2017 | Movie |  3126 |
| 2021 | Movie |  2902 |
+------+-------+-------+
5 rows in set (0.09 sec)

-- --------------------------------------
-- CONTENT-BASED INSIGHTS
-- --------------------------------------

-- Q13: What are the top 10 most common titles on Netflix?
 
SELECT DISTINCT TITLE , TYPE , COUNT(*) AS TOTAL FROM NETFLIX
GROUP BY TITLE , TYPE
ORDER BY TOTAL DESC
LIMIT 10;

+---------------------------------------+-------+-------+
| TITLE                                 | TYPE  | TOTAL |
+---------------------------------------+-------+-------+
| Esperando la carroza                  | Movie |     6 |
| Love in a Puff                        | Movie |     6 |
| ??? ?????                             | Movie |     6 |
| Veronica                              | Movie |     6 |
| Shutter Island                        | Movie |     5 |
| In Our Mothers' Gardens               | Movie |     5 |
| The Trial of the Chicago 7            | Movie |     5 |
| Monster                               | Movie |     5 |
| Cracked Up: The Darrell Hammond Story | Movie |     5 |
| Grown Ups                             | Movie |     5 |
+---------------------------------------+-------+-------+
10 rows in set (0.10 sec)

-- Q14: What are the most frequent genres in the dataset?

SELECT GENRE , COUNT(*) AS FREQUENT FROM NETFLIX
WHERE GENRE IS not NULL
GROUP BY GENRE 
ORDER BY FREQUENT DESC
LIMIT 5;

+-----------------------+----------+
| GENRE                 | FREQUENT |
+-----------------------+----------+
|                       |     9367 |
|  International Movies |     2394 |
| Dramas                |     1519 |
| Comedies              |     1128 |
| Action & Adventure    |      809 |
+-----------------------+----------+
5 rows in set (0.06 sec)
 
-- Q15: What are the longest-running contents?
 
SELECT TITLE, TYPE, DURATION  FROM NETFLIX
WHERE DURATION > 200 
Order by duration desc
LIMIT 5;

+------------------------+-------+----------+
| TITLE                  | TYPE  | DURATION |
+------------------------+-------+----------+
| The School of Mischief | Movie | 253 min  |
| The School of Mischief | Movie | 253 min  |
| The School of Mischief | Movie | 253 min  |
| No Longer kids         | Movie | 237 min  |
| No Longer kids         | Movie | 237 min  |
+------------------------+-------+----------+
5 rows in set (0.03 sec)
 
-- Q16: Are there any duplicate titles in the dataset?
 
SELECT DISTINCT TITLE , COUNT(*) FROM NETFLIX
GROUP BY TITLE
ORDER BY COUNT(*) DESC
LIMIT 5;

+---------------------------+----------+
| TITLE                     | COUNT(*) |
+---------------------------+----------+
| Esperando la carroza      |        6 |
| Love in a Puff            |        6 |
| ??? ?????                 |        6 |
| Veronica                  |        6 |
| Michael McIntyre: Showman |        5 |
+---------------------------+----------+
5 rows in set (0.09 sec)
 
-- Q17: Which genres are more associated with Movies vs TV Shows?
 
SELECT GENRE, COUNT(CASE WHEN TYPE = 'MOVIE' THEN 1 END) AS MOVIE_COUNTS , 
COUNT(CASE WHEN TYPE = 'TV SHOW' THEN 1 END) AS TV_SHOWS
FROM NETFLIX
WHERE GENRE IS NOT NULL
GROUP BY GENRE
ORDER BY MOVIE_COUNTS DESC , TV_SHOWS DESC
LIMIT 3;

 +-----------------------+--------------+----------+
| GENRE                 | MOVIE_COUNTS | TV_SHOWS |
+-----------------------+--------------+----------+
|                       |         9145 |      222 |
|  International Movies |         2394 |        0 |
| Dramas                |         1519 |        0 |
+-----------------------+--------------+----------+
3 rows in set (0.12 sec)

-- Q18: What are the most commonly used ratings?
 
SELECT RATING , COUNT(*) AS COUNT FROM NETFLIX 
GROUP BY RATING
ORDER BY COUNT DESC
LIMIT 5;

+--------+-------+
| RATING | COUNT |
+--------+-------+
| TV-MA  |  7521 |
| TV-14  |  4733 |
| R      |  3149 |
| PG-13  |  1908 |
| TV-PG  |  1890 |
+--------+-------+
5 rows in set (0.07 sec)
 
-- Q19: What is the average movie duration?
 
SELECT TYPE,
 COUNT(*) AS TOTAL_COUNT ,
 AVG(CAST(SUBSTRING_INDEX(DURATION, ' ', 1) AS UNSIGNED)) AS AVG_DURATION
 FROM NETFLIX
 GROUP BY TYPE
 ORDER BY AVG_DURATION;

+---------+-------------+--------------+
| TYPE    | TOTAL_COUNT | AVG_DURATION |
+---------+-------------+--------------+
| TV Show |         678 |       1.7330 |
| Movie   |       21253 |      99.0612 |
+---------+-------------+--------------+
2 rows in set, 15 warnings (0.09 sec)

-- Q20: How many short films (< 40 mins) or TV series with few episodes are there?
 
SELECT DISTINCT(TITLE) , DURATION FROM NETFLIX 
WHERE TYPE = 'MOVIE' AND CAST(SUBSTRING_INDEX(DURATION, ' ', 1) AS UNSIGNED)< 40 
ORDER BY CAST(SUBSTRING_INDEX(DURATION, ' ', 1) AS UNSIGNED) DESC
LIMIT 10;

+-----------------------------------+----------+
| TITLE                             | DURATION |
+-----------------------------------+----------+
| After Maria                       | 38 min   |
| Birders                           | 38 min   |
| Mariah Carey's Merriest Christmas | 38 min   |
| We, the Marines                   | 38 min   |
| LeapFrog: Letter Factory          | 37 min   |
| Out of Many, One                  | 35 min   |
| LeapFrog: Phonics Farm            | 35 min   |
| From One Second to the Next       | 35 min   |
| Making The Witcher                | 33 min   |
| LeapFrog: Numberland              | 33 min   |
+-----------------------------------+----------+
10 rows in set, 30 warnings (0.05 sec)
 
-- --------------------------------------
-- COUNTRY & GENRE-BASED ANALYSIS
-- --------------------------------------

-- Q21: Which countries produce the most Netflix content?
 
SELECT COUNTRY , COUNT(*) AS CONTENTS FROM NETFLIX
WHERE COUNTRY IS NOT NULL
GROUP BY COUNTRY
ORDER BY CONTENTS DESC
LIMIT 5;

+----------------+----------+
| COUNTRY        | CONTENTS |
+----------------+----------+
| United States  |     8665 |
| India          |     2917 |
| United Kingdom |      859 |
| Canada         |      487 |
| Spain          |      367 |
+----------------+----------+
5 rows in set (0.09 sec)
 
-- Q22: What type of content (Movie/TV Show) is more common in each country?
 
SELECT COUNTRY , COUNT(CASE WHEN TYPE = 'MOVIE' THEN 1 END) AS MOVIE , COUNT( CASE WHEN TYPE = 'TV SHOW' THEN 1 END ) AS TV_SHOW
FROM NETFLIX
WHERE COUNTRY IS NOT NULL
GROUP BY COUNTRY
ORDER BY MOVIE DESC, TV_SHOW DESC
LIMIT 5;

+----------------+-------+---------+
| COUNTRY        | MOVIE | TV_SHOW |
+----------------+-------+---------+
| United States  |  8463 |     202 |
| India          |  2881 |      36 |
| United Kingdom |   791 |      68 |
| Canada         |   475 |      12 |
| Spain          |   332 |      35 |
+----------------+-------+---------+
5 rows in set (0.08 sec)
 
-- Q23: Find countries with very few titles, potentially untapped markets.
 
SELECT COUNTRY , COUNT(TITLE) AS TOTAL_TITLES FROM NETFLIX 
WHERE COUNTRY IS NOT NULL
GROUP BY COUNTRY
ORDER BY TOTAL_TITLES ASC
LIMIT 5;

+-----------------------------------------------------------------------+--------------+
| COUNTRY                                                               | TOTAL_TITLES |
+-----------------------------------------------------------------------+--------------+
| China, United States, Australia                                       |            3 |
| United States, Ghana, Burkina Faso, United Kingdom, Germany, Ethiopia |            3 |
| Pakistan, United Arab Emirates                                        |            3 |
| United States, Philippines                                            |            3 |
| Argentina, France                                                     |            3 |
+-----------------------------------------------------------------------+--------------+
5 rows in set (0.07 sec)
 
-- Q24: Detect content saturation — genres that are overrepresented.
 
SELECT GENRE , COUNT(*) AS COUNT FROM NETFLIX
WHERE GENRE IS NOT NULL
GROUP BY GENRE
ORDER BY COUNT DESC
LIMIT 5;

+-----------------------+-------+
| GENRE                 | COUNT |
+-----------------------+-------+
|                       |  9367 |
|  International Movies |  2394 |
| Dramas                |  1519 |
| Comedies              |  1128 |
| Action & Adventure    |   809 |
+-----------------------+-------+
5 rows in set (0.07 sec)
