select top 10 C.firstname + ' ' + C.lastname as name,  round(SUM(S.OrderQuantity*P.productprice),2) as summ
from sales.sales S join production.products P on  P.productID=S.productID
join sales.customers C on S.CustomerKEY=C.customerID
GROUP by C.firstname + ' ' + C.lastname, S.CustomerKEY
order by 2 DESC
