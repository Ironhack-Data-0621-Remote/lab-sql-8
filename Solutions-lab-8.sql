USE sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.

-- rank:
SELECT title, length, RANK() OVER(ORDER BY length DESC) as rank_length
FROM film
WHERE length <> ' ' OR 0;

-- dense rank:
SELECT title, length, DENSE_RANK() OVER(ORDER BY length DESC) as dense_rank_length
FROM film
WHERE length <> ' ' OR 0;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.

-- rank:
SELECT title, length, rating, RANK() OVER(PARTITION BY rating ORDER BY length DESC) as rank_length
FROM film
WHERE length <> ' ' OR 0;

-- dense rank:
SELECT title, length, rating, DENSE_RANK() OVER(PARTITION BY rating ORDER BY length DESC) as dense_rank_length
FROM film
WHERE length <> ' ' OR 0;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT fc.category_id, c.name, COUNT(fc.film_id) AS nbr_films
FROM film_category fc
INNER JOIN category c
ON fc.category_id = c.category_id
GROUP BY fc.category_id;

-- 4. Which actor has appeared in the most films?

SELECT fa.actor_id, a.first_name, a.last_name, COUNT(fa.actor_id) AS nbr_films
FROM film_actor fa
INNER JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY actor_id
ORDER BY nbr_films DESC
LIMIT 1;

-- 5. Most active customer (the customer that has rented the most number of films)

SELECT r.customer_id, c.first_name, c.last_name, COUNT(r.customer_id) AS nbr_rentals
FROM rental r
INNER JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY r.customer_id
ORDER BY nbr_rentals DESC
LIMIT 1;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. 
-- This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.

SELECT i.film_id, f.title, COUNT(r.inventory_id) AS rented_x_times
FROM rental r
INNER JOIN film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rented_x_times DESC;