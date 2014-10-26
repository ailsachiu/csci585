-- Find the villa with the highest count of reserved nights in 2014.

select villa_id
from RESERVATION
where start_date between '2014-01-01' and '2014-12-31'
and end_date between '2014-01-01' and '2014-12-31'
group by villa_id
order by sum(datediff(end_date,start_date)) desc
limit 1;

-- RESULTS: Vil7
