-- עדכנו את הדו"ח מהסעיף הקודם כך שיכלול רק מוצרים גדולים 
-- (L) או  מוצרים בצבעים 
-- ProfitMargin שחור, לבן, אדום. בנוסף, הוסיפו עמודה בשם 
-- אשר תציג את אחוז הרווח הנקי ביחס למחיר 
-- (עגלו את התוצאות לשתי ספרות אחרי הנקודה העשרונית


SELECT ProductName as 'Name'
, ModelName as 'Model'
, ProductColor + ',' + cast(ProductStyle as varchar) + ',' + cast(ProductSize as varchar) as 'Properties'
, ProductPrice as 'Price'
, (ProductPrice-ProductCost) as 'NetProfit'
, round((ProductPrice-ProductCost)/ProductPrice, 2) as 'ProfitMargin'
From Production.Products
WHERE ProductSize='L' 
OR ProductColor IN('Black','White', 'Red')

--whitout where, so we have a list from all the products
SELECT ProductName as 'Name'
, ModelName as 'Model'
, ProductColor + ',' + cast(ProductStyle as varchar) + ',' + cast(ProductSize as varchar) as 'Properties'
, ProductPrice as 'Price'
, (ProductPrice-ProductCost) as 'NetProfit'
, round((ProductPrice-ProductCost)/ProductPrice, 2) as 'ProfitMargin'
From Production.Products
order by  6 DESC

--for thee story on slide 9, produt w/ higher profit, not in stock
--344 345
select storeid, productid
from production.Stocks
where UnitsInStock = 0
and productid in (344 , 345, 346)

select *
from sales.Stores
where storelocation = 'France'

select*
from production.Products
where ProductID = 346

-- other products not in stock in fraמce, store 6
-- order by higher profit
select p.ProductName
, p.ProductPrice-p.ProductCost as net_profit
, i.category
, s.StoreID
from production.Stocks s
join production.products p on p.productid = s.ProductID
join id_category_name i on  p.productid = i.ProductID
where  s.UnitsInStock = 0
and s.StoreID in (6)
order by 2 desc

--net profit by seasonality

SELECT case
WHEN orderdate BETWEEN '2015-01-01' and '2015-07-01' THEN 'first half 2015'
WHEN orderdate BETWEEN '2016-01-01' and '2016-07-01' THEN 'first half 2016'
WHEN orderdate BETWEEN '2017-01-01' and '2017-07-01' THEN 'first half 2017'
END as 'seasonality'
, sum (s.orderquantity*p.ProductPrice) - sum(orderquantity*p.productcost) as net_profit
from sales.sales s
join production.products p on s.productid = p.productid
where orderdate BETWEEN '2015-01-01' and '2015-07-01'
or orderdate BETWEEN '2016-01-01' and '2016-07-01'
or orderdate BETWEEN '2017-01-01' and '2017-07-01'
GROUP by case
WHEN orderdate BETWEEN '2015-01-01' and '2015-07-01' THEN 'first half 2015'
WHEN orderdate BETWEEN '2016-01-01' and '2016-07-01' THEN 'first half 2016'
WHEN orderdate BETWEEN '2017-01-01' and '2017-07-01' THEN 'first half 2017'
END 
order by 1


--net profit by season
SELECT 'first half 2015' as 'period'
, sum (s.orderquantity*p.ProductPrice) - sum(orderquantity*p.productcost) as net_profit
from sales.sales s
join production.products p on s.productid = p.productid
where OrderDate BETWEEN '2015-01-01' and '2015-07-01'

UNION

SELECT 'first half 2016' as 'period'
, sum (s.orderquantity*p.ProductPrice) - sum(orderquantity*p.productcost) as net_profit
from sales.sales s
join production.products p on s.productid = p.productid
where OrderDate BETWEEN '2016-01-01' and '2016-07-01'

UNION
SELECT 'first half 2017' as 'period'
, sum (s.orderquantity*p.ProductPrice) - sum(orderquantity*p.productcost) as net_profit
from sales.sales s
join production.products p on s.productid = p.productid
where OrderDate BETWEEN '2017-01-01' and '2017-07-01'

