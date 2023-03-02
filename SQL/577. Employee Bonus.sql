select name, bonus
from employee emp left join bonus b on emp.empId=b.empId
where bonus<1000 or bonus is null
