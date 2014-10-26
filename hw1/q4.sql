-- Find the name of top three users who have had the highest amount of deposit during 2013.
-- Notes: Please note that a user (e.g., Jesse Jackson) might have two of the three highest-deposit reservations and this is totally fine.

-- From FAQ, finding 3 users with top total deposit in 2013
select USER.first_name, USER.last_name
from USER join RESERVATION on USER.user_id = RESERVATION.user_id
where RESERVATION.start_date between '2013-01-01' and '2013-12-31' 
and RESERVATION.end_date between '2013-01-01' and '2013-12-31'
group by USER.user_id
order by sum(RESERVATION.deposit) desc
limit 3;

-- RESULTS
-- 'Niki','Nanjan'
-- 'Jessie','Jackson'
-- 'Jalli','Shadan'
