SELECT * FROM film;

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT TITLE, LENGTH,  DENSE_RANK() OVER(ORDER BY LENGTH DESC) AS 'DENSE RANK' from film
WHERE LENGTH IS NOT NULL AND LENGTH != ' ';

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT TITLE, LENGTH, RATING, DENSE_RANK () OVER(PARTITION by RATING ORDER by length DESC) 'DENSE_RANK' FROM film
WHERE LENGTH IS NOT NULL AND LENGTH != ' ';

-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT NAME 'CATEGORY_NAME', COUNT(DISTINCT FILM_ID) 'FILMS_PER_CATEGORY'
FROM FILM_CATEGORY FC
LEFT JOIN CATEGORY C on FC.CATEGORY_ID = C.CATEGORY_ID
GROUP BY FC.CATEGORY_ID;

-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT * FROM ACTOR;
SELECT * FROM FILM_ACTOR;

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) 'ACTOR_NAME', COUNT(DISTINCT FILM_ID) 'NUMBER_OF_FILMS'
FROM FILM_ACTOR FA LEFT JOIN ACTOR A ON FA.ACTOR_ID = A.ACTOR_ID
GROUP BY FA.ACTOR_ID
ORDER BY NUMBER_OF_FILMS DESC
LIMIT 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT * FROM CUSTOMER;
SELECT * FROM RENTAL;

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) 'CUSTOMER_NAME', COUNT(DISTINCT RENTAL_ID) 'NUMBER_OF_RENTALS'
FROM RENTAL R LEFT JOIN CUSTOMER C ON R.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY R.CUSTOMER_ID
ORDER BY NUMBER_OF_RENTALS DESC
LIMIT 1;