/*

https://platform.stratascratch.com/coding/10352-users-by-avg-session-time


Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. 

For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit, with an obvious restriction that load time event should happen before exit time event . 

Output the user_id and their average session time.

*/

with tab_load as (select user_id, max(timestamp) as max_load, action, date(timestamp) as d_date 
from facebook_web_log
where action='page_load'
group by 1,3,4),

tab_exit as (select user_id, min(timestamp) as min_exit, action, date(timestamp) as d_date
from facebook_web_log
where action ='page_exit'
group by 1,3,4),

final_table as (select tl.user_id, tl.max_load, te.min_exit,(te.min_exit - tl.max_load) as time_elapsed , tl.action as l_action, te.action as e_action, tl.d_date
from tab_exit as te, tab_load as tl
where te.d_date = tl.d_date 
and te.user_id = tl.user_id)

select final_table.user_id, avg(time_elapsed)
from final_table
group by 1
