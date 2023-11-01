select worker_title as best_paid_title
from worker as w
join title as t
on w.worker_id = t.worker_ref_id
where w.salary >= any(
select max(salary) from worker)
