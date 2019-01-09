USE [<database_name>]
GO

/****** Object:  View [dbo].[vw_RandomSampleSeed]    Script Date: 09/01/2019 12:22:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------------------
-- Script Name:		vw_RandomSampleSeed
-- Description:		Basic view of a random seed being kept for generating random samples.
-- Author:			Avision Ho	
-- Creation Date:	09/01/2019
-----------------
-- Change History
-----------------
--S.No.			Date		Author			Change Description
--0.1			09/01/2019	AH				Initial base view of table

----------------------------------------------------------------------------------------------

CREATE VIEW [dbo].[vw_RandomSampleSeed] AS
	-- generate a pseudo-random number
	SELECT [RandomNumber] = RAND() 
GO


