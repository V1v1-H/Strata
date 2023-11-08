/*

https://platform.stratascratch.com/coding/10350-algorithm-performance



Meta/Facebook is developing a search algorithm that will allow users to search through their post history. You have been assigned to evaluate the performance of this algorithm.

We have a table with the user's search term, search result positions, and whether or not the user clicked on the search result.

Write a query that assigns ratings to the searches in the following way:

•	If the search was not clicked for any term, assign the search with rating=1

•	If the search was clicked but the top position of clicked terms was outside the top 3 positions, assign the search a rating=2

•	If the search was clicked and the top position of a clicked term was in the top 3 positions, assign the search a rating=3

As a search ID can contain more than one search term, select the highest rating for that search ID. Output the search ID and its highest rating.

Example: The search_id 1 was clicked (clicked = 1) and its position is outside of the top 3 positions (search_results_position = 5), therefore its rating is 2.

*/



/*If the search was not clicked for any term, assign the search with rating=1*/

with gp1 as (select fb1.search_id, fb1.search_term,	fb1.clicked as clicked1, fb1.search_results_position, 1 as rating
from fb_search_events as fb1
where 1 > all(select clicked from fb_search_events a
        where a.search_id = fb1.search_id)),        
/*
• If the search was clicked but the top position of clicked terms was outside the top 3 positions, assign the search a rating=2

• If the search was clicked and the top position of a clicked term was in the top 3 positions, assign the search a rating=3   
*/

gp2 as ( select search_id, search_term, clicked, 
            search_results_position,
           CASE
           WHEN search_results_position> 3
                THEN 2
           WHEN search_results_position <= 3
                THEN 3 
            END rating                      
        from fb_search_events as fb3
        where fb3.search_id not in (
        select search_id from gp1) 
        and fb3.clicked = 1
        )
        
        select gp2.search_id, max(gp2.rating) as max_rating from gp2
        group by gp2.search_id
        union
        select gp1.search_id, max(gp1.rating) as max_rating from gp1
        group by gp1.search_id
