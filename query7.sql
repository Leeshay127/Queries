-- מחלקת השיווק מעוניינת להבין יותר טוב את קהל הלקוחות שלנו
-- אחד הדו"חות שמעניין אותם לראות הוא פילוח מספר הלקוחות לפי רמת השכלה ומין. יש להשמיט מהדו"ח לקוחות שלא ציינו את מינם


select EducationLevel 
, Gender
, count(EducationLevel) as 'number_of_customers'
from sales.Customers
where gender is not null
group by EducationLevel, Gender
order by 1 
