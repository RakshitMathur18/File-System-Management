
-- Name - Rakshit Mathur
-- CSI Program
-- SQL (batch 1) 20 May 2025 to 20 July 2025
-- College - Poornima University
-- Branch - CS General
-- Project - File System Management

-- Task - We are provided a hierarchical file system and we have to find the size of each of the folder and its subfolder .
-- Each folder and its subfolder has its own unique (NodeID) and Name (NodeName) and have its own size in Bytes (SizeBytes) also each folder 
-- has its ParentID also


-- Create and use a database
create database Main_Project
use Main_Project;

-- create required tables

create table FileSystem (
    NodeID int primary key,
    NodeName varchar(50),
    ParentID int null,
    SizeBytes int
);

-- inserting required data

insert into FileSystem
values(1, 'Documents', NULL, 1550),
(2, 'Pictures', NULL, 1450),
(3, 'File1.txt', 1, 500),
(4, 'Folder1', 1, 1050),
(5, 'Image.jpg', 2, 1200),
(6, 'Subfolder1', 4, 750),
(7, 'File2.txt', 4, 300),
(8, 'File3.txt', 6, 300),
(9, 'Folder2', 2, 250),
(10, 'File4.txt', 9, 250);

-- Output Brfore

select * from FileSystem


-- Query to solve the project

go
with FileTree as (
    -- Anchor: Start from each node
    select NodeID,NodeName,ParentID,SizeBytes,NodeID as RootID from FileSystem
    union all

    -- get children and link them to their root

    select file_sys.NodeID,file_sys.NodeName,file_sys.ParentID,file_sys.SizeBytes,file_tree.RootID
    FROM FileSystem file_sys
    INNER JOIN FileTree file_tree ON file_sys.ParentID = file_tree.NodeID
)

select file_tree.RootID as NodeID,file_sys.NodeName,sum(file_tree.SizeBytes) as SizeBytes
from FileTree file_tree
join FileSystem file_sys on file_sys.NodeID = file_tree.RootID
group by file_tree.RootID, file_sys.NodeName
order by file_tree.RootID;

-- output 

-- NodeID	NodeName    SizeBytes
-- 1	    Documents	4450
-- 2	    Pictures	3150
-- 3	    File1.txt	500
-- 4		Folder1	    2400
-- 5		Image.jpg	1200
-- 6		Subfolder1	1050
-- 7		File2.txt	300
-- 8		File3.txt	300
-- 9		Folder2	    500
-- 10		File4.txt	250
