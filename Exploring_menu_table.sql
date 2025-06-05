# Number of Unique Items on Menu
select COUNT(distinct menu_item_id) from menu_items;

# Top 5 highest priced items
select item_name from menu_items order by price desc limit 5;

# Average price per category
select category, Concat('$', Round(avg(price),2)) as average_price from menu_items group by category;

# Cheapest Item in each category
select m1.category, m1.item_name, CONCAT('$',m1.price) as item_price from menu_items as m1 where m1.price = (select min(m2.price) from menu_items as m2 where m1.category = m2.category);

# Price Range Per Category
select category, min(price) as min_price, max(price) as max_price from menu_items group by category; 

