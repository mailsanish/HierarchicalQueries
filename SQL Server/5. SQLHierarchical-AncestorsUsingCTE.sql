/* 
-- SQL Hierarchical Queries  -  SQL Server (2005 version onwards)
-- CTE Script solution to find all ancestors
-- Copyright SaneeCodes © 2022
-- Author: Sanish Abraham @ https://www.linkedin.com/in/sanishabraham/  
*/

DECLARE @StartOrgId INT = 8; /* input value */

WITH SelectedOrgs AS 
(
SELECT Id, Name, ParentId
FROM Organization
WHERE Id=@StartOrgId

UNION ALL

SELECT O.Id, O.Name, O.ParentId
FROM Organization O
INNER JOIN SelectedOrgs OS ON O.Id=OS.ParentId
)

SELECT Id, Name, ParentId FROM SelectedOrgs
