/*
https://platform.stratascratch.com/coding/10310-class-performance?code_type=1

You are given a table containing assignment scores of students in a class. Write a query that identifies the largest difference in total score  of all assignments.

Output just the difference in total score (sum of all 3 assignments) between a student with the highest score and a student with the lowest score.

*/

select max(total_score) - min(total_score)  as difference_in_scores 

from (select student, assignment1 + assignment2 + assignment3  as total_score from box_scores) as total
