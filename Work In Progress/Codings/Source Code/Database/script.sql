USE [master]
GO
/****** Object:  Database [EventZone]    Script Date: 12/01/2015 1:23:28 CH ******/
CREATE DATABASE [EventZone]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EventZone', FILENAME = N'B:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\EventZone.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EventZone_log', FILENAME = N'B:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\EventZone_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EventZone] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EventZone].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EventZone] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EventZone] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EventZone] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EventZone] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EventZone] SET ARITHABORT OFF 
GO
ALTER DATABASE [EventZone] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [EventZone] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EventZone] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EventZone] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EventZone] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EventZone] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EventZone] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EventZone] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EventZone] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EventZone] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EventZone] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EventZone] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EventZone] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EventZone] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EventZone] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EventZone] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EventZone] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EventZone] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EventZone] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EventZone] SET  MULTI_USER 
GO
ALTER DATABASE [EventZone] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EventZone] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EventZone] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EventZone] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [EventZone]
GO
/****** Object:  Table [dbo].[Action]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Action](
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
	[ActionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ActorAction] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Appeal]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appeal](
	[AppealID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[AppealContent] [nvarchar](max) NOT NULL,
	[AppealStatus] [int] NOT NULL,
	[SendDate] [date] NOT NULL,
	[ResultDate] [date] NULL,
	[HandleBy] [bigint] NULL,
 CONSTRAINT [PK_Appeal] PRIMARY KEY CLUSTERED 
(
	[AppealID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](256) NOT NULL,
	[CategoryAvatar] [bigint] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryFollow]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryFollow](
	[CategoryFollowID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryID] [bigint] NOT NULL,
	[FollowerID] [bigint] NOT NULL,
 CONSTRAINT [PK_CategoryFollow] PRIMARY KEY CLUSTERED 
(
	[CategoryFollowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Channel]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Channel](
	[ChannelID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[ChannelName] [nvarchar](512) NOT NULL,
	[ChannelDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_Channel] PRIMARY KEY CLUSTERED 
(
	[ChannelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[CommentContent] [nvarchar](max) NOT NULL,
	[DateIssue] [datetime] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Event]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[EventID] [bigint] IDENTITY(1,1) NOT NULL,
	[ChannelID] [bigint] NOT NULL,
	[EventName] [nvarchar](1024) NOT NULL,
	[EventStartDate] [datetime] NOT NULL,
	[EventEndDate] [datetime] NOT NULL,
	[EventDescription] [nvarchar](max) NULL,
	[EventRegisterDate] [datetime] NOT NULL,
	[View] [bigint] NOT NULL,
	[CategoryID] [bigint] NOT NULL,
	[Privacy] [int] NOT NULL,
	[Avatar] [bigint] NULL,
	[EditBy] [bigint] NULL,
	[EditTime] [datetime] NULL,
	[EditContent] [nvarchar](max) NULL,
	[Status] [bit] NOT NULL,
	[LockedReason] [nvarchar](100) NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventFollow]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventFollow](
	[EventFollowID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[FollowerID] [bigint] NOT NULL,
 CONSTRAINT [PK_EventFollow] PRIMARY KEY CLUSTERED 
(
	[EventFollowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventImage]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventImage](
	[EventImageID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NULL,
	[ImageID] [bigint] NULL,
 CONSTRAINT [PK_EventImage] PRIMARY KEY CLUSTERED 
(
	[EventImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventPlace]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventPlace](
	[EventPlaceID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[LocationID] [bigint] NOT NULL,
 CONSTRAINT [PK_EventPlace] PRIMARY KEY CLUSTERED 
(
	[EventPlaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventRank]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventRank](
	[EventId] [bigint] NOT NULL,
	[Score] [bigint] NOT NULL,
 CONSTRAINT [PK_EventRank] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Image]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ImageID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[ImageLink] [nvarchar](256) NOT NULL,
	[UploadDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Gallery] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LikeDislike]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikeDislike](
	[LikeDislikeID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_LikeDislike_1] PRIMARY KEY CLUSTERED 
(
	[LikeDislikeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Location]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[LocationID] [bigint] IDENTITY(1,1) NOT NULL,
	[Longitude] [float] NOT NULL,
	[Latitude] [float] NOT NULL,
	[LocationName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NotificationChange]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationChange](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[NotificationID] [bigint] NULL,
	[EventID] [bigint] NULL,
	[ActorID] [bigint] NULL,
	[AddDate] [date] NULL,
	[IsRead] [bit] NOT NULL,
	[Type] [int] NULL,
	[ReveiverID] [bigint] NULL,
 CONSTRAINT [PK_NotificationChange] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PeopleFollow]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeopleFollow](
	[PeopleFollowID] [bigint] IDENTITY(1,1) NOT NULL,
	[FollowerUserID] [bigint] NOT NULL,
	[FollowingUserID] [bigint] NOT NULL,
 CONSTRAINT [PK_PeopleFollow] PRIMARY KEY CLUSTERED 
(
	[PeopleFollowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Report]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[SenderID] [bigint] NOT NULL,
	[ReportType] [int] NOT NULL,
	[ReportContent] [nvarchar](max) NULL,
	[ReportStatus] [int] NOT NULL,
	[ReportDate] [datetime] NOT NULL,
	[HandleDate] [datetime] NULL,
	[HandleBy] [bigint] NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReportDefine]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportDefine](
	[ReportTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ReportTypeName] [nvarchar](50) NULL,
	[ReportDefine] [nvarchar](200) NULL,
 CONSTRAINT [PK_ReportDefine] PRIMARY KEY CLUSTERED 
(
	[ReportTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Share]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Share](
	[ShareID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
 CONSTRAINT [PK_Share] PRIMARY KEY CLUSTERED 
(
	[ShareID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrackingAction]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackingAction](
	[TrackingID] [bigint] IDENTITY(1,1) NOT NULL,
	[SenderID] [bigint] NOT NULL,
	[ReceiverID] [bigint] NOT NULL,
	[SenderType] [int] NOT NULL,
	[ReceiverType] [int] NULL,
	[ActionID] [int] NOT NULL,
	[ActionTime] [datetime] NOT NULL,
 CONSTRAINT [PK_TrackingAction] PRIMARY KEY CLUSTERED 
(
	[TrackingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[UserFirstName] [nvarchar](32) NOT NULL,
	[UserLastName] [nvarchar](32) NULL,
	[UserEmail] [nvarchar](64) NOT NULL,
	[UserDOB] [date] NOT NULL,
	[IDCard] [nvarchar](16) NULL,
	[UserRoles] [int] NOT NULL,
	[Phone] [nvarchar](max) NULL,
	[Place] [nvarchar](max) NULL,
	[AccountStatus] [bit] NOT NULL,
	[Gender] [int] NOT NULL,
	[Avartar] [bigint] NULL,
	[DataJoin] [date] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Video]    Script Date: 12/01/2015 1:23:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video](
	[VideoID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventPlaceID] [bigint] NOT NULL,
	[VideoLink] [nvarchar](256) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[Privacy] [int] NOT NULL,
	[PrimaryServer] [nvarchar](50) NULL,
	[BackupServer] [nvarchar](50) NULL,
	[StreamName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
(
	[VideoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Action] ON 

INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1, N'Lock Event')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (2, N'Unlock Event')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (3, N'Lock User')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (4, N'UnlockUser')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (5, N'ChangeUserEmail')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1005, N'Set Mod')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1006, N'UnSet Mod')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1007, N'Set Admin')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1008, N'Unset Admin')
SET IDENTITY_INSERT [dbo].[Action] OFF
SET IDENTITY_INSERT [dbo].[Appeal] ON 

INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (1, 2, N' 124253424', 1, CAST(0xB93A0B00 AS Date), CAST(0xBA3A0B00 AS Date), 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (2, 4, N' 4123535', 2, CAST(0xBC3A0B00 AS Date), NULL, 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (3, 3, N' 42515', 2, CAST(0xB93A0B00 AS Date), CAST(0xBA3A0B00 AS Date), 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (4, 5, N'please review my event. That all report not true', 1, CAST(0xBA3A0B00 AS Date), CAST(0xBA3A0B00 AS Date), 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (5, 2, N'demo 2/11', 0, CAST(0xBC3A0B00 AS Date), NULL, NULL)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (6, 6, N'hello', 1, CAST(0xBC3A0B00 AS Date), NULL, 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (7, 78, N'demo 2', 0, CAST(0xBC3A0B00 AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Appeal] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (1, N'Music', 10035)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (2, N'Food & Drink', 10034)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (3, N'Classes', 10039)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (4, N'Arts', 10033)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (5, N'Parties', 10037)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (6, N'Sport & Wellness', 10038)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (7, N'Networking', 10036)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[CategoryFollow] ON 

INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (1, 6, 12)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (2, 2, 12)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (9, 7, 13)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (15, 1, 13)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (16, 5, 13)
SET IDENTITY_INSERT [dbo].[CategoryFollow] OFF
SET IDENTITY_INSERT [dbo].[Channel] ON 

INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (1, 2, N'', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (2, 4, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (3, 7, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (4, 8, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (5, 9, N'cuong fiiuouo', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (6, 11, N'Vu Phan', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (7, 12, N'cuong nguyen van', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (8, 13, N'cuong nguyen van', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (9, 14, N'cug', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (10, 15, N'2151 512', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (11, 16, N'14125 211521', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (12, 17, N'712957 892751', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (13, 18, N'14', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (14, 19, N'38575 21', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (15, 20, N'cuong 24', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (16, 21, N'cuong 2871', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (17, 22, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (18, 23, N'1 4567', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (19, 24, N'cuong 211 ', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (20, 25, N'cuong 214', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (21, 26, N'cuong 59128591', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (22, 27, N'cuong nguyen van', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (23, 28, N'125151 23535', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (24, 29, N'cuong 2114', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (25, 30, N'cuong 2198', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (26, 31, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (27, 32, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (28, 33, N'cuong', N'')
SET IDENTITY_INSERT [dbo].[Channel] OFF
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (1, 1, 12, N'Hello', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (2, 1, 12, N'How are you?', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (3, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (4, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (5, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (6, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (7, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (8, 1, 12, N'4124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (9, 1, 12, N'512512512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (10, 1, 12, N'551251251', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (11, 1, 12, N'412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (12, 1, 12, N'41251', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (13, 1, 12, N'41252512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (14, 1, 12, N'53462464', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (15, 1, 12, N'4124241', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (16, 1, 12, N'152515', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (17, 1, 13, N'412412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (18, 1, 13, N'512512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (19, 1, 13, N'512512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (20, 1, 13, N'42512512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (21, 1, 13, N'day la gi', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (22, 1, 13, N'543762', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (23, 1, 13, N'54363626', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (24, 1, 13, N'412412412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (25, 1, 13, N'41241', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (26, 1, 13, N'555', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (27, 1, 13, N'hello', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (28, 1, 13, N'435351', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (29, 1, 13, N'5125125152', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (30, 1, 13, N'54236246346', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (31, 1, 13, N'i26u34oi62j3o632462346', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (32, 1, 13, N'634634', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (33, 1, 13, N'632462', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (34, 1, 13, N'632462346', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (35, 1, 13, N'41241', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (36, 1, 13, N'41251', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (37, 1, 13, N'125346235', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (38, 1, 13, N'4124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (39, 1, 13, N'421', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (40, 2, 13, N'551', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (41, 2, 13, N'51251251', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (42, 1, 13, N'31412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (43, 1, 13, N'63146146', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (44, 2, 13, N'eqwee12412124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (45, 1, 13, N'412412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (48, 1, 13, N'Hello', NULL)
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (49, 1, 13, N'It''s me', NULL)
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (50, 1, 13, N'How are your', CAST(0x0000A54D017C6426 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (51, 1, 13, N'4124', CAST(0x0000A54D017C81DB AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (52, 1, 13, N'4124', CAST(0x0000A54D017D0C56 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (53, 1, 13, N'Hello
', CAST(0x0000A54D017FB2EE AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (54, 1, 13, N'it''s me', CAST(0x0000A54D017FBBBC AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (55, 1, 13, N'hello', CAST(0x0000A54D01800933 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (56, 1, 13, N'41241', CAST(0x0000A54D01800E1C AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (57, 1, 13, N'Hello', CAST(0x0000A54E000537A9 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (58, 1, 13, N'1', CAST(0x0000A54E00055292 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (59, 1, 13, N'1', CAST(0x0000A54E00055B74 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (60, 1, 13, N'21512515', CAST(0x0000A54E0005608D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (61, 1, 13, N'51251251', CAST(0x0000A54E000563CF AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (62, 1, 13, N'1', CAST(0x0000A54E000576E0 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (63, 1, 13, N'foaisfa', CAST(0x0000A54E0005865E AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (64, 1, 13, N'515125161', CAST(0x0000A54E00058ACE AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (65, 9, 13, N'hello', CAST(0x0000A54E0036AE55 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (66, 1, 13, N'4
', CAST(0x0000A54E0099998D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (67, 1, 13, N'333333333', CAST(0x0000A54E00999FA5 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (68, 1, 13, N'4', CAST(0x0000A54E0099B102 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (69, 1, 13, N'41241', CAST(0x0000A54E009FFC3A AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (70, 1, 13, N'1', CAST(0x0000A54E00A00081 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (71, 1, 13, N'1', CAST(0x0000A54E00A00E41 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (72, 1, 13, N'12', CAST(0x0000A54E00A01225 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (73, 1, 13, N'1251251', CAST(0x0000A54E00A0175D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (74, 1, 13, N'512512', CAST(0x0000A54E00A01A7A AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (75, 1, 13, N'.', CAST(0x0000A54E00A01EEF AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (76, 0, 13, N'12124124141', CAST(0x0000A54E01239515 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (77, 1, 13, N'51515151512', CAST(0x0000A55201298584 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (78, 1, 13, N'412511', CAST(0x0000A55201298A9A AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (79, 1, 13, N'5151515', CAST(0x0000A552012990BA AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (80, 1, 13, N'515', CAST(0x0000A552012B7858 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (81, 18, 13, N'52151', CAST(0x0000A559015A7DDD AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (82, 10108, 13, N'41251', CAST(0x0000A55D011D2E19 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (83, 10108, 13, N'52453', CAST(0x0000A55D011D30CA AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (84, 10108, 13, N'4352334646356
', CAST(0x0000A55D011D51E0 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (85, 10109, 13, N'24124', CAST(0x0000A56100098D93 AS DateTime))
SET IDENTITY_INSERT [dbo].[Comment] OFF
SET IDENTITY_INSERT [dbo].[Event] ON 

INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (0, 8, N'test1', CAST(0x0000A45800A02030 AS DateTime), CAST(0x0000A51000A06680 AS DateTime), N'Enter your description', CAST(0x0000A54B00A053B6 AS DateTime), 32, 7, 0, 3, 13, CAST(0x0000A561001368E5 AS DateTime), N'', 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (1, 2, N'LadyByNight', CAST(0x0000A53600000000 AS DateTime), CAST(0x0000A53700000000 AS DateTime), N'Lady by night được tổ chức hàng năm vào ngày 20/10 - DH FPT', CAST(0x0000A53600000000 AS DateTime), 1082, 5, 0, 3, 13, CAST(0x0000A55C00E24ED6 AS DateTime), N'', 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (2, 8, N'Final ESL ', CAST(0x0000A4F100A4CB80 AS DateTime), CAST(0x0000A5100127CE90 AS DateTime), N'Giai dau dota', CAST(0x0000A54A01287DC2 AS DateTime), 37, 1, 0, 3, 13, CAST(0x0000A55C001FE454 AS DateTime), N'', 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (3, 8, N'Quiz Pay', CAST(0x0000A52E004A2860 AS DateTime), CAST(0x0000A52E004A2860 AS DateTime), N'Quiz thanh toan', CAST(0x0000A54B004A0EF5 AS DateTime), 6, 7, 0, 3, 13, CAST(0x0000A55C001FE6D7 AS DateTime), N'', 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (4, 8, N'Quiz ktw', CAST(0x0000A43C005192D0 AS DateTime), CAST(0x0000A5100051D920 AS DateTime), N'Enter your description', CAST(0x0000A54B0051CDD8 AS DateTime), 7, 7, 0, 3, 13, CAST(0x0000A554003DA89C AS DateTime), N'', 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (5, 8, N'252151', CAST(0x0000A4580052F260 AS DateTime), CAST(0x0000A510005338B0 AS DateTime), N'251251', CAST(0x0000A54B0053188A AS DateTime), 4, 7, 0, 3, 13, CAST(0x0000A554003826E8 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (6, 8, N'56789', CAST(0x0000A47700D827F0 AS DateTime), CAST(0x0000A56B00D86E40 AS DateTime), N'4567890', CAST(0x0000A54C00D88167 AS DateTime), 38, 3, 0, 3, 13, CAST(0x0000A55400380EAC AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (7, 8, N'1125125', CAST(0x0000A5460032CFD0 AS DateTime), CAST(0x0000A54900331620 AS DateTime), N'41241', CAST(0x0000A54E00337717 AS DateTime), 3, 1, 0, 3, 13, CAST(0x0000A55400383AF3 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (8, 8, N'demo1241', CAST(0x0000A5480033A2C0 AS DateTime), CAST(0x0000A54D0033E910 AS DateTime), NULL, CAST(0x0000A54E00341728 AS DateTime), 4, 1, 0, 3, 13, CAST(0x0000A55400355B53 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (9, 8, N'51251', CAST(0x0000A549003548A0 AS DateTime), CAST(0x0000A54E00358EF0 AS DateTime), N'Enter your description2', CAST(0x0000A54E003615FF AS DateTime), 1, 2, 0, 3, 13, CAST(0x0000A54E003615FF AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (10, 8, N'4125151', CAST(0x0000A477003DCC50 AS DateTime), CAST(0x0000A41E003E12A0 AS DateTime), N'41241241', CAST(0x0000A54E003E6159 AS DateTime), 1, 1, 0, 3, 13, CAST(0x0000A54E003E6159 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (11, 8, N'41251251', CAST(0x0000A495003F7230 AS DateTime), CAST(0x0000A459003FB880 AS DateTime), N'41241', CAST(0x0000A54E003FAAEE AS DateTime), 2, 1, 0, 3, 13, CAST(0x0000A54E003FAAEE AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (12, 8, N'5125125', CAST(0x0000A52E00404520 AS DateTime), CAST(0x0000A52F00408B70 AS DateTime), N'512512512', CAST(0x0000A54E00409AD0 AS DateTime), 0, 4, 0, 3, 13, CAST(0x0000A54E00409AD0 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (13, 1, N'ewesdrfghuji', CAST(0x0000A56B011EBE40 AS DateTime), CAST(0x0000A41E011EBE40 AS DateTime), N'412', CAST(0x0000A54E011EF426 AS DateTime), 4, 1, 0, 3, 13, CAST(0x0000A55E013ED9AF AS DateTime), N'', 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (14, 8, N'DEmo 2', CAST(0x0000A5540120AA70 AS DateTime), CAST(0x0000A5590120F0C0 AS DateTime), N'Demo', CAST(0x0000A55101211BEC AS DateTime), 0, 5, 0, 3, 13, CAST(0x0000A55101211BEC AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (15, 8, N'Demo24124', CAST(0x0000A55401225050 AS DateTime), CAST(0x0000A55D012296A0 AS DateTime), NULL, CAST(0x0000A551012287D3 AS DateTime), 6, 2, 0, 3, 13, CAST(0x0000A551012287D3 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (16, 8, N'demo 3', CAST(0x0000A55101259C10 AS DateTime), CAST(0x0000A5530125E260 AS DateTime), N'Demo', CAST(0x0000A5510125DF6B AS DateTime), 1, 3, 0, 3, 13, CAST(0x0000A5510125DF6B AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (17, 8, N'Demo 6', CAST(0x0000A55101373010 AS DateTime), CAST(0x0000A55301377660 AS DateTime), NULL, CAST(0x0000A55101375D8D AS DateTime), 0, 5, 0, 3, 13, CAST(0x0000A55101376089 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (18, 8, N'demo 7', CAST(0x0000A551014604F0 AS DateTime), CAST(0x0000A55401464B40 AS DateTime), NULL, CAST(0x0000A55101465B8C AS DateTime), 3, 6, 0, 3, 13, CAST(0x0000A55101465B8C AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (19, 8, N'Demo_art', CAST(0x0000A552002BABB0 AS DateTime), CAST(0x0000A554002BF200 AS DateTime), N'Demo Arts+ avatar', CAST(0x0000A552002BFC4C AS DateTime), 0, 4, 0, 10033, 13, CAST(0x0000A552002BFC59 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (20, 8, N'Demo default avatar', CAST(0x0000A550002C3850 AS DateTime), CAST(0x0000A554002C7EA0 AS DateTime), N'Demo default avatar', CAST(0x0000A552002C7705 AS DateTime), 0, 2, 0, 10034, 13, CAST(0x0000A552002C7706 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (21, 8, N'Demo location', CAST(0x0000A552002D5190 AS DateTime), CAST(0x0000A554002D97E0 AS DateTime), N'Demo location', CAST(0x0000A552002E308B AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552002E308C AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (22, 8, N'demo add live 1', CAST(0x0000A553004E00C0 AS DateTime), CAST(0x0000A554004E4710 AS DateTime), N'demo add live 1', CAST(0x0000A552004E55CD AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552004E55CF AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (23, 8, N'demo live 2', CAST(0x0000A552004ED3B0 AS DateTime), CAST(0x0000A555004F1A00 AS DateTime), N'demo live 2', CAST(0x0000A552004F360A AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552004F360B AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (24, 8, N'demo live 3', CAST(0x0000A552004FA6A0 AS DateTime), CAST(0x0000A554004FECF0 AS DateTime), N'Demo live 2', CAST(0x0000A552004FE421 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552004FE422 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (25, 8, N'demo live 3', CAST(0x0000A552004FA6A0 AS DateTime), CAST(0x0000A554004FECF0 AS DateTime), N'Demo live 2', CAST(0x0000A55200500E63 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55200500E63 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (26, 8, N'demo 12184', CAST(0x0000A55200D33650 AS DateTime), CAST(0x0000A55400D37CA0 AS DateTime), N'Demo 12 50', CAST(0x0000A55200D395F7 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55200D395F8 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (27, 8, N'Demo12151', CAST(0x0000A552011C8BC0 AS DateTime), CAST(0x0000A554011CD210 AS DateTime), N'Demo 111', CAST(0x0000A552011CF078 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552011CF079 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (28, 8, N'Hello', CAST(0x0000A552011DEB50 AS DateTime), CAST(0x0000A554011E31A0 AS DateTime), N'Demo', CAST(0x0000A552011E0CFB AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552011E0CFC AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (29, 8, N'e82759375', CAST(0x0000A552011EBE40 AS DateTime), CAST(0x0000A555011F0490 AS DateTime), N'Demo', CAST(0x0000A552011EE955 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552011EE956 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (30, 8, N'de mo', CAST(0x0000A5520120AA70 AS DateTime), CAST(0x0000A5550120AA70 AS DateTime), N'Demo', CAST(0x0000A5520120B972 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520120B973 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (31, 8, N'thu vien', CAST(0x0000A5520123F630 AS DateTime), CAST(0x0000A55401243C80 AS DateTime), N'demo', CAST(0x0000A5520124214F AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55201242151 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (32, 8, N'thu vien 2', CAST(0x0000A552012555C0 AS DateTime), CAST(0x0000A55701259C10 AS DateTime), N'Demo thu vien 2', CAST(0x0000A552012581C8 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552012581C9 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (33, 8, N'thu vien 3', CAST(0x0000A5520125E260 AS DateTime), CAST(0x0000A554012628B0 AS DateTime), N'demo', CAST(0x0000A55201261B76 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55201261B77 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (34, 8, N'1251512512', CAST(0x0000A5520126B550 AS DateTime), CAST(0x0000A5540126FBA0 AS DateTime), N'3825793287293', CAST(0x0000A5520126D99F AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520126D9A0 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (35, 8, N'Demo15185', CAST(0x0000A5520146D7E0 AS DateTime), CAST(0x0000A55C0146D7E0 AS DateTime), N'Demo41241', CAST(0x0000A5520146FA71 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520146FA72 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (36, 8, N'dota2', CAST(0x0000A5520148C410 AS DateTime), CAST(0x0000A5550148C410 AS DateTime), N'15125151', CAST(0x0000A5520148D01D AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520148D01F AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (38, 8, N'412151', CAST(0x0000A55201549380 AS DateTime), CAST(0x0000A5550154D9D0 AS DateTime), NULL, CAST(0x0000A5520154F862 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520154FA8B AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (39, 8, N'1512521', CAST(0x0000A5520159CB70 AS DateTime), CAST(0x0000A554015A11C0 AS DateTime), N'41415', CAST(0x0000A552015A04D4 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552015A04D5 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (40, 8, N'515151251', CAST(0x0000A552015E3070 AS DateTime), CAST(0x0000A55B015E76C0 AS DateTime), NULL, CAST(0x0000A552015E5829 AS DateTime), 7, 1, 0, 10035, 13, CAST(0x0000A552015E5922 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (41, 8, N'5151515', CAST(0x0000A55201629570 AS DateTime), CAST(0x0000A5540162DBC0 AS DateTime), N'Enter your description515', CAST(0x0000A5520162B01D AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A5520162B01E AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (42, 8, N'512511', CAST(0x0000A55201643B50 AS DateTime), CAST(0x0000A55401643B50 AS DateTime), NULL, CAST(0x0000A5520164450D AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A5520164450D AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (43, 8, N'895710', CAST(0x0000A55201650E40 AS DateTime), CAST(0x0000A55401655490 AS DateTime), NULL, CAST(0x0000A55201655435 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55201655436 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (44, 8, N'195810', CAST(0x0000A55201659AE0 AS DateTime), CAST(0x0000A5540165E130 AS DateTime), NULL, CAST(0x0000A5520165CCFC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520165CCFE AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (45, 8, N'5125151', CAST(0x0000A5520165E130 AS DateTime), CAST(0x0000A55401662780 AS DateTime), NULL, CAST(0x0000A5520165F855 AS DateTime), 0, 3, 0, 10039, 13, CAST(0x0000A5520165F855 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (46, 8, N'523462326', CAST(0x0000A5520166FA70 AS DateTime), CAST(0x0000A55C016740C0 AS DateTime), NULL, CAST(0x0000A552016720C7 AS DateTime), 1, 4, 0, 10033, 13, CAST(0x0000A552016720C9 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (47, 8, N'5125151', CAST(0x0000A552016740C0 AS DateTime), CAST(0x0000A55501678710 AS DateTime), N'5151', CAST(0x0000A55201677DAC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55201677DAD AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (48, 8, N'1251515', CAST(0x0000A55500E556F0 AS DateTime), CAST(0x0000A55600E556F0 AS DateTime), NULL, CAST(0x0000A55500E57545 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500E57546 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (49, 8, N'25361361362', CAST(0x0000A55500000000 AS DateTime), CAST(0x0000A55600E629E0 AS DateTime), NULL, CAST(0x0000A55500E62724 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500E62726 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (50, 8, N'51361343643', CAST(0x0000A55500E67030 AS DateTime), CAST(0x0000A55600E6B680 AS DateTime), NULL, CAST(0x0000A55500E6FB0B AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500E6FB0C AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (51, 8, N'51251616', CAST(0x0000A55500E6FCD0 AS DateTime), CAST(0x0000A55600E74320 AS DateTime), NULL, CAST(0x0000A55500E71EA4 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500E71EA5 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (52, 8, N'89571958', CAST(0x0000A55500EA0240 AS DateTime), CAST(0x0000A55600EA4890 AS DateTime), NULL, CAST(0x0000A55500EA2918 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500EA291A AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (53, 8, N'156354676890-', CAST(0x0000A55500EB61D0 AS DateTime), CAST(0x0000A55600EBA820 AS DateTime), NULL, CAST(0x0000A55500EBB427 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55500EBB429 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (54, 8, N'151515151515', CAST(0x0000A55500EC34C0 AS DateTime), CAST(0x0000A55600EC7B10 AS DateTime), NULL, CAST(0x0000A55500EC62B8 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55500EC62BA AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (55, 8, N'5152151616', CAST(0x0000A55500EF3A30 AS DateTime), CAST(0x0000A55600EF8080 AS DateTime), NULL, CAST(0x0000A55500EF5A18 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55500EF5A1B AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (56, 8, N'5136236', CAST(0x0000A55500EFC6D0 AS DateTime), CAST(0x0000A55600F00D20 AS DateTime), NULL, CAST(0x0000A55500EFEEDE AS DateTime), 4, 1, 0, 10035, 13, CAST(0x0000A55500EFEEE2 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (57, 8, N'153465768654342', CAST(0x0000A55500F1B300 AS DateTime), CAST(0x0000A55600F1F950 AS DateTime), NULL, CAST(0x0000A55500F1E6FC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500F1E700 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (58, 8, N'51345676352', CAST(0x0000A55500F23FA0 AS DateTime), CAST(0x0000A55D00F285F0 AS DateTime), NULL, CAST(0x0000A55500F25628 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500F25629 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (59, 8, N'5456765463542', CAST(0x0000A55500F23FA0 AS DateTime), CAST(0x0000A55600F285F0 AS DateTime), NULL, CAST(0x0000A55500F26EB2 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55500F26EB4 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (60, 22, N'demo212376', CAST(0x0000A5550107F250 AS DateTime), CAST(0x0000A556010838A0 AS DateTime), NULL, CAST(0x0000A5550108240D AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A5550108240F AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (61, 8, N'251251251', CAST(0x0000A559015D1730 AS DateTime), CAST(0x0000A55A015D5D80 AS DateTime), N'5125125125', CAST(0x0000A559015E70C5 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559015E70C6 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (62, 8, N'12525126', CAST(0x0000A559015E76C0 AS DateTime), CAST(0x0000A55B015EBD10 AS DateTime), N'51251', CAST(0x0000A559015ECE6E AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A559015EDFC0 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (63, 8, N'2859715', CAST(0x0000A5590162DBC0 AS DateTime), CAST(0x0000A55B01632210 AS DateTime), N'25121161', CAST(0x0000A55901631F3F AS DateTime), 0, 1, 0, 10044, 13, CAST(0x0000A55901633CE8 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (64, 8, N'21251', CAST(0x0000A559016BA5C0 AS DateTime), CAST(0x0000A55C016BA5C0 AS DateTime), NULL, CAST(0x0000A559016BD7C7 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016BD839 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (65, 8, N'21251', CAST(0x0000A559016BA5C0 AS DateTime), CAST(0x0000A55C016BA5C0 AS DateTime), NULL, CAST(0x0000A559016BD96B AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016BD9D3 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (66, 8, N'21251', CAST(0x0000A559016BA5C0 AS DateTime), CAST(0x0000A55C016BA5C0 AS DateTime), NULL, CAST(0x0000A559016BDC66 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016BDD1B AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (67, 8, N'21251', CAST(0x0000A559016BA5C0 AS DateTime), CAST(0x0000A55C016BA5C0 AS DateTime), NULL, CAST(0x0000A559016BEC47 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016BECCE AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (68, 8, N'915918', CAST(0x0000A559016E1E90 AS DateTime), CAST(0x0000A55B016E64E0 AS DateTime), NULL, CAST(0x0000A559016E7C0A AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016E7C0B AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (69, 8, N'15161', CAST(0x0000A559016E64E0 AS DateTime), CAST(0x0000A55B016EAB30 AS DateTime), NULL, CAST(0x0000A559016EA3BC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016EA3BE AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (70, 8, N'155161', CAST(0x0000A559016EAB30 AS DateTime), CAST(0x0000A55A016EF180 AS DateTime), N'Enter your description', CAST(0x0000A559016F2016 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016F2017 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (71, 8, N'29581098601', CAST(0x0000A5590170DDB0 AS DateTime), CAST(0x0000A55B0170DDB0 AS DateTime), N'5151251', CAST(0x0000A5590170EB68 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590170EB6A AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (72, 8, N'8927519510', CAST(0x0000A55901712400 AS DateTime), CAST(0x0000A55B01712400 AS DateTime), NULL, CAST(0x0000A55901715A57 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901715A58 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (73, 8, N'125151', CAST(0x0000A5590171B0A0 AS DateTime), CAST(0x0000A55B0171F6F0 AS DateTime), NULL, CAST(0x0000A5590171F36C AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590171F36E AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (74, 8, N'15251', CAST(0x0000A5590171F6F0 AS DateTime), CAST(0x0000A55B01723D40 AS DateTime), NULL, CAST(0x0000A559017211AC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017211AD AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (75, 8, N'41251251', CAST(0x0000A55901742970 AS DateTime), CAST(0x0000A55A01746FC0 AS DateTime), NULL, CAST(0x0000A5590174747E AS DateTime), 2, 1, 0, 10035, 13, CAST(0x0000A55901747480 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (76, 8, N'156573', CAST(0x0000A5590174B610 AS DateTime), CAST(0x0000A55B0174FC60 AS DateTime), NULL, CAST(0x0000A5590174C5E8 AS DateTime), 2, 1, 0, 10035, 13, CAST(0x0000A5590174C5EA AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (77, 8, N'156573', CAST(0x0000A5590174B610 AS DateTime), CAST(0x0000A55B0174FC60 AS DateTime), N'Enter your description', CAST(0x0000A5590176248A AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590176248C AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (78, 8, N'1345625', CAST(0x0000A5590176A240 AS DateTime), CAST(0x0000A55B0176E890 AS DateTime), N'12534623', CAST(0x0000A5590176DB4D AS DateTime), 2, 1, 0, 10035, 13, CAST(0x0000A5590176DB4F AS DateTime), NULL, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (79, 8, N'12345623', CAST(0x0000A5590176E890 AS DateTime), CAST(0x0000A55B0176E890 AS DateTime), N'512263626', CAST(0x0000A5590176F842 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A5590176F843 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (80, 8, N'1533464434', CAST(0x0000A55A01777530 AS DateTime), CAST(0x0000A55B0177BB80 AS DateTime), NULL, CAST(0x0000A55901778248 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590177824B AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (81, 8, N'512646', CAST(0x0000A55901777530 AS DateTime), CAST(0x0000A55B0177BB80 AS DateTime), NULL, CAST(0x0000A5590177B8FA AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590177B8FD AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (82, 8, N'5345623', CAST(0x0000A55901788E70 AS DateTime), CAST(0x0000A55C0178D4C0 AS DateTime), NULL, CAST(0x0000A5590178BB20 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590178BB23 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (83, 8, N'3465235', CAST(0x0000A55901788E70 AS DateTime), CAST(0x0000A55B0178D4C0 AS DateTime), NULL, CAST(0x0000A5590178D312 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590178D313 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (84, 8, N'87358374592', CAST(0x0000A55901791B10 AS DateTime), CAST(0x0000A55A01796160 AS DateTime), NULL, CAST(0x0000A55901795A21 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901795A25 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (85, 8, N'547633', CAST(0x0000A55901796160 AS DateTime), CAST(0x0000A55C0179A7B0 AS DateTime), NULL, CAST(0x0000A55901798DD0 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901798DD3 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (86, 8, N'12552352', CAST(0x0000A559017A7AA0 AS DateTime), CAST(0x0000A55A017AC0F0 AS DateTime), NULL, CAST(0x0000A559017AC75E AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017AC760 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (87, 8, N'iu3895', CAST(0x0000A559017AC0F0 AS DateTime), CAST(0x0000A55B017B0740 AS DateTime), NULL, CAST(0x0000A559017B2104 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017B2105 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (88, 8, N'5125151', CAST(0x0000A559017B93E0 AS DateTime), CAST(0x0000A55B017BDA30 AS DateTime), NULL, CAST(0x0000A559017BBD0B AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017BBD10 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (89, 8, N'36545356', CAST(0x0000A559017C2080 AS DateTime), CAST(0x0000A55C017C66D0 AS DateTime), NULL, CAST(0x0000A559017C439F AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017C43A1 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (90, 8, N'251125', CAST(0x0000A559017D39C0 AS DateTime), CAST(0x0000A55B017D39C0 AS DateTime), NULL, CAST(0x0000A559017D4050 AS DateTime), 0, 2, 0, 10034, 13, CAST(0x0000A559017D4055 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (91, 8, N'165678', CAST(0x0000A55901841790 AS DateTime), CAST(0x0000A55C01845DE0 AS DateTime), NULL, CAST(0x0000A55901845BF6 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901845BF8 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (92, 8, N'21354567365', CAST(0x0000A5590184A430 AS DateTime), CAST(0x0000A55D0184EA80 AS DateTime), NULL, CAST(0x0000A5590184E733 AS DateTime), 0, 1, 0, 10045, 13, CAST(0x0000A5590184EAC0 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (93, 8, N'54675', CAST(0x0000A5590184EA80 AS DateTime), CAST(0x0000A55C018530D0 AS DateTime), NULL, CAST(0x0000A55901850B69 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901850B6B AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (94, 8, N'452457', CAST(0x0000A5590185BD70 AS DateTime), CAST(0x0000A55B018603C0 AS DateTime), NULL, CAST(0x0000A5590185FE36 AS DateTime), 0, 1, 0, 10046, 13, CAST(0x0000A559018601AA AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (95, 8, N'423463', CAST(0x0000A559018603C0 AS DateTime), CAST(0x0000A55C01864A10 AS DateTime), NULL, CAST(0x0000A559018643FF AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901864404 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (96, 8, N'346563', CAST(0x0000A55C01871D00 AS DateTime), CAST(0x0000A55D01876350 AS DateTime), NULL, CAST(0x0000A5590187626D AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901876271 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (97, 8, N'4656513', CAST(0x0000A55901883640 AS DateTime), CAST(0x0000A55C01887C90 AS DateTime), NULL, CAST(0x0000A55901886BCC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901886BD0 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (98, 8, N'534653', CAST(0x0000A559018995D0 AS DateTime), CAST(0x0000A55C0189DC20 AS DateTime), NULL, CAST(0x0000A5590189BBE5 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590189BBE8 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (99, 22, N'235678762143453465763524145367', CAST(0x0000A55A009FD9E0 AS DateTime), CAST(0x0000A55C009FD9E0 AS DateTime), N'13245678980', CAST(0x0000A55A00A04203 AS DateTime), 1, 1, 0, 10035, 27, CAST(0x0000A55A00A04205 AS DateTime), NULL, 1, NULL)
GO
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (100, 22, N'235678762143453465763524145367', CAST(0x0000A55A009FD9E0 AS DateTime), CAST(0x0000A55C009FD9E0 AS DateTime), N'5767867969679679679', CAST(0x0000A55A00A06637 AS DateTime), 3, 1, 0, 10035, 13, CAST(0x0000A55D011BDB88 AS DateTime), N'I dont want your event in my website xD', 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (101, 22, N'143235', CAST(0x0000A55A00F6A4A0 AS DateTime), CAST(0x0000A55C00F6EAF0 AS DateTime), NULL, CAST(0x0000A55A00F6B95E AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A55A00F6B961 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (102, 22, N'345462', CAST(0x0000A55A00F84A80 AS DateTime), CAST(0x0000A55C00F890D0 AS DateTime), NULL, CAST(0x0000A55A00F85BB9 AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A55A00F85BBE AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (103, 22, N'413265', CAST(0x0000A55A00F8D720 AS DateTime), CAST(0x0000A55B00F91D70 AS DateTime), NULL, CAST(0x0000A55A00F914C2 AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A55A00F914C6 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (104, 22, N'123465', CAST(0x0000A55A00FA36B0 AS DateTime), CAST(0x0000A55B00FA7D00 AS DateTime), NULL, CAST(0x0000A55A00FA6CB0 AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A55A00FA6CB1 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (105, 8, N'1253463', CAST(0x0000A55B00B54640 AS DateTime), CAST(0x0000A55C00B58C90 AS DateTime), N'25151', CAST(0x0000A55B00B5945D AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55B00B5945F AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (106, 8, N'demo follow', CAST(0x0000A55B00B58C90 AS DateTime), CAST(0x0000A55D00B5D2E0 AS DateTime), N'demo', CAST(0x0000A55B00B5DB71 AS DateTime), 1, 5, 0, 10037, 13, CAST(0x0000A55B00B5DB74 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (107, 22, N'1345655', CAST(0x0000A55B00D6C860 AS DateTime), CAST(0x0000A55C00D70EB0 AS DateTime), N'215475', CAST(0x0000A55B00D6E16A AS DateTime), 0, 6, 0, 10048, 27, CAST(0x0000A55B00D6E403 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (108, 8, N'423582658732658236', CAST(0x0000A55C00EE6740 AS DateTime), CAST(0x0000A55D00EEAD90 AS DateTime), N'2543654756', CAST(0x0000A55C00EEC423 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55C00EEC426 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (109, 8, N'demo 12184', CAST(0x0000A55D00317040 AS DateTime), CAST(0x0000A55D0031B690 AS DateTime), N'abc', CAST(0x0000A55C00F77B33 AS DateTime), 0, 1, 0, 10054, 13, CAST(0x0000A56001811546 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (10108, 8, N'demo 27', CAST(0x0000A55D01163A90 AS DateTime), CAST(0x0000A55E011680E0 AS DateTime), N'demo 27', CAST(0x0000A55D011690B6 AS DateTime), 1, 1, 0, 20055, 13, CAST(0x0000A55D01169563 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (10109, 8, N'43245674', CAST(0x0000A55E010087E0 AS DateTime), CAST(0x0000A5600100CE30 AS DateTime), N'&lt;ol&gt;&lt;ol&gt;&lt;li style=''text-align: center; ''&gt;&lt;img src=''http://i.imgur.com/vCBNmUy.gif'' style=''width: 215px;''&gt;&lt;span style=''background-color: rgb(247, 247, 247);''&gt;512512151&lt;/span&gt;&lt;/li&gt;&lt;/ol&gt;&lt;/ol&gt;', CAST(0x0000A55E0100DDF4 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55E0100DE15 AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [LockedReason]) VALUES (10110, 8, N'332546', CAST(0x0000A5600182FE50 AS DateTime), CAST(0x0000A562018344A0 AS DateTime), N'&lt;p&gt;35251&lt;/p&gt;', CAST(0x0000A56001834DAD AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A56001834DCA AS DateTime), NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[Event] OFF
SET IDENTITY_INSERT [dbo].[EventFollow] ON 

INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (7, 1, 3)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (8, 1, 5)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (59, 1, 4)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10072, 1, 12)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10098, 6, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10106, 2, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10110, 0, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10116, 3, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10119, 15, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10124, 104, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10125, 105, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (20130, 10109, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (20132, 10108, 13)
SET IDENTITY_INSERT [dbo].[EventFollow] OFF
SET IDENTITY_INSERT [dbo].[EventImage] ON 

INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (1, 1, 3)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (4, 1, NULL)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (5, 1, NULL)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (7, 9, 10022)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (8, 1, 10023)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (9, 1, 10025)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (12, 40, 10040)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (13, 2, 10041)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (14, 2, 10047)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (15, 56, 10049)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (17, 10108, 20056)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (18, 108, 20057)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID]) VALUES (19, 108, 20058)
SET IDENTITY_INSERT [dbo].[EventImage] OFF
SET IDENTITY_INSERT [dbo].[EventPlace] ON 

INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (1, 1, 7)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (2, 1, 2)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (3, 2, 8)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (4, 3, 9)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (5, 4, 9)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (6, 5, 9)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (7, 0, 9)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (8, 6, 11)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (9, 7, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10, 8, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (11, 8, 14)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (12, 8, 15)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (13, 9, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (14, 9, 16)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (15, 10, 17)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (16, 11, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (17, 12, 18)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (18, 13, 19)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (19, 14, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (20, 15, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (21, 16, 20)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (22, 17, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (23, 18, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (24, 19, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (25, 20, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (26, 21, 16)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (27, 21, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (28, 22, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (29, 23, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (30, 24, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (31, 25, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (32, 25, 21)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (33, 25, 22)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (34, 26, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (35, 27, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (36, 27, 16)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (37, 28, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (38, 29, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (39, 30, 24)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (40, 31, 14)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (41, 32, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (42, 33, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (43, 34, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (44, 35, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (45, 36, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (46, 38, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (47, 39, 25)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (48, 40, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (49, 41, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (50, 42, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (51, 43, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (52, 44, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (53, 45, 16)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (54, 46, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (55, 47, 26)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (56, 48, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (57, 49, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (58, 50, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (59, 51, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (60, 52, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (61, 53, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (62, 54, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (63, 55, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (64, 56, 28)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (65, 57, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (66, 58, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (67, 59, 30)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (68, 60, 14)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (69, 61, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (70, 62, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (71, 63, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (72, 64, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (73, 65, 32)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (74, 66, 32)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (75, 67, 32)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (76, 68, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (77, 69, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (78, 70, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (79, 71, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (80, 72, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (81, 72, 33)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (82, 72, 34)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (83, 73, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (84, 74, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (85, 75, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (86, 76, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (87, 77, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (88, 78, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (89, 79, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (90, 80, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (91, 81, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (92, 82, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (93, 83, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (94, 84, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (95, 85, 35)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (96, 86, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (97, 87, 34)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (98, 88, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (99, 89, 29)
GO
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (100, 90, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (101, 91, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (102, 92, 36)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (103, 93, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (104, 94, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (105, 95, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (106, 96, 37)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (107, 97, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (108, 98, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (109, 99, 38)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (110, 100, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (111, 101, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (112, 102, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (113, 103, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (114, 104, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (115, 105, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (116, 106, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (117, 107, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (118, 108, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10118, 10108, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10119, 10109, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10120, 109, 39)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10121, 10110, 27)
SET IDENTITY_INSERT [dbo].[EventPlace] OFF
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (0, 206)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (1, 4580)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (2, 174)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (3, 84)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (4, 28)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (5, 16)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (6, 212)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (7, 12)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (8, 16)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (9, 74)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (11, 8)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (12, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (13, 16)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (14, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (15, 64)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (16, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (17, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (18, 42)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (19, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (20, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (21, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (22, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (23, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (24, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (25, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (26, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (27, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (28, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (29, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (30, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (31, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (32, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (33, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (34, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (35, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (36, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (38, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (39, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (40, 48)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (41, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (42, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (43, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (44, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (45, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (46, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (47, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (48, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (49, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (50, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (51, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (52, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (53, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (54, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (55, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (56, 16)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (57, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (58, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (59, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (60, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (61, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (62, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (63, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (64, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (65, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (66, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (67, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (68, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (69, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (70, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (71, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (72, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (73, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (74, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (75, 8)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (76, 8)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (77, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (78, 8)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (79, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (80, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (81, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (82, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (83, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (84, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (85, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (86, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (87, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (88, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (89, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (90, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (91, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (92, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (93, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (94, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (95, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (96, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (97, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (98, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (99, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (100, 12)
GO
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (101, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (102, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (103, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (104, 40)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (105, 40)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (106, 4)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (107, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (108, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (109, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10108, 74)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10109, 40)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10110, 0)
SET IDENTITY_INSERT [dbo].[Image] ON 

INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (3, 2, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A53700000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10005, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54700000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10006, 12, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54700000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10007, 12, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54700000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10008, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54800000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10009, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10010, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10011, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10012, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10013, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10014, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10015, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10016, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54A00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10017, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54A00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10018, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/9568e4e3-403d-423a-a2ad-feb43e39a12013.png', CAST(0x0000A54B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10019, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/97c1388f-142c-411c-9d66-1477a98f52c91.png', CAST(0x0000A54C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10020, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/2ae405b3-7952-4a54-b53b-3c753370caef1.png', CAST(0x0000A54C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10022, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/d188cd66-c815-443e-b394-8bd2779540fe9.png', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10023, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/92186c55-286b-478f-b988-deb9b96fe0201.png', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10024, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/3ee11985-1ad4-4d17-9589-3d4c09a0182a13.png', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10025, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/fb306213-4886-4427-9ce6-3c554d76cfe21.png', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10032, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/default-avatar.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10033, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Arts.png', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10034, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Food+%26+Drink.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10035, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Music.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10036, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Networking.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10037, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Parties.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10038, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Sport+%26+Wellness.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10039, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/classes.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10040, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/b672c910-e09b-4aed-9fcf-fcba68d3e46440.jpg', CAST(0x0000A55300000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10041, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/82f5254b-ce01-4e4f-9056-a1f11c9988f12.jpg', CAST(0x0000A55500000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10042, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/9986c768-fa95-4c10-9f37-26ca4c064b1d13.jpg', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10043, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/cde4eb01-981c-4e95-8297-1c1f5bef689713.jpg', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10044, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/fb3ae843-4288-4f8d-8a27-4178c472140613.jpg', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10045, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/3c54a1d4-ec19-41a0-9d98-454e6ec63e8d13.jpg', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10046, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/2c241ce8-3eca-4525-8c11-96005ca1291613.png', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10047, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/c3236635-00d5-4c7c-a439-86bcff0141632.jpg', CAST(0x0000A55B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10048, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/867b9adc-2e19-4011-8446-67c00bea1e7027.jpg', CAST(0x0000A55B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10049, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/f6090171-470e-4a81-a25b-7263f7c520fd56.jpg', CAST(0x0000A55B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10050, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/a155a75d-a705-44dc-93dd-74607d1aac4e13.jpg', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10051, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/a5552686-0e32-49aa-b632-172ae44c22b413.png', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10052, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/c95701d0-715e-4017-a205-13607cfc2bfd13.jpg', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10053, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/2150c1f9-8395-42f3-a063-b05b03da93b113.png', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10054, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/bfb4d751-6e99-465e-afd8-de093353fa0b13.jpg', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20055, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/69ce9775-ed56-429a-be06-11f63fc5285413.png', CAST(0x0000A55D00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20056, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/bcfbdaef-4498-4068-8304-3a2c37491a4710108.jpg', CAST(0x0000A55D00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20057, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/1ec927d3-004e-4ff6-9cca-67e4246fa909108.jpg', CAST(0x0000A56000000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20058, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/e731ba69-e0da-454b-9873-171c98532085108.jpg', CAST(0x0000A56000000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[Image] OFF
SET IDENTITY_INSERT [dbo].[LikeDislike] ON 

INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (1, 1, 2, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (2, 1, 3, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (3, 1, 13, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (4, 1, 12, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (5, 2, 13, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (6, 3, 13, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (7, 0, 13, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (8, 6, 13, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (9, 9, 13, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (10, 9, 27, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (11, 1, 27, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (12, 40, 27, -1)
SET IDENTITY_INSERT [dbo].[LikeDislike] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (2, 105.837017, 21.030379, N'Bảo tàng Mỹ thuật Việt Nam, 66 Nguyễn Thái Học, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (3, 105.84899, 21.022947, N'Trung tâm Giao lưu Văn hóa Nhật Bản tại Việt Nam 27 Quang Trung, Hoàn Kiếm, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (4, 105.856258, 21.024564, N'Swing 21 Tràng Tiền, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (5, 105.876266, 21.047961, N'Tầng 2, 292 Tây Sơn, Tòa nhà Kinh Đô, Quận Đống Đa, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (7, 105.526555, 21.013629, N'Đại học FPT thạch thất hà nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (8, 105.52655549999996, 21.0136289, N'FPT University, Thạch Thất, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (9, 105.83415979999997, 21.0277644, N'Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (10, 152.93236019999995, -27.7369652, N'Queensland, 4124, Úc')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (11, 105.86075069999993, 21.0090571, N'Hai Bà Trưng, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (12, 75.87663329999998, 29.6507626, N'125120, Ấn Độ')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (13, 105.83415979999995, 21.0277644, N'Hà Noi, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (14, 105.52106070000002, 20.9891204, N'Hòa Lạc, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (15, 105.81716359999996, 21.0316851, N'FPT Hà Nội, Vạn Bảo, Ngọc Khánh, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (16, 105.54157550000002, 21.0075179, N'Hoa Lac Hi-Tech Park, tt. Liên Quan, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (17, 7.2499212000000171, 51.0489965, N'51515, Kürten, Đức')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (18, 105.84276879999993, 21.0278995, N'21412 Hà Nội, Cửa Nam, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (19, 105.97880110000006, 21.0792026, N'VSIP Bắc Ninh, tx. Từ Sơn, Bắc Ninh, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (20, 105.85230590000003, 21.0137888, N'Ha Tay Co., Ltd, Ngô Thì Nhậm, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (21, 105.85725189999994, 21.0228524, N'Cua Long Shop, Hà Noi, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (22, 105.84878679999997, 21.0368623, N'Ha Long Hotel, Hàng Mã, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (23, 105.84260710000001, 21.0252277, N'Hà Nội, Cửa Nam, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (24, 105.8529595, 21.0323006, N'Democracy Hotel, Cầu Gỗ, Hà Noi, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (25, 105.83616970000003, 21.0546707, N'H Mart, Yên Phụ, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (26, 105.84415190000004, 21.0267781, N'Hà Nội branch, Hai Bà Trưng, Cửa Nam, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (27, 105.83415979999995, 21.0277644, N'Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (28, 105.84778640000002, 21.0098302, N'Hoa Lư, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (29, 105.54157550000002, 21.0075179, N'Khu Công nghệ cao Hòa Lạc, tt. Liên Quan, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (30, 105.84598789999996, 20.9964525, N'124 Đại La, Đại La, Trương Định, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (31, 105.83415979999995, 21.0277644, N'Hanoi Vietnam, Đường Thành, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (32, 105.54157550000002, 21.0075179, N'ha noi')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (33, 105.7822605, 21.0285295, N'FPT University, Mỹ Đình 2, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (34, 105.52748889999998, 21.0136689, N'FPT University, Thạch Thất, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (35, 3.9118720000000167, 51.8031945, N'3253 Ouddorp, Hà Lan')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (36, 105.85101320000001, 21.027964, N'Hoàn Kiếm, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (37, 105.852666, 21.008647, N'536 Trần Khát Chân, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (38, 18.08470710000006, 59.2363294, N'123 46 Stockholm, Thuỵ Điển')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (39, 105.8341598, 21.0277644, N'Hà Nội, Việt Nam')
SET IDENTITY_INSERT [dbo].[Location] OFF
SET IDENTITY_INSERT [dbo].[NotificationChange] ON 

INSERT [dbo].[NotificationChange] ([ID], [NotificationID], [EventID], [ActorID], [AddDate], [IsRead], [Type], [ReveiverID]) VALUES (1, 1, 10, 2, CAST(0x883A0B00 AS Date), 0, 5, 13)
SET IDENTITY_INSERT [dbo].[NotificationChange] OFF
SET IDENTITY_INSERT [dbo].[PeopleFollow] ON 

INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (1, 13, 1)
INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (2, 13, 2)
INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (3, 13, 3)
SET IDENTITY_INSERT [dbo].[PeopleFollow] OFF
SET IDENTITY_INSERT [dbo].[Report] ON 

INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (1, 1, 13, 1, N'', 1, CAST(0x0000A55B0025A8F3 AS DateTime), CAST(0x0000A55C0020391E AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (2, 2, 13, 1, N'', 3, CAST(0x0000A55B002B325A AS DateTime), CAST(0x0000A55E013F1FAB AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (3, 13, 13, 1, N'', 1, CAST(0x0000A55B002B747A AS DateTime), CAST(0x0000A56100BB494E AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (4, 6, 13, 1, N'', 1, CAST(0x0000A55B002CA0C1 AS DateTime), CAST(0x0000A55E01769CA7 AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (5, 1, 2, 1, N'', 3, CAST(0x0000A55B002D784C AS DateTime), CAST(0x0000A55C000F8796 AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (6, 3, 2, 1, N'', 1, CAST(0x0000A55B002E533B AS DateTime), CAST(0x0000A55E0173EB1F AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (7, 4, 2, 1, N'', 1, CAST(0x0000A55B00320256 AS DateTime), CAST(0x0000A55E017384CF AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (8, 5, 2, 1, N'', 1, CAST(0x0000A55B00328397 AS DateTime), CAST(0x0000A55E01767085 AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (9, 8, 2, 1, N'', 2, CAST(0x0000A55B003302DD AS DateTime), CAST(0x0000A5610013EC3C AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (10, 7, 2, 1, N'', 2, CAST(0x0000A55B003371CD AS DateTime), CAST(0x0000A56100BB217D AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (11, 11, 2, 2, N'', 0, CAST(0x0000A55B0033F8A2 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (12, 15, 2, 2, N'', 0, CAST(0x0000A55B0034C417 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (13, 41, 2, 2, N'', 0, CAST(0x0000A55B003545F6 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (14, 42, 2, 1, N'', 0, CAST(0x0000A55B0035F78B AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (15, 62, 2, 1, N'', 0, CAST(0x0000A55B00367663 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (16, 76, 2, 2, N'', 0, CAST(0x0000A55B003777E6 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (17, 16, 2, 2, N'', 0, CAST(0x0000A55B00388915 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (18, 56, 2, 1, N'', 0, CAST(0x0000A55B00398363 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (19, 75, 2, 1, N'', 0, CAST(0x0000A55B003B63BD AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (20, 78, 2, 8, N'', 1, CAST(0x0000A55B003BA28E AS DateTime), CAST(0x0000A56100BB6406 AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (21, 79, 2, 9, N'', 0, CAST(0x0000A55B003BE78B AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (22, 26, 2, 9, N'', 0, CAST(0x0000A55B003CB262 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (23, 1, 27, 1, N'', 3, CAST(0x0000A55B00D65C31 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (24, 2, 27, 2, N'252465512346', 3, CAST(0x0000A55B00D6916D AS DateTime), CAST(0x0000A55C00167FDB AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (25, 2, 33, 1, N'', 1, CAST(0x0000A5610045C5AB AS DateTime), CAST(0x0000A56100A3F006 AS DateTime), 13)
SET IDENTITY_INSERT [dbo].[Report] OFF
SET IDENTITY_INSERT [dbo].[ReportDefine] ON 

INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (1, N'Sexual content', N'Includes graphic sexual activity, nudity, and other sexual content.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (2, N'Violent or repulsive content', N'Violent or graphic content, or content posted to shock viewers.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (8, N'Hateful or abusive content', N'Content that promotes hatred against protected groups, abuses vulnerable individuals, or engages in cyberbullying.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (9, N'Harmful dangerous acts', N'Content that includes acts that may result in physical harm')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (10, N'Child abuse', N'Content that includes sexual, predatory or abusive communications towards minors.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (11, N'Spam or misleading', N'Content that is massively posted or otherwise misleading in nature.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (12, N'Infringes my rights', N'Privacy, copyright and other legal complaints.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (13, N'Other', N'Other violation')
SET IDENTITY_INSERT [dbo].[ReportDefine] OFF
SET IDENTITY_INSERT [dbo].[TrackingAction] ON 

INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (7, 13, 13, 2, 0, 1, CAST(0x0000A5540028077D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (8, 13, 13, 2, 0, 1, CAST(0x0000A55400280C89 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (9, 13, 4, 2, 0, 1, CAST(0x0000A55400281135 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (10, 13, 13, 2, 0, 1, CAST(0x0000A55400291263 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (11, 13, 13, 2, 0, 1, CAST(0x0000A554002B137E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (12, 13, 13, 2, 0, 1, CAST(0x0000A554002B176F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (13, 13, 13, 2, 0, 1, CAST(0x0000A554002D35F7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (14, 13, 4, 2, 0, 1, CAST(0x0000A554002DDD85 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (15, 13, 4, 2, 0, 1, CAST(0x0000A554002E7B7C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (16, 13, 4, 2, 0, 1, CAST(0x0000A554002F7A57 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (17, 13, 13, 2, 0, 1, CAST(0x0000A5540032505C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (18, 13, 13, 2, 0, 1, CAST(0x0000A5540035504A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (19, 13, 13, 2, 0, 1, CAST(0x0000A55400355B74 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20, 13, 13, 2, 0, 1, CAST(0x0000A5540037E92B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (21, 13, 13, 2, 0, 1, CAST(0x0000A55400380ECE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (22, 13, 13, 2, 0, 1, CAST(0x0000A554003826F7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (23, 13, 13, 2, 0, 1, CAST(0x0000A55400383B06 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (24, 13, 13, 2, 0, 1, CAST(0x0000A5540038A036 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (25, 13, 4, 2, 0, 1, CAST(0x0000A5540038E93C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (26, 13, 13, 2, 0, 1, CAST(0x0000A5540038FB69 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (27, 13, 13, 2, 0, 1, CAST(0x0000A5540038FF8E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (28, 13, 13, 2, 0, 1, CAST(0x0000A554003A17F8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (29, 13, 13, 2, 0, 1, CAST(0x0000A554003A9E6E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (30, 13, 13, 2, 0, 2, CAST(0x0000A554003CD738 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (31, 13, 4, 2, 0, 2, CAST(0x0000A554003D33AE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (32, 13, 13, 2, 0, 2, CAST(0x0000A554003DA2E3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (33, 13, 13, 2, 0, 2, CAST(0x0000A554003DA4F7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (34, 13, 13, 2, 0, 2, CAST(0x0000A554003DA8B0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (35, 13, 13, 2, 0, 1, CAST(0x0000A554003DBE8D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (36, 13, 13, 2, 0, 2, CAST(0x0000A554003DC128 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (37, 13, 13, 2, 0, 1, CAST(0x0000A554003DC2EF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (38, 13, 13, 2, 0, 2, CAST(0x0000A554003DC757 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (39, 13, 13, 2, 0, 1, CAST(0x0000A554003DC899 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (40, 13, 13, 2, 0, 2, CAST(0x0000A554003DCE55 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (41, 13, 13, 2, 0, 1, CAST(0x0000A554003DD031 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (42, 13, 13, 2, 0, 2, CAST(0x0000A554003DD168 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (43, 13, 13, 2, 0, 1, CAST(0x0000A554003DE96F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (44, 13, 13, 2, 0, 2, CAST(0x0000A554003DEAEF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (45, 13, 13, 2, 0, 1, CAST(0x0000A554003DEC46 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (46, 13, 13, 2, 0, 2, CAST(0x0000A554003DEDEC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (47, 13, 13, 2, 0, 1, CAST(0x0000A554003DEF39 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (48, 13, 13, 2, 0, 2, CAST(0x0000A554003DF094 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (49, 13, 13, 2, 0, 1, CAST(0x0000A554003DF1DD AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (50, 13, 13, 2, 0, 2, CAST(0x0000A554003DF2FB AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (51, 13, 13, 2, 0, 1, CAST(0x0000A554003DF431 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (52, 13, 13, 2, 0, 2, CAST(0x0000A554003DF73F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (53, 13, 4, 2, 0, 1, CAST(0x0000A554003DF942 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (54, 13, 4, 2, 0, 1, CAST(0x0000A554003F1C4F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (55, 13, 4, 2, 0, 2, CAST(0x0000A55400406D07 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (56, 13, 4, 2, 0, 1, CAST(0x0000A554004512C8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (57, 13, 4, 2, 0, 2, CAST(0x0000A554004555CE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (58, 13, 4, 2, 0, 1, CAST(0x0000A55400455CD8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (59, 13, 4, 2, 0, 2, CAST(0x0000A55400456C62 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (60, 13, 4, 2, 0, 1, CAST(0x0000A55400458CD1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (61, 13, 4, 2, 0, 1, CAST(0x0000A554004745A8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (62, 13, 4, 2, 0, 2, CAST(0x0000A554004753F0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (63, 13, 4, 2, 0, 1, CAST(0x0000A5540047E0CA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (64, 13, 4, 2, 0, 2, CAST(0x0000A5540047E291 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (65, 13, 13, 2, 0, 1, CAST(0x0000A554004AC7E1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (66, 13, 13, 2, 0, 2, CAST(0x0000A554004AC9BB AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (67, 13, 1, 2, 0, 4, CAST(0x0000A554005CD761 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (68, 13, 1, 2, 0, 4, CAST(0x0000A554005CE58D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (69, 13, 1, 2, 0, 4, CAST(0x0000A554005D697E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (70, 13, 1, 2, 0, 4, CAST(0x0000A554005D6DEF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (71, 13, 1, 2, 0, 4, CAST(0x0000A554005D6F71 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (72, 13, 1, 2, 0, 1, CAST(0x0000A554005E0A6D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (73, 13, 2, 2, 0, 1, CAST(0x0000A554005E5291 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (74, 13, 1, 2, 0, 4, CAST(0x0000A554005F90D1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (75, 13, 1, 2, 0, 1, CAST(0x0000A554005F971F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (76, 13, 1, 2, 0, 4, CAST(0x0000A554005F9C89 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (77, 13, 2, 2, 0, 4, CAST(0x0000A554005FAB96 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (10067, 13, 1, 2, 0, 1, CAST(0x0000A55400E7A165 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (10068, 13, 1, 2, 0, 4, CAST(0x0000A5540104B9C8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20068, 13, 13, 2, 0, 1, CAST(0x0000A5540115C0EA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20069, 13, 13, 2, 0, 2, CAST(0x0000A5540115C691 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20070, 13, 1, 2, 0, 1, CAST(0x0000A5540115CF37 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20071, 13, 1, 2, 0, 4, CAST(0x0000A5540115D111 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20072, 13, 13, 2, 0, 1, CAST(0x0000A55A000EE26B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20073, 13, 13, 2, 0, 2, CAST(0x0000A55A000EE7EC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20074, 13, 1, 2, 0, 1, CAST(0x0000A55A000F08CC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20075, 13, 1, 2, 0, 4, CAST(0x0000A55A000F0BE6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20076, 13, 1, 2, 0, 1, CAST(0x0000A55A008DEC55 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20077, 13, 1, 2, 0, 4, CAST(0x0000A55A008DEF1F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20078, 13, 1, 2, 0, 5, CAST(0x0000A55A008E789F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20079, 13, 1, 2, 0, 5, CAST(0x0000A55A008EA193 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20080, 13, 1, 2, 0, 5, CAST(0x0000A55A008FE574 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20081, 13, 1, 2, 0, 5, CAST(0x0000A55A00902E41 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20082, 13, 1, 2, 0, 5, CAST(0x0000A55A0092D640 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20083, 13, 1, 2, 0, 5, CAST(0x0000A55A00938544 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20084, 13, 1, 2, 0, 5, CAST(0x0000A55A0095B424 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20085, 13, 1, 2, 0, 5, CAST(0x0000A55A00963133 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20086, 13, 1, 2, 0, 5, CAST(0x0000A55A009D3A36 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20087, 13, 3, 2, 0, 1, CAST(0x0000A55A00B192C4 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20088, 13, 3, 2, 0, 4, CAST(0x0000A55A00B19570 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20089, 13, 1, 2, 0, 5, CAST(0x0000A55A00B35399 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20090, 13, 1, 2, 0, 5, CAST(0x0000A55A00B36F2D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20091, 13, 9, 2, 0, 5, CAST(0x0000A55A00B3C009 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20092, 13, 1, 2, 0, 1, CAST(0x0000A55A00B3D131 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20093, 13, 1, 2, 0, 4, CAST(0x0000A55A00B3D410 AS DateTime))
GO
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20094, 13, 1, 2, 0, 1, CAST(0x0000A55A00B3DD16 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20095, 13, 1, 2, 0, 4, CAST(0x0000A55A00B3DED9 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20096, 13, 1, 2, 0, 1, CAST(0x0000A55A00B3E06A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20097, 13, 1, 2, 0, 4, CAST(0x0000A55A00B3E39C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20098, 13, 1, 2, 0, 1, CAST(0x0000A55A00B3ECC0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20099, 13, 1, 2, 0, 4, CAST(0x0000A55A00B3F228 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20100, 13, 4, 2, 0, 1, CAST(0x0000A55A00B41BFE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20101, 13, 4, 2, 0, 2, CAST(0x0000A55A00B427EC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20102, 13, 4, 2, 0, 1, CAST(0x0000A55A00B433EC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20103, 13, 4, 2, 0, 2, CAST(0x0000A55A00B442C6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20104, 13, 1, 2, 0, 1, CAST(0x0000A55A00B5D0C7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20105, 13, 1, 2, 0, 4, CAST(0x0000A55A00B5D3E3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20106, 13, 1, 2, 0, 5, CAST(0x0000A55A00FAE3BE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20107, 13, 1, 2, 0, 1005, CAST(0x0000A55A0108A4BD AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20108, 13, 2, 2, 0, 1005, CAST(0x0000A55A0108B826 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20109, 13, 3, 2, 0, 1005, CAST(0x0000A55A010A2FCA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20116, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EAA40 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20117, 13, 1, 2, 0, 1006, CAST(0x0000A55A010EB178 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20118, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EB536 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20119, 13, 1, 2, 0, 1006, CAST(0x0000A55A010ECBD3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20120, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EDD35 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20121, 13, 1, 2, 0, 1006, CAST(0x0000A55A010EE1AF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20122, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EE5A8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20123, 13, 1, 2, 0, 1006, CAST(0x0000A55A010EE912 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20124, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EF066 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20125, 13, 1, 2, 0, 1006, CAST(0x0000A55A011092E1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20126, 13, 1, 2, 0, 1005, CAST(0x0000A55A0110AC04 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20127, 13, 3, 2, 0, 1006, CAST(0x0000A55A0110B190 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20128, 13, 1, 2, 0, 1006, CAST(0x0000A55A0110BFD2 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20129, 13, 1, 2, 0, 1005, CAST(0x0000A55A0110D029 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20130, 13, 1, 2, 0, 1006, CAST(0x0000A55A0110DA97 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20131, 13, 1, 2, 0, 1005, CAST(0x0000A55A0110E5AC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20132, 13, 1, 2, 0, 1006, CAST(0x0000A55A0110EEBF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20133, 13, 1, 2, 0, 1005, CAST(0x0000A55A01115166 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20134, 13, 1, 2, 0, 1006, CAST(0x0000A55A01119686 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20135, 13, 1, 2, 0, 1005, CAST(0x0000A55A01123EC1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20136, 13, 1, 2, 0, 1006, CAST(0x0000A55A0112479B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20137, 13, 2, 2, 0, 1005, CAST(0x0000A55A01131C4A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20138, 13, 2, 2, 0, 1006, CAST(0x0000A55A011320A6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20139, 13, 2, 2, 0, 1005, CAST(0x0000A55A01132448 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20140, 13, 2, 2, 0, 1006, CAST(0x0000A55A01132756 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20141, 13, 1, 2, 0, 1005, CAST(0x0000A55A01132B4F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20142, 13, 2, 2, 0, 1005, CAST(0x0000A55A01135D1B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20143, 13, 1, 2, 0, 1006, CAST(0x0000A55A01139515 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20144, 13, 2, 2, 0, 1006, CAST(0x0000A55A011398D3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20145, 13, 1, 2, 0, 1005, CAST(0x0000A55A0113A07D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20146, 13, 1, 2, 0, 1006, CAST(0x0000A55A0113A4A7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20147, 13, 1, 2, 0, 1005, CAST(0x0000A55A0113A77A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20148, 13, 1, 2, 0, 1006, CAST(0x0000A55A0113AD53 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20149, 13, 1, 2, 0, 1005, CAST(0x0000A55A01191BD3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20150, 13, 1, 2, 0, 1006, CAST(0x0000A55A0119202C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20151, 13, 1, 2, 0, 1, CAST(0x0000A55A01192D25 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20152, 13, 1, 2, 0, 4, CAST(0x0000A55A0119307F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20153, 13, 1, 2, 0, 1, CAST(0x0000A55A01193256 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20154, 13, 1, 2, 0, 4, CAST(0x0000A55A0119357F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20155, 13, 1, 2, 0, 1005, CAST(0x0000A55A01193864 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20156, 13, 1, 2, 0, 1, CAST(0x0000A55A01193B5F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20157, 13, 1, 2, 0, 4, CAST(0x0000A55A01193DC5 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20158, 13, 1, 2, 0, 1006, CAST(0x0000A55A011940C0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20159, 13, 1, 2, 0, 5, CAST(0x0000A55A01195AA8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20160, 13, 1, 2, 0, 5, CAST(0x0000A55A01196CDB AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20161, 13, 1, 2, 0, 1005, CAST(0x0000A55A01197B9A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20162, 13, 1, 2, 0, 1006, CAST(0x0000A55A01198076 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20163, 30, 1, 3, 0, 1, CAST(0x0000A55A017C2256 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20164, 30, 1, 3, 0, 4, CAST(0x0000A55A017C257E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20165, 30, 1, 3, 0, 1007, CAST(0x0000A55A017C294E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20166, 30, 1, 3, 0, 1007, CAST(0x0000A55A017C339B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20167, 30, 1, 3, 0, 1007, CAST(0x0000A55A0185A78F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20168, 30, 1, 3, 2, 1008, CAST(0x0000A55A018829FA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20169, 30, 1, 3, 2, 1005, CAST(0x0000A55A01883069 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20170, 30, 2, 3, 0, 1007, CAST(0x0000A55A018833F1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20171, 30, 2, 3, 0, 1008, CAST(0x0000A55A0189B319 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20172, 13, 2, 3, 0, 1, CAST(0x0000A55A0189CF70 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20173, 13, 2, 3, 0, 4, CAST(0x0000A55A0189FF2B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20174, 13, 2, 3, 0, 1, CAST(0x0000A55A018ABAEE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20175, 13, 2, 3, 0, 4, CAST(0x0000A55B0001A7AF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20176, 13, 2, 3, 0, 1, CAST(0x0000A55B000313F1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20177, 13, 2, 3, 0, 4, CAST(0x0000A55B00039BF0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20178, 13, 2, 3, 0, 1, CAST(0x0000A55B0004E322 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20179, 13, 2, 3, 0, 4, CAST(0x0000A55B0006EB5D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20180, 13, 2, 3, 0, 1, CAST(0x0000A55B000701D1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20181, 13, 2, 3, 0, 4, CAST(0x0000A55B0007687C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20182, 13, 2, 3, 0, 1, CAST(0x0000A55B000792E7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20183, 13, 2, 3, 0, 4, CAST(0x0000A55B0008BAE3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20184, 13, 2, 3, 0, 1, CAST(0x0000A55B0008D171 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20185, 13, 2, 3, 0, 4, CAST(0x0000A55B0008E8E1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20186, 13, 2, 3, 0, 1, CAST(0x0000A55B0008F333 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20187, 13, 2, 3, 0, 4, CAST(0x0000A55B000944E0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20188, 13, 2, 3, 0, 1, CAST(0x0000A55B00095B7A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20189, 13, 2, 3, 0, 4, CAST(0x0000A55B000A8685 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20190, 13, 2, 3, 0, 1007, CAST(0x0000A55B00D5425D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20191, 13, 2, 3, 0, 1008, CAST(0x0000A55B00D5481C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20192, 13, 13, 3, 3, 1, CAST(0x0000A55B00F5562A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20193, 13, 4, 3, 0, 1, CAST(0x0000A55B00F56E20 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20194, 13, 4, 3, 1, 2, CAST(0x0000A55B00F57033 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20195, 13, 13, 3, 3, 1, CAST(0x0000A55B00F57214 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20196, 13, 13, 3, 3, 1, CAST(0x0000A55B00F58103 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20197, 13, 13, 3, 0, 2, CAST(0x0000A55B00F58270 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20198, 13, 13, 3, 3, 1, CAST(0x0000A55B00F58434 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20199, 13, 13, 3, 0, 2, CAST(0x0000A55B00F58578 AS DateTime))
GO
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20200, 13, 13, 3, 3, 1, CAST(0x0000A55B00F5877D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20201, 13, 13, 3, 3, 1, CAST(0x0000A55B00F59ED3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20202, 13, 4, 3, 0, 1, CAST(0x0000A55B00F5ACA5 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20203, 13, 4, 3, 1, 2, CAST(0x0000A55B00F5AEA9 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20204, 13, 4, 3, 0, 1, CAST(0x0000A55B00F5B036 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20205, 13, 4, 3, 1, 2, CAST(0x0000A55B00F5B19A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20206, 13, 4, 3, 0, 1, CAST(0x0000A55B00F5B342 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20207, 13, 4, 3, 1, 2, CAST(0x0000A55B00F5B4FA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20208, 13, 13, 3, 3, 1, CAST(0x0000A55B00F5B899 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20209, 13, 13, 3, 0, 2, CAST(0x0000A55B00F5BA01 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20210, 13, 1, 3, 1, 1, CAST(0x0000A55B00F5C8A7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20211, 13, 1, 3, 1, 4, CAST(0x0000A55B00F5CA31 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20212, 13, 1, 3, 1, 1, CAST(0x0000A55B00F5CBF4 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20213, 13, 1, 3, 1, 4, CAST(0x0000A55B00F5D083 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20214, 13, 2, 3, 0, 1005, CAST(0x0000A55B00F5D7DA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20215, 13, 2, 3, 0, 1007, CAST(0x0000A55B00F5DC29 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20216, 13, 2, 3, 0, 1008, CAST(0x0000A55B00F5E106 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20217, 13, 2, 3, 0, 1006, CAST(0x0000A55B00F5E6AA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20218, 13, 2, 3, 0, 1005, CAST(0x0000A55B00F5EAAF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20219, 13, 2, 3, 0, 1006, CAST(0x0000A55B00F5EF23 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20220, 13, 2, 3, 0, 1005, CAST(0x0000A55B00F5F3EC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20221, 13, 2, 3, 0, 1006, CAST(0x0000A55B00F5FB3C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20222, 13, 2, 3, 0, 1, CAST(0x0000A55B010151DF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20223, 13, 2, 3, 0, 4, CAST(0x0000A55B01015490 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20224, 13, 13, 3, 3, 1, CAST(0x0000A55B0189E382 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20225, 13, 4, 3, 0, 1, CAST(0x0000A55B018A0A33 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20226, 13, 4, 3, 1, 2, CAST(0x0000A55C0003B0E7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20227, 13, 4, 3, 1, 2, CAST(0x0000A55C001FE278 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20228, 13, 13, 3, 0, 2, CAST(0x0000A55C001FE467 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20229, 13, 13, 3, 0, 2, CAST(0x0000A55C001FE6E1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20230, 13, 4, 3, 1, 2, CAST(0x0000A55C00E24F63 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20231, 13, 13, 3, 3, 1, CAST(0x0000A55D00027CE3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20232, 13, 2, 3, 0, 1, CAST(0x0000A55D0003CDD2 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20233, 13, 29, 3, 0, 1, CAST(0x0000A55D011B6349 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20234, 13, 27, 3, 0, 1, CAST(0x0000A55D011BDBAC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20235, 13, 2, 3, 3, 2, CAST(0x0000A55E013ED9B6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20236, 13, 13, 3, 3, 1, CAST(0x0000A5610013669D AS DateTime))
SET IDENTITY_INSERT [dbo].[TrackingAction] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (1, N'cuongnv764119', N'3e6867ab6a3630d9f7c6db7cda84a1f8', N'Cuong1', N'Nguyen Van', N'441@g4.cc', CAST(0x9F1A0B00 AS Date), NULL, 1, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (2, N'cuongnvse02837', N'489845d6089a0710bff1d4f99a0acc86', N'cuong2', NULL, N'cuongnvse02837@fpt.edu.vn', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (3, N'cuong1111', N'Scylla7601', N'cuong3', NULL, N'cuongnv1412@gmail.com', CAST(0xC3150B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (4, N'cuong111111', N'Scylla7601', N'cuong4', NULL, N'cuong.nv764119@gmail.com', CAST(0xC3150B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (5, N'hinatahyuga1412', N'Scylla7601', N'ニコニコ', N'動画', N'hinatahyuga1412@gmail.com', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (6, N'cuong1234', N'Scylla7601', N'cuong', NULL, N'cuon.gnv764119@gmail.com', CAST(0xE2150B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (7, N'cuong6666', N'Scylla7601', N'cuong', NULL, N'cuongnv.764119@gmail.com', CAST(0x321A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (8, N'cuongnv76', N'Scylla7601', N'cuong', NULL, N'cuong.nv76.4119@gmail.com', CAST(0x2A1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (9, N'cuongnvse02837555', N'Scylla7601', N'cuong', N'fiiuouo', N'123456@1244.cc', CAST(0x321A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (10, N'felixphan1394', N'JOX0D028', N'Phan Thanh', N'Vũ', N'vupt94@gmail.com', CAST(0xD6150B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (11, N'felixphan', N'heaven13', N'Vu', N'Phan', N'VuPTSE61276@fpt.edu.vn', CAST(0xFF370B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (12, N'cuongnvse028377', N'Scylla7601', N'cuong', N'nguyen van', N'cuongnvse0283.7@fpt.edu.vn', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA13A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (13, N'cuongnvse0283777', N'489845d6089a0710bff1d4f99a0acc86', N'Nguyen Van', N'Cuong', N'cuong.nv.se02837@fpt.edu.vn', CAST(0x0C1C0B00 AS Date), N'145465', 3, N'01648080401', N'ha noi', 1, 0, 10053, CAST(0xA13A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (14, N'cuongnvse0283799999999', N'b13cb53261ce5815a2a126117dd01a87', N'cug', NULL, N'cuong@nma.cn', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA13A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (15, N'cuongnvse0283774', N'489845d6089a0710bff1d4f99a0acc86', N'2151', N'512', N'3579357293@wr.c', CAST(0xD6160300 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA13A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (16, N'21546462626', N'Scylla7601', N'14125', N'211521', N'cuong.nv14.12@gmail.com', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (17, N'359812510', N'Scylla7601', N'712957', N'892751', N'cuongnv.1412@gmail.com', CAST(0x53030000 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (18, N'41241251', N'Scylla7601', N'14', NULL, N'c.uongnv1412@gmail.com', CAST(0x73040000 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (19, N'51251251251', N'Scylla7601', N'38575', N'21', N'c.uongnv.1412@gmail.com', CAST(0x7C780200 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (20, N'412515215261', N'Scylla7601', N'cuong', N'24', N'cuon.g.nv1412@gmail.com', CAST(0x9A4D0000 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (21, N'cuong125125125', N'Scylla7601', N'cuong', N'2871', N'2@gmai.co', CAST(0x23100000 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (22, N'cuong12323', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'cuon@gmail.com', CAST(0xBC1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA63A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (23, N'cuong5678', N'25d55ad283aa400af464c76d713c07ad', N'1', N'4567', N'ewrdtf@gmail.com', CAST(0xA83A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA63A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (24, N'412151251', N'25d55ad283aa400af464c76d713c07ad', N'cuong', N'211 ', N'cuong@gmail.dds', CAST(0xA13A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA63A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (25, N'41241241', N'25d55ad283aa400af464c76d713c07ad', N'cuong', N'214', N'123@gmail.com', CAST(0xA03A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA63A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (26, N'2109869509863403', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', N'59128591', N'32852@io3ut3.c', CAST(0x971A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (27, N'14127601', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', N'nguyen van', N'2151@32598.co', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (28, N'5136576246462', N'489845d6089a0710bff1d4f99a0acc86', N'125151', N'23535', N'co@cc.co', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (29, N'4154655423', N'Scylla7601', N'cuong', N'2114', N'12345@3263.cc', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 0, 0, 10032, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (30, N'415643651', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', N'2198', N'cc@351.c', CAST(0x9F1A0B00 AS Date), NULL, 3, NULL, NULL, 1, 0, 10032, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (31, N'adminaskfj', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'cu@of.cc', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xBA3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (32, N'982353425345', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'asf@dd.cc', CAST(0x791A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xBA3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (33, N'446576512254', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'5358727@gmail.com', CAST(0x7D1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xBA3A0B00 AS Date))
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[Video] ON 

INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (1, 1, N'https://www.youtube.com/watch?v=xM-6fHqXvig', CAST(0x0000A53600000000 AS DateTime), CAST(0x0000A53800000000 AS DateTime), 1, N'1', N'1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (2, 20, N'https://www.youtube.com/watch?v=xsHfZA-gGLE', CAST(0x0000A55401225050 AS DateTime), CAST(0x0000A55501225050 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (3, 22, N'https://www.youtube.com/watch?v=3vqaaozEXwk', CAST(0x0000A55101373010 AS DateTime), CAST(0x0000A55201373010 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10, 47, N'https://www.youtube.com/watch?v=ooK9qdKjZXI', CAST(0x0000A5520159CB70 AS DateTime), CAST(0x0000A552016A4630 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (11, 48, N'https://www.youtube.com/watch?v=xeukX7nGhyI', CAST(0x0000A552015E3070 AS DateTime), CAST(0x0000A552016EAB30 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (12, 48, N'https://www.youtube.com/watch?v=dfFdZqvl7MQ', CAST(0x0000A552015E3070 AS DateTime), CAST(0x0000A552016EAB30 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (13, 49, N'https://www.youtube.com/watch?v=LYFC-K2AFd0', CAST(0x0000A55201629570 AS DateTime), CAST(0x0000A55201731030 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (15, 52, N'https://www.youtube.com/watch?v=bKH_9Aq5eEQ', CAST(0x0000A55201659AE0 AS DateTime), CAST(0x0000A552017615A0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (16, 54, N'https://www.youtube.com/watch?v=U7CKrJaZskY', CAST(0x0000A5520166FA70 AS DateTime), CAST(0x0000A55201777530 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (17, 65, N'https://www.youtube.com/watch?v=cmudyoVVyxk', CAST(0x0000A55500F1F950 AS DateTime), CAST(0x0000A55600F1F950 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (18, 67, N'https://www.youtube.com/watch?v=sHZSqRAYNlM', CAST(0x0000A55500F23FA0 AS DateTime), CAST(0x0000A55600F23FA0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (19, 68, N'https://www.youtube.com/watch?v=xyfrQDBXDlo', CAST(0x0000A5550107F250 AS DateTime), CAST(0x0000A5560107F250 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (20, 71, N'https://www.youtube.com/watch?v=Fd3pSKJwgqI', CAST(0x0000A55901632210 AS DateTime), CAST(0x0000A55A01632210 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.2skk-kh5z-11gg-62c2')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (21, 75, N'https://www.youtube.com/watch?v=Uis9Is1ixLU', CAST(0x0000A559016BEC10 AS DateTime), CAST(0x0000A55A016BEC10 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.ghgk-17j3-cyq1-d0uk')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (22, 79, N'https://www.youtube.com/watch?v=7eajeQvpy7c', CAST(0x0000A5590170DDB0 AS DateTime), CAST(0x0000A55A0170DDB0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.esxm-67kc-sbcz-4brz')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (23, 82, N'https://www.youtube.com/watch?v=YGzqbRKGZF4', CAST(0x0000A55901712400 AS DateTime), CAST(0x0000A55A01712400 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.x8yg-brx0-g368-23h1')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (24, 83, N'https://www.youtube.com/watch?v=UyEOdnB_Ifs', CAST(0x0000A5590171B0A0 AS DateTime), CAST(0x0000A55A0171B0A0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.73kt-t1me-gvue-5f77')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (25, 85, N'https://www.youtube.com/watch?v=w2r10SS9qD8', CAST(0x0000A55901746FC0 AS DateTime), CAST(0x0000A55A01746FC0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.tyhg-jjj2-60me-b5zs')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (26, 88, N'https://www.youtube.com/watch?v=XgxZPlAYIVU', CAST(0x0000A5590176A240 AS DateTime), CAST(0x0000A55A0176A240 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.f56e-tjvf-yjga-17yp')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (27, 90, N'https://www.youtube.com/watch?v=KofBiIanCdw', CAST(0x0000A55901777530 AS DateTime), CAST(0x0000A55A01777530 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.k8gf-fpuc-xa34-bdfq')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (28, 92, N'https://www.youtube.com/watch?v=BJuwPnPbHek', CAST(0x0000A55901788E70 AS DateTime), CAST(0x0000A55A01788E70 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.rghg-y7bg-1ywm-9mty')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (29, 94, N'https://www.youtube.com/watch?v=1lxS7wHEC-o', CAST(0x0000A55901791B10 AS DateTime), CAST(0x0000A55A01791B10 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.8ahx-6prs-evq8-1vh8')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (30, 96, N'https://www.youtube.com/watch?v=ytsswzXTFI4', CAST(0x0000A559017AC0F0 AS DateTime), CAST(0x0000A55A017AC0F0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.g0tb-j6cw-kw0u-fu0k')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (31, 98, N'https://www.youtube.com/watch?v=383ZV_0i-TY', CAST(0x0000A559017C2080 AS DateTime), CAST(0x0000A55A017C2080 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.x684-r2e6-q21f-1ws3')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (32, 102, N'https://www.youtube.com/watch?v=SwShNKQkzWg', CAST(0x0000A5590184EA80 AS DateTime), CAST(0x0000A55A0184EA80 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.6ypt-0vzh-qr0d-9dee')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (33, 104, N'https://www.youtube.com/watch?v=4pM0GdaXy_c', CAST(0x0000A559018603C0 AS DateTime), CAST(0x0000A55A018603C0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.gey5-2g5e-m7xd-fhy1')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (34, 105, N'https://www.youtube.com/watch?v=1mAtWdGkORs', CAST(0x0000A5590186D6B0 AS DateTime), CAST(0x0000A55A0186D6B0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.38sd-mm2g-yumk-drgj')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (35, 107, N'https://www.youtube.com/watch?v=-oFE9-G3VgA', CAST(0x0000A55901887C90 AS DateTime), CAST(0x0000A55A01887C90 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.6vgd-5fe7-13fe-27t7')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (36, 110, N'https://www.youtube.com/watch?v=hAPdCHUyBqs', CAST(0x0000A55A00A06680 AS DateTime), CAST(0x0000A55B00A06680 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.pebq-kcrk-ccmj-8c6d')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (37, 115, N'https://www.youtube.com/watch?v=NwvCPk3l3eY', CAST(0x0000A55B00B58C90 AS DateTime), CAST(0x0000A55C00B58C90 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.jsd9-f23a-sbpu-9jpa')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (38, 116, N'https://www.youtube.com/watch?v=jkHLjTEZQVA', CAST(0x0000A55B00B5D2E0 AS DateTime), CAST(0x0000A55C00B5D2E0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.hy5y-vmk0-9asc-bq1e')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10039, 10118, N'https://www.youtube.com/watch?v=ifVVCpnVedY', CAST(0x0000A55D011680E0 AS DateTime), CAST(0x0000A55E011680E0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.ga1f-rwb5-qt7c-cjvv')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10040, 10120, N'https://www.youtube.com/watch?v=Yx-9Dgg86q4', CAST(0x0000A5600181E510 AS DateTime), CAST(0x0000A5610181E510 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.tc32-pe20-zgja-1xfc')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10041, 10121, N'https://www.youtube.com/watch?v=IffkOWALx3Q', CAST(0x0000A560018344A0 AS DateTime), CAST(0x0000A561018344A0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.kgg2-vm95-xd5g-3ejm')
SET IDENTITY_INSERT [dbo].[Video] OFF
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_DateIssue]  DEFAULT (getdate()) FOR [DateIssue]
GO
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_LockedReason]  DEFAULT (N'Your event against our Term Of Service') FOR [LockedReason]
GO
ALTER TABLE [dbo].[NotificationChange] ADD  CONSTRAINT [DF_NotificationChange_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO
ALTER TABLE [dbo].[NotificationChange] ADD  CONSTRAINT [DF_NotificationChange_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[TrackingAction] ADD  CONSTRAINT [DF_TrackingAction_ActionTime]  DEFAULT (getdate()) FOR [ActionTime]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_DataJoin]  DEFAULT (getdate()) FOR [DataJoin]
GO
ALTER TABLE [dbo].[Appeal]  WITH CHECK ADD  CONSTRAINT [FK_Appeal_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Appeal] CHECK CONSTRAINT [FK_Appeal_Event1]
GO
ALTER TABLE [dbo].[Appeal]  WITH CHECK ADD  CONSTRAINT [FK_Appeal_User] FOREIGN KEY([HandleBy])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Appeal] CHECK CONSTRAINT [FK_Appeal_User]
GO
ALTER TABLE [dbo].[CategoryFollow]  WITH CHECK ADD  CONSTRAINT [FK_CategoryFollow_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[CategoryFollow] CHECK CONSTRAINT [FK_CategoryFollow_Category]
GO
ALTER TABLE [dbo].[CategoryFollow]  WITH CHECK ADD  CONSTRAINT [FK_CategoryFollow_User] FOREIGN KEY([FollowerID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[CategoryFollow] CHECK CONSTRAINT [FK_CategoryFollow_User]
GO
ALTER TABLE [dbo].[Channel]  WITH CHECK ADD  CONSTRAINT [FK_Channel_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Channel] CHECK CONSTRAINT [FK_Channel_User]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Event1]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Category]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Channel1] FOREIGN KEY([ChannelID])
REFERENCES [dbo].[Channel] ([ChannelID])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Channel1]
GO
ALTER TABLE [dbo].[EventFollow]  WITH CHECK ADD  CONSTRAINT [FK_EventFollow_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[EventFollow] CHECK CONSTRAINT [FK_EventFollow_Event1]
GO
ALTER TABLE [dbo].[EventFollow]  WITH CHECK ADD  CONSTRAINT [FK_EventFollow_User] FOREIGN KEY([FollowerID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[EventFollow] CHECK CONSTRAINT [FK_EventFollow_User]
GO
ALTER TABLE [dbo].[EventImage]  WITH CHECK ADD  CONSTRAINT [FK_EventImage_Event] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[EventImage] CHECK CONSTRAINT [FK_EventImage_Event]
GO
ALTER TABLE [dbo].[EventImage]  WITH CHECK ADD  CONSTRAINT [FK_EventImage_Image] FOREIGN KEY([ImageID])
REFERENCES [dbo].[Image] ([ImageID])
GO
ALTER TABLE [dbo].[EventImage] CHECK CONSTRAINT [FK_EventImage_Image]
GO
ALTER TABLE [dbo].[EventPlace]  WITH CHECK ADD  CONSTRAINT [FK_EventPlace_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[EventPlace] CHECK CONSTRAINT [FK_EventPlace_Event1]
GO
ALTER TABLE [dbo].[EventPlace]  WITH CHECK ADD  CONSTRAINT [FK_EventPlace_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[EventPlace] CHECK CONSTRAINT [FK_EventPlace_Location]
GO
ALTER TABLE [dbo].[Image]  WITH CHECK ADD  CONSTRAINT [FK_Gallery_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Image] CHECK CONSTRAINT [FK_Gallery_User]
GO
ALTER TABLE [dbo].[LikeDislike]  WITH CHECK ADD  CONSTRAINT [FK_LikeDislike_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[LikeDislike] CHECK CONSTRAINT [FK_LikeDislike_Event1]
GO
ALTER TABLE [dbo].[LikeDislike]  WITH CHECK ADD  CONSTRAINT [FK_LikeDislike_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[LikeDislike] CHECK CONSTRAINT [FK_LikeDislike_User]
GO
ALTER TABLE [dbo].[NotificationChange]  WITH CHECK ADD  CONSTRAINT [FK_NotificationChange_Event] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[NotificationChange] CHECK CONSTRAINT [FK_NotificationChange_Event]
GO
ALTER TABLE [dbo].[NotificationChange]  WITH CHECK ADD  CONSTRAINT [FK_NotificationChange_User] FOREIGN KEY([ActorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[NotificationChange] CHECK CONSTRAINT [FK_NotificationChange_User]
GO
ALTER TABLE [dbo].[NotificationChange]  WITH CHECK ADD  CONSTRAINT [FK_NotificationChange_User1] FOREIGN KEY([ReveiverID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[NotificationChange] CHECK CONSTRAINT [FK_NotificationChange_User1]
GO
ALTER TABLE [dbo].[PeopleFollow]  WITH CHECK ADD  CONSTRAINT [FK_PeopleFollow_User] FOREIGN KEY([FollowerUserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PeopleFollow] CHECK CONSTRAINT [FK_PeopleFollow_User]
GO
ALTER TABLE [dbo].[PeopleFollow]  WITH CHECK ADD  CONSTRAINT [FK_PeopleFollow_User3] FOREIGN KEY([FollowingUserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PeopleFollow] CHECK CONSTRAINT [FK_PeopleFollow_User3]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_Event] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_Event]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_ReportDefine] FOREIGN KEY([ReportType])
REFERENCES [dbo].[ReportDefine] ([ReportTypeID])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_ReportDefine]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_User] FOREIGN KEY([SenderID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_User]
GO
ALTER TABLE [dbo].[Share]  WITH CHECK ADD  CONSTRAINT [FK_Share_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Share] CHECK CONSTRAINT [FK_Share_Event1]
GO
ALTER TABLE [dbo].[Share]  WITH CHECK ADD  CONSTRAINT [FK_Share_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Share] CHECK CONSTRAINT [FK_Share_User]
GO
ALTER TABLE [dbo].[TrackingAction]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAction_ActorAction] FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[TrackingAction] CHECK CONSTRAINT [FK_TrackingAction_ActorAction]
GO
ALTER TABLE [dbo].[TrackingAction]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAction_User2] FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingAction] CHECK CONSTRAINT [FK_TrackingAction_User2]
GO
ALTER TABLE [dbo].[TrackingAction]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAction_User3] FOREIGN KEY([SenderID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingAction] CHECK CONSTRAINT [FK_TrackingAction_User3]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Image] FOREIGN KEY([Avartar])
REFERENCES [dbo].[Image] ([ImageID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Image]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_EventPlace] FOREIGN KEY([EventPlaceID])
REFERENCES [dbo].[EventPlace] ([EventPlaceID])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FK_Video_EventPlace]
GO
USE [master]
GO
ALTER DATABASE [EventZone] SET  READ_WRITE 
GO
