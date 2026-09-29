-- Customers who spend more than the average
SELECT c.name, SUM(o.price * o.quantity) AS total_spend
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING total_spend > (
    SELECT AVG(price * quantity) FROM orders
)
ORDER BY total_spend DESC;

-- Average spend per city
SELECT city, ROUND(AVG(customer_total), 2) AS avg_customer_spend
FROM (
    SELECT c.city, c.id, SUM(o.price * o.quantity) AS customer_total
    FROM customers c
    JOIN orders o ON c.id = o.customer_id
    GROUP BY c.city, c.id
) AS customer_spends
GROUP BY city
ORDER BY avg_customer_spend DESC;

-- Customers who have ordered in the Electronics category
SELECT c.name, c.email
FROM customers c
WHERE EXISTS (
SELECT 1 FROM orders o 
WHERE o.customer_id = c.id 
AND o.category = "Electronics"
);

SELECT
c.name,
c.city,
COUNT(o.id) AS total_orders,
SUM(o.price * o.quantity) AS lifetime_value,
ROUND(AVG(o.price * o.quantity), 2) AS avg_order_value,
MIN(o.order_date) AS first_order,
MAX(o.order_date) AS last_order
FROM customers c
JOIN orders o on c.id = o.customer_id
GROUP BY c.id, c.name, c.city
ORDER BY lifetime_value DESC
LIMIT 10;

SELECT
    substr(order_date, 7, 4) || "-" || substr (order_date,4,2) AS month,
    COUNT(*) AS orders,
    SUM(price * quantity) AS revenue,
    ROUND(AVG(price * quantity), 2) AS avg_order
FROM orders
GROUP BY month
ORDER BY month;


/*From the analysis the top 3 customers are William Rodriguez($879.96), John Williams($758.00) and
 Jessica Thomas($519.96). These top three customers represent the highest individual lifetime value in the database, 
 spending far above the overall average customer spend across all cities(eg. LOndon average spend is $257.12). VIP 
 customers are votal for revenue stability, prioritizing them with exclusive loyalty rewards, targeted cross-selling or 
 premium support ensures hig retention and guards against customer churn.

The strongest period(On quarter 4) peaks towards the end of the year, with December
being the top revenue month($ 1468.40). It also boasts the highest average
basket size ($293.68/order).
The secondary spring hike is on quarter one and march is the second highest revenue month($1452.90)
with 7 orders.
Summer Slump during the months experience a significant slowdown ,hitting 
absolute lowest point in July($58.99 with total revenue, 2 orders, $29.50
average order).
Septemner had the highest order volume with 8 orders, but the lowest average order
value ($109.55). In contrast, December generated nearly double the revenue with only
5 orders due to the higher customer spend per transaction.

Electronics is the category with the highest aggregated revenue from the analysis. By allocating marketing budget and maintain higher
inventory reserves for top performing categories to  prevent stockouts, also
using product budling strategies to boost sales in lower-performing categories could
also help.

7 customers have never ordered out of 25 total registered customers, and 18 appreas only
in order history. In order to solve this problems first-purchase discount like launching
an automated email campaign targeting the 7 unengaged email addresses with a time-limited
welcome offer on their first order could be helpful. 
Showcasing top-rated bestsellers in email newsletters to reduce decision fatigue
for new customers and gathering a feedback from non-purchasers to idnetify
friction points(unexpected shipping costs or lack of pereferred paymment methods)

 */