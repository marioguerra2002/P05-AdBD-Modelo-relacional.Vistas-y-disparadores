-- Ejercoicio4 . a
select category.name as categoria,
sum(payment.amount) as ventas_totales
from payment
inner join rental on rental.rental_id = payment.rental_id
inner join inventory on inventory.inventory_id = rental.inventory_id
inner join film_category on film_category.film_id = inventory.film_id
inner join category on category.category_id = film_category.category_id
group by categoria
order by ventas_totales desc;

create view view_ventas_totales as
select category.name as categoria,
sum(payment.amount) as ventas_totales
from payment
inner join rental on rental.rental_id = payment.rental_id
inner join inventory on inventory.inventory_id = rental.inventory_id
inner join film_category on film_category.film_id = inventory.film_id
inner join category on category.category_id = film_category.category_id
group by categoria
order by ventas_totales desc;


-- ejercicio 4 B
SELECT
 CONCAT(city.city, ', ', country.country) AS location,
 CONCAT(staff.first_name, ' ', staff.last_name) AS manager,
 SUM(payment.amount) AS total_sales
FROM payment
INNER JOIN rental ON rental.rental_id = payment.rental_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN store ON store.store_id = inventory.store_id
INNER JOIN staff ON staff.staff_id = store.manager_staff_id
INNER JOIN address ON address.address_id = store.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country ON country.country_id = city.country_id
GROUP BY location, manager
ORDER BY total_sales DESC;

create view view_ventas_totales_GroupManager as
SELECT
 CONCAT(city.city, ', ', country.country) AS location,
 CONCAT(staff.first_name, ' ', staff.last_name) AS manager,
 SUM(payment.amount) AS total_sales
FROM payment
INNER JOIN rental ON rental.rental_id = payment.rental_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN store ON store.store_id = inventory.store_id
INNER JOIN staff ON staff.staff_id = store.manager_staff_id
INNER JOIN address ON address.address_id = store.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country ON country.country_id = city.country_id
GROUP BY location, manager
ORDER BY total_sales DESC;

-- Ejercicio 4 C
select f.film_id as id_peli,
	f.title as nombre_peli,
	f.description as descripcion_peli,
	c.name as categoria,
	f.rental_rate as precio,
	f.length as duracion,
	f.rating as clasificacion,
   STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS actores
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
join film_actor fa on f.film_id = fa.film_id
join actor a on fa.actor_id = a.actor_id
group by f.film_id , f.title , f.description , c.name, f.rental_rate, f.length , f.rating


create view view_Informacion_peliculas as
select f.film_id as id_peli,
	f.title as nombre_peli,
	f.description as descripcion_peli,
	c.name as categoria,
	f.rental_rate as precio,
	f.length as duracion,
	f.rating as clasificacion,
   STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS actores
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
join film_actor fa on f.film_id = fa.film_id
join actor a on fa.actor_id = a.actor_id
group by f.film_id , f.title , f.description , c.name, f.rental_rate, f.length , f.rating


--Ejercicio 4 D

SELECT
 CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name,
 STRING_AGG(category.name || ':' || film.title, ', ') AS categorias_peliculas
FROM actor
INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id
INNER JOIN film ON film.film_id = film_actor.film_id
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY actor_name
ORDER BY actor_name;


create view view_ActorCategory as
SELECT
 CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name,
 STRING_AGG(category.name || ':' || film.title, ', ') AS categorias_peliculas
FROM actor
INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id
INNER JOIN film ON film.film_id = film_actor.film_id
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY actor_name
ORDER BY actor_name;



-- Ejercicio 6 Checks:
ALTER TABLE film
ADD CONSTRAINT CK_film_rental_duration_positiva CHECK (rental_duration > 0);


ALTER TABLE film
ADD CONSTRAINT check_rental_rate_no_negativo
CHECK (rental_rate >= 0.00);


ALTER TABLE film
ADD CONSTRAINT check_replacement_cost_positivo
CHECK (replacement_cost >= 0.00);

ALTER TABLE film
ADD CONSTRAINT check_rating_valido
CHECK (rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17'));

ALTER TABLE rental
ADD CONSTRAINT check_devolucion_posterior_alquiler
CHECK (return_date IS NULL OR return_date >= rental_date);

ALTER TABLE rental
ADD CONSTRAINT check_fecha_alquiler_no_futura
CHECK (rental_date <= CURRENT_TIMESTAMP);


ALTER TABLE customer
ADD CONSTRAINT check_customer_activo_valido
CHECK (active IN (0, 1));

ALTER TABLE staff
ADD CONSTRAINT check_staff_activo_valido
CHECK (active IN (TRUE, FALSE));



-- Ejercicio 8
create table if not exists film_insert_log (
	log_id serial primary key,
	film_id integer not null,
	insert_date timestamp not null default CURRENT_TIMESTAMP,
	-- no se si current_timestamp o NOW()
	constraint fk_film foreign key (film_id) references film(film_id) on delete cascade 
	
);

create or replace function log_film_insert()
returns trigger as $$
-- solo las funciones que devuelven trigger se pueden
-- usar en triggers
begin
	insert into film_insert_log (film_id, insert_date)
	values (new.film_id, now());
	return new;
-- new es var auto creada por postgre que existe según la 
-- operacion. New existe en update y insert
end;
$$ language plpgsql;
-- con $$ se delimita el cuerpo de la funcion

drop trigger if exists trigger_log_film_insert on film;
create trigger trigger_log_film_insert
	after insert on film
	for each row
	execute function log_film_insert();



-- Ejercicio 9
create table if not exists film_delete_log (
    log_id serial primary key,
    film_id integer not null,
    delete_date timestamp not null default current_timestamp
);

create or replace function log_film_delete()
returns trigger as $$
begin
    insert into film_delete_log (film_id, delete_date)
    values (old.film_id, now());
    return old;
end;
$$ language plpgsql;

drop trigger if exists trigger_log_film_delete on film;
create trigger trigger_log_film_delete
    before delete on film
    for each row
    execute function log_film_delete();


