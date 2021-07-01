-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
use sakila;
select title, length, rank() over (order by length) from film
where length is not null;


-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.

select title, length, rating, rank() over (partition by rating order by length) from film
where length is not null;
-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

select c.name, count(f.film_id)
from category c
join film_category f on c.category_id = f.category_id 
group by c.name;

-- 4. Which actor has appeared in the most films?
select a.first_name, a.last_name, a.actor_id, count(f.film_id)
from actor a
join film_actor f on a.actor_id = f.actor_id
order by count(f.film_id) desc;
-- penelope guiness --> count 5462--> seems kinda wrong?


-- 5. Most active customer (the customer that has rented the most number of films)
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) 
from rental r
join customer c on r.customer_id = c.customer_id
group by customer_id
order by count(rental_id) desc
limit 1;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
