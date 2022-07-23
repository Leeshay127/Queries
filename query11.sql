with cte_id_categorys as
(
select pc.categoryname as category
, pp.ProductID as productID
, pp.ProductCost as cost
from production.categories pc join production.SubCategories ps on pc.CategoryID = ps.CategoryID
join production.Products pp on pp.SubcategoryID= ps.SubcategoryID
)

SELECT c.category, round(sum(c.cost*s.orderquantity), 0) as quantity
from  cte_id_categorys c join sales.sales s on c.productid=s.ProductID
GROUP by c.category


-- : *במחלקת השיווק פיתחו קמפיין חדש למוצרי 
-- הביגוד של החברה ומעוניינים לדעת מתי הזמן הטוב ביותר בשנה להשיק אותו. 
-- הם מעוניינים לדעת מהו החודש החלש ביותר בשנה מבחינת 
-- מספר ההזמנות הנכנסות וסך כל היחידות שנמכרו (האם מדובר באותו החודש?)

--units sold by category
with cte_id_categorys as
(
select pc.categoryname as category
, pp.ProductID as productID
from production.categories pc join production.SubCategories ps on pc.CategoryID = ps.CategoryID
join production.Products pp on pp.SubcategoryID= ps.SubcategoryID
)

SELECT month(s.OrderDate) as 'monthi'
, count(distinct s.ordernumber) as 'order made'
, sum(s.OrderQuantity) as 'units sold' 
from sales.sales s join cte_id_categorys c on s.ProductID = c.productid
WHERE c.category = 'Clothing'
GROUP by month(OrderDate) 
order by 1


-- order by month by category-
with cte_id_categorys as
(
select pc.categoryname as category
, pp.ProductID as productID
from production.categories pc join production.SubCategories ps on pc.CategoryID = ps.CategoryID
join production.Products pp on pp.SubcategoryID= ps.SubcategoryID
)

SELECT month(s.OrderDate) as 'monthi'
,  c.category
, count(distinct s.ordernumber) as 'order made'
, sum(s.OrderQuantity) as 'units sold' 
from sales.sales s join cte_id_categorys c on s.ProductID = c.productid
GROUP by month(s.OrderDate) ,c.category
order by 2, 1


--retun percent
SELECT s.productid
, s.units_sold
, r.units_returned
, (r.units_returned*1.0/s.units_sold) as percentil_returns
from sold_by_id s 
left join RETURN_by_id r on s.productid = r.productid
select count(*) as not_in_stock
from production.stocks 
where unitsinstock = 0

--in stock
select count(*) as stock_stores
from production.stocks 
where unitsinstock <> 0

--products not in stock
select count(*) as stock_stores
from production.stocks 
where unitsinstock = 0

--stock on stores
select count(*) as total_stock_stores
from production.stocks



--not wright
select count(S.ProductID) as 'total products' , sum(P.ProductPrice-P.ProductCost) as
'NetProfit', s.OrderDate
from production.Products P join sales.sales S on p.ProductID=s.ProductID
group by s.OrderDate
order BY 'netprofit' DESC--not a good conection

--net profit by year
with sold_per_year AS
(
SELECT productid
, sum(orderquantity) as quantity_sold
,year(orderdate) as year
from sales.sales
group by productid
,year(orderdate)
)

SELECT year
, sum(s.quantity_sold*p.ProductPrice) - 
sum(s.quantity_sold*p.productcost) as net_profit
from sold_per_year s
join production.products p on s.productid = p.productid
group by YEAR


--sold by year
with sold_per_year AS
(
SELECT productid
, sum(orderquantity) as quantity_sold
,year(orderdate) as year
from sales.sales
group by productid
,year(orderdate)
)

SELECT year
, sum(s.quantity_sold) AS sum_sold
from sold_per_year s
join production.products p on s.productid = p.productid
group by YEAR



-- custumer by country

SELECT top 10 *
from sales.customers

--sell by country
select st.StoreLocation
, sum(sa.orderquantity) as quantity_sold
from sales.sales sa
join sales.stores st on sa.storeid = st.storeid
group by st.StoreLocation
order by 2 desc

--products not in stock in store 6 slide 9
select *
from production.Stocks
where StoreID= 6
and UnitsInStock = 0

--store country
select distinct storelocation
from sales.Stores

--distinct storeid
select distinct storeid
from sales.Stores

--first open store
select top 1 *
from sales.Stores
order by YearOpened

--workers
select count(staffmemberid) as workers
from sales.Staff

--products not in stock
select storeid
, count(productid) as not_in_stock
from production.Stocks
where UnitsInStock = 0
group by StoreID

--stores in france
select storeid
from sales.stores
where lower(storelocation) = 'france'

