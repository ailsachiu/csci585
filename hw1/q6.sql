-- Find the three villas and their associated owners, who have the highest average user rating.

select VILLA.villa_id, USER.first_name, USER.last_name, avg(REVIEW.rating) as avg_rating
from (VILLA join REVIEW on VILLA.villa_id = REVIEW.villa_id) left outer join USER on VILLA.owner = USER.user_id
group by VILLA.villa_id
order by avg_rating desc
limit 3;

-- RETURNS
-- 'Vil4','Roberto','Carlos','5.0000'
-- 'Vil9','nino','bino','5.0000'
-- 'Vil6','Roberto','Carlos','4.0000'