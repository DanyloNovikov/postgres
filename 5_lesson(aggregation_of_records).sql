
-- Grouping
-- Reduces many rows down to fewer rows
-- Done by using the 'GROUP BY' keyword
-- Visualizing the result is key to use

-- Aggregates
-- Reduces many values down to one
-- Done by using 'aggregate functions'

-- Возможно тупо что на не на английском но это нужно описать как можно подробнее
-- как работает group_by он работает следующим образом:
-- 1. во первых фуункционал из названия он групирует елементы по заданному елементу

select user_id
from comments
group by user_id;

-- конкретно в этом примере у нас есть коментарии у которых есть связь с таблицей user через user_id
-- мы групирует наши записи в таблице comment по user наши записи буду отсортированный по пользователям
-- но если мы укажем * то словим ошибку с 'агрегацией' ;

select *
from comments
group by contents;

-- что значит aggregate function ? давай посмотрим прямо сейчас.
-- Функции агрегата возвращают какое-то подсчитаное значение

-- count() ==> return the number of value in a group of value.
-- sum()   ==> finds the sum of a group of numbers.
-- avg()   ==> finds the average of a group of numbers.
-- min()   ==> returns the minimum value from a group of numbers.
-- max()   ==> returns the maximum value from a group of numbers.

select max(id)
from comments;

-- Combining group by and aggregate;

select user_id
from comments
group by user_id;

-- почему это отдельная тема использования функций агрегации и group by вместе ? потому что эти функции будут
-- будет применяться индивидуально к каждой группе;

select user_id, count(id)
from comments
group by user_id;

-- всего 5 груп потому что мы сгрупироали по юзерам а всего 5 юзеров и указали что в каждой группе нам нужен
-- максимальный id

-- remember all keywords
-- from     ==> specifies starting set of rows to work with;
-- join     ==> merges in data from additional table;
-- where    ==> filters the set of rows;
-- group by ==> groups rows by a unique set of values;
-- having   ==> filters the set of groups;

-- having своеобразный фильтр для фильтрации(выборки данных) только он используеться для выборки груп
-- мы никогда не встратим having без group by.

select photos_id, count(*)
from comments
where photos_id < 3
group by photos_id
having count(*) > 2;

select user_id, count(photos_id)
from comments
where photos_id > 2
group by user_id
having count(photos_id) > 11;

