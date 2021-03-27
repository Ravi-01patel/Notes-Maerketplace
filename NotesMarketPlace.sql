USE [master]
GO
/****** Object:  Database [NotesMarketplace]    Script Date: 27-03-2021 20:48:51 ******/
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
/****** Object:  Table [dbo].[AdminDetail]    Script Date: 27-03-2021 20:48:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminDetail](
	[ID] [int] NOT NULL,
	[Users] [int] IDENTITY(1,1) NOT NULL,
	[PhoneNumber] [varchar](20) NULL,
	[ProfilePicture] [varchar](max) NULL,
	[SecondaryEmail] [varchar](100) NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_AdminDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactUs]    Script Date: 27-03-2021 20:48:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactUs](
	[CUId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](50) NOT NULL,
	[EmailID] [varchar](50) NOT NULL,
	[Subjects] [varchar](100) NOT NULL,
	[Comments] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ContactUs] PRIMARY KEY CLUSTERED 
(
	[CUId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTC]    Script Date: 27-03-2021 20:48:52 ******/
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
/****** Object:  Table [dbo].[DownloadedNotes]    Script Date: 27-03-2021 20:48:52 ******/
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
 CONSTRAINT [PK_DownloadedNotes] PRIMARY KEY CLUSTERED 
(
	[DId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 27-03-2021 20:48:52 ******/
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
/****** Object:  Table [dbo].[ManageCTC]    Script Date: 27-03-2021 20:48:52 ******/
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
/****** Object:  Table [dbo].[NoteDetail]    Script Date: 27-03-2021 20:48:52 ******/
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
/****** Object:  Table [dbo].[NoteStatus]    Script Date: 27-03-2021 20:48:52 ******/
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
/****** Object:  Table [dbo].[SpamReport]    Script Date: 27-03-2021 20:48:52 ******/
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
/****** Object:  Table [dbo].[Statistic]    Script Date: 27-03-2021 20:48:52 ******/
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
/****** Object:  Table [dbo].[SystemConfiguration]    Script Date: 27-03-2021 20:48:52 ******/
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
	[FacebookUrl] [varchar](50) NOT NULL,
	[TwitterUrl] [varchar](50) NOT NULL,
	[LinkedInUrl] [varchar](50) NOT NULL,
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
/****** Object:  Table [dbo].[UserProfileDetail]    Script Date: 27-03-2021 20:48:52 ******/
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
/****** Object:  Table [dbo].[UserRole]    Script Date: 27-03-2021 20:48:52 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 27-03-2021 20:48:52 ******/
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
INSERT [dbo].[CTC] ([CTC], [CTCName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Category', CAST(N'2021-03-01T17:46:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[CTC] ([CTC], [CTCName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Type', CAST(N'2021-03-01T17:47:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[CTC] ([CTC], [CTCName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'Country', CAST(N'2021-03-01T17:47:00.000' AS DateTime), NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[DownloadedNotes] ON 

INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (1, 37, 35, 49, 0, CAST(N'2021-03-24T10:26:32.013' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Life', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'BCD', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (2, 38, 35, 49, 0, CAST(N'2021-03-24T10:26:49.107' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Everything', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'Physics', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (3, 39, 49, 35, 0, CAST(N'2021-03-24T10:26:32.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Life', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'BCD', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (4, 40, 49, 35, 1, CAST(N'2021-03-24T10:26:49.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Everything', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'Physics', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (5, 41, 49, 35, 0, CAST(N'2021-03-24T10:26:32.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Life', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'BCD', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (6, 42, 49, 35, 0, CAST(N'2021-03-24T10:26:49.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Everything', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'Physics', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (7, 43, 49, 35, 0, CAST(N'2021-03-24T10:26:32.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Life', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'BCD', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (8, 44, 49, 35, 1, CAST(N'2021-03-24T10:26:49.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Everything', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'Physics', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (9, 45, 49, 35, 0, CAST(N'2021-03-24T10:26:32.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Life', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'BCD', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (10, 47, 49, 35, 0, CAST(N'2021-03-24T10:26:49.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Everything', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'Physics', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (11, 48, 49, 35, 0, CAST(N'2021-03-24T10:26:32.000' AS DateTime), NULL, NULL, NULL, 1, N'ABC', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'ABC', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (12, 49, 49, 35, 1, CAST(N'2021-03-24T10:26:49.000' AS DateTime), NULL, NULL, NULL, 1, N'XYZ', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'DAB', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (13, 50, 35, 49, 1, CAST(N'2021-03-24T10:26:32.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Life', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'BCD', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (14, 51, 35, 49, 1, CAST(N'2021-03-24T10:26:49.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Everything', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'Physics', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (15, 52, 35, 49, 1, CAST(N'2021-03-24T10:26:32.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Life', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'BCD', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (16, 53, 35, 49, 1, CAST(N'2021-03-24T10:26:49.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Everything', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'Physics', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (17, 54, 35, 49, 1, CAST(N'2021-03-24T10:26:32.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Life', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'BCD', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (18, 55, 35, 49, 1, CAST(N'2021-03-24T10:26:49.000' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Everything', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'Physics', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (19, 44, 35, 49, 1, CAST(N'2021-03-26T14:17:57.303' AS DateTime), NULL, NULL, NULL, 1, N'FreeBook', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 0, N'BCD', N'dhruv@gmail.com', N'+91 9574366040')
INSERT [dbo].[DownloadedNotes] ([DId], [Note], [Users], [Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [NoteTitle], [Attachment], [SellPrice], [Category], [BuyerEmail], [BuyerMobile]) VALUES (20, 42, 35, 49, 0, CAST(N'2021-03-26T14:28:34.583' AS DateTime), NULL, NULL, NULL, 1, N'Theory of Everything', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', 122, N'Physics', N'dhruv@gmail.com', N'+91 9574366040')
SET IDENTITY_INSERT [dbo].[DownloadedNotes] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([FId], [Note], [Users], [Review], [Comments], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 51, 49, 5, N'kjnckjcnkcjn', CAST(N'2021-03-26T10:27:17.530' AS DateTime), NULL, CAST(N'2021-03-26T11:46:29.443' AS DateTime), NULL, 1)
INSERT [dbo].[Feedback] ([FId], [Note], [Users], [Review], [Comments], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 51, 49, 5, N'Ravi', CAST(N'2021-03-26T10:27:17.000' AS DateTime), NULL, CAST(N'2021-03-26T11:46:29.000' AS DateTime), NULL, 1)
INSERT [dbo].[Feedback] ([FId], [Note], [Users], [Review], [Comments], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 51, 49, 5, N'Shiv', CAST(N'2021-03-26T10:27:17.000' AS DateTime), NULL, CAST(N'2021-03-26T11:46:29.000' AS DateTime), NULL, 1)
INSERT [dbo].[Feedback] ([FId], [Note], [Users], [Review], [Comments], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 44, 49, 4, N'Nice Book', CAST(N'2021-03-27T13:47:22.193' AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[ManageCTC] ON 

INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 1, N'IT', N'Handle IT Related date', NULL, CAST(N'2021-03-01T17:49:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 1, N'Social Science', N'Handle social data', NULL, CAST(N'2021-03-01T17:50:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 1, N'Economics', N'Handle economy related data', NULL, CAST(N'2021-03-01T17:51:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 2, N'Handwritten', N'Handwritten Type', NULL, CAST(N'2021-03-01T17:51:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 2, N'University', N'University Type', NULL, CAST(N'2021-03-01T17:51:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 2, N'Story Book', N'Story Book Type', NULL, CAST(N'2021-03-01T17:51:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, 3, N'India', N'Indian Region', 91, CAST(N'2021-03-01T17:51:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([CTCId], [CTC], [CTCValue], [Descriptions], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 3, N'America', N'America Region', 1, CAST(N'2021-03-01T17:51:00.000' AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[ManageCTC] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteDetail] ON 

INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (37, 35, 3, N'Theory of Everything', N'Physics', N'05s03s2021f12a50a11.jpg', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', N'Handwritten', 110, N'cbjhjbv  v jhv ', N'Ravi Patel', N'America', N'IT', N'122', N'kbbkjfblbf hbfdhj fd ', 122, N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (38, 35, 3, N'Theory of Life', N'BCD', N'05s03s2021f12a50a11.jpg', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', N'Handwritten', 110, N'cbjhjbv  v jhv ', N'Ravi Patel', N'America', N'IT', N'122', N'kbbkjfblbf hbfdhj fd ', 122, N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (39, 35, 1, N'Science of life', N'Social Science', N'16s03s2021f11a08a00.jpg', N'C:\Project\NotesMarketplace\Upload\Pdf\16s03s2021f11a08a00.pdf', N'Handwritten', 111, N'tHIS IS BOOK ', N'nbc jhbdjb ', N'India', N'ss', N'192902', N'Ravi Patel', 0, N'C:\Project\NotesMarketplace\Upload\Pdf\16s03s2021f11a08a00.pdf', 0, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (40, 49, 3, N'Theory of Everything', N'Physics', N'05s03s2021f12a50a11.jpg', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', N'PDF', 110, N'cbjhjbv  v jhv ', N'Ravi Patel', N'India', N'CS', N'122', N'kbbkjfblbf hbfdhj fd ', 122, N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (41, 35, 3, N'Theory of Life', N'BCD', N'05s03s2021f12a50a11.jpg', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', N'PDF', 110, N'cbjhjbv  v jhv ', N'Ravi Patel', N'America', N'CS', N'122', N'kbbkjfblbf hbfdhj fd ', 122, N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (42, 49, 3, N'Theory of Everything', N'Physics', N'05s03s2021f12a50a11.jpg', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', N'Paper', 110, N'cbjhjbv  v jhv ', N'Ravi Patel', N'India', N'ECO', N'122', N'kbbkjfblbf hbfdhj fd ', 122, N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (43, 35, 3, N'Theory of Life', N'BCD', N'05s03s2021f12a50a11.jpg', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', N'Paper', 110, N'cbjhjbv  v jhv ', N'Ravi Patel', N'India', N'IT', N'122', N'kbbkjfblbf hbfdhj fd ', 122, N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (44, 35, 3, N'FreeBook', N'BCD', N'05s03s2021f12a50a11.jpg', N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', N'Paper', 110, N'cbjhjbv  v jhv ', N'Ravi Patel', N'India', N'IT', N'122', N'kbbkjfblbf hbfdhj fd ', 0, N'C:\Project\NotesMarketplace\Upload\Pdf\05s03s2021f12a50a11.pdf', NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, CAST(N'2021-03-15T08:57:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (45, 49, 2, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, NULL, CAST(N'2021-03-23T10:23:20.087' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.913' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (47, 49, 5, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Unwanted Stuff', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 0)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (48, 49, 5, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 0)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (49, 49, 5, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Unwanted Stuff', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (50, 49, 5, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 0)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (51, 49, 5, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Unwanted Stuff', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (52, 49, 5, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (53, 49, 5, N'My Name Is Ravi', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (54, 49, 5, N'XAX', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 0)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (55, 49, 5, N'ABC', N'IT', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 0)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (58, 49, 5, N'BCD', N'ABC', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (59, 49, 5, N'XYZ', N'YSA', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (60, 49, 5, N'BBC', N'BBC', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-23T10:23:20.000' AS DateTime), NULL, CAST(N'2021-03-23T11:10:20.000' AS DateTime), NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (63, 49, 1, N'ABC', N'IT', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-26T14:08:57.570' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (64, 49, 1, N'XAX', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-26T14:10:19.233' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (65, 49, 1, N'XAX', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-26T14:10:49.813' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (66, 49, 1, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-26T14:11:00.177' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (67, 49, 1, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-26T14:25:18.077' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (68, 49, 1, N'MyBook4', N'Economics', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Unwanted Stuff', CAST(N'2021-03-26T17:29:27.327' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (69, 49, 1, N'ABC', N'IT', N'23s03s2021f11a10a20.jpg', N'23s03s2021f11a10a20.pdf', N'University', 110, N'I am the owner of this book', N'Oxford University', N'America', N'Astrology', N'11', N'Albert Eienstine', 110, N'23s03s2021f11a10a20.pdf', 0, NULL, N'Inrealistic things', CAST(N'2021-03-26T17:29:31.817' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteDetail] ([Note], [Users], [NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (70, 49, 2, N'Elon musk', N'IT', N'26s03s2021f17a51a56.jpg', N'26s03s2021f17a51a56.pdf', N'University', 212, N'Autobiography of elon musk.', N'MIT', N'America', N'IT', N'132', N'Elon Musk', 122, N'26s03s2021f17a51a58.pdf', 0, NULL, NULL, CAST(N'2021-03-26T17:41:31.360' AS DateTime), NULL, CAST(N'2021-03-26T17:51:58.620' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[NoteDetail] OFF
GO
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Draft', N'Note is in draft State', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Submitted', N'Note is submitted', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'In Review', N'Note is in review', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'Published', N'Note is been published', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'Rejected', N'Note is rejected by admin', CAST(N'2021-03-05T12:48:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteStatus] ([NoteStatus], [StatusName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Unpublished', N'Unpublished by admin', NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[SpamReport] ON 

INSERT [dbo].[SpamReport] ([SpamId], [Note], [Users], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, 44, 49, N'Sexual Content', CAST(N'2021-03-27T16:31:03.243' AS DateTime), NULL, CAST(N'2021-03-27T16:31:29.987' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[SpamReport] OFF
GO
SET IDENTITY_INSERT [dbo].[Statistic] ON 

INSERT [dbo].[Statistic] ([StatsId], [Users], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpenses], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (2, 35, 100, 10, 20, 2000, 10000, 12, 11, 5)
SET IDENTITY_INSERT [dbo].[Statistic] OFF
GO
SET IDENTITY_INSERT [dbo].[UserProfileDetail] ON 

INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 35, CAST(N'2000-01-01' AS Date), N'Male', N'+91 9773469307', N'16s03s2021f12a08a08.jpg', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', NULL, NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 35, CAST(N'2000-01-01' AS Date), N'Male', N'+91 1238787464786', N'16s03s2021f12a19a26.jpg', N'bvvbjkcj', N'jkdjdb', N'jnbdb', N'jjkdk', N'17226255', N'America', N'bnbfjkbf', N'jdbbdbd', NULL, NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 41, CAST(N'2000-01-01' AS Date), N'Male', N'+91 888188188', N'16s03s2021f12a27a50.jpg', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'GEC PATAN', NULL, NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 41, CAST(N'2000-01-01' AS Date), N'Female', N'+91 9998198198', N'16s03s2021f12a30a38.jpg', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'GEC PATAN', NULL, NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 41, CAST(N'2000-01-01' AS Date), N'Male', N'+91 8287827827', N'16s03s2021f12a36a46.jpg', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'GTU', N'VGEC', NULL, NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 41, CAST(N'2000-01-01' AS Date), N'Female', N'+91 42254365435', N'16s03s2021f13a12a48.jpg', N'dbhhjdgjg', N'hbhsvjhbv', N'bhjbdshb', N'hbdhbv', N'256565', N'America', N'dghfghfd', N'bhdhjg', NULL, NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, 38, CAST(N'1999-10-18' AS Date), N'Male', N'+91 7203810210', N'16s03s2021f16a11a23.jpg', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'Gujarat University', N'JG College of Nursing', NULL, NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, 47, CAST(N'2000-07-03' AS Date), N'Female', N'+1 9726483344', N'18s03s2021f12a40a31.jpg', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'America', N'SEO', N'IKPS', CAST(N'2021-03-18T12:40:31.490' AS DateTime), NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, 46, CAST(N'1975-06-15' AS Date), N'Male', N'+91 9925589960', N'18s03s2021f14a30a21.jpg', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'HNGU', N'PAC', CAST(N'2021-03-18T00:00:00.000' AS DateTime), NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, 40, CAST(N'2010-10-10' AS Date), N'Female', N'+91 9925589960', N'004s18s03s2021f15a33a20.jpg', N'ManekPur', N'Dahegham', N'Dahegham', N'Gujarat', N'382800', N'America', N'GTU', N'VGEC', CAST(N'2021-03-18T00:00:00.000' AS DateTime), NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 33, CAST(N'2010-10-10' AS Date), N'Female', N'+91 10203040', N'005s19s03s2021f13a04a40.jpg', N'Manipura', N'Vijapur', N'Vijapur', N'Gujarat', N'382870', N'India', N'KSVU', N'KSV', CAST(N'2021-03-19T00:00:00.000' AS DateTime), NULL, 0)
INSERT [dbo].[UserProfileDetail] ([ID], [Users], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [States], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 49, CAST(N'2020-10-10' AS Date), N'Male', N'+91 9574366040', N'User49.jpg', N'Motipura', N'Bhavsor', N'Vijapur', N'Gujarat', N'382870', N'India', N'Gujarat University', N'JG College of Nursing', CAST(N'2021-03-19T00:00:00.000' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[UserProfileDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRole] ON 

INSERT [dbo].[UserRole] ([UserRole], [RoleName], [Descriptions], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Member', N'User who buy and sell his notes', NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[UserRole] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple0198', 0, 0, CAST(N'2021-02-26T14:55:17.270' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 1, N'Ravi', N'Patel', N'ravipatel@gmail.com', N'Jp@0198', 0, 0, CAST(N'2021-02-26T19:49:52.207' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Jp@0198', 0, 0, CAST(N'2021-02-26T19:54:46.887' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Jp@0198', 0, 0, CAST(N'2021-02-26T19:55:45.277' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Jp@0198', 0, 0, CAST(N'2021-02-26T19:56:05.083' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T19:56:08.047' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T19:58:03.217' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T19:58:08.873' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T19:58:12.767' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T19:58:44.433' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T20:05:29.770' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple#0198', 0, 0, CAST(N'2021-02-26T20:06:39.340' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T20:07:54.627' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T20:07:58.110' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (15, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T20:09:56.250' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (16, 1, N'Geeta', N'Patel', N'geetapatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-26T20:48:40.267' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (17, 1, N'geeta', N'patel', N'geetapatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T09:23:55.653' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (18, 1, N'Raj', N'Patel', N'ravipatel@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T09:25:29.727' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (19, 1, N'ABc', N'dbhjdgb', N'rajp@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T11:01:26.303' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (20, 1, N'ABc', N'dbhjdgb', N'rajp1@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T11:02:52.813' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (21, 1, N'Raj', N'Patel', N'raj123@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T11:04:42.287' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (22, 1, N'Raj', N'Patel', N'raj123@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T11:12:16.657' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (23, 1, N'Margi', N'Patel', N'MargiRPatel@gmail.com', N'Mr@0102', 0, 0, CAST(N'2021-02-27T11:15:41.270' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (24, 1, N'Margi', N'Patel', N'MargiRPatel@gmail.com', N'Mr@0102', 0, 0, CAST(N'2021-02-27T11:26:44.550' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (25, 1, N'Margi', N'Patel', N'MargiRPatel@gmail.com', N'Mr@0102', 0, 0, CAST(N'2021-02-27T11:28:47.453' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (26, 1, N'Het', N'Patel', N'hetpatel012000@gmail.com', N'Het@123', 0, 0, CAST(N'2021-02-27T13:31:14.623' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (27, 1, N'Het', N'Patel', N'hetpatel012000@gmail.com', N'Het@123', 0, 0, CAST(N'2021-02-27T13:32:07.253' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (28, 1, N'Het', N'Patel', N'hetpatel012000@gmail.com', N'Het@123', 0, 0, CAST(N'2021-02-27T13:33:19.027' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (29, 1, N'Het', N'Patel', N'hetpatel012000@gmail.com', N'Het@123', 0, 0, CAST(N'2021-02-27T13:36:25.350' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (30, 1, N'Het', N'Patel', N'hetpatel012000@gmail.com', N'Het@123', 0, 0, CAST(N'2021-02-27T13:42:46.063' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (31, 1, N'Ushaben', N'Patel', N'ushapatel@gmail.com', N'Cr6}b$G5', 0, 0, CAST(N'2021-02-27T13:53:47.317' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (32, 1, N'Kamlesh', N'Patel', N'kamleshpatel@gmail.com', N'Kamlesh@123', 0, 0, CAST(N'2021-02-27T14:04:24.593' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (33, 1, N'Banker', N'Patel', N'banker@gmail.com', N'Ban@123', 1, 1, CAST(N'2021-02-27T14:10:21.910' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (34, 1, N'Raj', N'Patel', N'rajp@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T14:28:02.513' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (35, 1, N'Raj', N'Patel', N'rajp@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T14:28:19.267' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (36, 1, N'Raj', N'Patel', N'rajp@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T14:29:45.350' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (37, 1, N'Raj', N'Patel', N'raj1234@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-02-27T14:31:23.027' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (38, 1, N'Janak', N'Patel', N'jp@gmail.com', N'Apple@0198', 1, 0, CAST(N'2021-02-27T14:32:40.763' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (39, 1, N'Raj', N'Patel', N'ravipatel123@gmail.com', N'Apple@0198', 1, 0, CAST(N'2021-02-27T14:36:21.060' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (40, 1, N'Final', N'Patidar', N'finalpatel@gmail.com', N'Apple@0198', 1, 1, CAST(N'2021-02-27T14:43:47.897' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (41, 1, N'Mehul', N'Prajapati', N'mehul@gmail.com', N'Mehul@123', 1, 1, CAST(N'2021-03-01T11:11:36.973' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (46, 1, N'Satish', N'Patel', N'satish@gmail.com', N'Aa@123', 1, 1, CAST(N'2021-03-17T20:11:46.673' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (47, 1, N'Geeta', N'Patel', N'gita@gmail.com', N'Aa@123', 1, 1, CAST(N'2021-03-17T20:13:58.370' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (48, 1, N'Joita', N'Patel', N'joita@gmail.com', N'Aa@123', 1, 0, CAST(N'2021-03-17T20:16:28.847' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (49, 1, N'Dhruv', N'Patel', N'dhruv@gmail.com', N'Aa@123', 1, 1, CAST(N'2021-03-19T13:57:03.577' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (50, 1, N'Ravi', N'Patel', N'ravipatel012000@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-03-27T19:55:51.587' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Users], [UserRole], [FirstName], [LastName], [EmailID], [Passwords], [IsEmailVerified], [IsDetailSubmitted], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (51, 1, N'Ravi', N'Patel', N'ravipatel2000@gmail.com', N'Apple@0198', 0, 0, CAST(N'2021-03-27T19:59:02.973' AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_Users]    Script Date: 27-03-2021 20:48:52 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [IX_Users] UNIQUE NONCLUSTERED 
(
	[Users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdminDetail] ADD  CONSTRAINT [DF_AdminDetail_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ContactUs] ADD  CONSTRAINT [DF_ContactUs_IsActive]  DEFAULT ((1)) FOR [IsActive]
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
