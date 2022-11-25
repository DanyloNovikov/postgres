CREATE TABLE accounts
(
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(20) NOT NULL,
    balance INTEGER
);

INSERT INTO accounts (name, balance)
VALUES
    ('Gia', 100),
    ('Alyson', 100);

-- transaction it is process when we call several query and we have to make sure that first query finish success but if
-- second query has been fail we must return back first query. so how we can make this ?

-- if we cant to set a transaction we must use BEGIN for example
BEGIN;
-- some code
UPDATE accounts
SET balance = balance - 50
WHERE name = 'Alyson';
-- now simulate some crash
-- we can just close the current session and the transaction has died

