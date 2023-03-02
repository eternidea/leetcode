WITH a AS (SELECT COUNT(DISTINCT CONCAT(requester_id, accepter_id)) as accept
FROM RequestAccepted),

b AS (SELECT COUNT(DISTINCT CONCAT(sender_id, send_to_id)) as request
FROM FriendRequest)

SELECT IF(round(accept/request, 2) IS NOT NULL, round(accept/request, 2), 0.00)as accept_rate
FROM a,b
