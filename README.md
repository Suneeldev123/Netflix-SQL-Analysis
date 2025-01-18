# Netflix-SQL-Analysis
A SQL-based analysis of Netflix's content library, includes queries to explore content trends, popular genres, country-wise contributions, and historical release patterns.

# Netflix Content Analysis Using SQL

## Introduction
This project analyzes the Netflix dataset using SQL to uncover insights into the platform's content library. By querying the dataset, we aim to answer 15 business-critical questions, such as content trends, genre distribution, regional contributions, and more. The analysis will help us understand how Netflix's catalog has evolved and identify patterns that can drive data-driven decisions.

### Key Objectives
1. Analyze the distribution of Movies and TV Shows.
2. Identify popular genres and regional strengths.
3. Uncover trends in content additions over the years.
4. Highlight key contributors like directors and actors.
5. Assess content ratings and duration patterns.

---

## Dataset Information

The dataset includes information about Netflix titles and their metadata. Below are the column details:

| Column Name    | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| `show_id`      | Unique identifier for each title.                                           |
| `type`         | Indicates if the title is a "Movie" or "TV Show".                           |
| `title`        | Title of the content.                                                      |
| `director`     | Director of the content (if available).                                     |
| `cast`         | Main cast members of the content.                                           |
| `country`      | Country where the content was produced.                                     |
| `date_added`   | Date Netflix added the title to its catalog.                                |
| `release_year` | Year the content was originally released.                                   |
| `rating`       | Content rating (e.g., PG, R, TV-MA).                                        |
| `duration`     | Duration of the content (e.g., `90 min` for movies or `1 Season` for shows).|
| `listed_in`    | Genres associated with the title (e.g., Drama, Comedy).                    |
| `description`  | Short description or synopsis of the content.                              |

---

## SQL Queries

### Question 1: What is the total number of Movies and TV Shows available on Netflix?
**Objective**: Understand the split between Movies and TV Shows on the platform.

```sql
-- Question 1: What is the total number of Movies and TV Shows available on Netflix?
SELECT type, COUNT(*) AS count
FROM NETFLIX
GROUP BY type;
```

### Question 2: Which genres are most common on Netflix?
**Objective**: Identify popular genres to target content strategies.

```sql
-- Question 2: Which genres are most common on Netflix?
SELECT listed_in, COUNT(*) AS count
FROM NETFLIX
GROUP BY listed_in
ORDER BY count DESC
LIMIT 10;
```

### Question 3: How many Movies and TV Shows were released each year?
**Objective**: Analyze historical release trends for Movies and TV Shows.

```sql
-- Question 3: How many Movies and TV Shows were released each year?
SELECT release_year, type, COUNT(*) AS count
FROM NETFLIX
GROUP BY release_year, type
ORDER BY release_year DESC;
```

### Question 4: Which countries produce the most content on Netflix?
**Objective**: Highlight key countries contributing content.

```sql
-- Question 4: Which countries produce the most content on Netflix?
SELECT country, COUNT(*) AS count
FROM NETFLIX
WHERE country IS NOT NULL
GROUP BY country
ORDER BY count DESC
LIMIT 10;
```

### Question 5: What are the top-rated content types based on their ratings?
**Objective**: Understand which ratings dominate Netflix's library (e.g., PG, R).

```sql
-- Question 5: What are the top-rated content types based on their ratings?
SELECT rating, COUNT(*) AS count
FROM NETFLIX
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY count DESC;
```

### Question 6: What is the average duration of Movies on Netflix?
**Objective**: Assess content length trends for better curation.

```sql
-- Question 6: What is the average duration of Movies on Netflix?
SELECT AVG(CAST(SUBSTRING_INDEX(COALESCE(duration, '0 min'), ' ', 1) AS UNSIGNED)) AS avg_duration
FROM NETFLIX
WHERE type = 'Movie';
```

### Question 7: Which directors have the most titles on Netflix?
**Objective**: Identify influential directors contributing to Netflix's catalog.

```sql
-- Question 7: Which directors have the most titles on Netflix?
SELECT director, COUNT(*) AS count
FROM NETFLIX
WHERE director IS NOT NULL
GROUP BY director
ORDER BY count DESC
LIMIT 5;
```

### Question 8: Which actors appear most frequently in Netflix titles?
**Objective**: Determine frequently cast actors for fan targeting.

```sql
-- Question 8: Which actors appear most frequently in Netflix titles?
SELECT cast, COUNT(*) AS count
FROM NETFLIX
WHERE cast IS NOT NULL
GROUP BY cast
ORDER BY count DESC
LIMIT 5;
```

### Question 9: What percentage of titles were added after 2020?
**Objective**: Measure the impact of recent content additions.

```sql
-- Question 9: What percentage of titles were added after 2020?
SELECT ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM NETFLIX)), 2) AS percentage
FROM NETFLIX
WHERE YEAR(date_added) > 2020;
```

### Question 10: Which genres dominate TV Shows versus Movies?
**Objective**: Compare genre popularity across Movies and TV Shows.

```sql
-- Question 10: Which genres dominate TV Shows versus Movies?
SELECT type, listed_in, COUNT(*) AS count
FROM NETFLIX
GROUP BY type, listed_in
ORDER BY count DESC
LIMIT 10;
```

### Question 11: How many titles were released each year after 2010?
**Objective**: Analyze the yearly release trends for Netflix content since 2010.

```sql
-- Question 11: How many titles were released each year after 2010?
SELECT release_year, COUNT(*) AS count
FROM NETFLIX
WHERE release_year > 2010
GROUP BY release_year
ORDER BY release_year;
```

### Question 12: Which countries contribute the most titles across all genres?
**Objective**: Identify which countries have the highest contribution to the Netflix catalog across all genres.

```sql
-- Question 12: Which countries contribute the most titles across all genres?
SELECT country, COUNT(*) AS count
FROM NETFLIX
WHERE country IS NOT NULL
GROUP BY country
ORDER BY count DESC
LIMIT 10;
```

### Question 13: What are the top genres in countries producing the most content?
**Objective**: Correlate country and genre dominance for focused marketing.

```sql
-- Question 13: What are the top genres in countries producing the most content?
SELECT country, listed_in, COUNT(*) AS count
FROM NETFLIX
WHERE country IS NOT NULL
GROUP BY country, listed_in
ORDER BY count DESC
LIMIT 10;
```

### Question 14: Which genres dominate content added after 2015?
**Objective**: Explore trends in genres for recent additions.

```sql
-- Question 14: Which genres dominate content added after 2015?
SELECT listed_in, COUNT(*) AS count
FROM NETFLIX
WHERE YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) > 2015
GROUP BY listed_in
ORDER BY count DESC
LIMIT 10;
```

### Question 15: How many TV Shows and Movies are produced by year for the top country?
**Objective**: Analyze yearly production trends for the top content-producing country.

```sql
-- Question 15: How many TV Shows and Movies are produced by year for the top country?
SELECT release_year, type, COUNT(*) AS count
FROM NETFLIX
WHERE country = (SELECT country FROM NETFLIX GROUP BY country ORDER BY COUNT(*) DESC LIMIT 1)
GROUP BY release_year, type
ORDER BY release_year;
```

---

## Insights and Visualizations

### Key Insights:
1. **Content Split**: Movies dominate the Netflix catalog, with a higher count than TV Shows.
2. **Popular Genres**: Drama, Comedy, and Action top the list of popular genres globally.
3. **Release Trends**: The number of titles added to Netflix increased significantly in recent years.
4. **Country Contributions**: The United States leads in content production, followed by India and the UK.
5. **Average Movie Duration**: The average duration of movies is approximately 90 minutes, meeting industry standards.

---

## Conclusion
This project provides actionable insights into Netflix's content library using SQL. Key takeaways include:
- The platform offers a diverse catalog, with Movies dominating the library.
- Drama and Comedy are universally popular genres, with Action gaining traction globally.
- The United States is the largest contributor of content, but regional contributions, particularly from India and the UK, are growing.
- The growth in Netflix's library is evident, with a significant number of titles added in recent years.

Further analysis could focus on:
1. User engagement metrics per genre and type.
2. Regional preferences for content ratings.
3. Content availability trends by language.
