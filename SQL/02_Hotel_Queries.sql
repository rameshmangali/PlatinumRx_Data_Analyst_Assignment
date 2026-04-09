-- 02_Hotel_Queries.sql
-- Hotel Management System - Queries for Part A
-- Modified to be fully compatible with MySQL 5.7 (Without using CTEs or Window Functions)

-- 1. For every user in the system, get the user_id and last booked room_no
SELECT b1.user_id, b1.room_no AS last_booked_room_no
FROM bookings b1
JOIN (
    SELECT user_id, MAX(booking_date) AS max_date
    FROM bookings
    GROUP BY user_id
) b2 ON b1.user_id = b2.user_id AND b1.booking_date = b2.max_date;

-- 2. Get booking_id and total billing amount of every booking created in November, 2021
SELECT 
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE EXTRACT(MONTH FROM b.booking_date) = 11 AND EXTRACT(YEAR FROM b.booking_date) = 2021
GROUP BY b.booking_id;

-- 3. Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount > 1000
SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE EXTRACT(MONTH FROM bc.bill_date) = 10 AND EXTRACT(YEAR FROM bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-- 4. Determine the most ordered and least ordered item of each month of year 2021
SELECT 
    t_main.bill_month,
    (SELECT item_id 
     FROM booking_commercials 
     WHERE EXTRACT(YEAR FROM bill_date) = 2021 AND EXTRACT(MONTH FROM bill_date) = t_main.bill_month
     GROUP BY item_id 
     ORDER BY SUM(item_quantity) DESC LIMIT 1) AS most_ordered_item_id,
    (SELECT item_id 
     FROM booking_commercials 
     WHERE EXTRACT(YEAR FROM bill_date) = 2021 AND EXTRACT(MONTH FROM bill_date) = t_main.bill_month
     GROUP BY item_id 
     ORDER BY SUM(item_quantity) ASC LIMIT 1) AS least_ordered_item_id
FROM (
    SELECT DISTINCT EXTRACT(MONTH FROM bill_date) AS bill_month 
    FROM booking_commercials 
    WHERE EXTRACT(YEAR FROM bill_date) = 2021
) t_main;

-- 5. Find the customers with the second highest bill value of each month of year 2021
SELECT 
    main_bills.bill_month, 
    main_bills.user_id, 
    main_bills.total_bill_value
FROM (
    SELECT 
        EXTRACT(MONTH FROM bc.bill_date) as bill_month,
        b.user_id,
        SUM(bc.item_quantity * i.item_rate) AS total_bill_value
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE EXTRACT(YEAR FROM bc.bill_date) = 2021
    GROUP BY EXTRACT(MONTH FROM bc.bill_date), b.user_id, bc.bill_id
) main_bills
WHERE (
    SELECT COUNT(DISTINCT sub_bills.total_bill_value)
    FROM (
        SELECT 
            EXTRACT(MONTH FROM bc2.bill_date) as m2,
            SUM(bc2.item_quantity * i2.item_rate) AS total_bill_value
        FROM booking_commercials bc2
        JOIN items i2 ON bc2.item_id = i2.item_id
        WHERE EXTRACT(YEAR FROM bc2.bill_date) = 2021
        GROUP BY EXTRACT(MONTH FROM bc2.bill_date), bc2.bill_id
    ) sub_bills
    WHERE sub_bills.m2 = main_bills.bill_month 
      AND sub_bills.total_bill_value > main_bills.total_bill_value
) = 1;
