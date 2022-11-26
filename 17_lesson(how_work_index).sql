-- How the index is work?
-- Firstly we load data from the hard store to the RAM and search rows that relatively large perform
-- as database engineers we thy to minimize the amount of data that is being moved. Than we load table we make
-- full table scan -- pg has to load many (or all) rows from the heap file to memory.
-- we can add index to the block for quick search
-- then we create index we add index to the block id for example
-- Block 0,
-- Nancy, id = 40,
-- created_at, updated_at
-- Alf, id = 2
-- created_at, updated_at,
-- url

-- Block 1
-- Jia, id = 5,
-- created_at, updated_at,
-- url
-- Riann, id = 3,
-- created_at, updated_at
-- url

-- if we add username to index in the block we can see some like Riann, id=3
-- block is sorting by Alphabetical for node algorithm, node needed for quick search example
-- https://www.udemy.com/course/sql-and-postgresql/learn/lecture/22802665#notes

-- how to add index to the table
CREATE INDEX ON users (first_name);

-- and we can assign name to the index
CREATE INDEX users_first_name_idx
    ON users (first_name);

-- how to drop the index
DROP INDEX users_first_name_idx;

-- we can check all index into the pg_indexes
SELECT *
FROM pg_indexes
WHERE schemaname = 'public';


SELECT *
FROM users
WHERE first_name = 'Mathilde';

-- for check speed request we can use next request
EXPLAIN ANALYSE
SELECT *
FROM users
WHERE first_name = 'Mathilde';

-- Why the index is not always used ?
-- 1. Table with index used more RAM.
-- You can check who many memory the index use with this request.

SELECT PG_SIZE_PRETTY(PG_RELATION_SIZE('users'));
SELECT PG_SIZE_PRETTY(PG_RELATION_SIZE('users_first_name_idx'));
-- Users 8 kB.
-- Index of first_name 16 kB.

-- Downsides on index:
-- 1. Can be large! Storage data from at least one column of the real table.
-- 2. Slows down insert/update/delete - the index has to be updated!
-- 3. Index might not actually get used!

-- What the type of index exist
-- B-Tree  --> General purpose index. 99% of the time you want this (main index).
-- Hash    --> Speeds up simple equality checks.
-- GiST    --> Geometry, full-text search.
-- SP-GiST --> Clustered data, such as dates many rows might have the same year.
-- GIN     --> For columns that contain arrays or JSON data.
-- BRIN    --> Specialized for really large dataset.

-- Automatically generated indexes
-- The Postgres has automatically create index when we set UNIQUE for some column
-- example hashtags into the instagram database id is the index because it an unique value.

-- Index create file in the heap. The heap contains
SELECT *
FROM pageinspect('users_first_name_idx');

-- How postgres works with requests
-- 1. Firstly he got request and parses to the request to the request three -- It is description what is query we try to run
-- 2. Rewrite         -- The postgres check request and add some property to the query.
-- 3. Then go Planner -- Look at the query tree think what information we try to fetch and then come up with a series of
-- different plans or strategies that could be used (index table or just fetch all data).
-- 4. Execute query

-- EXPLAIN         --> Build a query plan and display info about it.
-- EXPLAIN ANALYZE --> Build a query plan, speed of each query it and info about it.

SELECT *
FROM users AS U
         JOIN orders AS O ON U.id = O.user_id
WHERE first_name = 'Mathilde';

-- Add EXPLAIN
EXPLAIN
SELECT *
FROM users AS U
         JOIN orders AS O ON U.id = O.user_id
WHERE first_name = 'Mathilde';

-- Add EXPLAIN ANALYSE
EXPLAIN ANALYSE
SELECT *
FROM users AS U
         JOIN orders AS O ON U.id = O.user_id
WHERE first_name = 'Mathilde';

-- Different between explain and explain analyze
-- just EXPLAIN    -- return to us how many action we do
-- EXPLAIN ANALYZE -- return to us how many action we do + time require

-- Return from explain analyze and explain is it steps.
-- Firstly he do seq scan how make access all the different roads inside of a table.
-- Secondly he check a hash how contains blocks in the table and check all indexes in blocks

-- Explain what is cost, rows, width and actual time, rows, loops in response table
-- Hash Join --> how this node is generating data
-- cost      --> Amount of processing power required for this step
-- rows      --> A guess at how many rows this step will produce
-- width     --> A guess at the average number of bytes of each row

SELECT *
FROM pg_stats
WHERE schemaname = 'public';

-- index automatically check with a solution will be faster (index or load all pages);
