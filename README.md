
# Blinkit E-Commerce Database Schema

This repository contains the ERD (Entity Relationship Diagram) and SQL schema for Blinkit, an e-commerce platform. The schema is designed to efficiently handle user data, orders, products, vendors, payments, reviews, and delivery processes.

## Features:
* Users: Represents customers placing orders.
* Orders: Tracks order details and their statuses.
* Products: Details products available for sale.
* Vendors: Suppliers providing the products.
* Delivery Partners: Manages delivery personnel and their orders.
* Payments: Handles transaction data for orders.
* Coupons: Represents discounts applied to orders.
* Reviews: Captures user feedback on orders.

## Relationships
* One user can place multiple orders.
* Each order has one delivery partner and one payment record.
* Multiple products can belong to one order (via the Order_Product table).
* Vendors supply multiple products.
* Users can review multiple orders.
* Each order can use one coupon for discounts.

## How to Use
* Clone the repository.
* Run the SQL scripts to create tables and insert sample data.
* Visualize the ERD for understanding the database relationships.

## Contributing
Feel free to open issues and pull requests for improvements.
