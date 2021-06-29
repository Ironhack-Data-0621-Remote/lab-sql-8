Use sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT title, film.length, rank() over(order by film.length desc) as `Rank`
FROM film
WHERE film.length != 0 AND film.length is not null;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
SELECT rating, title, film.length,  dense_rank() over(partition by rating order by film.length desc) as `Rank`
FROM film
WHERE film.length != 0 AND film.length is not null;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT c.category_id, c.name, COUNT(fc.film_id) as num_films
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
GROUP BY c.name;

-- 4. Which actor has appeared in the most films?
SELECT a.actor_id, a.first_name, a.last_name,COUNT(f.film_id), rank() over (order by COUNT(f.film_id) desc) as `Rank`
FROM actor a
JOIN film_actor f
ON a.actor_id = f.actor_id
GROUP BY a.actor_id;

-- 5. Most active customer (the customer that has rented the most number of films)
SELECT c.customer_id, c.first_name, c.last_name,COUNT(r.rental_id) as num_films, rank() over (order by COUNT(r.rental_id) desc) as `Rank`
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
SELECT f.film_id, f.title,COUNT(r.rental_id) as num_films, rank() over (order by COUNT(r.rental_id) desc) as `Rank`
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id;
