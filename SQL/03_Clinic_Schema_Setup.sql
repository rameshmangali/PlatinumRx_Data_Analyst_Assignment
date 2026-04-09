-- 03_Clinic_Schema_Setup.sql
-- Clinic Management System - Schema Setup AND Data Insertion

-- 1. Create 'clinics' table
CREATE TABLE IF NOT EXISTS clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

-- 2. Create 'customer' table
CREATE TABLE IF NOT EXISTS customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

-- 3. Create 'clinic_sales' table (Revenue)
CREATE TABLE IF NOT EXISTS clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(12, 2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- 4. Create 'expenses' table
CREATE TABLE IF NOT EXISTS expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(12, 2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Data Insertion (Sample Data provided in assignment)

INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'XYZ clinic', 'lorem', 'ipsum', 'dolor'),
('cnc-02', 'ABC clinic', 'lorem', 'ipsum', 'dolor'),
('cnc-03', 'City Health', 'metro', 'state_A', 'dolor');

INSERT INTO customer (uid, name, mobile) VALUES
('bk-09f3e-95hj', 'Jon Doe', '97XXXXXXXX'),
('cust-02', 'Alice Green', '98XXXXXXXX');

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999.00, '2021-09-23 12:03:22', 'sodat'),
('ord-02', 'cust-02', 'cnc-0100001', 15000.00, '2021-09-24 10:00:00', 'online'),
('ord-03', 'bk-09f3e-95hj', 'cnc-02', 5000.00, '2021-10-15 09:30:00', 'walk-in'),
('ord-04', 'cust-02', 'cnc-03', 30000.00, '2021-10-16 11:00:00', 'online');

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies', 557.00, '2021-09-23 07:36:48'),
('exp-02', 'cnc-0100001', 'rent', 10000.00, '2021-09-01 00:00:00'),
('exp-03', 'cnc-02', 'utilities', 2000.00, '2021-10-05 08:00:00'),
('exp-04', 'cnc-03', 'salaries', 25000.00, '2021-10-28 09:00:00');
