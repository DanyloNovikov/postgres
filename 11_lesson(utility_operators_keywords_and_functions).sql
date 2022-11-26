SELECT GREATEST(20, 10, 30);
-- This is a special operator that checks if the selected value is greater than
-- the specified if not then not returned.

-- Example:
SELECT name, price, GREATEST(30, 2 * weight)
FROM products;

-- There is a similar function for smaller values.
-- Example:
SELECT LEAST(1000, 20, 50, 100);

SELECT name, price, LEAST(price * 0.5, 300)
FROM products;

-- How to use case:
SELECT name,
       price,
       CASE
           WHEN price > 600 THEN 'high'
           WHEN price > 300 THEN 'medium'
           ELSE 'cheap'
           END
FROM products;
