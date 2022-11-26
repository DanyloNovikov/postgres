-- Create database example_name;
-- --------------- ------------
--    Keywords     Identifiers

-- Create database — Keywords, tell the database that we want to do something. Always written on the capital letter.
-- Example_name    — Identifiers, Tell the database what thing we want to act on. Always written out in lower case letters.

CREATE TABLE cities
(
    name       VARCHAR(50),
    country    VARCHAR(50),
    population INTEGER,
    area       INTEGER
);
INSERT INTO cities(name,
                   country,
                   population,
                   area)
VALUES ('Tokyo', 'Japan', 38505000, 8223),
       ('Delhi', 'India', 28125000, 2240),
       ('Shanghai', 'China', 22125000, 4015),
       ('Sao Paulo', 'Brazil', 20935000, 3043);

SELECT *
FROM cities;
SELECT name, country
FROM cities;

SELECT name, population / area
FROM cities;

SELECT name, population / area AS population_density
FROM cities;

-- Homework №2
CREATE TABLE movies
(
    title      VARCHAR(60),
    box_office INTEGER
);

INSERT INTO movies (title, box_office)
VALUES ('The Avengers', 1500000000),
       ('Batman v Superman', 873000000);

SELECT *
FROM movies;

-- String Operations and Functions.
--
-- ||       — Join two strings.
-- Concat() — join to strings.
-- Lower()  — given a lower case string.
-- Length() — Gives number of characters in a string.
-- Upper()  — Gives an upper case string.


SELECT name || ', ' || country AS location
FROM cities;
SELECT CONCAT(name, ', ', country) AS location
FROM cities;
SELECT LOWER(CONCAT(name, ', ', country)) AS location
FROM cities;
SELECT UPPER(CONCAT(name, ', ', country)) AS location
FROM cities;
SELECT LENGTH(CONCAT(name, ', ', country)) AS location
FROM cities;
