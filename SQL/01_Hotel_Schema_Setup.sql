-- 01_Hotel_Schema_Setup.sql
-- Hotel Management System - Schema Setup AND Data Insertion

-- 1. Create 'users' table
CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- 2. Create 'bookings' table
CREATE TABLE IF NOT EXISTS bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 3. Create 'items' table
CREATE TABLE IF NOT EXISTS items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10, 2)
);

-- 4. Create 'booking_commercials' table
CREATE TABLE IF NOT EXISTS booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Note: The exact syntax of 'IF NOT EXISTS' may vary slightly depending on the specific SQL engine (MySQL/PostgreSQL/SQLite).
-- Assuming standard MySQL / PostgreSQL SQL compliance.

-- Data Insertion (Sample Data provided in assignment)

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe', '97XXXXXXXX', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('user-2', 'Jane Smith', '98XXXXXXXX', 'jane.s@example.com', 'YY, Street Z, DEF City');

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o', '2021-09-23 08:00:00', 'rm-349f-xcnv', 'user-2'),
('bk-nov-1', '2021-11-05 10:00:00', 'rm-101', '21wrcxuy-67erfn'),
('bk-nov-2', '2021-11-15 14:30:00', 'rm-102', 'user-2'),
('bk-oct-1', '2021-10-10 09:00:00', 'rm-201', '21wrcxuy-67erfn');

INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu', 'Tawa Paratha', 18.00),
('itm-a07vh-aer8', 'Mix Veg', 89.00),
('itm-w978-23u4', 'Special Item', 200.00),
('itm-high-value', 'Luxury Spa', 1500.00);

-- Insert into booking_commercials
-- Including some examples in November for Q2, and October with bill > 1000 for Q3
INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-w978-23u4', 0.5),

-- November (Q2)
('bc-nov-1', 'bk-nov-1', 'bl-nov-1', '2021-11-05 12:00:00', 'itm-a07vh-aer8', 2),
('bc-nov-2', 'bk-nov-2', 'bl-nov-2', '2021-11-16 10:00:00', 'itm-a9e8-q8fu', 5),

-- October Bills (Q3) - Total > 1000
('bc-oct-1', 'bk-oct-1', 'bl-oct-1', '2021-10-11 11:00:00', 'itm-high-value', 1);
