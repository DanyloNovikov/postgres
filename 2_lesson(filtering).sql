
-- How postgres analyze command ?
-- select name, area from cities where area > 4000;
-- ----------------- ----------- -----------------
--       third          first         second

select name, area from cities where area > 4000;

-- Comparison Math Operations
-- = are the values equal ?
-- > Is the value on the left greater ?
-- < Is the value on the left less ?
-- >= Is the value on the left greater or equal to ?
-- in Is the value present in a list ?
-- <= Is the value on the left less or equal to ?
-- <> Are there values not equal ?
-- != Are there values not equal ?
-- between Is the value between two other values ?
-- not in Is the value not present in a list ?

select name, area from cities where area > 4000;
select name, area from cities where area = 8223;
select name, area from cities where area != 8223;
select name, area from cities where area between 2000 and 4000;
select name, area from cities where name in ('Delhi', 'Shanghai');
select name, area from cities where name not in ('Delhi', 'Shanghai');
select name, area from cities where area not in (8223, 3043) and name = 'Delhi';
select name, area from cities where area not in (8223, 3043) or name = 'Delhi' or name = 'Tokyo';

-- we also can calculate some value in were request
select
    name, population / area as population_density
from
    cities
where
    population / area > 6000;

-- Update row
update cities set population = 39505000 where name = 'Tokyo';
-- Delete row
delete from cities where name = 'Tokyo';