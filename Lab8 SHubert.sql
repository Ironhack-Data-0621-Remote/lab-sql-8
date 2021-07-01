-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.

-- select title, length, rank() over (order by film.length desc) as 'rank'
-- from film
-- where film.length > 0 and film.length IS NOT NULL ;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.

-- select title, film.length, rating, rank() over (order by film.length desc) as 'rank'
-- from film
-- where film.length > 0 and film.length IS NOT NULL 
-- order by rating;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
-- select a.category_id, count(a.film_id) as n_film, rank() over (order by count(a.film_id) desc) as 'rank', b.name
-- from film_category a
-- join category b
-- on a.category_id = b.category_id
-- group by name;

-- 4. Which actor has appeared in the most films?
-- select count(a.film_id) as n_film, rank() over (order by count(a.film_id) desc) as 'rank', a.actor_id , b.first_name, b.last_name
-- from film_actor a
-- join actor b
-- on a.actor_id = b.actor_id
-- group by actor_id
-- order by n_film desc
-- limit 1;

-- 5. Most active customer (the customer that has rented the most number of films)
-- select count(a.rental_id) as n_rental, a.customer_id, b.first_name, b.last_name
-- from rental a
-- join customer b
-- on a.customer_id = b.customer_id
-- group by customer_id
-- order by n_rental desc
-- limit 1 ;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.

