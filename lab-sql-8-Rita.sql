use sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.

SELECT title, length, rank() over (order by length desc) as rank_l
FROM film
WHERE length IS NOT NULL OR length <>0;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.

SELECT title, rating, length, rank() over (partition by rating order by length desc) as rank_l
FROM film
WHERE length IS NOT NULL OR length <>0;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT c.name, count(f.film_id) as count_film
FROM category c
INNER JOIN film_category f
ON c.category_id = f.category_id
GROUP BY name
ORDER BY count_film DESC;

-- 4. Which actor has appeared in the most films?

SELECT first_name, last_name
FROM (SELECT a.first_name, a.last_name, rank() over(order by count(f.actor_id) DESC) as rank_a
FROM actor a
INNER JOIN film_actor f
ON a.actor_id = f.actor_id 
GROUP by first_name, last_name) as t
WHERE rank_a = 1;

-- ANSWER: SUSAN DAVIS
-- I think there's an easier way to do it, but I couldn't find one. QUESTION when we use a subquery do we always need to give an alias to the table?

-- 5. Most active customer (the customer that has rented the most number of films)

SELECT first_name, last_name
FROM (SELECT c.first_name, c.last_name, rank() over(order by count(r.rental_id) DESC) as rank_a
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id 
GROUP by first_name, last_name) as t
WHERE rank_a = 1;

-- ANSWER: ELEANOR HUNT

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.

SELECT title
FROM (SELECT f.title, rank() over (order by count(r.rental_id) DESC) as rank_a
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP by title) as t
WHERE rank_a = 1

-- ANSWER: BUCKET BROTHERWOOD