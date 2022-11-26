-- primary key - Uniquely identifies this record in this table.
-- 1. each row in every table has one primary key.
-- 2. no other row in the same table can have the same value.
-- 3. 99% of the time called 'id'.
-- 4. either an integer or a UUID.
-- 5. will never change.

-- foreign key - Identifies a record (usually in another table) that this row is associated.
-- 1. rows only have this if they belong to another record.
-- 2. many rows in the same table can have the same foreign key.
-- 3. name varies, usually called something like 'xyz_id'.
-- 4. exactly equal to the primary key of the referenced row.
-- 5. will change if the relationship changes.

-- How work SERIAL ?
-- It is special mechanism iteration in postgres
-- for each a new record take a preview id and give + 1.

-- PRIMARY KEY - say that the colum is primary key.

CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    username VARCHAR(50)
);

-- In preview table we created the table with name users
-- in the table with photos we set reference with users and photos
-- how to set reference ?

-- We must create a column for who we are want reference in our case it is user and we can say to postgres that it is
-- a REFERENCES and set an id it there table.

CREATE TABLE photos
(
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER REFERENCES users (id) ON DELETE SET NULL
);

INSERT INTO users (username)
VALUES ('monahan93'),
       ('pfeffer'),
       ('99stroman'),
       ('sim3onis');

INSERT INTO photos (url,
                    user_id)
VALUES ('http://one.jpg', 4),
       ('http://two.jpg', 1),
       ('http://25.jpg', 1),
       ('http://36.jpg', 1),
       ('http://754.jpg', 2),
       ('http://35.jpg', 3),
       ('http://256.jpg', 4);

-- If we want to clear all in the table we can use next command.
TRUNCATE photos;
SELECT *
FROM photos;

SELECT *
FROM photos
WHERE user_id = 4;
SELECT *
FROM photos
         JOIN users ON users.id = photos.user_id;

-- We insert a photo that is tied to a user that exists  -- Everything works OK!
-- We insert a photo that refers to a user that does not -- An error!
-- We insert a photo that is not tied to any user        -- Put in a value of 'NULL' for the user_id.

-- on delete option       What happens if you try to delete a user when a photo is still referencing
-- on delete restrict    ==>  Throw an error.
-- on delete no action   ==>  Throw an error.
-- on delete cascade     ==>  Delete the photo too!
-- on delete set null    ==>  Set the 'user_id' of the photo to 'Null'.
-- on delete set default ==>  Set the 'user_id' of the photo to a default value, if one is provided.
--
-- CREATE TABLE photos
-- (
--     id      SERIAL PRIMARY KEY,
--     url     VARCHAR(200),
--     user_id INTEGER REFERENCES users (id) ON DELETE CASCADE
-- );
--
-- CREATE TABLE photos
-- (
--     id      SERIAL PRIMARY KEY,
--     url     VARCHAR(200),
--     user_id INTEGER REFERENCES users (id) ON DELETE SET NULL
-- );
DROP TABLE users;
DROP TABLE photos;
DELETE
FROM users
WHERE id = 1;
SELECT *
FROM photos;
