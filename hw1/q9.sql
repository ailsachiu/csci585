-- Find the vacancy ratio for each owner in 8/15/2014. The vacancy ratio is defined as the
-- ratio of villas not reserved for a specific date, over the total number of villas owned by that owner.


-- user_id, occupied / total owned
select tot.owner, (tot.total - ifnull(oc.occupied,0))/tot.total as vacancy_ratio
from(	select v.owner as owner, count(r.villa_id) as occupied
		from RESERVATION r join VILLA v on v.villa_id = r.villa_id
        where '2014-08-15' between r.start_date and r.end_date
        group by v.owner
	) as oc
    right outer join
    (	select owner, count(distinct villa_id) as total
		from villa
        group by owner
	) as tot
    on tot.owner = oc.owner;

-- RESULTS
-- 'U11','0.7500'
-- 'U12','1.0000'
-- 'U13','0.6667'
-- 'U14','1.0000'
