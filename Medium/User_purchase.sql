with final_table as (select at1.user_id, at1.item as item1, at2.item as item2, at1.created_at, at2.created_at, (at1.created_at:: date - at2.created_at::date) as days
from amazon_transactions as at1, amazon_transactions as at2
where at1.user_id = at2.user_id 
and at1.id != at2.id
and at1.created_at:: date - at2.created_at::date between 0 and 7
order by at1.user_id, at1.created_at)

select distinct final_table.user_id from final_table 
order by user_id;
