BEGIN;

-- Customers
INSERT INTO customer (email, phone) VALUES
    ('aly@gmail.com', '555-0101'),
    ('audy@gmail.com', '555-0102');

-- Addresses
INSERT INTO address (customer_id, street, city, state, zip, label) VALUES
    (1, '123 Maple St', 'Charlotte', 'NC', '28202', 'home'),
    (2, '456 Oak Ave', 'Raleigh', 'NC', '27601', 'home');

-- Products 
INSERT INTO product (sku, name, price, stock_on_hand) VALUES
    ('SKU-001', 'Wireless Mouse', 19.99, 100),
    ('SKU-002', 'Mechanical Keyboard', 79.99, 50),
    ('SKU-003', 'USB-C Hub', 34.99, 75);

-- Orders
INSERT INTO order_header (customer_id, address_id, status) VALUES
    (1, 1, 'OPEN'),
    (2, 2, 'PAID');

-- Multiple order lines per order (at least one order with ≥2 lines)
INSERT INTO order_line (order_id, product_id, quantity, unit_price) VALUES
    (1, 1, 2, 19.99),   -- order 1: 2x mouse
    (1, 2, 1, 79.99),   -- order 1: 1x keyboard
    (2, 3, 3, 34.99);   -- order 2: 3x hub

COMMIT;

-- ============================================
-- Price change AFTER an order exists
-- Proves historical order_line prices don't retroactively change
-- ============================================
UPDATE product
SET price = 24.99
WHERE sku = 'SKU-001';

-- Verify: should still show 19.99 (what was actually charged), not 24.99
SELECT ol.unit_price AS price_customer_paid, p.price AS current_product_price
FROM order_line ol
JOIN product p ON p.id = ol.product_id
WHERE p.sku = 'SKU-001';

-- ============================================
-- Guarded single-row cancel
-- WHERE narrows this to exactly one logical row
-- ============================================
UPDATE order_header
SET status = 'CANCELLED'
WHERE id = 1 AND status = 'OPEN';

-- ============================================
-- TEST 1: Full order detail — join across all 5 tables
-- ============================================
SELECT
    c.email,
    o.id AS order_id,
    o.status,
    a.city AS ship_to_city,
    p.name AS product_name,
    ol.quantity,
    ol.unit_price,
    (ol.quantity * ol.unit_price) AS line_total
FROM order_header o
JOIN customer c ON c.id = o.customer_id
JOIN address a ON a.id = o.address_id
JOIN order_line ol ON ol.order_id = o.id
JOIN product p ON p.id = ol.product_id
ORDER BY o.id, ol.id;

-- ============================================
-- TEST 2: Order totals (aggregate check)
-- ============================================
SELECT
    o.id AS order_id,
    c.email,
    COUNT(ol.id) AS line_count,
    SUM(ol.quantity * ol.unit_price) AS order_total
FROM order_header o
JOIN customer c ON c.id = o.customer_id
JOIN order_line ol ON ol.order_id = o.id
GROUP BY o.id, c.email
ORDER BY o.id;
