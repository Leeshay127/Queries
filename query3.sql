-- מנהל השיווק מעוניין לדעת כמה יחידות נמכרו סך הכל במחצית השנייה של 2016,
--  וכמה הזמנות שונות התבצעו בתקופה זו.


SELECT  sum(OrderQuantity) as 'total_units_sold'
, count(distinct OrderNumber) as 'distinct_orders'
from sales.Sales
where year(OrderDate) = 2017 


-- product most sold

SELECT p.ProductName
, sum(s.OrderQuantity) as 'total_units_sold'
from sales.Sales s 
join production.products p on s.productid = p.productid
group by p.ProductName
order by 2 desc

--for fun, would add average units per order

SELECT sum(OrderQuantity) as 'total_units_sold'
, count (distinct OrderNumber) as 'distinct_orders'
,round (avg (OrderQuantity*1.0), 2) as 'average_units_sold'
from sales.Sales
where  year(OrderDate) = 2017 


--by season/6months
--could also do a case when
SELECT 'first half 2015' as 'period'
, sum(OrderQuantity) as 'total_units_sold'
, count(distinct OrderNumber) as 'distinct_orders'
from sales.Sales
where OrderDate BETWEEN '2015-01-01' and '2015-07-01'

UNION

SELECT 'second half 2015' as 'period'
, sum(OrderQuantity) as 'total_units_sold'
, count(distinct OrderNumber) as 'distinct_orders'
from sales.Sales
where OrderDate BETWEEN '2015-07-01' and '2015-12-31'

UNION

SELECT 'first half 2016'
, sum(OrderQuantity) as 'total_units_sold'
, count(distinct OrderNumber) as 'distinct_orders'
from sales.Sales
where OrderDate BETWEEN '2016-01-01' and '2016-07-01'

union 

SELECT 'second half 2016' as 'period'
, sum(OrderQuantity) as 'total_units_sold'
, count(distinct OrderNumber) as 'distinct_orders'
from sales.Sales
where OrderDate BETWEEN '2016-07-01' and '2016-12-31'


UNION

SELECT 'first half 2017'
, sum(OrderQuantity) as 'total_units_sold'
, count(distinct OrderNumber) as 'distinct_orders'
from sales.Sales
where OrderDate BETWEEN '2017-01-01' and '2017-07-01'

--category by season
--used a view that we created id_category_name
SELECT 'first half 2015' as 'period'
, i.category
, sum (s.orderquantity) as 'quantity_sold'
from sales.sales s
join id_category_name i on i.ProductID = s.ProductID
where s.OrderDate BETWEEN '2015-01-01' and '2015-07-01'
group by i.category

UNION

SELECT 'first half 2016' as 'period'
, i.category
, sum (s.orderquantity) as 'quantity_sold'
from sales.sales s
join id_category_name i on i.ProductID = s.ProductID
where s.OrderDate BETWEEN '2016-01-01' and '2016-07-01'
group by i.category

UNION
SELECT 'first half 2017' as 'period'
, i.category
, sum (s.orderquantity) as 'quantity_sold'
from sales.sales s
join id_category_name i on i.ProductID = s.ProductID
where s.OrderDate BETWEEN '2017-01-01' and '2017-07-01'
group by i.category

--category by year
--used a view that we created id_category_name
SELECT '2015' as 'period'
, i.category
, sum (s.orderquantity) as 'quantity_sold'
from sales.sales s
join id_category_name i on i.ProductID = s.ProductID
where year(s.OrderDate) = 2015
group by i.category

UNION

SELECT '2016' as 'period'
, i.category
, sum (s.orderquantity) as 'quantity_sold'
from sales.sales s
join id_category_name i on i.ProductID = s.ProductID
where year(s.OrderDate) = 2016
group by i.category

UNION
SELECT '2017' as 'period'
, i.category
, sum (s.orderquantity) as 'quantity_sold'
from sales.sales s
join id_category_name i on i.ProductID = s.ProductID
where year(s.OrderDate) = 2017
group by i.category


--sold by category
SELECT 'first half 2015' as 'period'
, sum (orderquantity) as 'quantity_sold'
from sales.sales 
where OrderDate BETWEEN '2015-01-01' and '2015-07-01'

union 
SELECT 'first half 2016' as 'period'
, sum (orderquantity) as 'quantity_sold'
from sales.sales 
where OrderDate BETWEEN '2016-01-01' and '2016-07-01'

union
SELECT 'first half 2017' as 'period'
, sum (orderquantity) as 'quantity_sold'
from sales.sales 
where OrderDate BETWEEN '2017-01-01' and '2017-07-01'


select distinct(i.category)
from sales.sales s join id_category_name i on s.ProductID=i.productID
where i.category = 'components'
