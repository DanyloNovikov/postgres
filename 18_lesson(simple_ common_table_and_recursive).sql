-- what is with (Common Table Expression) CTE -- make command more clearly
WITH tags AS (SELECT user_id, created_at
              FROM captions_tags
              UNION ALL
              SELECT user_id, created_at
              FROM photos_tags)
SELECT username, tags.created_at
FROM users
         JOIN tags ON tags.user_id = users.id
WHERE tags.created_at < '2010-01-07';

-- recursive CTE
-- Very, Very different from simple CTE
-- Useful anymore you have tree on graph-type data structure
-- Must use a 'union' keyword - simple CTE`s dont have to use a union
-- This is super advanced

WITH RECURSIVE countdown(value) AS (SELECT 3 AS val -- Initial, Non-recursive query
                                    UNION
                                    SELECT val - 1
                                    FROM countdown
                                    WHERE val > 1 -- Recursive query
)
SELECT *
FROM countdown;
-- every CTE must have an 'UNION' inside

-- 1. Define the result and working tables
-- 2. Run the initial non-recursive statement, put the results into the results table and working table
-- 3. Run the recursive statement replacing the table name 'countdown' with a reference with a reference to the working table
-- 4. If recursive statement returns some rows, append them to the results table and run recursion again
-- 5. If recursive statement returns no rows stop recursive

-- how we can use recursive in the real world:
WITH RECURSIVE suggestions(leader_id, follower_id, depth) AS (SELECT leader_id, follower_id, 1 AS depth
                                                              FROM followers
                                                              WHERE follower_id = 1
                                                              UNION
                                                              SELECT followers.leader_id, followers.follower_id, depth + 1
                                                              FROM followers
                                                                       JOIN suggestions ON suggestions.leader_id = followers.follower_id
                                                              WHERE depth < 3)
SELECT DISTINCT users.id, users.username
FROM suggestions
         JOIN users ON users.id = suggestions.leader_id
WHERE depth > 1
LIMIT 30;
