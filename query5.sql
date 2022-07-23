/*
הציגו את מספר השורות מטבלת המכירות עבור כל סטטוס 
(Order_Status) 
עבור שורות בהן שהכמות שנרכשה (OrderQuantity)
גדולה מ-1. 
השמיטו את השורות המסומנות בסטטוס 
ok.
*/

select Order_Status
, count(Order_Status) as row_count
from sales.sales
where OrderQuantity>1
and Order_Status <> 'ok'
GROUP BY Order_Status
order by 2 desc

--with all order statuses
select Order_Status
, count(Order_Status) as row_count
from sales.sales
where OrderQuantity>1
GROUP BY Order_Status
order by 2 desc
