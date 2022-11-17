select greatest(20, 10, 30);
-- Эта специальный оператор который проверяет то что выбраное значение больше
-- указаного если нет но оно будет меня значения на свое

-- example
select name, price, greatest(30, 2 * weight)
from products;

-- есть аналогичная фунция для меньших значений
-- example
select least(1000, 20, 50, 100);

select name, price, least(price * 0.5, 300)
from products;

-- how to use case
SELECT
    name,
    price,
    CASE
        WHEN price > 600 then 'high'
        WHEN price > 300 then 'medium'
        ELSE 'cheap'
    END
FROM products;

