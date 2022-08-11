/*
-- SQL Hierarchical Queries  - Oracle
-- Oracle script to find all ancestors of a given organization id

-- Copyright SaneeCodes © 2022
-- Author: Sanish Abraham @ https://www.linkedin.com/in/sanishabraham/
*/

CREATE PRIVATE TEMPORARY TABLE 
ORA$PTT_SelectedOrgs (Id INT, Name VARCHAR2(30), ParentId INT)
ON COMMIT DROP DEFINITION ;
DECLARE StartOrgId INTEGER:=1; /* input value*/
BEGIN
INSERT INTO ORA$PTT_SelectedOrgs
SELECT Id, Name, ParentId
FROM Organization
CONNECT BY PRIOR ParentId = Id
START WITH Id = StartOrgId;
END;
/
SELECT * FROM ORA$PTT_SelectedOrgs;
COMMIT;
