-- Find the average age (in years) of users who rented villas during low-season last year (i.e. from September to December 2013).
-- Notes: Please note that a user who reserves a villa in late December 2013, and leaves the villa in Jan. 2014, is among the users that have rented the villa within the period of September to December. 
-- Also, note that we are interested in the average age (in years) at the time of reservation (start date). 
-- If a user is involved in two reservations, his age will be used in the calculations twice.

select avg(TIMESTAMPDIFF(YEAR,USER.dob,RESERVATION.start_date)) as avg_age 
from USER join RESERVATION on USER.user_id = RESERVATION.user_id
where RESERVATION.start_date between '2013-09-01' and '2013-12-31'
and RESERVATION.end_date between '2013-09-01' and '2014-01-31';

-- RETURNS 33.3333