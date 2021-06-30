use sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select title, new_length, rank() over(order by new_length asc) as 'rank' from film
order by new_length;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
select title, new_length, rating, rank() over(partition by rating order by new_length asc) as 'rank' from film
order by rating;

select * from category;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
ALTER TABLE category 
RENAME COLUMN name TO new_name;

select c.new_name, count(f.film_id) as n_film, dense_rank() over(order by count(f.film_id) desc) as 'Number_of_film' 
from film_category f
inner join category c 
on f.category_id = c.category_id
group by new_name
order by n_film desc;

-- 4. Which actor has appeared in the most films?
select a.first_name, a.last_name, count(f.actor_id) as n_film, rank() over(order by count(f.actor_id) desc) as 'Rank' 
from film_actor f
inner join actor a
on f.actor_id = a.actor_id
group by last_name, first_name
order by n_film desc;

-- or (without names) :
select actor_id, count(film_id) as 'Number_of_film' ,
rank() over(order by count(film_id) desc) as 'rank'
from film_actor
group by actor_id;

-- 5. Most active customer (the customer that has rented the most number of films)
select c.first_name, c.last_name, count(r.customer_id) as n_cust, rank() over(order by count(r.customer_id) desc) as 'Rank' 
from customer c
inner join rental r
on c.customer_id = r.customer_id
group by last_name, first_name
order by n_cust desc;

-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
