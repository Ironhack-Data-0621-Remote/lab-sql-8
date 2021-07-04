USE sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.

select title, length, rank() over(order by length asc) as 'rank' 
from film
where length is not null and length > 0 
order by length;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.

select title, length, rating, rank() over(order by length asc) as 'rank' 
from film;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

select name as category_name, count(*) as num_films
from sakila.category inner join sakila.film_category using (category_id)
group by name
order by num_films desc;

-- 4. Which actor has appeared in the most films?
select first_name, last_name from actor
where actor_id = (
select fa.actor_id 
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by actor_id
order by count(fa.film_id) desc
limit 1);

-- 5. Most active customer (the customer that has rented the most number of films)

select first_name, last_name from customer
where customer_id = (
select  c.customer_id
from rental r
join customer c on r.customer_id = c.customer_id
group by c.customer_id
order by count(r.rental_id) desc
limit 1);

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.

select title from film
where film_id = (
select f.film_id
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by f.film_id
order by count(r.rental_id) desc
limit 1);