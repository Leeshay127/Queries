-- מנהל בקרת האיכות של המפעל מעוניין לדעת מהם 3 המוצרים בעלי מספר ההחזרות הגבוה ביותר.
--  הציגו את שמות המוצרים וכן את מספר היחידות שהוחזרו

select top 3 p.ProductName
, SUM(s.ReturnQuantity) as sum_returns
from sales.returns s
join Production.Products p on s.ProductID = p.ProductID
group by  p.ProductName
order by sum_returns DESC



--percent returns
-- רוצות לחבר בין יחידות שנמכרו, לשהוחזרו.
-- אח"ז לעשות אחוזום מה הוחזר יותר
select productid
, sum (orderquantity) as units_sold
from sales.sales
GROUP BY productid
order by 1

SELECT productID
, sum (ReturnQuantity) as units_returned
from sales.returns
GROUP BY productid
order by 1

-- join
select s.productid
, sum (s.orderquantity) as units_sold
, sum (r.ReturnQuantity) as units_returned
from sales.sales s
join sales.returns r on s.productid = r.productid
GROUP BY s.productid
order by 1--not ok


-- join doesn't work. explanation why(-- alredy get it.. duplicated )


--מנסה אחרת דומה למה שעשיתי בתרגיל
--  לפני הרבה זמן 
--  SELECT sum(s.quantity) as 'total sales',
-- (select sum(r.quantity)
-- from returns r) as 'total returns'
-- from sales s

SELECT s.productid
, sum(s.orderquantity) as units_sold,
(
select sum(r.ReturnQuantity)
from sales.returns r
) as units_returned --מחזיר כל ה total.. לא נכון
from sales.sales s
group by s.productid --not ok



SELECT s.productid
, sum(s.orderquantity) as units_sold,
(
select r.productid
, sum(r.ReturnQuantity)
from sales.returns r
group by r.productid
) -- trying that way doesn't work
as units_returned
from sales.sales s
group by s.productid--not ok

-- create view

create view sold_by_id as
select productid
, sum (orderquantity) as units_sold
from sales.sales
GROUP BY productid

create view RETURN_by_id as
SELECT productID
, sum (ReturnQuantity) as units_returned
from sales.returns
GROUP BY productid
 

SELECT s.productid
, s.units_sold
, r.units_returned
, (r.units_returned*1.0/s.units_sold) as percentil_returns
from sold_by_id s 
left join RETURN_by_id r on s.productid = r.productid
order BY 4 desc

---it worked!!!
