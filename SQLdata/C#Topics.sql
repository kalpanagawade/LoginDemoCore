USE [LoginDB]
GO
/****** Object:  Table [dbo].[C#Topics]    Script Date: 16-10-2026 11:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C#Topics](
	[Id] [int] NOT NULL,
	[ParentID] [int] NULL,
	[TopicName] [varchar](50) NULL,
	[TopicContent] [nvarchar](max) NULL,
	[Code] [nvarchar](max) NULL,
	[Language] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]






