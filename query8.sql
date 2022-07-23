--סמנכ"ל המכירות של החברה מבקש לדעת מי הם 5 אנשי המכירות המצטיינים
-- אנשי המכירות מדורגים פשוט ע"פ מספר היחידות שהם מכרו, ללא קשר לסוג המוצר או שוויו/
--  הציגו את שמם הפרטי ואת כמות היחידות שמכרו



select top 5 t.FirstName, sum (s.OrderQuantity) as 'total_unint_sold'
from sales.Staff t   join sales.Sales s on t.StaffMemberID=s.SoldBy
GROUP by t.FirstName 
order BY total_unint_sold DESC
