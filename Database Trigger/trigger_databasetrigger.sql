USE [<database_name>]
GO

/****** Object:  DdlTrigger [trg_DatabaseChangeLog]    Script Date: 08/01/2019 12:14:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER trg_DatabaseChangeLog ON DATABASE 
    FOR DDL_DATABASE_LEVEL_EVENTS 
AS 
    DECLARE @data XML 
    SET @data = EVENTDATA() 
    IF @data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)') <> 'CREATE_STATISTICS'  
		INSERT  INTO [DatabaseChangeLog] 
		( 
			[EventType], 
			[ObjectName], 
			[ObjectType], 
			[TsqlCode]
		) 
		VALUES  
		( 
			@data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'), 
			@data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)'), 
			@data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'nvarchar(100)'), 
			@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)') 
		); 
GO

ENABLE TRIGGER [trg_DatabaseChangeLog] ON DATABASE
GO


