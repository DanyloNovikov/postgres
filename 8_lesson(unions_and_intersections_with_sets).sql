SELECT *
FROM products
ORDER BY price DESC
LIMIT 4;

SELECT *
FROM products
ORDER BY price / weight DESC
LIMIT 4;

-- UNION
-- what does it do? it combines two results into one example below:
(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 4)
UNION
(SELECT *
 FROM products
 ORDER BY price / weight DESC
 LIMIT 4);

-- If there is a record that was returned in the first query and in the second one,
-- then it will return 1 line instead of two but we can pre-write this by prewriting UNION ALL,
-- which would mean not to remove the duplicate.

(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 4)
UNION ALL
(SELECT *
 FROM products
 ORDER BY price / weight DESC
 LIMIT 4);

-- the UNION is very sensitive to the type of data it connects
SELECT name
FROM products
UNION
SELECT price
FROM products;

-- Data type connection error:
-- UNION         ==> Join together the results of two queries and remove duplicate rows.
-- UNION ALL     ==> Join together results of two quesries.
-- INTERSECT     ==> Find the rows common in the results of two queries. Remove dublicates.
-- INTERSECT ALL ==> Find the rows common in the results of two queries.
-- EXPECT        ==> Find the rows that are present in first query but not second query. Remove duplicates.
-- EXPECT ALL    ==> Find the rows that are present in first query but not second query.

(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 4)
INTERSECT ALL
(SELECT *
 FROM products
 ORDER BY (price / weight) DESC
 LIMIT 4);

-- INTERSECT -- output the same sides that were found in the first and in the second query.
-- EXPECT    -- returns unique values only from the left side it will find the values that were in the left and right
-- cross out the ones that matched the values on the right and returns the values on the left.

(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 4)
EXCEPT
(SELECT *
 FROM products
 ORDER BY price / weight DESC
 LIMIT 4);
