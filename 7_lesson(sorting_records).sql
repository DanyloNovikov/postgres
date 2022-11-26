SELECT *
FROM products
ORDER BY price;

SELECT *
FROM products
ORDER BY price ASC;

SELECT *
FROM products
ORDER BY price DESC;

-- We can use ORDER BY for many attributes.

SELECT *
FROM products
ORDER BY price, weight ASC;

SELECT *
FROM products
ORDER BY price, weight ASC;

-- OFFSET means that we need skip first 40 user.

SELECT *
FROM users
OFFSET 40;

-- LIMIT only give the first five rows of the results set.
SELECT *
FROM users
LIMIT 5;

SELECT *
FROM products
ORDER BY price DESC
LIMIT 5 OFFSET 1;

-- LIMIT and OFFSET are used most often for pagination.
