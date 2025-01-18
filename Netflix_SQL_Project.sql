-- CREATE THE TABLE / SCHEMA
-- CREATE TABLE NETFLIX
(
    show_id      VARCHAR(5) PRIMARY KEY,
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);



-- SQL Queries
-- Question 1: What is the total number of Movies and TV Shows available on Netflix?
SELECT type, COUNT(*) AS count
FROM Netflix
GROUP BY type;

-- Question 2: Which genres are most common on Netflix?
SELECT listed_in, COUNT(*) AS count
FROM NETFLIX
GROUP BY listed_in
ORDER BY count DESC
LIMIT 10;

-- Question 3: How many Movies and TV Shows were released each year?
SELECT release_year, type, COUNT(*) AS count
FROM NETFLIX
GROUP BY release_year, type
ORDER BY release_year DESC;

-- Question 4: Which countries produce the most content on Netflix?
SELECT country, COUNT(*) AS count
FROM NETFLIX
WHERE country IS NOT NULL
GROUP BY country
ORDER BY count DESC
LIMIT 10;

-- Question 5: What are the top-rated content types based on their ratings?
SELECT rating, COUNT(*) AS count
FROM NETFLIX
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY count DESC;

-- Question 6: What is the average duration of Movies on Netflix?
SELECT AVG(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)) AS avg_duration
FROM NETFLIX
WHERE type = 'Movie';

-- Question 7: Which directors have the most titles on Netflix?
SELECT director, COUNT(*) AS count
FROM NETFLIX
WHERE director IS NOT NULL
GROUP BY director
ORDER BY count DESC
LIMIT 5;

-- Question 8: Which actors appear most frequently in Netflix titles?
SELECT cast, COUNT(*) AS count
FROM NETFLIX
WHERE cast IS NOT NULL
GROUP BY cast
ORDER BY count DESC
LIMIT 5;

-- Question 9: What percentage of titles were added after 2020?
SELECT ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM NETFLIX)), 2) AS percentage
FROM NETFLIX
WHERE YEAR(date_added) > 2020;

-- Question 10: Which genres dominate TV Shows versus Movies?
SELECT type, listed_in, COUNT(*) AS count
FROM NETFLIX
GROUP BY type, listed_in
ORDER BY count DESC
LIMIT 10;

-- Question 11: How many titles were released each year after 2010?
SELECT release_year, COUNT(*) AS count
FROM NETFLIX
WHERE release_year > 2010
GROUP BY release_year
ORDER BY release_year;

-- Question 12: Which countries contribute the most titles across all genres?
SELECT country, COUNT(*) AS count
FROM NETFLIX
WHERE country IS NOT NULL
GROUP BY country
ORDER BY count DESC
LIMIT 10;

-- Question 13: What are the top genres in countries producing the most content?
SELECT country, listed_in, COUNT(*) AS count
FROM NETFLIX
WHERE country IS NOT NULL
GROUP BY country, listed_in
ORDER BY count DESC
LIMIT 40;

-- Question 14: Which genres dominate content added after 2015?
SELECT listed_in, COUNT(*) AS count
FROM NETFLIX
WHERE YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) > 2015
GROUP BY listed_in
ORDER BY count DESC
LIMIT 10;

-- Question 15: How many TV Shows and Movies are produced by year for the top country?
SELECT release_year, type, COUNT(*) AS count
FROM NETFLIX
WHERE country = (SELECT country FROM NETFLIX GROUP BY country ORDER BY COUNT(*) DESC LIMIT 1)
GROUP BY release_year, type
ORDER BY release_year;