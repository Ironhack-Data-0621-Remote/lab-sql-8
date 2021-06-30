USE	 sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT title, length, RANK() OVER(ORDER BY length DESC) AS length_rank
FROM film
WHERE length IS NOT NULL AND length > 0
ORDER BY length_rank;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
SELECT title, rating, length, RANK() OVER(PARTITION BY rating ORDER BY length DESC) AS length_rank
FROM film
WHERE length IS NOT NULL AND length > 0
ORDER BY rating, length_rank;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT COUNT(fc.film_id) AS film_count, c.name
FROM film_category fc
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY c.name;

-- 4. Which actor has appeared in the most films?
SELECT * 
FROM (
	SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS film_count,
		RANK() OVER(ORDER BY COUNT(fa.film_id) DESC) AS actor_rank
	FROM film_actor fa
	JOIN actor a
	ON fa.actor_id = a.actor_id
	GROUP BY fa.actor_id
	ORDER BY film_count DESC)
    ranked_actors
WHERE actor_rank = 1;

-- alternative with 'WITH' statement
WITH ranked_actors AS (
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS film_count,
	RANK() OVER(ORDER BY COUNT(fa.film_id) DESC) AS actor_rank
FROM film_actor fa
JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id
ORDER BY film_count DESC
)
SELECT *
FROM ranked_actors
WHERE actor_rank =1;

-- 5. Most active customer (the customer that has rented the most number of films)
SELECT * 
FROM (
	SELECT c.first_name, c.last_name, COUNT(r.inventory_id) AS film_count,
		RANK() OVER(ORDER BY COUNT(r.inventory_id) DESC) AS customer_rank
	FROM rental r
	JOIN customer c
	ON r.customer_id = c.customer_id
	GROUP BY r.customer_id
	ORDER BY film_count DESC)
    ranked_customers
WHERE customer_rank =1;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
SELECT * 
FROM (
	SELECT f.title, COUNT(r.rental_id) AS rental_count,
		RANK() OVER(ORDER BY COUNT(r.rental_id) DESC) AS rental_rank
	FROM inventory i
	JOIN film f ON i.film_id = f.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
	GROUP BY i.film_id
	ORDER BY rental_count DESC
	)
ranked_rentals
WHERE rental_rank =1;

