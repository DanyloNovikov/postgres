select *
from products
order by price DESC
LIMIT 4;

select *
from products
order by price / weight desc
LIMIT 4;

-- union
-- что он делает ? он обьединяет два результат в 1 пример ниже:

(
    select *
    from products
    order by price DESC
    LIMIT 4
)
UNION
(
    select *
from products
order by price / weight desc
LIMIT 4
);

-- если есть запись которая вернулась в первом запросе и во втором тогда она будет 1 а не две Unions вернет нам 1 строку
-- но мы может это предваритить предварительно написав union all что будет означать не удалять дубликант

(
    select *
    from products
    order by price DESC
    LIMIT 4
)
UNION ALL
(
    select *
from products
order by price / weight desc
LIMIT 4
);

-- юнион очень чуствительный к типу данных которых он обединяет

select name
from products
union
select price
from products;

-- ошибка соединения типов данных
-- UNION         ==> Join together the results of two queries and remove duplicate rows.
-- UNION ALL     ==> Join together results of two quesries.
-- INTERSECT     ==> Find the rows common in the results of two queries. Remove dublicates.
-- INTERSECT ALL ==> Find the rows common in the results of two queries.
-- EXPECT        ==> Find the rows that are present in first query but not second query. Remove duplicates.
-- EXPECT ALL    ==> Find the rows that are present in first query but not second query.

(
    SELECT *
    FROM products
    ORDER BY price DESC
    LIMIT 4
)
INTERSECT ALL
(
    SELECT *
    FROM products
    ORDER BY (price / weight) DESC
    LIMIT 4
);

-- Intersect вывод одинаковые стороки которые нашлись в первом и во втором запросе
-- EXPECT -- возвращает уникальные значение только с левой строны он найдет значения которые были в левом и правом
-- вычеркнет те что совпадали со значениями справа и возвращает значения слева.

(
    SELECT *
    FROM products
    ORDER BY price DESC
    LIMIT 4
)
EXCEPT
(
    SELECT *
    FROM products
    ORDER BY price / weight DESC
    LIMIT 4
);