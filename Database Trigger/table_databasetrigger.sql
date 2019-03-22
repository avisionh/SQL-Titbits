USE [HE-AN-DATA-NS]
GO

/****** Object:  Table [AuditDetails].[DatabaseChangeLog]    Script Date: 22/03/2019 16:10:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [AuditDetails].[DatabaseChangeLog](
	[ChangeId] [int] IDENTITY(1,1) NOT NULL
	,[ChangeDate] [datetime] NOT NULL 
		CONSTRAINT [DF_ddl_log_ChangeDate]
			DEFAULT (GETDATE())
	,[NameUser] [nvarchar](50) NOT NULL
		CONSTRAINT [DF_ddl_log_NameUser]   
            DEFAULT (CONVERT([nvarchar](50), USER_NAME(), (0)))
	,[NameSecurity] [nvarchar](50) NOT NULL
		CONSTRAINT [DF_DDLChangeLog_NameSecurity]   
            DEFAULT (CONVERT([nvarchar](50), SUSER_SNAME(), (0)))
	,[NameLogin] [nvarchar](50) NOT NULL
		CONSTRAINT [DF_DDLChangeLog_NameLogin]   
            DEFAULT (CONVERT([nvarchar](50), original_login(),(0)))
	,[EventType] [nvarchar](100) NULL
	,[ObjectName] [nvarchar](100) NULL
	,[ObjectType] [nvarchar](100) NULL
	,[TsqlCode] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


