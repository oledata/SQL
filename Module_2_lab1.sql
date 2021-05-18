select * from orders
limit 10

select distinct ship_mode from public.orders

select ship_mode, count (distinct order_id) as number_orders from public.orders
group by ship_mode 

select city, count (distinct order_id) as number_orders, sum(sales) as revenue 
from public.orders o 
where category in ('Furniture', 'Technology')
group by 1
having sum(sales) >10000
order by revenue desc;
--9,994 rows

/*select distinct category from orders o ;*/
 
select count(*), count (distinct o.order_id) from orders o inner join returns r on o.order_id=r.order_id ;
--inner 3,226, count 296
select count(*), count (distinct o.order_id) from orders o left join returns r on o.order_id=r.order_id ;
--left 12,420, count 5,009

select count(*), count (distinct o.order_id) from orders o 
where order_id in (select distinct order_id from returns)
--count 800, count 296

select now() --timestamp
select date_trunc('day',now())

select city, count (distinct order_id) as number_orders, sum(sales) as revenue 
from public.orders o 
where category in ('Furniture', 'Technology')
and extract ('year' from order_date) =2018
group by 1
having sum(sales) >10000
order by revenue desc;