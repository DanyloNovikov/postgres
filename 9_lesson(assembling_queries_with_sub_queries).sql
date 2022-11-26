SELECT name, price
FROM products
WHERE price > (SELECT MAX(price)
               FROM products
               WHERE department = 'Toys');

-- We can insert sub-query in any path our request: SELECT, FROM, JOIN, WHERE.

SELECT p1.name,
       (SELECT COUNT(name) FROM products)
FROM (SELECT * FROM products) AS p1
         JOIN (SELECT * FROM products) AS p2 ON p1.id = p2.id
WHERE p1.id IN (SELECT id FROM products);

SELECT name, (price / weight) AS price_weight_ratio
FROM products;

-- More important is an order query
-- 1. firstly run the JOIN command.
-- 2. secondly run the FROM command.
-- 3. then run the WHERE and then the SELECT.

-- sub-query -- must returned only 1 column for SELECT !!!
SELECT department, MAX(price), COUNT(*)
FROM products
GROUP BY department;

-- Example sub-query in the SELECT:
SELECT name,
       price,
       (SELECT price
        FROM products
        WHERE id = 3)
FROM products
WHERE price > 867;

-- We can make filtering in WHERE from table what we select with sub-query from FROM.
-- Example:
SELECT name, price_weight_ratio
FROM (SELECT name, price / weight AS price_weight_ratio
      FROM products) AS p
WHERE price_weight_ratio > 5;

-- Next example usage sub-query:
SELECT *
FROM (SELECT MAX(price)
      FROM products) AS p;

SELECT AVG(order_count)
FROM (SELECT user_id, COUNT(*) AS order_count
      FROM orders
      GROUP BY user_id) AS p;

-- Example sub-query in the JOIN:
SELECT first_name
FROM users
         JOIN (SELECT user_id
               FROM orders
               WHERE product_id = 3) AS o
              ON o.user_id = users.id;

-- Example sub-query in the WHERE:
SELECT *
FROM orders
WHERE product_id IN (SELECT id
                     FROM products
                     WHERE (price / weight) > 50);

SELECT id
FROM products
WHERE (price / weight) > 5;

-- Which operator to which data to apply operators.
-- >               == Single value
-- <               == Single value
-- >=              == Single value
-- <=              == Single value
-- =               == Single value
-- <> or !=        == Single value
-- in              == Single column
-- not in          == Single column
-- > ALL/SOME/ANY  == Single column
-- < ALL/SOME/ANY  == Single column
-- >= ALL/SOME/ANY == Single column
-- <= ALL/SOME/ANY == Single column
-- = ALL/SOME/ANY  == Single column
-- <> ALL/SOME/ANY == Single column

SELECT name
FROM products
WHERE price > (SELECT AVG(price)
               FROM products);

-- Example how we can use not in.
SELECT name
FROM products
WHERE department NOT IN (SELECT department
                         FROM products
                         WHERE price < 100);

SELECT name, department, price
FROM products
WHERE price > ALL (SELECT price
                   FROM products
                   WHERE department = 'Industrial');

-- How to use > SOME.
SELECT name, department, price
FROM products
WHERE price > SOME (SELECT price
                    FROM products
                    WHERE department = 'Industrial');

-- Make iteration.
SELECT name, department, price
FROM products AS p1
WHERE p1.price = (SELECT MAX(price)
                  FROM products AS p2
                  WHERE p2.department = p1.department);

-- firstly we call first request and get p1
-- Who is WHERE work ?
-- It is very important to understand how to use sub-request
-- where is called each time for each line because of this we can implement a different iteration
-- that is, from the beginning we call from, which will return the table row by row and in where
-- but this would rather make a loop in a loop after all the iterations in the auxiliary query have passed us.

-- Without using a JOIN or a GROUP BY, print the number of orders for each product.
SELECT product_id, paid
FROM orders AS o
WHERE product_id = (SELECT id
                    FROM products AS p
                    WHERE p.id = o.product_id
                      AND o.paid = TRUE);

SELECT COUNT(*)
FROM orders;
SELECT COUNT(*)
FROM products;

SELECT name
FROM products AS p1;

SELECT p1.name,
       (SELECT COUNT(*)
        FROM orders AS o1
        WHERE o1.product_id = p1.id) AS num_orders
FROM products AS p1;
