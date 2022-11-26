-- How postgres analyze command ?
-- select name, area from cities where area > 4000;
-- ----------------- ----------- -----------------
--       third          first         second

SELECT name, area
FROM cities
WHERE area > 4000;

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

SELECT name, area
FROM cities
WHERE area > 4000;

SELECT name, area
FROM cities
WHERE area = 8223;

SELECT name, area
FROM cities
WHERE area != 8223;

SELECT name, area
FROM cities
WHERE area BETWEEN 2000 AND 4000;

SELECT name, area
FROM cities
WHERE name IN ('Delhi', 'Shanghai');

SELECT name, area
FROM cities
WHERE name NOT IN ('Delhi', 'Shanghai');

SELECT name, area
FROM cities
WHERE area NOT IN (8223, 3043)
  AND name = 'Delhi';

SELECT name, area
FROM cities
WHERE area NOT IN (8223, 3043)
   OR name = 'Delhi'
   OR name = 'Tokyo';

-- We can also calculate some value in where.
SELECT name,
       population / area AS population_density
FROM cities
WHERE population / area > 6000;

-- Update row.
UPDATE cities
SET population = 39505000
WHERE name = 'Tokyo';
-- Delete row.
DELETE
FROM cities
WHERE name = 'Tokyo';
