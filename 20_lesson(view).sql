-- VIEW it is a fake table

-- What VIEW can do ?
-- 1. Create a fake table that has rows from other tables
-- 2. These can be exact rows as they exist on another table, or a computed value
-- 3. Can reference the view in any place where we`d normally reference a table
-- 4. View does not actually create a new table or move any data around
-- 5. does not have to be used for a union! Can compute absolutely any value.

-- How create VIEW:
CREATE VIEW tags AS
(
SELECT id, created_at, user_id, post_id, 'photo_tag' AS type
FROM photo_tags
UNION ALL
SELECT id, created_at, user_id, post_id, 'caption_tag' AS type
FROM caption_tags
    );

-- as like with but we can use VIEW many time:
SELECT *
FROM tags
WHERE type = 'caption_tag';

SELECT username, COUNT(*)
FROM users
         JOIN tags ON tags.user_id = users.id
GROUP BY username
ORDER BY COUNT(*) DESC;

-- imagine: the 10 most recent posts are really important!
-- We can use view because we use one query many time

-- For example:
-- Show the users who created the 10 most recent posts
-- Show the users who were tagged in the 10 most recent posts
-- Show the average number of hashtags used in the 10 most recent posts
-- Show the number of likes each of the 10 most recent posts received
-- Show the hashtags used by the 10 most recent posts
-- Show the total number of comments the 10 most recent posts received

CREATE VIEW recent_posts AS
(
SELECT *
FROM posts
ORDER BY created_at DESC
LIMIT 10 );

-- How make update to the VIEW:
CREATE OR REPLACE VIEW recent_posts AS
(
SELECT *
FROM posts
ORDER BY created_at DESC
LIMIT 15 );

-- How to drop VIEW:
DROP VIEW recent_posts;

-- What different between VIEW and MATERIALIZED VIEW ?

-- VIEW               -- Query that gets executed every time you refer to it
-- MATERIALIZED VIEW  -- Query that gets executed only at very specific times, but the results are saved and can be
-- Referenced without rerunning the query.

-- Simple Common Table Expression(CTE) and Views they are convenience tools

-- Use slow request:
SELECT *
FROM likes
         LEFT JOIN posts ON posts.id = likes.post_id
         LEFT JOIN comments ON comments.id = likes.comment_id;

-- Example hard query to executed can load a long times we can optimise the query with MATERIALIZED VIEW:
SELECT DATE_TRUNC('week', COALESCE(posts.created_at, comments.created_at)),
       COUNT(posts.id)    AS num_posts,
       COUNT(comments.id) AS num_comments
FROM likes
         LEFT JOIN posts ON posts.id = likes.post_id
         LEFT JOIN comments ON comments.id = likes.comment_id
GROUP BY week
ORDER BY week;

-- Lets have write query with MATERIALIZED VIEW:
CREATE MATERIALIZED VIEW weekly_likes AS
(
SELECT DATE_TRUNC('week', COALESCE(posts.created_at, comments.created_at)),
       COUNT(posts.id)    AS num_posts,
       COUNT(comments.id) AS num_comments
FROM likes
         LEFT JOIN posts ON posts.id = likes.post_id
         LEFT JOIN comments ON comments.id = likes.comment_id
GROUP BY week
ORDER BY week
    )
WITH DATA;

SELECT
FROM weekly_likes;

DELETE
FROM posts
WHERE created_at < '2010-02-01';

-- we delete some of posts but weekly_likes still show them because views save previes data
SELECT
FROM weekly_likes;
-- in really this data not exist anymore
-- to fix this we must say to postgres update materialize views
-- how we can do this ?
-- we can just refresh data
REFRESH MATERIALIZED VIEW weekly_likes;

-- So what different between view and material view ?
-- VIEW              -- call an query every time when we use the view we send request again and again.
-- MATERIALIZED VIEW -- save result from first query and then we must manually update MATERIALIZED VIEW.

-- We must use materialized view every time then we have very expensive query
