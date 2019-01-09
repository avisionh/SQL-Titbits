USE [<database_name>]
GO

/****** Object:  UserDefinedFunction [Temp].[fn_SelectRandomRow]    Script Date: 09/01/2019 12:20:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_SelectRandomRow]()
RETURNS FLOAT AS
BEGIN
    DECLARE @returnValue FLOAT
    SELECT @returnValue = [RandomNumber] FROM [dbo].[vw_RandomSampleSeed]
    RETURN @returnValue
END
GO


