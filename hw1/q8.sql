-- Find the most famous reviewer: the user who owns reviews that have been liked the most for a larger number of villas compared to any other reviewer. 
-- Please note that we are NOT looking for the user who has received the largest total number of likes. Rather, we care about the count of villas in which a user's reviews were considered as the top review.

select tr.top_writer
from(
	select max(rev.num_likes), rev.writer as top_writer, rev.villa_id as v_id
	from(
		select count(liked_reviews.user_id) as num_likes, REVIEW.user_id as writer, REVIEW.villa_id as villa_id
		from liked_reviews join REVIEW on liked_reviews.review_id = REVIEW.review_id
		group by REVIEW.review_id
		order by REVIEW.villa_id
	) as rev
	group by villa_id
) as tr
group by tr.top_writer
order by count(distinct tr.v_id) desc
limit 1;

-- RESULT
-- U1