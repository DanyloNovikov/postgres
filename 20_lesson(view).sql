-- View it is a fake table

-- What view can do ?
-- 1. Create a fake table that has rows from other tables
-- 2. These can be exact rows as they exist on another table, or a computed value
-- 3. Can reference the view in any place where we`d normally reference a table
-- 4. View does not actually create a new table or move any data around
-- 5. does not have to be used for a union! Can compute absolutely any value.

-- how create view
CREATE VIEW tags AS (
    SELECT id, created_at, user_id, post_id, 'photo_tag' AS type FROM photo_tags
    UNION ALL
    SELECT id, created_at, user_id, post_id, 'caption_tag' AS type FROM caption_tags
);

-- as like with but we can use view many time
SELECT *
FROM tags
WHERE type = 'caption_tag';

SELECT username, count(*)
FROM users
JOIN tags ON tags.user_id = users.id
GROUP BY username
ORDER BY count(*) desc;

-- imagine: the 10 most recent posts are really important!
-- we can use view because we use one query many time

-- for example:

-- Show the users who created the 10 most recent posts
-- Show the users who were tagged in the 10 most recent posts
-- Show the average number of hashtags used in the 10 most recent posts
-- Show the number of likes each of the 10 most recent posts received
-- Show the hashtags used by the 10 most recent posts
-- Show the total number of comments the 10 most recent posts received

CREATE VIEW recent_posts AS (
    SELECT *
    FROM posts
    ORDER BY created_at DESC
    LIMIT 10
);

-- how make update to the view
CREATE OR REPLACE VIEW recent_posts AS (
    SELECT *
    FROM posts
    ORDER BY created_at DESC
    LIMIT 15
);

-- how to drop view
DROP VIEW recent_posts;

-- what different between views and Materialized Views ?

-- View -- Query that gets executed every time you refer to it
-- Materialized Views -- Query that gets executed only at very specific times, but the results are saved and can be
-- referenced without rerunning the query

-- Simple Common Table Expression(CTE) and Views they are convenience tools

-- use slow request

select *
from likes
left join posts ON posts.id = likes.post_id
left join comments on comments.id = likes.comment_id;

-- example hard query to executed can load a long times we can optimise the query with materialized view

select
    date_trunc('week', COALESCE(posts.created_at, comments.created_at)),
    count(posts.id) as num_posts,
    count(comments.id) as num_comments
from likes
left JOIN posts on posts.id = likes.post_id
LEFT JOIN comments on comments.id = likes.comment_id
GROUP BY week
ORDER BY week;

-- lets have write materiazed view

CREATE MATERIALIZED VIEW  weekly_likes AS (
    select
        date_trunc('week', COALESCE(posts.created_at, comments.created_at)),
        count(posts.id) as num_posts,
        count(comments.id) as num_comments
    from likes
    left JOIN posts on posts.id = likes.post_id
    LEFT JOIN comments on comments.id = likes.comment_id
    GROUP BY week
    ORDER BY week
) WITH DATA;

SELECT FROM weekly_likes;

DELETE FROM posts
WHERE created_at < '2010-02-01';

-- we delete some of posts but weekly_likes still show them because views save previes data
SELECT FROM weekly_likes;
-- in really this data not exist anymore
-- to fix this we must say to postgres update materialize views
-- how we can do this ?
-- we can just refresh data
REFRESH MATERIALIZED VIEW weekly_likes;

-- so what different between view and material view
-- view every time when we use the view we send request again and again
-- materialize view -- save result from first request and then we must manualy update materialized view

-- we must use materialized view every time then we have very expensive query

