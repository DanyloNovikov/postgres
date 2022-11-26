-- Grouping
-- Reduces many rows down to fewer rows
-- Done by using the 'GROUP BY' keyword
-- Visualizing the result is key to use

-- Aggregates
-- Reduces many values down to one
-- Done by using 'aggregate functions'

-- The GROUP BY work by next:
-- 1. Firstly GROUP BY has group rows by some column for example user_id

SELECT user_id
FROM comments
GROUP BY user_id;

-- in this example you can see that we group all rows from the table comments by user_id
-- but if we try group rows by *
-- we had an error, because for GROUP BY must be some value for grouping. the value for grouping must be some uniq for
-- example it can be references id

SELECT *
FROM comments
GROUP BY contents;

-- what is aggregate function ?
-- Aggregate function -- return calculate value from group.

-- COUNT() ==> return the number of value in a group of value.
-- SUM()   ==> finds the sum of a group of numbers.
-- AVG()   ==> finds the average of a group of numbers.
-- MIN()   ==> returns the minimum value from a group of numbers.
-- MAX()   ==> returns the maximum value from a group of numbers.

SELECT MAX(id)
FROM comments;

-- Combining group by and aggregate;

SELECT user_id
FROM comments
GROUP BY user_id;

SELECT user_id, COUNT(id)
FROM comments
GROUP BY user_id;

-- There are only 5 groups because we have grouped them by user and
-- there are only 5 users and specified that in each group we need maximum id.

-- Remember all keywords
-- FROM     ==> specifies starting set of rows to work with;
-- JOIN     ==> merges in data from additional table;
-- WHERE    ==> filters the set of rows;
-- GROUP BY ==> groups rows by a unique set of values;
-- HAVING   ==> filters the set of groups;

-- Having it has a kind of filter for filtering (sampling data)
-- only it is used for sampling groups we never use HAVING without GROUP BY.

SELECT photos_id, COUNT(*)
FROM comments
WHERE photos_id < 3
GROUP BY photos_id
HAVING COUNT(*) > 2;

SELECT user_id, COUNT(photos_id)
FROM comments
WHERE photos_id > 2
GROUP BY user_id
HAVING COUNT(photos_id) > 11;
