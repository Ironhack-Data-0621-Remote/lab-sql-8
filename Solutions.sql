use sakila;
-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select title, length, rank() over(order by length desc) as length_rank
from film
where length is not null or length > 0 
order by length_rank;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
select title, rating, length, rank() over(partition by rating order by length desc) as length_rank
from film
where length is not null or length > 0
order by rating, length_rank;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
select count(fc.film_id) as film_count, c.name
from film_category fc
join category c
on fc.category_id = c.category_id
group by c.name
order by c.name;

-- 4. Which actor has appeared in the most films?
select *
from (
	select a.first_name, a.last_name, count(fa.film_id) as film_count,
		rank() over(order by count(fa.film_id) desc) as actor_rank
	from film_actor fa
    join actor a
    on fa.actor_id = a.actor_id
    group by fa.actor_id
    order by film_count desc)
    ranked_actors
where actor_rank =1;

-- 5. Most active customer (the customer that has rented the most number of films)
select *
from(
	select c.first_name, c.last_name, count(r.inventory_id) as film_count,
		rank() over(order by count (r.inventory_id) desc) as customer_rank
	from rental r
    join customer c
    on r.customer_id = c.customer_id
    group by r.customer_id
    order by film_count desc)
    ranked_customers
where customer_rank = 1;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.

