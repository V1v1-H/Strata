/*
https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries?code_type=1

Problem :

You have been asked to find the job titles of the highest-paid employees.

Your output should include the highest-paid title or multiple titles with the same salary.

*/

select worker_title as best_paid_title
from worker as w
join title as t
on w.worker_id = t.worker_ref_id
where w.salary >= any(
select max(salary) from worker)
