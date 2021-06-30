-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.
USE sakila; 
SELECT title, length, RANK() over(ORDER BY length) AS 'Rank'
FROM film 
WHERE length is not null AND length != 0; 

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
SELECT title, length, rating, RANK() over(ORDER BY length) AS 'Rank'
FROM film 
WHERE length is not null AND length != 0
GROUP by rating; 



-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query
-- the join is not necessary. table film_category give us film_od and category_id

SELECT COUNT(fc.film_id) AS films, c.name AS category_name, c.category_id AS category
FROM film_category fc
JOIN category c
ON fc.category_id = c.category_id
GROUP by c.category_id
ORDER BY COUNT(fc.film_id) ASC; 


-- 4. Which actor has appeared in the most films?
SELECT fa.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS films
FROM film_actor fa 
JOIN actor a
ON fa.actor_id = a.actor_id 
group by actor_id
ORDER BY COUNT(film_id) DESC;
-- actor_id: 107, Gina Degeneres



-- 5. Most active customer (the customer that has rented the most number of films)
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rentals
FROM customer c 
JOIN rental r
ON c.customer_id = r.customer_id 
group by customer_id
ORDER BY COUNT(rental_id) DESC;
-- most active costumer is ELENOT HUNT with 46 rentals 


