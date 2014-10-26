-- List the name of all villa owners, who own villas with a 10% or more growth in the count
-- of reserved nights in the first 8 months of 2014 compared to the similar period in 2013.

-- growth = (new size - old size)/old size

select user.first_name, user.last_name
from user join (
	select distinct villa.owner as owner_id
	from villa join (

		select n13.villa_id as villa_id
		from(	select villa_id, (SELECT SUM(DATEDIFF(end_date,start_date))) as nights_2013
				from reservation
				where reservation.start_date between '2013-01-01' and '2013-08-31'
				group by villa_id
			) as n13
			inner join
			(	select villa_id, (SELECT SUM(DATEDIFF(end_date,start_date))) as nights_2014
				from reservation
				where reservation.start_date between '2014-01-01' and '2014-08-31'
				group by villa_id
			) as n14 
			on n13.villa_id = n14.villa_id
		where (n14.nights_2014-n13.nights_2013)/n13.nights_2013 > 0.10
		) as grew_10
		on villa.villa_id = grew_10.villa_id
	) as grew_10_owners
on user.user_id = grew_10_owners.owner_id;

-- RESULTS
-- 'Roberto','Carlos'
-- 'De','Vilardo'
-- 'villa','Blanka'
