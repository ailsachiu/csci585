-- List the villa owner names, as well as the count of villas they own, sorted by count of villas.
select USER.first_name, USER.last_name, count(distinct villa_id) 
from USER join VILLA on villa.owner = user.user_id 
group by USER.user_id 
order by count(distinct villa_id) desc;

-- RETURNS
-- 'Roberto','Carlos','4'
-- 'De','Vilardo','4'
-- 'villa','Blanka','3'
-- 'nino','bino','1'
