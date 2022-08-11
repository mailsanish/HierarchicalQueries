/*
-- SQL Hierarchical Queries - SQL Server (Pre 2005 versions)
-- Script solution to find all descendants using only while and table variable

-- Copyright SaneeCodes © 2022
-- Author: Sanish Abraham @ https://www.linkedin.com/in/sanishabraham/
*/

DECLARE @StartOrgId INT = 1; /* input value */

DECLARE @SelectedOrgs TABLE (TempId INT IDENTITY(1,1), OrgId INT)
DECLARE @loopCount INT = 0;

INSERT INTO @SelectedOrgs(OrgId) VALUES (@StartOrgId)

WHILE (@loopCount<>(SELECT MAX(TempId) FROM @SelectedOrgs))
BEGIN
	SET @loopCount=@loopCount+1
	INSERT INTO @SelectedOrgs(OrgId)
	SELECT Id
	FROM Organization
	WHERE ParentId=(SELECT OrgId FROM @SelectedOrgs WHERE TempId=@loopCount)
END

SELECT Id,Name,ParentId
FROM Organization O
INNER JOIN @SelectedOrgs SO ON O.Id=SO.OrgId
ORDER BY SO.TempId ASC
