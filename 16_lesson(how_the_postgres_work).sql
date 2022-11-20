-- to see where database store postgres database;
SHOW DATA_DIRECTORY;

SELECT oid, datname
FROM pg_database;

-- return all object on our postgres(tables)
SELECT * FROM pg_class;

-- heap(куча) or heap file --> file the contains all the data (rows) of our table.
-- tuple(кортеж) or Item --> Individual row from the table.
-- block or page --> The heap file is divided into many different 'blocks' or 'pages'. Each page/block stores some
-- number of rows.

-- directory var-14 is heap. iin the directory 'base' we have garbage our database. we can oid your database with
-- command SELECT oid, datname FROM pg_database; we can see oid what we need and open the heap
-- in this files in the heap we can see all table in the database what we choice.
-- in this table we can see blocks of rows in this table. We can all data in the binar format
-- the heap file stop save inside themself some blocks/pages and the block

-- how postgres stores date in the binare format we can see in this video
-- https://www.udemy.com/course/sql-and-postgresql/learn/lecture/22802657#notes -- more details
-- https://www.postgresql.org/docs/8.1/storage.html -- more details
