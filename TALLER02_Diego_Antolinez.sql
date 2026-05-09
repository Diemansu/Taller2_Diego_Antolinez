## 1 Con la consulta SELECT y FROM puedo llamar la informacion de las columnas de manera especifica
SELECT first_name, last_name
FROM customer;

## Se realiza la consulta de las peliculas con duracion mayor a 120 min con la funcion where y lenght, especificando que la duracion sea mayor "> 120"
SELECT title,length
FROM film
WHERE length > 120;

## 2 Se realiza la organizacion de los apellidos por orden alfabetico con la cunsulta ORDER BY Y ASC, para que sea de manera ascendente 
SELECT first_name, last_name
FROM customer
ORDER BY last_name ASC;

## Por medio de la consulta ORDER BY Y DESC, se realiza la busqueda del top 5 de peliculas mas largas ejecutandose de manera descentende la busqueda, se usa LIMIT para que solo traiga las ultimas 5 peliculas
SELECT title, length
FROM film
ORDER BY length DESC 
LIMIT 5;

## 3 Con la consulta INNER JOIN se combina la busqueda en las columnas devolviendo los registros que tienen coincidencia en las tablas, la relacion se genera por medio de las llaves primarias y foraneas
SELECT 
	customer.first_name,
    customer.last_name,
    payment.amount,
    payment.payment_date
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

SELECT 
	film.title,
    rental.rental_date
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id;

## 4 Se realiza la consulta de los clientes sin pagos por medio de la CONSULTA LEFT JOIN, WHERE e IS NULL, WHERE funciona como una condicional donde si el pago es 0 con la funcion IS NULL registraria los clientes sin pagos priorizando la tabla de la izquierda que tenga coincidencias con la de la derecha con la consulta LEFT JOIN
SELECT 
	customer.first_name,
    customer.last_name
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.payment_id IS NULL;

## PELICULAS QUE NO TIENEN ACTORES
SELECT
	film.title,
    film.length
FROM film
LEFT JOIN film_actor
ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id IS NULL;
    
## 5 Se inserta un nuevo actor por medio de la funcion INSERT INTO, se realiza la actualizacion del nombre del actor temporal (DIEGO) con la funcion UPDATE, como se realizaron varias consultas del actor antes de la actualizacion del nombre se crearon varias filas al momento de insertarlo, se elimina el actor temporal buscando el id del actor y con la funcion DELETE se elimina el registro
INSERT INTO actor (first_name, last_name)
VALUES ('Temporal', 'Actor');

UPDATE actor
SET first_name = 'DIEGO'
WHERE first_name = 'Temporal';

DELETE FROM actor
WHERE actor_id = '213';

## 6 Por medio de la funcion SUM se realiza la suma del dinero gastado en el servicio de renta y con la funcion COUNT se realiza el conteo de las veces que se rento
SELECT 
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_pagado
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY total_pagado DESC
LIMIT 5;

SELECT 
    film.title,
    COUNT(rental.rental_id) AS veces_alquilada
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
GROUP BY film.film_id
ORDER BY veces_alquilada DESC
LIMIT 5;
    
    