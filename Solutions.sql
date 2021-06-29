USE sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT title, film.length,
RANK() over(order by film.length desc) as "RANK"
FROM film
where film.length is not null;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
SELECT title, film.length, rating,
RANK() over(partition by rating ORDER BY film.length desc) "RANK"
FROM film
where film.length is not null;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
-- determine and review needed tables
-- film_category (film_id, category_id, date)
SELECT fc.category_id, count(f.film_id)
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
GROUP BY fc.category_id
ORDER BY count(f.film_id) desc;

-- 4. Which actor has appeared in the most films?
SELECT concat(a.first_name," ",a.last_name) as fullname, count(ac.film_id) as films,
RANK() over(order by count(ac.film_id) desc) as "RANK"
FROM actor a 
JOIN film_actor ac 
ON a.actor_id = ac.actor_id
GROUP BY a.actor_id;

-- 5. Most active customer (the customer that has rented the most number of films)
SELECT concat(c.first_name," ",c.last_name) as fullname, count(r.customer_id) as rentals,
RANK() over(order by count(r.customer_id) desc) as "RANK"
FROM customer c 
JOIN rental r 
ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- film_id, title
SELECT *
FROM film;

-- inventory_id
SELECT *
FROM rental;

-- inventory_id, film_id
SELECT *
FROM inventory;

SELECT f.title, count(i.film_id) as rentals,
RANK() over(order by count(i.film_id) desc) as "RANK"
FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title;