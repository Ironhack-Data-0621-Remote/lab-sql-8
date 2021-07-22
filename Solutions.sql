-- lab-sql-8
USE sakila;
-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.

SELECT title, RANK() OVER (ORDER BY length DESC) as 'Rank'
FROM film;

-- 2. Rank films by length within the rating category
-- (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.

SELECT title, rating, length, RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS 'rank'
FROM film
WHERE length IS NOT NULL AND length > '0';

-- 3. How many films are there for each of the categories in the category table.
-- Use appropriate join to write this query

SELECT category.name, COUNT(fc.category_id) AS Movies per Category
FROM film_category AS fc
JOIN category ON fc.category_id = category.category_id
GROUP BY fc.category_id
HAVING Movies per Category
ORDER BY Movies per Category DESC;

-- 4. Which actor has appeared in the most films?

SELECT COUNT(film_actor.actor_id), actor.first_name, actor.last_name 
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY film_actor.actor_id
ORDER BY COUNT(film_actor.actor_id) desc
LIMIT 1;

-- 5. Most active customer (the customer that has rented the most number of films)

SELECT cust.customer_id, count(*) as Total_Rentals
FROM rental as r
INNER JOIN customer AS cust on r.customer_id = cust.customer_id
GROUP BY cust.customer_id
ORDER BY COUNT(Total_Rentals) desc
LIMIT 1;

