1.	מנהל הייצור מבקש לקבל את הדו"ח הבא. מתוך טבלת המוצרים, הציגו את: 
➢	שם המוצר (תחת הכינוי Name)
➢	שם הדגם (תחת הכינוי Model)
➢	צבע, גודל וסגנון מופרדים בפסיקים (תחת הכינוי Properties)
➢	מחיר המוצר (תחת הכינוי Price)
➢	רווח נקי (מחיר פחות עלות) (תחת הכינוי NetProfit)
SELECT ProductName as 'Name'
, ModelName as 'Model'
, ProductColor + ',' + cast(ProductStyle as varchar) + ',' + cast(ProductSize as varchar) as 'Properties'
, ProductPrice as 'Price'
, (ProductPrice-ProductCost) as 'NetProfit'
From Production.Products
 
בדקנו את הרווח הנקי של המוצרים , החישוב הוא מחיר פחות עלות.


SELECT ProductName as 'Name'
, ModelName as 'Model'
, ProductColor + ',' + cast(ProductStyle as varchar) + ',' + cast(ProductSize as varchar) as 'Properties'
, ProductPrice as 'Price'
, (ProductPrice-ProductCost) as 'NetProfit'
From Production.Products
order by 5 desc --כדי לדעת עם מה מרווחים יותר

מצאנו כי Mountain-100   הוא המוצר הרווחי ביותר לחברה , 
הצבעים שהכי נמכרים silver & black 
והוספנו בדיקה של אילו חמשת המוצרים עם הרווח הכי גבוה - ORDER BY 5 DESC 
 

בדקנו את הרווחיות לפי שנים על מנת להשוות את התנועה ברווחיות לאורך השנים. מצאנו שלא הייתה ירידה ברווחיות, אולי מכיוון שהמידע הקיים הוא עד אמצע 2017. לכן בדקנו את כמות היחידות שנמכרו את אחוז הרווחיות לפי חציונים ראשונים של 2015-17


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

 


