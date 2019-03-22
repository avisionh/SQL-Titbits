USE [HE-AN-DATA-NS]
GO

----------------------------------------------------------------------------------------------
-- Script Name:		vw_DatabaseChangeLog
-- Description:		View of the database trigger where we include schema.
-- Note:			Need to bring in information from sys.all_objects table,
--					in particular, [object_id], to obtain the schema name of each
--					object captured from the database trigger.
-- Author:			Avision Ho	
-- Creation Date:	22/03/2019

-----------------
-- Change History
-----------------

--S.No.			Date		Author			Change Description
--1.0			22/03/2019	AH				Initial base view of table

----------------------------------------------------------------------------------------------

CREATE VIEW [AuditDetails].[vw_DatabaseChangeLog]
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
FROM [AuditDetails].[DatabaseChangeLog] AS changelog
LEFT JOIN [sys].[all_objects] AS admintable
	ON changelog.[objectName] = admintable.[name]
-- Keep only 'genuine'/real-people SQL users
WHERE changelog.[NameUser] != 'dbo'

GO