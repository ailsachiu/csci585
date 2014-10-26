-- Find the (first and last) name of all users who have ever used a coupon code offering a discount more than 10%.

select distinct USER.first_name, USER.last_name
from USER join RESERVATION on USER.user_id = RESERVATION.user_id
where coupon_id in (select coupon_id from COUPON where discount > 10);

-- RETURNS
-- 'Naz','Nazi'
-- 'Ben','Ghazi'
-- 'Houtan','Khandan'
