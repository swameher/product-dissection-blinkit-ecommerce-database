-- 1. USER TABLE

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Users (name, email, phone_number, address) VALUES
('Alice Johnson', 'alice@example.com', '9876543210', '123 Park Street, Delhi'),
('Bob Smith', 'bob@example.com', '8765432109', '45 Main Road, Mumbai'),
('Charlie Brown', 'charlie@example.com', '7654321098', '67 High Street, Pune'),
('David White', 'david@example.com', '6543210987', '89 Elm Road, Chennai'),
('Ella Green', 'ella@example.com', '5432109876', '101 Oak Street, Bangalore'),
('Fiona Black', 'fiona@example.com', '4321098765', '121 Willow Lane, Kolkata');

-- 2. ORDER TABLE :: Linked with Coupon and Delivery Partner

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    total_amount DECIMAL(10, 2),
    delivery_partner_id INT REFERENCES Delivery_Partner(delivery_partner_id),
    coupon_id INT REFERENCES Coupon(coupon_id)
);

INSERT INTO Orders (user_id, order_date, status, total_amount, delivery_partner_id, coupon_id) VALUES
(1, '2024-12-20 10:30:00', 'Delivered', 250.00, 1, 1),
(2, '2024-12-20 11:00:00', 'Pending', 150.00, 2, 2),
(3, '2024-12-21 09:00:00', 'In Progress', 300.00, 3, NULL),
(4, '2024-12-21 12:00:00', 'Cancelled', 120.00, NULL, NULL),
(5, '2024-12-22 14:30:00', 'Delivered', 400.00, 4, 3),
(6, '2024-12-23 16:00:00', 'Pending', 200.00, 5, 4);

-- 3. PRODUCT TABLE :: Linked with Vendor

CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock INT,
    vendor_id INT REFERENCES Vendor(vendor_id)
);

INSERT INTO Product (name, category, price, stock, vendor_id) VALUES
('Rice', 'Groceries', 50.00, 100, 1),
('Milk', 'Dairy', 25.00, 200, 2),
('Bread', 'Bakery', 40.00, 150, 3),
('Eggs', 'Dairy', 60.00, 180, 2),
('Butter', 'Dairy', 45.00, 100, 2),
('Tomato', 'Vegetables', 30.00, 120, 4);


-- 4. VENDOR TABLE

CREATE TABLE Vendor (
    vendor_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    contact_info TEXT,
    location TEXT
);

INSERT INTO Vendor (name, contact_info, location) VALUES
('Best Grocers', '9876543210', 'Delhi'),
('Fresh Dairy', '8765432109', 'Mumbai'),
('Bakery House', '7654321098', 'Pune'),
('Veggie Delight', '6543210987', 'Chennai'),
('Spices Hub', '5432109876', 'Bangalore'),
('Frozen Foods Co.', '4321098765', 'Kolkata');

-- 5. DELIVERY PARTNER TABLE

CREATE TABLE Delivery_Partner (
    delivery_partner_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    vehicle_type VARCHAR(20)
);

INSERT INTO Delivery_Partner (name, phone_number, vehicle_type) VALUES
('Ramesh Kumar', '9876543210', 'Bike'),
('Suresh Singh', '8765432109', 'Scooty'),
('Anjali Sharma', '7654321098', 'Cycle'),
('Priya Verma', '6543210987', 'Car'),
('Rahul Gupta', '5432109876', 'Bike'),
('Amit Jain', '4321098765', 'Scooty');


-- 6. PAYMENT TABLE

CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES Orders(order_id),
    payment_method VARCHAR(20),
    payment_status VARCHAR(20),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Payment (order_id, payment_method, payment_status, payment_date) VALUES
(1, 'UPI', 'Success', '2024-12-20 10:40:00'),
(2, 'Credit Card', 'Pending', '2024-12-20 11:10:00'),
(3, 'Debit Card', 'Success', '2024-12-21 09:20:00'),
(4, 'Cash', 'Cancelled', '2024-12-21 12:10:00'),
(5, 'UPI', 'Success', '2024-12-22 14:40:00'),
(6, 'Wallet', 'Pending', '2024-12-23 16:20:00');


-- 7. REVIEW TABLE

CREATE TABLE Review (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    order_id INT REFERENCES Orders(order_id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT
);

INSERT INTO Review (user_id, order_id, rating, comment) VALUES
(1, 1, 5, 'Excellent service!'),
(2, 2, 4, 'Good delivery speed.'),
(3, 3, 3, 'Average experience.'),
(4, 4, 1, 'Order was cancelled.'),
(5, 5, 5, 'Perfectly delivered!'),
(6, 6, 4, 'Great products.');


-- 8. ORDER PRODUCT TABLE

CREATE TABLE Order_Product (
    order_product_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES Orders(order_id),
    product_id INT REFERENCES Product(product_id),
    quantity INT,
    sub_total DECIMAL(10, 2)
);

INSERT INTO Order_Product (order_id, product_id, quantity, sub_total) VALUES
(1, 1, 2, 100.00),
(2, 2, 1, 25.00),
(3, 3, 3, 120.00),
(4, 4, 1, 50.00),
(5, 5, 4, 60.00),
(6, 6, 5, 90.00);


-- 9. COUPON TABLE

CREATE TABLE Coupon (
    coupon_id SERIAL PRIMARY KEY,
    code VARCHAR(20),
    discount_percentage INT,
    valid_from DATE,
    valid_until DATE
);

INSERT INTO Coupon (code, discount_percentage, valid_from, valid_until) VALUES
('SAVE10', 10, '2024-12-01', '2024-12-31'),
('FIRST50', 50, '2024-12-01', '2024-12-15'),
('FREESHIP', 100, '2024-12-01', '2024-12-31'),
('WELCOME20', 20, '2024-12-01', '2024-12-31'),
('WINTER25', 25, '2024-12-01', '2024-12-31'),
('HOLIDAY30', 30, '2024-12-01', '2024-12-31');

-- Junction Table for Coupon ↔ User (Many-to-Many)
CREATE TABLE User_Coupon (
    user_coupon_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    coupon_id INT REFERENCES Coupon(coupon_id),
    usage_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Users and Coupons into the Many-to-Many Junction Table
INSERT INTO User_Coupon (user_id, coupon_id, usage_date) VALUES
(1, 1, '2024-12-20 12:30:00'),
(2, 2, '2024-12-21 15:00:00'),
(1, 3, '2024-12-22 10:45:00');

-- Updated ORDERS TABLE to include Coupon Reference
ALTER TABLE Orders
ADD COLUMN coupon_id INT REFERENCES Coupon(coupon_id);

-- Link Coupons to Orders
UPDATE Orders
SET coupon_id = 1
WHERE order_id = 1;

UPDATE Orders
SET coupon_id = 2
WHERE order_id = 2;
