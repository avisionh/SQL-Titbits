USE [<database_name>]
GO

/****** Object:  View [AdminDetails].[vw_DatabaseChangeLog]    Script Date: 08/01/2019 17:18:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------------------
-- Script Name:		vw_DatabaseChangeLog
-- Description:		View of the database trigger where we include schema.
-- Note:			Need to bring in information from sys.all_objects table,
--					in particular, [object_id], to obtain the schema name of each
--					object captured from the database trigger.
-- Author:			Avision Ho	
-- Creation Date:	18/01/2019
-----------------
-- Change History
-----------------
--S.No.			Date		Author			Change Description
--1.0			18/01/2019	AH				Initial base view of table
----------------------------------------------------------------------------------------------
CREATE VIEW [AdminDetails].[vw_DatabaseChangeLog]
AS 
SELECT changelog.[ChangeId]
      ,changelog.[ChangeDate]
      ,changelog.[NameUser]
      ,changelog.[NameSecurity]
      ,changelog.[NameLogin]
      ,changelog.[EventType]
	  ,[SchemaId] = admintable.[schema_id]
	  ,[SchemaName] = OBJECT_SCHEMA_NAME(admintable.[object_id])
	  ,[ObjectId] = admintable.[object_id]
      ,changelog.[ObjectName]
      ,[ObjectType] = admintable.[type_desc]
      ,changelog.[TsqlCode]
FROM [AdminDetails].[DatabaseChangeLog] AS changelog
LEFT JOIN [sys].[all_objects] AS admintable
	ON changelog.[objectName] = admintable.[name]
-- Keep only 'genuine'/real-people SQL users
WHERE changelog.[CurrentUser] != 'dbo'
GO


