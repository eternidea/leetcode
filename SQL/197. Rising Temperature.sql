select A.id
from weather A
inner join weather B on A.recordDate-1 = B.recordDate
where A.Temperature > B.Temperature
