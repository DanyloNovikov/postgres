-- primary key - Uniquely identifies this record in this table
-- 1. each row in every table has one primary key.
-- 2. no other row in the same table can have the same value.
-- 3. 99% of the time called 'id'.
-- 4. either an integer or a UUID.
-- 5. will never change.

-- foreign key - Identifies a record (usually in another table) that this row is associated with
-- 1. rows only have this if they belong to another record.
-- 2. many rows in the same table can have the same foreign key.
-- 3. name varies, usually called something like 'xyz_id'.
-- 4. exactly equal to the primary key of the referenced row.
-- 5. will change if the relationship changes.

-- how work serial ?
-- it is special mechanism iteration in postgres
-- for each a new record take a prewies id and give + 1
-- primary key - say that the colum is primary key

create table users (
    id serial primary key,
    username varchar(50)
);

-- in preview table we created the table with name users
-- in the table with photos we set reference with users and photos
-- how to set reference ?
-- 1. we must create a column for who we are want reference in our case it is user and we can say to postgres that it is
-- a reference and set an id it there table.

create table photos (
    id serial primary key,
    url varchar(200),
    user_id integer references users(id) on delete set null
);

insert into users (
                   username
                   )
values ('monahan93'),
       ('pfeffer'),
       ('99stroman'),
       ('sim3onis');

insert into photos (
                    url,
                    user_id
) values ('http://one.jpg', 4),
         ('http://two.jpg', 1),
         ('http://25.jpg', 1),
         ('http://36.jpg', 1),
         ('http://754.jpg', 2),
         ('http://35.jpg', 3),
         ('http://256.jpg', 4);

-- if we want to clear all in the table we can use next command;
truncate photos;
select * from photos;

select * from photos where user_id = 4;
select * from photos join users on users.id = photos.user_id;

-- We insert a photo that is tied to a user that exists  -- Everything works OK!
-- We insert a photo that refers to a user that does not -- An error!
-- We insert a photo that is not tied to any user        -- put in a value of 'NULL' for the user_id

-- on delete option       What happens if you try to delete a user when a photo is still referencing
-- on delete restrict    ==>  Throw an error.
-- on delete no action   ==>  Throw an error.
-- on delete cascade     ==>  Delete the photo too!
-- on delete set null    ==>  Set the 'user_id' of the photo to 'Null'.
-- on delete set default ==>  Set the 'user_id' of the photo to a default value, if one is provided.
--
-- create table photos (
--     id serial primary key,
--     url varchar(200),
--     user_id integer references users(id) on delete cascade
-- );
--
-- create table photos (
--     id serial primary key,
--     url varchar(200),
--     user_id integer references users(id) on delete set null
-- );
drop table users;
drop table photos;
delete from users where id = 1;
select * from photos;
