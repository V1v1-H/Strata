/*

Given a table of purchases by date, calculate the month-over-month percentage change in revenue. 

The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.

The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100

*/

with gp1 as (
select f.created_at, sum(f.value) as value_month
from (
select to_char(created_at::date, 'YYYY-MM') AS created_at, value
from sf_transactions
) as f
GROUP BY f.created_at
order by f.created_at),

gp2 as (
select gp1.created_at as d1, gp1.value_month as v1, lag (gp1.value_month,1) over (order by gp1.created_at) as value_last_month
from gp1 )

select gp2.d1 as year_month, round(((gp2.v1-gp2.value_last_month)/gp2.value_last_month)*100,2) as revenue_diff_pct
from gp2
