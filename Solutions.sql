USE sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.

SELECT title, length,
DENSE_RANK() OVER(ORDER BY length)
FROM film;


-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.

SELECT title, length, rating,
DENSE_RANK() OVER(PARTITION BY rating ORDER BY length)
FROM film
WHERE length <> 0 OR length != ''
ORDER BY rating;


-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT film_category.category_id, category.name, COUNT(film_category.film_id) AS film_count
FROM film_category
JOIN category 
ON film_category.category_id = category.category_id
GROUP BY film_category.category_id;


-- 4. Which actor has appeared in the most films?

SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS film_count,
DENSE_RANK() OVER (ORDER BY COUNT(film_actor.film_id) DESC)
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY film_count DESC;

-- Gina Degeneres has appeared in 42 films

-- 5. Most active customer (the customer that has rented the most number of films)

SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS rental_count,
DENSE_RANK() OVER(ORDER BY COUNT(rental.rental_id) DESC)
FROM customer
JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

-- Eleanor Hunt has rented 46 films

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.

SELECT film.title, film.film_id, COUNT(inventory.inventory_id) AS rental_number
FROM film
JOIN inventory 
ON film.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title, film.film_id
ORDER BY rental_number DESC;

-- I think this is correct, but not sure? Accroding to my query bucket brotherhood has been rented 34 times, which is the most.

