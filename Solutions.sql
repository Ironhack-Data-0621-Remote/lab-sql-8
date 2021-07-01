USE sakila;
-- 1.Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.
SELECT title, length,
RANK() OVER(ORDER BY length) AS 'RANK'
FROM film
WHERE length != ' ' 
AND length != '0';
SELECT title, length,
DENSE_RANK() OVER(ORDER BY length) AS 'DENSE RANK'
FROM film
WHERE length != ' ' 
AND length != '0';
-- 2.Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column).
-- In your output, only select the columns title, length, rating and the rank.
SELECT title, length, rating,
RANK() OVER(PARTITION BY rating ORDER BY length) AS 'RANK'
FROM film
WHERE length != ' ' 
AND length != '0'; 
-- 3.How many films are there for each of the categories in the category table. Use appropriate join to write this query
SELECT c.category_id, COUNT(f.film_id)
FROM film_category f INNER JOIN category c
ON f.category_id = c.category_id
GROUP BY c.category_id; 
-- 4.Which actor has appeared in the most films?
SELECT a.actor_id, a.first_name, a.last_name, COUNT(f.film_id)
FROM film_actor f INNER JOIN actor a
ON f.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY COUNT(f.film_id) DESC
LIMIT 1;
-- 5.Most active customer (the customer that has rented the most number of films)
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id)
FROM rental r INNER JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY COUNT(r.rental_id) DESC
LIMIT 1;
-- Bonus: Which is the most rented film? The answer is Bucket Brotherhood
SELECT inventory_id, film_id FROM inventory
GROUP BY inventory_id;
SELECT film_id, title FROM film;
SELECT inventory_id FROM rental;
SELECT f.title, f.film_id, COUNT(f.film_id)
FROM inventory i
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
LEFT JOIN film f
ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY COUNT(f.film_id) DESC
LIMIT 1; 
-- This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- i am going crazy hahah. whatever i try, i only get ACADEMY DINOSAUR as result, either with 20 counts, 40 counts or 
-- now 41 counts. I know the fault lies in how i am joining them as there are more copies of each movie..
-- but how do i do this?