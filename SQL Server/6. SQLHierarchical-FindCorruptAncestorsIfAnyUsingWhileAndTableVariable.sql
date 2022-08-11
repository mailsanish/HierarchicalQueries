/*
-- SQL Hierarchical Queries - SQL Server 
-- Script to find corrupted ancestors(if any) in an multi organization hierarchy table, else simply list the ancestors 

-- Copyright SaneeCodes © 2022
-- Author: Sanish Abraham @ https://www.linkedin.com/in/sanishabraham/
*/

/*
--To test the below logic you make the demo data corrupted using below line:
UPDATE Organization
SET ParentId=12
WHERE Id=9

--To revert the changes run below line:
UPDATE Organization
SET ParentId=NULL
WHERE Id=9
*/

DECLARE @StartOrgId INT = 12; /* input value */

DECLARE @SelectedOrgs TABLE (TempId INT IDENTITY(1,1), OrgId INT)
DECLARE @loopCount INT = 0;

INSERT INTO @SelectedOrgs(OrgId) VALUES (@StartOrgId)

WHILE (@loopCount<>(SELECT MAX(TempId) FROM @SelectedOrgs))
BEGIN
	SET @loopCount=@loopCount+1

	IF EXISTS (SELECT OrgId FROM  @SelectedOrgs WHERE OrgId IN 
	(SELECT ParentId
	FROM Organization
	WHERE Id=(SELECT OrgId FROM @SelectedOrgs WHERE TempId=@loopCount)))
		BEGIN
			
			/* RAISE ERROR OR PRINT/SELECT CORRUPTED DATA */
			SELECT 'INVALID DATA FOUND - CIRCULAR REFERENCE FOUND' AS 'Message'
			
			SELECT O.Id,O.Name,O.ParentId
			FROM Organization O
			INNER JOIN @SelectedOrgs SO ON O.Id=SO.OrgId 
			AND SO.OrgId IN
			(SELECT OrgId
			FROM @SelectedOrgs
			WHERE OrgId=(SELECT OrgId FROM @SelectedOrgs WHERE TempId=@loopCount))

			BREAK; /* Dont break if you want to continue finding other corrupted items in the flow */
		END
	ELSE
		BEGIN
			INSERT INTO @SelectedOrgs(OrgId)
			SELECT ParentId
			FROM Organization
			WHERE Id=(SELECT OrgId FROM @SelectedOrgs WHERE TempId=@loopCount)
		END
	
END

SELECT Id,Name,ParentId
FROM Organization O
INNER JOIN @SelectedOrgs SO ON O.Id=SO.OrgId
ORDER BY SO.TempId ASC
GO


