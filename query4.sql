-- המפעל מעוניין לבצע צמצום של פסי הייצור במוצרים פחות רלוונטיים.
-- 2017 מצאו כמה מוצרים לא נמכרו כלל במהלך 

select count(ProductID) as unsold_products_2017
from production.Products
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
WHERE YEAR(orderdate)='2017'
)


--amount products never sold
select count(ProductID) as unsold_products
from production.Products
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
)

--total products
select count(productid) as amount_products
from production.products


--percent products never sold
select count(ProductID)/
(select count(productid)*1.0 
from production.products
)as percent_unsold_products
from production.Products
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
)

--id of products that wherent sold

select ProductID as unsold_products
from production.Products 
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
)


--name of products that where never sold
select ProductID as unsold_products
, ModelName
from production.Products 
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
)


--dashbord. products that are not in stock in all the stores

with unsold_name as
(
select ProductID as unsold_products
, ModelName
from production.Products 
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
)
)

SELECT distinct u.*
, p.unitsinstock
from production.stocks p 
join unsold_name u on p.productid = u.unsold_products
where p.unitsinstock = 0


--we created a view to have unsold products that are not in stock, so we can join w/ other tables
create view unsold_not_in_stock as

with unsold_name as
(
  select ProductID as unsold_products
, ModelName
from production.Products 
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
)
)

SELECT distinct u.*
, p.unitsinstock
from production.stocks p 
join unsold_name u on p.productid = u.unsold_products
where p.unitsinstock = 0

--we created a view to have unsold products that are in stock, and were never sold and so we can join w/ other tables
create view unsold_in_stock as

with unsold_name as
(
  select ProductID as unsold_products
, ModelName
from production.Products 
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
)
)

SELECT distinct u.*
, p.unitsinstock
from production.stocks p 
join unsold_name u on p.productid = u.unsold_products
where p.unitsinstock <> 0--realized that one product coul be out of stock in more than one store

--check the table 
select *
from production.stocks

--products not sold and their categories
select u.unsold_products
, i.category
, u.ModelName
, u.unitsinstock
from unsold_not_in_stock u
join id_category_name i on u.unsold_products = i.productid


--by category

select  c.category
, count(p.ProductID) as unsold_products_by_category
from production.Products p 
join  id_category_name c on p.productid = c.productid
WHERE p.ProductID not in
(
select distinct ProductID
from sales.sales
)
group by  c.category


---top10 higher  profit never sold to check if thy werent sold because they are too expensive. 
SELECT top 10 productid
, ProductName as 'Name'
, ModelName as 'Model'
, ProductColor + ',' + cast(ProductStyle as varchar) + ',' + cast(ProductSize as varchar) as 'Properties'
, ProductPrice as 'Price'
, (ProductPrice-ProductCost) as 'NetProfit'
, (ProductPrice-ProductCost)/ProductPrice as '%profit'
From Production.Products
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
)
order by 7 desc, 6 desc 

--higher profit -- ther are other products w same profit% that where sold
SELECT  productid
, ProductName as 'Name'
, ModelName as 'Model'
, ProductColor + ',' + cast(ProductStyle as varchar) + ',' + cast(ProductSize as varchar) as 'Properties'
, ProductPrice as 'Price'
, (ProductPrice-ProductCost) as 'NetProfit'
, (ProductPrice-ProductCost)/ProductPrice as '%profit'
From Production.Products
where ProductID IN
(
select distinct(productid)
from sales.sales
)
order by 7 desc, 6 desc 

--id in stock
select p.ProductID as unsold_products
, s.unitsinstock
from production.Products p join production.stocks s
on p.productid = s.productid
WHERE p.ProductID not in
(
select distinct ProductID
from sales.sales
)
order by 2 desc--לפי כמןת שיש לנו ממלאי

-- more than one stock from same product
select p.ProductID as unsold_products
, sum(s.unitsinstock) as units_in_stock
from production.Products p join production.stocks s
on p.productid = s.productid
WHERE p.ProductID not in
(
select distinct ProductID
from sales.sales
)
group by p.ProductID
order by 2 desc




-- count total not sold in stock
select count(unitsinstock) as products_in_stock_not_sold
from production.stocks s
WHERE UnitsInStock <> 0
and ProductID not in
(
select distinct ProductID
from sales.sales
)


--unsold group by category
select c.category as category_unsold_products
, sum(s.unitsinstock) as unsold_by_category
from production.Products p join production.stocks s
on p.productid = s.productid
join id_category_name c on p.productid = c.productid
WHERE p.ProductID not in
(
select distinct ProductID
from sales.sales
)
group by c.category
order by 2 desc



-- not sold+category
select p.ProductID as unsold_products
, c.category
from production.Products p
join id_category_name c --view we created
on p.productid = c.productid
WHERE p.ProductID not in
(
select distinct ProductID
from sales.sales
)

--not sold products group by category
select  c.category
, count(p.ProductID) as unsold_groups
from production.Products p
join id_category_name c on p.productid = c.productid
WHERE p.ProductID not in
(
select distinct ProductID
from sales.sales
)
group by c.category

--id איזה לא נמכרו ב2017 ונמכרו לפני
select ProductID as unsold_products_list
from production.Products
WHERE ProductID not in
(
select distinct ProductID
from sales.sales
WHERE YEAR(orderdate)='2017'
)
AND ProductID  in
(
select distinct ProductID
from sales.sales
)

--view by category
create view id_category_name AS
select pc.categoryname as category
, pp.ProductID as productID
from production.categories pc join production.SubCategories ps on pc.CategoryID = ps.CategoryID
join production.Products pp on pp.SubcategoryID= ps.SubcategoryID

--first sold 
select top 1 OrderDate
from sales.sales
order by orderdate

--last sold
select top 1 OrderDate
from sales.sales
order by orderdate desc

--not sold not in stock in at least one store
select  category
, count(s.unitsinstock) as not_sold_not_in_stock
from id_category_name i join production.stocks s
on s.productid = i.productid
WHERE s.ProductID not in
(
select distinct ProductID
from sales.sales
)
and s.unitsinstock = 0
group by category
order by 2


--percent not in stock
select count(unitsinstock)/
(
select  count(unitsinstock)*1.0 as not_in_stock
from production.stocks 
) as 'percent'
from production.stocks 
WHERE  unitsinstock = 0

--product in all stocks all stores
select count(unitsinstock)  as stock
from production.stocks 
