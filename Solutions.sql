-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.
USE sakila;
SELECT * FROM film;

SELECT title, length, rank() over (order by length desc) as length_rank
FROM film
WHERE length != " " AND length != 0
ORDER BY length_rank ASC;


-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
SELECT * FROM film;
SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length) AS length_ranking
FROM film
WHERE length != " " AND length != 0
ORDER BY rating ASC;



-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT * FROM category;
SELECT * FROM film_category;


-- SELECT f.category_id, c.name, count(f.category_id)
-- SELECT *
SELECT f.category_id, c.name, count(f.category_id) AS num_of_films
FROM film_category f
JOIN category c
ON f.category_id = c.category_id
GROUP BY f.category_id
ORDER BY category_id;



-- 4. Which actor has appeared in the most films?
SELECT * FROM actor; -- actor_id
SELECT * FROM film_actor;

SELECT actor_id, count(actor_id), RANK() OVER (ORDER BY count(actor_id) DESC) AS ranking -- , rank() over (order by count(actor_id) as ranking -- actor_id, sum(actor_id) -- RANK() OVER (PARTITION BY sum(actor_id)) as raking
FROM film_actor
GROUP BY actor_id
ORDER BY ranking;


-- 5. Most active customer (the customer that has rented the most number of films)
SELECT customer_id, count(customer_id), RANK() OVER (ORDER BY count(customer_id) DESC) AS ranking
FROM rental
GROUP BY customer_id
ORDER BY ranking;


-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- film_name, count(inventory

SELECT * FROM RENTAL; -- inventory_id
SELECT * FROM film; -- film_id
SELECT * FROM inventory; -- inventory_id , film_id

SELECT f.title, count(f.title), RANK() OVER (ORDER BY count(f.title)DESC) AS most_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY f.title;

