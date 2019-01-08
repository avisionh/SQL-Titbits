USE [<database_name>]
GO

/****** Object:  Table [AdminDetails].[DatabaseChangeLog]    Script Date: 08/01/2019 12:09:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [AdminDetails].[DatabaseChangeLog](
	[ChangeId] [int] IDENTITY(1,1) NOT NULL,
	[ChangeDate] [datetime] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[SecurityName] [nvarchar](50) NOT NULL,
	[LoginName] [nvarchar](50) NOT NULL,
	[EventType] [nvarchar](100) NULL,
	[ObjectName] [nvarchar](100) NULL,
	[ObjectType] [nvarchar](100) NULL,
	[TsqlCode] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[DatabaseChangeLog] ADD  CONSTRAINT [DF_DatabaseChangeLog_ChangeDate]  DEFAULT (getdate()) FOR [ChangeDate]
GO

ALTER TABLE [dbo].[DatabaseChangeLog] ADD  CONSTRAINT [DF_DatabaseChangeLog_UserName]  DEFAULT (CONVERT([nvarchar](50),user_name(),(0))) FOR [CurrentUser]
GO

ALTER TABLE [dbo].[DatabaseChangeLog] ADD  CONSTRAINT [DF_DatabaseChangeLog_SecurityName]  DEFAULT (CONVERT([nvarchar](50),suser_sname(),(0))) FOR [LoginName]
GO

ALTER TABLE [dbo].[DatabaseChangeLog] ADD  CONSTRAINT [DF_DatabaseChangeLog_LoginName]  DEFAULT (CONVERT([nvarchar](50),original_login(),(0))) FOR [Username]
GO
