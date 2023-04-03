
SELECT buyer_id
FROM Sales JOIN Product USING(product_id)
GROUP BY buyer_id
HAVING SUM(CASE WHEN product_name = 'S8' THEN 1 ELSE 0 END) > 0
AND SUM(CASE WHEN product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

##

select buyer_id 
from Sales 
join Product
using(product_id)
group by buyer_id
having sum(product_name='S8') > 0 and sum(product_name='iPhone') = 0

## S8을 갖고 있는데 iPhone은 갖고 있지 않은 애를 찾고 싶을 때 쓰게 된다.
## sum 안에 이렇게 조건을 쓸 수 있다. 아니면 위처럼 조건문을 넣을 수도 있다.
## sum을 1이냐 0이냐로 써서 필터링을 할 수 있다.
## _______________________________________________________


select product_id, product_name
from sales
join product
using (product_id)
group by product_id
having sum(sale_date between '2019-01-01' and '2019-03-31')>0
and sum(sale_date not between '2019-01-01' and '2019-03-31')=0

## 위의 아이디어를 그대로 사용한 결과다.
##

select s.product_id, p.product_name
from sales s, product p
where s.product_id = p.product_id
group by s.product_id, p.product_name
having min(s.sale_date) >= '2019-01-01' AND max(s.sale_date) <= '2019-03-31'

## 이런 식으로 쓸수도 있다.
## _______________________________________________________

SELECT book_id, name
FROM Books
WHERE available_from < '2019-05-23'
AND book_id NOT IN
(SELECT book_id
FROM Orders
WHERE dispatch_date BETWEEN '2018-06-23' AND '2019-06-23'
GROUP BY book_id
Having sum(quantity) >= 10) 

## null인 애들은 반영이 안되기 때문에 not in 으로 접근해야 한다. 

select b.book_id, b.name
from books b
left join orders o
on b.book_id = o.book_id and dispatch_date between '2018-06-23' and '2019-06-23'
where datediff('2019-06-23', available_from) > 30
group by b.book_id, b.name
having ifnull(sum(quantity),0) <10;

## 아니면 left join을 해서 null을 일부러 만들어버린 다음에 group by를 두 개로 하고 null을 나중에 처리해버린다.
## 이 방법이 나을 것 같다. 
## _______________________________________________________

select 
left(trans_date,7) month, 
country, 
count(*) trans_count, 
sum(state='approved') approved_count, 
sum(amount) trans_total_amount, 
sum(case when state='approved' then amount else 0 end) approved_total_amount
from transactions
group by month, country

## sum 안의 조건식으로 참/거짓 나눠서 하면 참 편하다. sum은 count로도 사용할 수 있다. 
## _______________________________________________________

SELECT ROUND(AVG(cnt), 2) AS average_daily_percent 
FROM
(
SELECT (COUNT(DISTINCT r.post_id)/ COUNT(DISTINCT a.post_id))*100  AS cnt
FROM Actions a
LEFT JOIN Removals r
ON a.post_id = r.post_id
WHERE extra='spam' and action = 'report'
GROUP BY action_date
) as tmp

## 퍼센트 구하는 건 대개 이런 구조를 갖고 있다. 
## 전체에서 부분을 구할 때는 left join을 이용해서 null을 이용해버린다.