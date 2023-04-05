
WITH temp AS (
SELECT product_id, change_date, 

LAST_VALUE(new_price)\ 
    OVER(PARTITION BY product_id \
         ORDER BY change_date\
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
as latest_price

FROM Products
WHERE change_date <= '2019-08-16'

) # 여기서 8월 16일 이전의 애들을 걸렀으니까 나머지는 latest_price 가 없다.

SELECT DISTINCT product_id, IFNULL(temp.latest_price, 10) AS 'price'
FROM Products
LEFT JOIN temp
using (product_id)

##### 궁극의 코드다. 일단 last_value 함수를 알아야 하고,
##### range between (UNBOUNDED PRECEDING) and (UNBOUNDED FOLLOWING) 을 알아야 한다.
##### UNBOUNDED PRECEDING 이 한 묶음, UNBOUNDED FOLLOWING 이 또 한 묶음이다.
##### range 자리에는 rows가 들어갈 수도 있다. 이건 논리적이 아니라 물리적 위치로 접근하는 방식이다.
##### between 뒤에는 "current row" 가 올수도 있다.
##### 그러니까 UNBOUNDED PRECEDING, UNBOUNDED FOLLOWING 에 더해서 3개가 올 수 있다.

##### UNBOUNDED 대신에 숫자가 올 수 있다. 2 FOLLOWING 은 현재 다음의 두번째 행(집합)까지를 의미한다.
##### range 는 order by change_date 에서 같은 change_date 를 가진 집단을 하나의 뭉텅이로 본다.
##### rows 는 그냥 row들로 접근을 한다. 