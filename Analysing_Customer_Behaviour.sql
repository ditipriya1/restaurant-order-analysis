# Joining two tables
select * from menu_items inner join order_details on menu_items.menu_item_id = order_details.item_id;

# Total revenue generated
select concat('$', format(sum(price), 2)) as total_revenue from menu_items inner join order_details on menu_items.menu_item_id = order_details.item_id;

# Average Order Value (AOV)
select concat('$', round(sum(price) / count(distinct order_id), 2)) as average_order_value from menu_items inner join order_details on menu_items.menu_item_id = order_details.item_id;

# Top 10 frequently ordered items
select item_name, count(*) from menu_items inner join order_details on menu_items.menu_item_id = order_details.item_id group by item_name order by count(*) desc limit 10;

# Category_wise total revenue
select category, concat('$', format(round(sum(price)), 0)) as total_revenue from menu_items inner join order_details on menu_items.menu_item_id = order_details.item_id group by category;

# Top 5 orders that spent the most money
select order_id, concat('$', format(round(sum(price)), 0)) as total_spend from menu_items inner join order_details on menu_items.menu_item_id = order_details.item_id group by order_id order by sum(price) desc limit 5;

# Most and least ordered items in each category
WITH item_counts AS (
    SELECT 
        item_name,
        category,
        COUNT(order_details_id) AS num_of_purchases,
        RANK() OVER (PARTITION BY category ORDER BY COUNT(order_details_id) DESC) AS rank_high,
        RANK() OVER (PARTITION BY category ORDER BY COUNT(order_details_id) ASC) AS rank_low
    FROM order_details 
    LEFT JOIN menu_items 
    ON order_details.item_id = menu_items.menu_item_id 
    GROUP BY item_name, category
)
SELECT item_name, category, num_of_purchases, 'Most Ordered' AS type
FROM item_counts
WHERE rank_high = 1
UNION ALL
SELECT item_name, category, num_of_purchases, 'Least Ordered' AS type
FROM item_counts
WHERE rank_low = 1;
