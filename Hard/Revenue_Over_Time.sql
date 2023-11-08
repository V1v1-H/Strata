/*

A coding interview from Amazon

https://platform.stratascratch.com/coding/10314-revenue-over-time


Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased. 

Do not include returns which are represented by negative purchase values. Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.

A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. 

The first two months will not be a true 3-month rolling average since we are not given data from last year. Assume each month has at least one purchase.

*/




select gp.created_at,
CASE
    WHEN lag(sum(gp.purchase_amt),1) over (w) isnull and lag(sum(gp.purchase_amt),2) over (w) isnull THEN sum(gp.purchase_amt)
    WHEN lag(sum(gp.purchase_amt),2) over (w) isnull THEN (sum(gp.purchase_amt) + lag(sum(gp.purchase_amt),1) over (w))/2
    ELSE (sum(gp.purchase_amt) + lag(sum(gp.purchase_amt),1) over (w) +lag(sum(gp.purchase_amt),2) over (w))/3
    END AS avg_revenue
from 
(
select to_char(created_at::date, 'YYYY-MM') AS created_at, purchase_amt
from amazon_purchases
where purchase_amt >0
Window w as (Partition by to_char(created_at::date, 'YYYY-MM'))
order by created_at) as gp
group by 1
Window w as (order by created_at)
