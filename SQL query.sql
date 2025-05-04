-- creating a database
create database ecom;
# imported data  from website tables are customers_large.csv (100 rows),products_large.csv,orders_large.csv,order_items_large.csv
use ecom;
# 1. Get the names and emails of customers from "Jenniferfort".
SELECT name, email, signup_date
FROM customers_large
WHERE city = 'Jenniferfort';

# Q2. Get the top 10 most expensive orders.
SELECT order_id, total_amount
FROM orders_large
ORDER BY total_amount DESC
LIMIT 10;

# Q3. Number of customers grouped by city.
SELECT city, COUNT(*) AS customer_count
FROM customers_large
GROUP BY city
ORDER BY customer_count DESC;

#Q4. Order details including customer name:
SELECT o.order_id, o.order_date, o.total_amount, c.name
FROM orders_large o
INNER JOIN customers_large c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC
LIMIT 20;

#Q5. Product list with number of times each product was ordered (guaranteed since products were used):

SELECT p.name, COUNT(oi.order_item_id) AS times_ordered
FROM products_large p
LEFT JOIN order_items_large oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY times_ordered DESC;

#Q6. All customers, with or without orders:

SELECT c.customer_id, c.name, o.order_id
FROM customers_large c
LEFT JOIN orders_large o ON c.customer_id = o.customer_id
ORDER BY c.customer_id
LIMIT 50;

#Q7. Customers with orders above average total_amount:
SELECT name
FROM customers_large
WHERE customer_id IN (
    SELECT customer_id
    FROM orders_large
    WHERE total_amount > (
        SELECT AVG(total_amount)
        FROM orders_large
    )
);
# Q8. Products more expensive than average (prices between ₹3–₹50):
SELECT name, price
FROM products_large
WHERE price > (
    SELECT AVG(price)
    FROM products_large
);
# Q9. Total revenue from all orders (guaranteed values):
SELECT ROUND(SUM(total_amount), 2) AS total_revenue
FROM orders_large;
# Q10. Average quantity ordered for each product (ensured many orders):
SELECT product_id, AVG(quantity) AS avg_quantity
FROM order_items_large
GROUP BY product_id
ORDER BY avg_quantity DESC;








