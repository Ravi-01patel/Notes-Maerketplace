USE [master]
GO
/****** Object:  Database [NotesMarketplace]    Script Date: 10-04-2021 22:19:35 ******/
CREATE DATABASE [NotesMarketplace]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NotesMarketplace', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\NotesMarketplace.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NotesMarketplace_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\NotesMarketplace_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [NotesMarketplace] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NotesMarketplace].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ARITHABORT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NotesMarketplace] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NotesMarketplace] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NotesMarketplace] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NotesMarketplace] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NotesMarketplace] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NotesMarketplace] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NotesMarketplace] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NotesMarketplace] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NotesMarketplace] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NotesMarketplace] SET RECOVERY FULL 
GO
ALTER DATABASE [NotesMarketplace] SET  MULTI_USER 
GO
ALTER DATABASE [NotesMarketplace] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NotesMarketplace] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NotesMarketplace] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NotesMarketplace] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NotesMarketplace] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NotesMarketplace', N'ON'
GO
ALTER DATABASE [NotesMarketplace] SET QUERY_STORE = OFF
GO
USE [NotesMarketplace]
GO
/****** Object:  Table [dbo].[AdminDetail]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Users] [int] NOT NULL,
	[PhoneNumber] [varchar](20) NULL,
	[ProfilePicture] [varchar](max) NULL,
	[SecondaryEmail] [varchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_AdminDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTC]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTC](
	[CTC] [int] NOT NULL,
	[CTCName] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__CTC__C1F8B7B6701C015F] PRIMARY KEY CLUSTERED 
(
	[CTC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DownloadedNotes]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DownloadedNotes](
	[DId] [int] IDENTITY(1,1) NOT NULL,
	[Note] [int] NOT NULL,
	[Users] [int] NOT NULL,
	[Buyer] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[NoteTitle] [varchar](100) NOT NULL,
	[Attachment] [varchar](max) NOT NULL,
	[SellPrice] [int] NOT NULL,
	[Category] [varchar](100) NOT NULL,
	[BuyerEmail] [varchar](50) NOT NULL,
	[BuyerMobile] [varchar](20) NOT NULL,
	[AttachmentSize] [int] NULL,
 CONSTRAINT [PK_DownloadedNotes] PRIMARY KEY CLUSTERED 
(
	[DId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[FId] [int] IDENTITY(1,1) NOT NULL,
	[Note] [int] NOT NULL,
	[Users] [int] NOT NULL,
	[Review] [int] NOT NULL,
	[Comments] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[FId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManageCTC]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManageCTC](
	[CTCId] [int] IDENTITY(1,1) NOT NULL,
	[CTC] [int] NOT NULL,
	[CTCValue] [varchar](100) NOT NULL,
	[Descriptions] [varchar](max) NOT NULL,
	[CountryCode] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ManageCTC] PRIMARY KEY CLUSTERED 
(
	[CTCId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteDetail]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteDetail](
	[Note] [int] IDENTITY(1,1) NOT NULL,
	[Users] [int] NOT NULL,
	[NoteStatus] [int] NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Category] [varchar](100) NOT NULL,
	[BookPicture] [varchar](max) NOT NULL,
	[NoteAttachment] [varchar](max) NOT NULL,
	[NoteType] [varchar](100) NULL,
	[NumberOfPages] [int] NULL,
	[NotesDescription] [varchar](max) NOT NULL,
	[InstitutionName] [varchar](200) NULL,
	[Country] [varchar](100) NULL,
	[Course] [varchar](100) NULL,
	[CourseCode] [varchar](100) NULL,
	[Professor] [varchar](100) NULL,
	[SellPrice] [int] NOT NULL,
	[NotePreview] [varchar](max) NULL,
	[NoteSize] [int] NULL,
	[PublishedDate] [datetime] NULL,
	[Remark] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__NoteDeta__7D8C2ADCE9F96DFC] PRIMARY KEY CLUSTERED 
(
	[Note] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteStatus]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteStatus](
	[NoteStatus] [int] NOT NULL,
	[StatusName] [varchar](50) NOT NULL,
	[Descriptions] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NoteStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpamReport]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpamReport](
	[SpamId] [int] IDENTITY(1,1) NOT NULL,
	[Note] [int] NOT NULL,
	[Users] [int] NOT NULL,
	[Remark] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_SpamReport] PRIMARY KEY CLUSTERED 
(
	[SpamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statistic]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statistic](
	[StatsId] [int] IDENTITY(1,1) NOT NULL,
	[Users] [int] NOT NULL,
	[UnderReviewNotes] [int] NOT NULL,
	[PublishedNotes] [int] NOT NULL,
	[DownloadedNotes] [int] NOT NULL,
	[TotalExpenses] [int] NOT NULL,
	[TotalEarning] [int] NOT NULL,
	[BuyerRequests] [int] NOT NULL,
	[SoldNotes] [int] NOT NULL,
	[RejectedNotes] [int] NOT NULL,
 CONSTRAINT [PK_Statistic] PRIMARY KEY CLUSTERED 
(
	[StatsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemConfiguration]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfiguration](
	[ConfigId] [int] IDENTITY(1,1) NOT NULL,
	[EmailID1] [varchar](100) NOT NULL,
	[EmailID2] [varchar](100) NULL,
	[PhoneNumber] [varchar](15) NOT NULL,
	[DefaultProfilePicture] [varchar](max) NOT NULL,
	[DefaultNotePreview] [varchar](max) NOT NULL,
	[FacebookUrl] [varchar](50) NULL,
	[TwitterUrl] [varchar](50) NULL,
	[LinkedInUrl] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_SystemConfiguration] PRIMARY KEY CLUSTERED 
(
	[ConfigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfileDetail]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfileDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Users] [int] NOT NULL,
	[DOB] [date] NULL,
	[Gender] [varchar](10) NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[ProfilePicture] [varchar](max) NULL,
	[Address1] [varchar](100) NOT NULL,
	[Address2] [varchar](100) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[States] [varchar](50) NOT NULL,
	[ZipCode] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[University] [varchar](100) NULL,
	[College] [varchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_UserProfileDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserRole] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[Descriptions] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__UserRole__81D4C6F1072F89A1] PRIMARY KEY CLUSTERED 
(
	[UserRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10-04-2021 22:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Users] [int] IDENTITY(1,1) NOT NULL,
	[UserRole] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[EmailID] [varchar](100) NOT NULL,
	[Passwords] [varchar](24) NOT NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[IsDetailSubmitted] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__Users__64B85EBFB50862A1] PRIMARY KEY CLUSTERED 
(
	[Users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AdminDetail] ON 

INSERT [dbo].[AdminDetail] ([ID], [Users], [PhoneNumber], [ProfilePicture], [SecondaryEmail], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (0, 12, N'+91 9925589960', N'User10.png', NULL, NULL, NULL, 1)
INSERT [dbo].[AdminDetail] ([ID], [Users], [PhoneNumber], [ProfilePicture], [SecondaryEmail], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 13, N'+110 0101001010', NULL, NULL, CAST(N'2021-04-10T20:42:22.883' AS DateTime), 12, 1)
SET IDENTITY_INSERT [dbo].[AdminDetail] OFF
GO
INSERT [dbo].[CTC] ([CTC], [CTCName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Category', CAST(N'2021-03-01T17:46:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[CTC] ([CTC], [CTCName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Type', CAST(N'2021-03-01T17:47:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[CTC] ([CTC], [CTCName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'Country', CAST(N'2021-03-01T17:47:00.000' AS DateTime), NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[DownloadedNotes] ON 

INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile], [AttachmentSize]) VALUES (1, 1, 1, 9, 1, CAST(N'2021-09-09T00:00:00.000' AS DateTime), NULL, CAST(N'2021-09-09T00:00:00.000' AS DateTime), NULL, 1, N'Elon Musk', N'10s04s2021f17a36a56.pdf', 110, N'SocialScience', N'mpp@gmail.com', N'+91 992568989', 11)
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile], [AttachmentSize]) VALUES (2, 1, 1, 10, 1, CAST(N'2021-09-09T00:00:00.000' AS DateTime), NULL, CAST(N'2021-09-09T00:00:00.000' AS DateTime), NULL, 1, N'Elon Musk', N'10s04s2021f17a36a56.pdf', 110, N'SocialScience', N'abc@gmail.com', N'+91 9773469307', 11)
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile], [AttachmentSize]) VALUES (3, 7, 6, 1, 1, CAST(N'2021-04-10T21:20:23.267' AS DateTime), NULL, NULL, NULL, 1, N'Elon musk', N'10s04s2021f17a36a56.pdf', 0, N'Social Science', N'ravipatel012000@gmail.com', N'+91 9773469307', 0)
SET IDENTITY_INSERT [dbo].[DownloadedNotes] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([FId], [Note], [Users], [Review], [Comments], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (0, 7, 1, 5, N'NICe', CAST(N'2021-04-10T21:23:14.040' AS DateTime), NULL, CAST(N'2021-04-10T21:23:27.773' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[ManageCTC] ON 

INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 1, N'IT', N'Handle IT Related date', NULL, CAST(N'2021-03-01T17:49:00.000' AS DateTime), 12, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 1, N'Social Science', N'Handle social data', NULL, CAST(N'2021-03-01T17:50:00.000' AS DateTime), 13, CAST(N'2021-04-10T21:02:07.567' AS DateTime), 12, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 1, N'Economics', N'Handle economy related data', NULL, CAST(N'2021-03-01T17:51:00.000' AS DateTime), 13, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 2, N'Antic Poetry', N'Very rare edition of poetry', NULL, CAST(N'2021-03-01T17:51:00.000' AS DateTime), 13, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 2, N'University', N'University Type', NULL, CAST(N'2021-03-01T17:51:00.000' AS DateTime), 12, NULL, NULL, 0)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 2, N'Story Book', N'Story Book Type', NULL, CAST(N'2021-03-01T17:51:00.000' AS DateTime), 12, NULL, NULL, 0)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, 3, N'India', N'Indian Region', 91, CAST(N'2021-03-01T17:51:00.000' AS DateTime), 13, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 3, N'America', N'America Region', 1, CAST(N'2021-03-01T17:51:00.000' AS DateTime), 13, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 2, N'AstroPhysics', N'It handle all data related to astrology', NULL, CAST(N'2021-04-05T22:05:18.563' AS DateTime), 12, CAST(N'2021-04-10T21:03:01.647' AS DateTime), 12, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 2, N'Art', N'It handle all the data related to art', NULL, CAST(N'2021-04-05T22:07:16.280' AS DateTime), 12, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, 2, N'Mythology', N'Ancient stoies', NULL, CAST(N'2021-04-06T10:29:19.527' AS DateTime), 13, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (15, 2, N'Handwirtten', N'Handwritten Type of book', NULL, CAST(N'2021-04-06T10:41:52.537' AS DateTime), 12, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (16, 3, N'CANADA', N'Country added', 110, CAST(N'2021-04-06T11:25:13.367' AS DateTime), 12, CAST(N'2021-04-10T21:03:29.500' AS DateTime), 12, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (17, 3, N'United Kingdom', N'Country added', 12, CAST(N'2021-04-06T11:28:39.600' AS DateTime), 12, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (18, 1, N'Enviroment', N'Enviroment Related Data.', NULL, CAST(N'2021-04-10T21:02:35.757' AS DateTime), 12, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (19, 3, N'Austrelia', N'Country added', 50, CAST(N'2021-04-10T21:03:24.697' AS DateTime), 12, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[ManageCTC] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteDetail] ON 

INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 1, 4, N'Elon musk', N'Social Science', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 110, NULL, 11, CAST(N'2021-04-10T21:03:50.213' AS DateTime), NULL, CAST(N'2021-04-10T16:27:59.973' AS DateTime), NULL, CAST(N'2021-04-10T21:03:50.213' AS DateTime), 12, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 1, 1, N'Elon musk', N'IT', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T17:36:56.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 2, 6, N'Love of life', N'Economics', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, CAST(N'2021-04-10T21:04:02.787' AS DateTime), N'Inappropriate Content', CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T21:12:54.673' AS DateTime), 12, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 1, 5, N'Elon musk', N'IT', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T21:11:52.823' AS DateTime), 12, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 5, 5, N'Elon musk', N'Economics', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T21:11:54.290' AS DateTime), 12, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 1, 1, N'Breaking bread', N'Social Science', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T17:36:56.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, 6, 4, N'Elon musk', N'Social Science', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, CAST(N'2021-04-10T21:03:55.823' AS DateTime), NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T21:03:55.823' AS DateTime), 12, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, 1, 2, N'Elon musk', N'IT', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T17:36:56.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, 7, 1, N'Narcos', N'Economics', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T17:36:56.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, 1, 2, N'Elon musk', N'IT', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T17:36:56.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 8, 3, N'Elon musk', N'Economics', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T21:12:28.940' AS DateTime), 12, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 1, 2, N'pirates of carabian', N'Social Science', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T17:36:56.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 10, 2, N'Elon musk', N'Economics', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T17:36:56.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, 1, 2, N'Bella chao', N'Social Science', N'10s04s2021f17a36a56.png', N'10s04s2021f17a36a56.pdf', N'Art', 199, N'Autobiography of elon musk.', N'Ryzen University', N'CANADA', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, CAST(N'2021-04-10T16:27:59.000' AS DateTime), NULL, CAST(N'2021-04-10T17:36:56.000' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[NoteDetail] OFF
GO
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Draft', N'Note is in draft State', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Submitted', N'Note is submitted', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'In Review', N'Note is in review', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'Published', N'Note is been published', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'Rejected', N'Note is rejected by admin', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Unpublished', N'Unpublished by admin', NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Statistic] ON 

INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (1, 1, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (2, 2, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (3, 3, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (4, 4, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (5, 5, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (6, 6, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (7, 7, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (8, 8, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (9, 9, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (10, 10, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (11, 11, 0, 0, 0, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Statistic] OFF
GO
SET IDENTITY_INSERT [dbo].[SystemConfiguration] ON 

INSERT [dbo].[SystemConfiguration] ([ConfigId], [EmailID1], [EmailID2], [PhoneNumber], [DefaultProfilePicture], [DefaultNotePreview], [FacebookUrl], [TwitterUrl], [LinkedInUrl], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'ravipatel021000@gmail.com', N'abc@gmail.com', N'8728998987', N'Default.png', N'Default.png', N'https://www.facebook.com/', N'https://www.twitter.com/', N'https://www.linkedin.com/', CAST(N'2021-04-10T20:48:58.937' AS DateTime), 12, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SystemConfiguration] OFF
GO
SET IDENTITY_INSERT [dbo].[UserProfileDetail] ON 

INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 1, CAST(N'2000-01-01' AS Date), N'Male', N'+91 9773469307', N'User1.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 2, CAST(N'2000-02-05' AS Date), N'Female', N'+91 9773469307', N'User2.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 3, CAST(N'2000-03-29' AS Date), N'Male', N'+91 9773469307', N'User3.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 4, CAST(N'1999-10-18' AS Date), N'Female', N'+91 9773469307', N'User4.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 5, CAST(N'2000-05-22' AS Date), N'Male', N'+91 9773469307', N'User5.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 6, CAST(N'2001-10-10' AS Date), N'Male', N'+91 9773469307', N'User6.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, 7, CAST(N'2001-10-10' AS Date), N'Female', N'+91 9773469307', N'User7.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, 8, CAST(N'2002-11-10' AS Date), N'Male', N'+91 9773469307', N'User8.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, 9, CAST(N'2000-01-01' AS Date), N'Female', N'+91 9773469307', N'User9.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, 10, CAST(N'1919-10-19' AS Date), N'Male', N'+91 9773469307', N'User10.png', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', CAST(N'2021-04-10T00:00:00.000' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[UserProfileDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRole] ON 

INSERT [dbo].[UserRole] ([UserRole], [RoleName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Member', N'User who buy and sell his notes', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserRole] ([UserRole], [RoleName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Admin', N'Admin can approve reject unpublish notes', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserRole] ([UserRole], [RoleName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'SuperAdmin', N'Admin has all the right.', NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[UserRole] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 1, N'Ravi', N'Patel', N'ravipatel012000@gmail.com', N'Marvi@0102', 1, 1, CAST(N'2021-04-10T15:15:34.747' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 1, N'Margi', N'Patel', N'mrp@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-04-09T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 1, N'Janak', N'Patel', N'jrp@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-04-08T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 1, N'Dhruv', N'Patel', N'ddpatel@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-04-10T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 1, N'Viru', N'Zala', N'rajputana@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-04-07T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 1, N'Satyam', N'Tadvi', N'sattuop@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-04-05T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, 1, N'Divyesh', N'Tripathi', N'iit@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-04-04T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, 1, N'Bhadresh', N'Patel', N'bhado@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-04-03T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, 1, N'Mehul', N'Prajapati', N'mpp@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-04-10T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, 1, N'Dinkal', N'Patel', N'drp@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-04-01T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 1, N'Raj', N'Patel', N'rajp30398@gmail.com', N'Apple@0198', 1, 0, CAST(N'2021-04-10T16:12:05.840' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 3, N'Ravi', N'Patel', N'superadmin@gmail.com', N'Super@0198', 1, 1, CAST(N'2021-04-01T15:15:34.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 2, N'Manan', N'Patel', N'mk@gmail.com', N'Admin@123', 1, 1, CAST(N'2021-04-10T20:42:13.270' AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_Users]    Script Date: 10-04-2021 22:19:36 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [IX_Users] UNIQUE NONCLUSTERED 
(
	[Users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdminDetail] ADD  CONSTRAINT [DF_AdminDetail_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CTC] ADD  CONSTRAINT [DF_CTC_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[DownloadedNotes] ADD  CONSTRAINT [DF_DownloadedNotes_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[DownloadedNotes] ADD  CONSTRAINT [DF_DownloadedNotes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Feedback] ADD  CONSTRAINT [DF_Feedback_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ManageCTC] ADD  CONSTRAINT [DF_ManageCTC_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[NoteDetail] ADD  CONSTRAINT [DF_NoteDetail_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[NoteStatus] ADD  CONSTRAINT [DF_NoteStatus_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UserProfileDetail] ADD  CONSTRAINT [DF_UserProfileDetail_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UserRole] ADD  CONSTRAINT [DF_UserRole_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsEmailVerified]  DEFAULT ((0)) FOR [IsEmailVerified]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsDetailSubmitted]  DEFAULT ((0)) FOR [IsDetailSubmitted]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AdminDetail]  WITH CHECK ADD  CONSTRAINT [FK_AdminDetail_ToTable] FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[AdminDetail] CHECK CONSTRAINT [FK_AdminDetail_ToTable]
GO
ALTER TABLE [dbo].[DownloadedNotes]  WITH CHECK ADD  CONSTRAINT [FK__Downloade__Buyer__46E78A0C] FOREIGN KEY([Buyer])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[DownloadedNotes] CHECK CONSTRAINT [FK__Downloade__Buyer__46E78A0C]
GO
ALTER TABLE [dbo].[DownloadedNotes]  WITH CHECK ADD  CONSTRAINT [FK__Downloade__Users__45F365D3] FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[DownloadedNotes] CHECK CONSTRAINT [FK__Downloade__Users__45F365D3]
GO
ALTER TABLE [dbo].[DownloadedNotes]  WITH CHECK ADD  CONSTRAINT [FK__Downloaded__Note__44FF419A] FOREIGN KEY([Note])
REFERENCES [dbo].[NoteDetail] ([Note])
GO
ALTER TABLE [dbo].[DownloadedNotes] CHECK CONSTRAINT [FK__Downloaded__Note__44FF419A]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK__Feedback__Note__49C3F6B7] FOREIGN KEY([Note])
REFERENCES [dbo].[NoteDetail] ([Note])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK__Feedback__Note__49C3F6B7]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK__Feedback__Users__4AB81AF0] FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK__Feedback__Users__4AB81AF0]
GO
ALTER TABLE [dbo].[ManageCTC]  WITH CHECK ADD  CONSTRAINT [FK__ManageCTC__CTC__5441852A] FOREIGN KEY([CTC])
REFERENCES [dbo].[CTC] ([CTC])
GO
ALTER TABLE [dbo].[ManageCTC] CHECK CONSTRAINT [FK__ManageCTC__CTC__5441852A]
GO
ALTER TABLE [dbo].[NoteDetail]  WITH CHECK ADD  CONSTRAINT [FK__NoteDetai__NoteS__4316F928] FOREIGN KEY([NoteStatus])
REFERENCES [dbo].[NoteStatus] ([NoteStatus])
GO
ALTER TABLE [dbo].[NoteDetail] CHECK CONSTRAINT [FK__NoteDetai__NoteS__4316F928]
GO
ALTER TABLE [dbo].[NoteDetail]  WITH CHECK ADD  CONSTRAINT [FK__NoteDetai__Users__4222D4EF] FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[NoteDetail] CHECK CONSTRAINT [FK__NoteDetai__Users__4222D4EF]
GO
ALTER TABLE [dbo].[SpamReport]  WITH CHECK ADD  CONSTRAINT [FK__SpamRepor__Users__4D94879B] FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[SpamReport] CHECK CONSTRAINT [FK__SpamRepor__Users__4D94879B]
GO
ALTER TABLE [dbo].[SpamReport]  WITH CHECK ADD  CONSTRAINT [FK__SpamReport__Note__4CA06362] FOREIGN KEY([Note])
REFERENCES [dbo].[NoteDetail] ([Note])
GO
ALTER TABLE [dbo].[SpamReport] CHECK CONSTRAINT [FK__SpamReport__Note__4CA06362]
GO
ALTER TABLE [dbo].[Statistic]  WITH CHECK ADD  CONSTRAINT [FK__Statistic__Users__4F7CD00D] FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[Statistic] CHECK CONSTRAINT [FK__Statistic__Users__4F7CD00D]
GO
ALTER TABLE [dbo].[UserProfileDetail]  WITH CHECK ADD  CONSTRAINT [FK_UserProfileDetail_ToTable] FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[UserProfileDetail] CHECK CONSTRAINT [FK_UserProfileDetail_ToTable]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK__Users__UserRole__398D8EEE] FOREIGN KEY([UserRole])
REFERENCES [dbo].[UserRole] ([UserRole])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK__Users__UserRole__398D8EEE]
GO
USE [master]
GO
ALTER DATABASE [NotesMarketplace] SET  READ_WRITE 
GO
