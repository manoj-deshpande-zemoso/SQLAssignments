-- 1. Find out the PG-13 rated comedy movies. DO NOT use the film_list table.
select 
	f.*
from 
	film f, film_category fc, category c
where
	f.rating = 'PG-13'
    and c.name = 'Comedy'
    and f.film_id = fc.film_id
    and fc.category_id = c.category_id;

-- 2. Find out the top 3 rented horror movies.
select A.title from (
	select f.title title, i.film_id film_id, count(i.film_id) rentals
	from 
		inventory i, rental r, film f
	where
		f.film_id = i.film_id
		and i.inventory_id = r.inventory_id
	group by i.film_id
order by rentals desc limit 3) A;

-- 3. Find out the list of customers from India who have rented sports movies.
select 
	customer.*
from 
	customer, address, city, country, rental, inventory, film, film_category, category
where
	customer.address_id = address.address_id
    and address.city_id = city.city_id
    and city.country_id = country.country_id
    and country.country = 'India'
    and customer.customer_id = rental.customer_id
	and rental.inventory_id = inventory.inventory_id
    and inventory.film_id = film.film_id
    and film.film_id = film_category.film_id
    and film_category.category_id = category.category_id
    and category.name = 'Sports';

-- 4. Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies.
select 
	customer.*
from 
	customer, address, city, country, rental, inventory, film, film_actor, actor
where
	customer.address_id = address.address_id
    and address.city_id = city.city_id
    and city.country_id = country.country_id
    and country.country = 'Canada'
    and customer.customer_id = rental.customer_id
	and rental.inventory_id = inventory.inventory_id
    and inventory.film_id = film.film_id
    and film.film_id = film_actor.film_id
    and film_actor.actor_id = actor.actor_id
    and actor.first_name = 'NICK'
    and actor.last_name = 'WAHLBERG';
    
-- 5. Find out the number of movies in which “SEAN WILLIAMS” acted.
select 
	count(film_actor.film_id)
from 
	actor, film_actor
where 
	actor.actor_id = film_actor.actor_id
    and actor.first_name = 'SEAN'
    and actor.last_name = 'WILLIAMS'
group by
film_actor.actor_id;
