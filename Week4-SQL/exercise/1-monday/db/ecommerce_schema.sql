-- Instructor reference — PostgreSQL. Adapt for other engines as needed.
-- One possible shape; trainees' designs may differ if they meet requirements.

BEGIN;

DROP TABLE IF EXISTS order_line CASCADE;
DROP TABLE IF EXISTS order_header CASCADE;
DROP TABLE IF EXISTS address CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS customer CASCADE;

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE address (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customer(id) ON DELETE CASCADE,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    label VARCHAR(50)
);

CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    stock_on_hand INT NOT NULL DEFAULT 0 CHECK (stock_on_hand >= 0)
);

CREATE TABLE order_header (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customer(id) ON DELETE RESTRICT,
    address_id INT NOT NULL REFERENCES address(id) ON DELETE RESTRICT,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) NOT NULL CHECK (status IN ('OPEN', 'PAID', 'SHIPPED', 'CANCELLED'))
);

CREATE TABLE order_line (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES order_header(id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES product(id) ON DELETE RESTRICT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

COMMIT;
