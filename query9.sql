--R&D מתכננים קו מוצרים חדש ומעוניינים לדעת מהו הצבע הפופולרי ביותר?
--הציגו את הצבע שמכר את מספר היחידות הרב ביותר (מוצרים ללא צבע לא ילקחו בחשבו)--

SELECT top 1  P.ProductColor 
,  sum (s.OrderQuantity) as 'total_unit_sold'
from Sales.Sales  s join production.Products p  on P.ProductID=s.ProductID
where p.ProductColor is not NULL
GROUP by p.ProductColor 
ORDER by total_unit_sold DESC
