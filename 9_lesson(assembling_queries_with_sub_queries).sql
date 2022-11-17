select name, price
from products
where price > (select max(price)
               from products
               where department = 'Toys');

-- Мы можем вкладывать запросы куда угодно вот пример запроса в SELECT

select p1.name,
       (select count(name) from products)
from (select * from products) as p1
         join (select * from products) as p2 on p1.id = p2.id
where p1.id in (select id from products);

-- как можно здесь увидеть

select name, price, (
    select price from products where id = 3
)
from products
where price > 867;

-- Пример саб запроса в from

select name, price / weight as price_weight_ratio
from products;

-- важный нюанс который не следует запоминать
-- что в select будут выбираться колонки из той таблицы которую мы указали в from об этом просто не стоит забывать
-- я это говорю к тому что мы можем сделать какие-то операции подзапросом в from и нам вернеться совершенно не та
-- таблица которую мы ожидаем

-- example:
select name, price_weight_ratio
from (
    select name, price / weight as price_weight_ratio
    from products
) as p
where price_weight_ratio > 5;

-- предварительно сделав выборку в таблице мы можем восопользоваться колонками которые были в этой таблице

-- Другой пример использования подзапроса

select *
from (
    select max(price)
    from products
) as p;

-- еще один пример использования подзапроса там где он реально может потребоваться
-- агрегаторные функции не могут вызывать сами себя avg(count(*)) но мы можем использовать подзапросы для
select AVG(order_count)
from (
    select user_id, count(*) as order_count
    from orders
    group by user_id
) as p;

-- использование подзапросов в JOIN

select first_name
from users
join (
    select user_id from orders where product_id = 3
) as o
on o.user_id = users.id;

-- так же мы можем использовать подзапросы в where
-- мы можем использовать подзапрос что бы получить список элементов для in и not in
-- что бы потом можно было найти элемент который есть в этом списке вот приимер использования

select *
from orders
where product_id in (
    select id from products
    where (price / weight) > 50
);

select id
from products
where (price / weight) > 5;

-- К каким оператором какие данные применяються
-- Operator in the
-- where clause
-- >               == Single value
-- <               == Single value
-- >=              == Single value
-- <=              == Single value
-- =               == Single value
-- <> or !=        == Single value
-- in              == Single column
-- not in          == Single column
-- > ALL/SOME/ANY  == Single column
-- < ALL/SOME/ANY  == Single column
-- >= ALL/SOME/ANY == Single column
-- <= ALL/SOME/ANY == Single column
-- = ALL/SOME/ANY  == Single column
-- <> ALL/SOME/ANY == Single column

select name
from products
where price > (
    select avg(price)
    from products
);

-- example how we can use not in

select name
from products
where department not in (
    select department
    from products
    where price < 100
);

select name, department, price
from products
where price > ALL (
    select price
    from products
    where department = 'Industrial'
);

-- how to use > SOME

select name, department, price
from products
where price > some (
    select price
    from products
    where department = 'Industrial'
 );

-- subquery -- must returned only 1 column

select department, max(price), count(*)
from products
group by department;

-- Make iteration
select name, department, price
from products as p1
where p1.price =  (
    select max(price)
    from products AS p2
    where p2.department = p1.department
);

-- firstly we call first request and get p1
-- Как же работает where ?
-- это очень важно для понимания как пользоваться с употребление subrequest
-- where вызываеться каждый раз когда для каждой строки благодаря этому мы можем реализовать свою итерацию
-- тоесть с самого начала мы вызываем from который нам будет возвращать таблицу по строчно и в where
-- но из этого получиться скорее цикл в цикле после того как все итерации в спомогательном запросе пройдут у нас пройдут

-- Without using a join or a group by, print the number of orders for each product

select product_id, paid
from orders as o
where product_id = (
    select id
    from products as p
    where p.id = o.product_id and o.paid = true
);

select count(*) from orders;
select count(*) from products;

select name
from products as p1;

select p1.name,
     (
        select count(*)
        from orders as o1
        where o1.product_id = p1.id
    ) as num_orders
from products as p1;