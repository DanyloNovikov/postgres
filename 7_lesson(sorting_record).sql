select *
from products
order by price;

select *
from products
order by price asc;

select *
from products
order by price desc;

-- we can use order by for many attributes;

select *
from products
order by price, weight asc;

select *
from products
order by price, weight asc;

-- offset means that we need skip first 40 user

select *
from users
offset 40;

-- limit only give the first five rows of the results set
select *
from users
limit 5;

select *
from products
order by price desc
limit 5
offset 1;

-- офсет или лимиты используються чаще всего используют для пагинации;