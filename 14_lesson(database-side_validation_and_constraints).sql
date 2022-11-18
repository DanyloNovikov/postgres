-- Alter table means that we are want to change structure table
ALTER TABLE products
ALTER COLUMN price
SET NOT NULL;

-- But all value must != null;
-- so before we must do something like this
UPDATE products
SET price = 9999
WHERE price is null;

-- example how failed validation
-- we set price as required values
-- INSERT INTO products (name, department, weight)
-- VALUES ('Shoes', 'Clothes', 5)

ALTER TABLE products
ALTER COLUMN price
SET DEFAULT 999; -- how add default value if params null

ALTER TABLE products
ADD UNIQUE (name);

-- then we are create or add some attributes as like unique values
-- firstly we need remove previous old uniq setting we can do it with next command
ALTER TABLE products
DROP CONSTRAINT products_name_key;

-- and now we can add multi-Column
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	department VARCHAR(50),
	price INTEGER,
	weight INTEGER,
	UNIQUE(name, department)
);

ALTER TABLE products
ADD UNIQUE(name, department);

-- Cheak
-- When Creating The Table
CREATE TABLE products(
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	department VARCHAR(50) NOT NULL,
	price INTEGER CHECK (price > 0),
	weight INTEGER
);

-- or after the table was created
ALTER TABLE products
ADD CHECK(price > 0);


CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL,
	created_at TIMESTAMP NOT NULL,
	est_delivery TIMESTAMP NOT NULL,
	CHECK (created_at < est_delivery)
)

INSERT INTO orders (name, created_at, est_delivery)
VALUES ('Shirt', '2000-NOV-20 01:00AM', '2000-NOV-10 01:00AM');