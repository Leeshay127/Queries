-- מנהל הייצור מבקש לקבל את הדו"ח הבא. מתוך טבלת המוצרים, הציגו את: 
-- שם המוצר (תחת הכינוי Name)
-- שם הדגם (תחת הכינוי Model)
-- צבע, גודל וסגנון מופרדים בפסיקים (תחת הכינוי Properties)
-- מחיר המוצר (תחת הכינוי Price)
-- רווח נקי (מחיר פחות עלות) (תחת הכינוי NetProfit)


SELECT ProductName as 'Name'
, ModelName as 'Model'
, ProductColor + ',' + cast(ProductStyle as varchar) + ',' + cast(ProductSize as varchar) as 'Properties'
, ProductPrice as 'Price'
, (ProductPrice-ProductCost) as 'NetProfit'
From Production.Products
order by 5 desc                                                   --כדי לדעת עם מה מרווחים יותר

--top 5 higher net profit
SELECT top 5 ProductName as 'Name'
, (ProductPrice-ProductCost) as 'NetProfit'
From Production.Products
order by 2 desc                                                   --כדי לדעת עם מה מרווחים יותר

-- if i would want to know  % profit i would do like this:
-- would also add product id, as FK, to be able to join with other tables if needed in future

SELECT productid
, ProductName as 'Name'
, ModelName as 'Model'
, ProductColor + ',' + cast(ProductStyle as varchar) + ',' + cast(ProductSize as varchar) as 'Properties'
, ProductPrice as 'Price'
, (ProductPrice-ProductCost) as 'NetProfit'
, (ProductPrice-ProductCost)/ProductPrice as '%profit'
From Production.Products
order by 7 desc, 6 desc 


-- top 5 higher profit
SELECT top 5 productid
, (ProductPrice-ProductCost)/ProductPrice as '%profit'
From Production.Products
order by 2 DESC
