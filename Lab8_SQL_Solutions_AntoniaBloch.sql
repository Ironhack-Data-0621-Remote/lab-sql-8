-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
use sakila;
select length, title, rank() over(order by length desc) as 'rank'
from film
where length <> 0;
 
-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
select title, rating, length, rank() over(partition by rating order by length desc) as 'rank'
from film
where length is not null or length > 0;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
select count(c.film_id) as count, f.name
from category f 
join film_category c
on c.category_id = f.category_id
group by f.name;

-- 4. Which actor has appeared in the most films?
select actor_id, film_id, rank() over(order by count(film_id) desc) as 'rank'
from film_actor
group by actor_id;
-- other result than when joining with actor table:

-- with names:
select a.first_name, a.last_name, count(film_id),rank() over(order by count(film_id) desc) as 'rank'
from actor a 
join film_actor b
on a.actor_id=b.actor_id
group by a.actor_id;

-- Actor 107 has appeared in most movies.

-- 5. Most active customer (the customer that has rented the most number of films)
select a.first_name, a.last_name, count(b.inventory_id) as rented_films,
		rank() over(order by count(b.inventory_id) desc) as 'rank'
	from customer a 
	join rental b
	on a.customer_id = b.customer_id
	group by a.customer_id;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- I dont know.. :(((
