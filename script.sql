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

