-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT 	title
		, length
        , RANK() OVER(ORDER BY length DESC)
        , DENSE_RANK() OVER(ORDER BY length)
FROM film
WHERE length IS NOT NULL;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
SELECT 	title
		, length
        , rating
        , RANK() OVER(PARTITION BY c.category_id ORDER BY f.length)
FROM film f
JOIN film_category c ON f.film_id = c.film_id
WHERE f.length IS NOT NULL;    

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT rating, COUNT(c.film_id)
FROM film f
JOIN film_category c ON f.film_id = c.film_id
GROUP BY rating
ORDER BY 2 DESC;

-- 4. Which actor has appeared in the most films?
SELECT ac.first_name, ac.last_name, COUNT(fi.film_id)
FROM actor ac
JOIN film_actor fa ON ac.actor_id = fa.actor_id
JOIN film fi ON fa.film_id = fi.film_id
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 3;

-- 5. Most active customer (the customer that has rented the most number of films)
SELECT c.customer_id, SUM(c.customer_id)
FROM customer c
JOIN rental r ON c.customer_id = c.customer_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
SELECT fil.title, MAX(pay.rental_id), RANK() OVER(ORDER BY MAX(pay.rental_id)DESC)
FROM film fil
JOIN inventory inv ON fil.film_id = inv.film_id
JOIN rental ren ON inv.inventory_id = ren.inventory_id
JOIN payment pay ON ren.rental_id = pay.rental_id
-- WHERE fil.title REGEXP 'Bucket Brotherhood'
GROUP BY fil.title
ORDER BY 2 DESC
LIMIT 23;
