/*
-- SQL Hierarchical Queries - Oracle
-- Oracle script to create table and insert data for demo

-- Copyright SaneeCodes © 2022
-- Author: Sanish Abraham @ https://www.linkedin.com/in/sanishabraham/
*/
	CREATE TABLE Organization 
	(Id int, Name VARCHAR2(30), ParentId int);
                   

   INSERT INTO Organization(Id,Name,ParentId) VALUES (1,'A1', null) ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (2,'A1-1', 1)  ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (3,'A1-2', 1)  ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (4,'A1-3', 1)    ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (5,'A1-1-1', 2)  ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (6,'A1-1-2', 2)  ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (7,'A1-2-1', 3)   ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (8,'A1-1-1-1', 5)  ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (9,'B1', null)    ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (10,'B1-1', 9)   ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (11,'B1-2', 9)   ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (12,'B1-1-1', 10)  ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (13,'C1', null)   ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (14,'C1-1', 13)   ;
   INSERT INTO Organization(Id,Name,ParentId) VALUES (15,'D1', null)   ;

   SELECT * FROM Organization; 