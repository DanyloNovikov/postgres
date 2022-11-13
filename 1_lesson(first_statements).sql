-- Create database example_name;
-- --------------- ------------
--    Keywords     Identifiers

-- Create database — Keywords, tell the database that we want to do something. Always written on the capital letter
--
-- Example_name — Identifiers, Tell the database what thing we want to act on. Always written out in lower case letters

create table cities(
    name varchar(50),
    country varchar(50),
    population integer,
    area integer
);
insert into cities(
                   name,
                   country,
                   population,
                   area
) values ('Tokyo', 'Japan', 38505000, 8223),
         ('Delhi', 'India', 28125000, 2240),
         ('Shanghai', 'China', 22125000, 4015),
         ('Sao Paulo', 'Brazil', 20935000, 3043);

select * from cities;
select name, country from cities;

select name, population / area from cities;

select name, population / area as population_density
from cities;

-- Homework №2
create table movies (
    title varchar(60),
    box_office integer
);

insert into movies (title, box_office)
values
('The Avengers', 1500000000),
('Batman v Superman', 873000000);

select * from movies;

-- String Operations and Functions
--
-- || — Join two strings
-- Concat() — join to strings
-- Lower() — given a lower case string
-- Length() — Gives number of characters in a string
-- Upper() — Gives an upper case string


select name || ', ' || country as location from cities;
select concat(name, ', ' , country) as location from cities;
select lower(concat(name, ', ', country)) as location from cities;
select upper(concat(name, ', ', country)) as location from cities;
select length(concat(name, ', ', country)) as location from cities;

