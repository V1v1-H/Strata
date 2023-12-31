/*

https://platform.stratascratch.com/coding/10297-comments-distribution



Write a query to calculate the distribution of comments by the count of users that joined Meta/Facebook between 2018 and 2020, for the month of January 2020.

The output should contain a count of comments and the corresponding number of users that made that number of comments in Jan-2020. 

For example, you'll be counting how many users made 1 comment, 2 comments, 3 comments, 4 comments, etc in Jan-2020. 

Your left column in the output will be the number of comments while your right column in the output will be the number of users. 

Sort the output from the least number of comments to highest.

To add some complexity, there might be a bug where an user post is dated before the user join date. You'll want to remove these posts from the result.


*/


with gp1 as 
(select fb_users.id, fb_users.name, fb_users.joined_at, to_char(coms.created_at::date,'YYYY-MM') as created_at, coms.body, count(*) over (w) as nb_coms
from 
(
select * from fb_users
where joined_at between '2018-01-01' and '2020-12-31'
) as fb_users
join fb_comments as coms
on fb_users.id =  coms.user_id and joined_at < created_at and  to_char(coms.created_at::date,'YYYY-MM') = '2020-01'
window w as (partition by to_char(coms.created_at::date,'YYYY-MM'),id)
order by name
)


select nb_coms as comment_cnt, count(distinct id) as user_cnt
from gp1
group by 1
