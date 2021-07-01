USE sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.

select length, title, 
dense_rank() over (order by length)rank_film
FROM film
HAVING length != 0 AND length != "";

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.

select length, title, rating,
dense_rank() over (PARTITION BY rating order by length)rank_film
FROM film
HAVING length != 0 AND length != "";

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
-- with GROUP BY : straight the point
SELECT category_id, COUNT(category_id)
FROM film_category
JOIN film
ON film.film_id = film_category.film_id
GROUP BY category_id;

-- WITH PARTITION : more data preserved
SELECT category_id, title, film.film_id,
COUNT(*) OVER (PARTITION BY category_id)categ_nb
FROM film_category
JOIN film
ON film.film_id = film_category.film_id;

-- 4. Which actor has appeared in the most films?
-- the answer
SELECT actor.actor_id, last_name, first_name,
COUNT(*) OVER (PARTITION BY actor_id)bankable
FROM film_actor
JOIN actor
ON actor.actor_id = film_actor.actor_id
ORDER BY bankable DESC
LIMIT 1;

-- to keep track for future reference
SELECT actor.actor_id, last_name, first_name, title,
COUNT(*) OVER (PARTITION BY actor_id)bankable
FROM film_actor
JOIN film
ON film.film_id = film_actor.film_id
JOIN actor
ON actor.actor_id = film_actor.actor_id
ORDER BY bankable DESC;

-- 5. Most active customer (the customer that has rented the most number of films)
SELECT rental.customer_id, last_name, first_name,
COUNT(*) OVER (PARTITION BY customer.customer_id)top_customer
FROM customer
JOIN rental
ON customer.customer_id = rental.customer_id
ORDER BY top_customer DESC
LIMIT 1;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.

SELECT rental.inventory_id, title
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
WHERE title = 'Bucket Brotherhood';

SELECT rental.inventory_id, title,
COUNT(*) OVER (PARTITION BY title)top_movie
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
ORDER BY top_movie DESC;

