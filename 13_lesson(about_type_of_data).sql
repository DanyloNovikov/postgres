-- Data type
-- 1. Numbers
-- 2. Date/Time
-- 3. Geometric
-- 4. Boolean
-- 5. Currency
-- 6. Character
-- 7. Range
-- 8. XML
-- 9. Binary
-- 10. JSON
-- 11. Arrays
-- 12. UUID

-- Numeric Types Fast Rules
-- 'Id' column of any table.                               --> Mark the column as SERIAL.
-- Need to store a number without a decimal.               --> Mark the column as INTEGER.
-- Bank balance, grams of gold, scientific calculations.   --> Need to store a number with a decimal and this data needs
-- To be very accurate.                                    --> Mark the column as NUMBER.
-- Kilograms of trash in a landfill, liters of watter in a lake, air pressure in a tire. --> Need to store a number with.
-- a decimal and the decimal doesn`t make a big difference. --> Mark the column as DOUBLE PRECISION.

-- https://postgrespro.ru/docs/postgresql/9.6/datatype-numeric
SELECT (2);          -- Type integer.
SELECT (2.0);        -- Type numeric.
SELECT (2::INTEGER); -- Type integer.

SELECT (2::SMALLINT); -- Type small integer -32768 to +32767.
SELECT (2::INTEGER);  -- Type simple integer -2147583648 to +2147583647.
SELECT (2::BIGINT);   -- Type big integer -9223372036854775808 to +9223372036854775807.

SELECT (1.9999::REAL - 1.9998::REAL); -- Accuracy within 6 decimal digits.
SELECT (2.21321321312);               -- Accuracy within 15 decimal digits.

SELECT (2.11110::DECIMAL);            -- 131072 digits before decimal point, 16383 after
SELECT (2.11110::NUMERIC);            -- 131072 digits before decimal point, 16383 after

-- SELECT (2::SMALLSERIAL); -- 1 .. 32767
-- SELECT (2::SERIAL);      -- 1 .. 2147483647
-- SELECT (2::BIGSERIAL);   -- 1 .. 9223372036854775807

-- Character types
-- CHAR(8)     --> Store some characters, length with always be 8 even if PG has to insert spaces.
-- VARCHAR     --> Store any length of string.
-- VARCHAR(40) --> Store a string up to 40 characters, authomatically remove extra characters.
-- TEXT        --> Store any length of string.

SELECT ('alaskaisabeststate'::VARCHAR(5)); -- Very interesting result.

-- Boolean types
-- true, yes, on, 1, t, y --> true
-- false, no, off, 0, f, n --> false
-- null --> NULL

-- Example:
SELECT('yes'::BOOLEAN);
SELECT(0::BOOLEAN);

-- DATE type ()
-- 1980-11-20        --> 20 November 1980
-- Nov-20-1980       --> 20 November 1980
-- 20-Nov-1980       --> 20 November 1980
-- 1980-November-20  --> 20 November 1980
-- November 20, 1980 --> 20 November 1980

-- Example:
SELECT ('NOV 20, 1980'::DATE);
SELECT ('1980 NOV 20'::DATE);

-- TIME type
-- 01:23 AM --> 01:23 no time zone
-- 05:23 PM --> 17:23 no time zone
-- 20:34    --> 20:34 no time zone

SELECT ('01:23 PM'::TIME WITHOUT TIME ZONE);
SELECT ('01:23:23 AM EST'::TIME WITH TIME ZONE);

-- INTERVAL type
-- 1 day       --> 1 day
-- 1 D         --> 1 day
-- 1 D 1 M 1 S --> 1 day 1 minute 1 second

SELECT ('1 d 1 h 30 m 45 s'::INTERVAL) - ('1 d'::INTERVAL);
