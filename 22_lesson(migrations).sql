-- Schema Migrations -- Making Changes to your Database Structure

-- where we use schema migration ?
-- for example we need to change name some column
ALTER TABLE comments
    RENAME COLUMN contents TO body;

-- Big Lesson #1 Changes to the DB structure and changes to clients need to be made at precisely tha same time
-- Big Lesson #2 When working with other engineers, we need a really easy way to tie the structure of out database
-- to our code.
-- Firstly I see the migration in ruby on rails but now I understood what migration can be in any programing lang
-- Migration file must contain up and down methods
-- up -- contains a statement that advances, or upgrades, the structure of our DB.
-- example:
ALTER TABLE comments
    RENAME COLUMN contents TO body;

-- down -- contains a statement that exactly undo`s the 'up' command
-- example:
ALTER TABLE comments
    RENAME COLUMN body TO contents;
