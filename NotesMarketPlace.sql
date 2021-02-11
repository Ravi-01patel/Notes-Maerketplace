USE [master]
GO
/****** Object:  Database [NotesMarketplace]    Script Date: 11-02-2021 20:18:35 ******/
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
/****** Object:  Table [dbo].[AdminDetail]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminDetail](
	[Users] [int] NOT NULL,
	[PhoneNumber] [varchar](20) NULL,
	[ProfilePicture] [varchar](max) NULL,
	[SecondaryEmail] [varchar](100) NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactUs]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactUs](
	[FullName] [varchar](50) NOT NULL,
	[EmailID] [varchar](50) NOT NULL,
	[Subjects] [varchar](100) NOT NULL,
	[Comments] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTC]    Script Date: 11-02-2021 20:18:36 ******/
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
PRIMARY KEY CLUSTERED 
(
	[CTC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DownloadedNotes]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DownloadedNotes](
	[Note] [int] NOT NULL,
	[Users] [int] NOT NULL,
	[Buyer] [int] NOT NULL,
	[IsApproved] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[NoteTitle] [varbinary](100) NOT NULL,
	[Attachment] [varbinary](max) NOT NULL,
	[SellPrice] [int] NOT NULL,
	[Category] [varchar](100) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[Note] [int] NOT NULL,
	[Users] [int] NOT NULL,
	[Review] [int] NOT NULL,
	[Comments] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManageCTC]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManageCTC](
	[CTC] [int] NOT NULL,
	[CTCValue] [varchar](100) NOT NULL,
	[Descriptions] [varchar](max) NOT NULL,
	[CountryCode] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteDetail]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteDetail](
	[Note] [int] NOT NULL,
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
PRIMARY KEY CLUSTERED 
(
	[Note] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteStatus]    Script Date: 11-02-2021 20:18:36 ******/
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
/****** Object:  Table [dbo].[SpamReport]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpamReport](
	[Note] [int] NOT NULL,
	[Users] [int] NOT NULL,
	[Remark] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statistic]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statistic](
	[Users] [int] NOT NULL,
	[UnderReviewNotes] [int] NOT NULL,
	[PublishedNotes] [int] NOT NULL,
	[DownloadedNotes] [int] NOT NULL,
	[TotalExpenses] [int] NOT NULL,
	[TotalEarning] [int] NOT NULL,
	[BuyerRequests] [int] NOT NULL,
	[SoldNotes] [int] NOT NULL,
	[RejectedNotes] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemConfiguration]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfiguration](
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
	[ModifiedBy] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfileDetail]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfileDetail](
	[Users] [int] NOT NULL,
	[DOB] [datetime] NULL,
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
PRIMARY KEY CLUSTERED 
(
	[Users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserRole] [int] NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[Descriptions] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11-02-2021 20:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Users] [int] NOT NULL,
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
PRIMARY KEY CLUSTERED 
(
	[Users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users]    Script Date: 11-02-2021 20:18:36 ******/
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
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([Note])
REFERENCES [dbo].[NoteDetail] ([Note])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[ManageCTC]  WITH CHECK ADD FOREIGN KEY([CTC])
REFERENCES [dbo].[CTC] ([CTC])
GO
ALTER TABLE [dbo].[NoteDetail]  WITH CHECK ADD FOREIGN KEY([NoteStatus])
REFERENCES [dbo].[NoteStatus] ([NoteStatus])
GO
ALTER TABLE [dbo].[NoteDetail]  WITH CHECK ADD FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[SpamReport]  WITH CHECK ADD FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[SpamReport]  WITH CHECK ADD FOREIGN KEY([Note])
REFERENCES [dbo].[NoteDetail] ([Note])
GO
ALTER TABLE [dbo].[Statistic]  WITH CHECK ADD FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([Users])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([UserRole])
REFERENCES [dbo].[UserRole] ([UserRole])
GO
USE [master]
GO
ALTER DATABASE [NotesMarketplace] SET  READ_WRITE 
GO
