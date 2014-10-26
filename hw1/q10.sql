-- Find any user who has reserved two or more villas at overlapping periods. 
-- Such a user has two or more reservations with overlapping (but not necessarily the same) stay periods.

select distinct r1.user_id from RESERVATION r1 join RESERVATION r2 on r1.user_id = r2.user_id
where r1.reservation_id != r2.reservation_id and r1.start_date < r2.end_date and r1.end_date > r2.start_date;

