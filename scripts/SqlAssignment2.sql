-- 1. Find out the number of documentaries with deleted scenes.
select
	count(film.film_id)
from
	film, film_category, category
where
	film.film_id = film_category.film_id
    and film_category.category_id = category.category_id
    and category.name = 'Documentary'
    and film.special_features like '%Deleted Scenes%';

-- 2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens.
select 
	count(distinct film_category.film_id)
from 
	staff, store, inventory, rental, film_category, category
where
	staff.store_id = store.store_id
    and store.store_id = inventory.store_id
    and inventory.inventory_id = rental.inventory_id
    and inventory.film_id = film_category.film_id
    and film_category.category_id = category.category_id
    and category.name = 'Sci-Fi'
    and staff.first_name = 'Jon'
    and staff.last_name = 'Stephens';
    
-- 3. Find out the total sales from Animation movies.
select 
	sum(payment.amount)
from 
	payment, rental, inventory, film_category, category
where
	payment.rental_id = rental.rental_id
    and rental.inventory_id = inventory.inventory_id
    and inventory.film_id = film_category.film_id
    and film_category.category_id = category.category_id
    and category.name = 'Animation';
    
-- 4. Find out the top 3 rented category of movies  by “PATRICIA JOHNSON”.
select category_name from (
select
	category.name category_name, count(film.film_id) films
from
	rental, inventory, film, film_category, category
where
	rental.inventory_id = inventory.inventory_id
    and inventory.film_id = film.film_id
    and film.film_id = film_category.film_id
    and film_category.category_id = category.category_id
    and film.film_id IN 
    (
		select film.film_id
        from film, actor, film_actor
        where
			film.film_id = film_actor.film_id
            and film_actor.actor_id = actor.actor_id
            and actor.first_name = 'PATRICIA'
            and actor.last_name = 'JOHNSON'
	)
group by category.category_id
order by films desc limit 3) A;
-- The above query does not result in anything because there is no actor called PATRICIA JOHNSON in my db. Tested with other actors and it worked fine

-- 5. Find out the number of R rated movies rented by “SUSAN WILSON”.
select
	count(*) as 'R Rated Movies'
from
	actor, film_actor, film
where
	actor.actor_id = film_actor.actor_id
    and film_actor.film_id = film.film_id
    and actor.first_name = 'SUSAN'
    and actor.last_name = 'WILSON'
    and film.rating = 'R';