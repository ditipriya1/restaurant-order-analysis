# Total number of orders placed
select count(order_id) as number_of_orders from order_details;

# Total quantity of items sold
select count(item_id) as quantity_sold from order_details;

# Orders by Day of week
select dayname(order_date) as order_day, count(order_id) as number_of_orders from order_details group by dayname(order_date) order by count(order_id) desc;

#sorting the days of week
SELECT 
  order_day,
  CASE 
    WHEN order_day = 'Monday' THEN 1
    WHEN order_day = 'Tuesday' THEN 2
    WHEN order_day = 'Wednesday' THEN 3
    WHEN order_day = 'Thursday' THEN 4
    WHEN order_day = 'Friday' THEN 5
    WHEN order_day = 'Saturday' THEN 6
    WHEN order_day = 'Sunday' THEN 7
  END AS day_sort,
  number_of_orders
FROM (
  SELECT 
    DAYNAME(order_date) AS order_day,
    COUNT(order_id) AS number_of_orders
  FROM order_details
  GROUP BY DAYNAME(order_date)
) AS sub
ORDER BY day_sort;


#Orders by time of day
select
case
	when hour(order_time) >= 5 and hour(order_time) < 12 then 'Morning'
	when hour(order_time) >= 12 and hour(order_time) < 17 then 'Afternoon'
	when hour(order_time) >= 17 and hour(order_time) < 19 then 'Evening'
	else 'Night'
end as 'Time_of_day',
count(order_id) as total_orders
from order_details
group by
case
	when hour(order_time) >= 5 and hour(order_time) < 12 then 'Morning'
	when hour(order_time) >= 12 and hour(order_time) < 17 then 'Afternoon'
	when hour(order_time) >= 17 and hour(order_time) < 19 then 'Evening'
	else 'Night'
end
order by total_orders desc;

# Month_wise Orders placed
select MONTHNAME(order_date) as month_name, count(order_id) as orders_placed from order_details group by MONTHNAME(order_date);

# Fixing sorting order of orders by month
SELECT 
  month_name,
  month_sort,
  number_of_orders
FROM (
  SELECT 
    MONTHNAME(order_date) AS month_name,
    MONTH(order_date) AS month_sort,
    COUNT(order_id) AS number_of_orders
  FROM order_details
  GROUP BY MONTH(order_date), MONTHNAME(order_date)
) AS sub
ORDER BY month_sort;


