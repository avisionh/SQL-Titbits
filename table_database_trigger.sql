USE [<database_name>]
GO

/****** Object:  Table [dbo].[DDLChangeLog]    Script Date: 08/01/2019 12:09:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DDLChangeLog](
	[DDLChangeLog_ID] [int] IDENTITY(1,1) NOT NULL,
	[InsertionDate] [datetime] NOT NULL,
	[CurrentUser] [nvarchar](50) NOT NULL,
	[LoginName] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[EventType] [nvarchar](100) NULL,
	[ObjectName] [nvarchar](100) NULL,
	[ObjectType] [nvarchar](100) NULL,
	[TsqlCode] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[DDLChangeLog] ADD  CONSTRAINT [DF_ddl_log_InsertionDate]  DEFAULT (getdate()) FOR [InsertionDate]
GO

ALTER TABLE [dbo].[DDLChangeLog] ADD  CONSTRAINT [DF_ddl_log_CurrentUser]  DEFAULT (CONVERT([nvarchar](50),user_name(),(0))) FOR [CurrentUser]
GO

ALTER TABLE [dbo].[DDLChangeLog] ADD  CONSTRAINT [DF_DDLChangeLog_LoginName]  DEFAULT (CONVERT([nvarchar](50),suser_sname(),(0))) FOR [LoginName]
GO

ALTER TABLE [dbo].[DDLChangeLog] ADD  CONSTRAINT [DF_DDLChangeLog_Username]  DEFAULT (CONVERT([nvarchar](50),original_login(),(0))) FOR [Username]
GO


