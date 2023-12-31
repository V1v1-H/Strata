/*
A job interview coding question from Uber

https://platform.stratascratch.com/coding/10302-distance-per-dollar


You’re given a dataset of uber rides with the traveling distance (‘distance_to_travel’) and cost (‘monetary_cost’) for each ride. 

First, find the difference between the distance-per-dollar for each date and the average distance-per-dollar for that year-month. 

Distance-per-dollar is defined as the distance traveled divided by the cost of the ride. 

Use the calculated difference on each date to calculate absolute average difference in distance-per-dollar metric on monthly basis (year-month).

--The output should include the year-month (YYYY-MM) and the absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal).

You should also count both success and failed request_status as the distance and cost values are populated for all ride requests. 

Also, assume that all dates are unique in the dataset. Order your results by earliest request date first.

*/


Select request_mnth, difference
from (
select to_char(request_date::date, 'YYYY-MM') as request_mnth, distance_to_travel/ monetary_cost - avg(distance_to_travel/ monetary_cost) over (w) as difference

from uber_request_logs
Window w as (partition by to_char(request_date::date, 'YYYY-MM'))
) as gp
where difference>0
