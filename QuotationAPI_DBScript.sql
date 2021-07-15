USE [master]
GO
/****** Object:  Database [QuotationApi]    Script Date: 07-15-2021 16:25:46 ******/
CREATE DATABASE [QuotationApi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuotationApi', FILENAME = N'D:\DATA\QuotationApi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuotationApi_log', FILENAME = N'D:\DATA\QuotationApi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuotationApi] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuotationApi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuotationApi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuotationApi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuotationApi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuotationApi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuotationApi] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuotationApi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuotationApi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuotationApi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuotationApi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuotationApi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuotationApi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuotationApi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuotationApi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuotationApi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuotationApi] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuotationApi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuotationApi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuotationApi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuotationApi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuotationApi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuotationApi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuotationApi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuotationApi] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuotationApi] SET  MULTI_USER 
GO
ALTER DATABASE [QuotationApi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuotationApi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuotationApi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuotationApi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuotationApi] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuotationApi] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuotationApi', N'ON'
GO
ALTER DATABASE [QuotationApi] SET QUERY_STORE = OFF
GO
USE [QuotationApi]
GO
/****** Object:  UserDefinedTableType [dbo].[UT_Quotation]    Script Date: 07-15-2021 16:25:46 ******/
CREATE TYPE [dbo].[UT_Quotation] AS TABLE(
	[QuotationId] [bigint] NULL,
	[QuotationDate] [nvarchar](500) NULL,
	[QuotationNumber] [nvarchar](500) NULL,
	[CustomerName] [nvarchar](500) NULL,
	[CustomerAddress] [nvarchar](1000) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[TotalVat] [decimal](18, 2) NULL,
	[TotalIncludingVat] [decimal](18, 2) NULL,
	[Status] [bigint] NULL,
	[UserId] [bigint] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UT_QuotationDetail]    Script Date: 07-15-2021 16:25:46 ******/
CREATE TYPE [dbo].[UT_QuotationDetail] AS TABLE(
	[QuotationDetailId] [bigint] NOT NULL,
	[QuotationId] [bigint] NOT NULL,
	[QuotationDescription] [nvarchar](500) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[TotalVat] [decimal](18, 2) NULL,
	[TotalIncludingVat] [decimal](18, 2) NULL,
	[UserId] [bigint] NULL
)
GO
/****** Object:  Table [dbo].[Quotation]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quotation](
	[QuotationId] [bigint] IDENTITY(1,1) NOT NULL,
	[QuotationDate] [datetime] NULL,
	[QuotationNumber] [nvarchar](500) NULL,
	[CustomerName] [nvarchar](500) NULL,
	[CustomerAddress] [nvarchar](1000) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[TotalVat] [decimal](18, 2) NULL,
	[TotalIncludingVat] [decimal](18, 2) NULL,
	[Status] [bigint] NULL,
	[UserId] [bigint] NULL,
 CONSTRAINT [PK_Quotation] PRIMARY KEY CLUSTERED 
(
	[QuotationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuotationDetail]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuotationDetail](
	[QuotationDetailId] [bigint] IDENTITY(1,1) NOT NULL,
	[QuotationId] [bigint] NOT NULL,
	[QuotationDescription] [nvarchar](500) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[TotalVat] [decimal](18, 2) NULL,
	[TotalIncludingVat] [decimal](18, 2) NULL,
	[UserId] [bigint] NULL,
 CONSTRAINT [PK_QuotationDetail] PRIMARY KEY CLUSTERED 
(
	[QuotationDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[EmailAddress] [nvarchar](500) NULL,
	[Password] [nvarchar](500) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Quotation] ON 
GO
INSERT [dbo].[Quotation] ([QuotationId], [QuotationDate], [QuotationNumber], [CustomerName], [CustomerAddress], [TotalAmount], [TotalVat], [TotalIncludingVat], [Status], [UserId]) VALUES (3, CAST(N'2021-04-07T00:00:00.000' AS DateTime), N'QUOTE-0003', N'SA Travels', N'Girish', CAST(2364.00 AS Decimal(18, 2)), CAST(331.00 AS Decimal(18, 2)), CAST(2695.00 AS Decimal(18, 2)), 1, 5)
GO
INSERT [dbo].[Quotation] ([QuotationId], [QuotationDate], [QuotationNumber], [CustomerName], [CustomerAddress], [TotalAmount], [TotalVat], [TotalIncludingVat], [Status], [UserId]) VALUES (4, CAST(N'2021-04-07T00:00:00.000' AS DateTime), N'QUOTE-0004', N'Checkers', N'Girish', CAST(2364.00 AS Decimal(18, 2)), CAST(331.00 AS Decimal(18, 2)), CAST(2695.00 AS Decimal(18, 2)), 1, 5)
GO
INSERT [dbo].[Quotation] ([QuotationId], [QuotationDate], [QuotationNumber], [CustomerName], [CustomerAddress], [TotalAmount], [TotalVat], [TotalIncludingVat], [Status], [UserId]) VALUES (5, CAST(N'2021-04-07T00:00:00.000' AS DateTime), N'QUOTE-0005', N'Woolworths', N'Girish', CAST(2364.00 AS Decimal(18, 2)), CAST(331.00 AS Decimal(18, 2)), CAST(2695.00 AS Decimal(18, 2)), 1, 5)
GO
INSERT [dbo].[Quotation] ([QuotationId], [QuotationDate], [QuotationNumber], [CustomerName], [CustomerAddress], [TotalAmount], [TotalVat], [TotalIncludingVat], [Status], [UserId]) VALUES (6, CAST(N'2021-04-07T00:00:00.000' AS DateTime), N'QUOTE-0006', N'PickNPay', N'Girish', CAST(2364.00 AS Decimal(18, 2)), CAST(331.00 AS Decimal(18, 2)), CAST(2695.00 AS Decimal(18, 2)), 1, 5)
GO
INSERT [dbo].[Quotation] ([QuotationId], [QuotationDate], [QuotationNumber], [CustomerName], [CustomerAddress], [TotalAmount], [TotalVat], [TotalIncludingVat], [Status], [UserId]) VALUES (7, CAST(N'2021-04-07T00:00:00.000' AS DateTime), N'QUOTE-0007', N'Game', N'Girish', CAST(2364.00 AS Decimal(18, 2)), CAST(331.00 AS Decimal(18, 2)), CAST(2695.00 AS Decimal(18, 2)), 1, 6)
GO
SET IDENTITY_INSERT [dbo].[Quotation] OFF
GO
SET IDENTITY_INSERT [dbo].[QuotationDetail] ON 
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (5, 3, N'Travel Stuff', CAST(10.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(115.00 AS Decimal(18, 2)), 5)
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (6, 3, N'Luggage Boxes', CAST(15.00 AS Decimal(18, 2)), CAST(150.95 AS Decimal(18, 2)), CAST(2264.25 AS Decimal(18, 2)), CAST(339.64 AS Decimal(18, 2)), CAST(2603.89 AS Decimal(18, 2)), 5)
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (7, 4, N'Household', CAST(10.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(115.00 AS Decimal(18, 2)), 5)
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (8, 4, N'Choklets', CAST(15.00 AS Decimal(18, 2)), CAST(150.95 AS Decimal(18, 2)), CAST(2264.25 AS Decimal(18, 2)), CAST(339.64 AS Decimal(18, 2)), CAST(2603.89 AS Decimal(18, 2)), 5)
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (9, 5, N'Fruits and Vages', CAST(10.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(115.00 AS Decimal(18, 2)), 5)
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (10, 5, N'Bakery Items', CAST(15.00 AS Decimal(18, 2)), CAST(150.95 AS Decimal(18, 2)), CAST(2264.25 AS Decimal(18, 2)), CAST(339.64 AS Decimal(18, 2)), CAST(2603.89 AS Decimal(18, 2)), 5)
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (11, 6, N'Clothes', CAST(10.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(115.00 AS Decimal(18, 2)), 5)
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (12, 6, N'Soft Drinks', CAST(15.00 AS Decimal(18, 2)), CAST(150.95 AS Decimal(18, 2)), CAST(2264.25 AS Decimal(18, 2)), CAST(339.64 AS Decimal(18, 2)), CAST(2603.89 AS Decimal(18, 2)), 5)
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (13, 7, N'Exectronics', CAST(10.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(115.00 AS Decimal(18, 2)), 6)
GO
INSERT [dbo].[QuotationDetail] ([QuotationDetailId], [QuotationId], [QuotationDescription], [Quantity], [UnitPrice], [TotalAmount], [TotalVat], [TotalIncludingVat], [UserId]) VALUES (14, 7, N'Sports Items', CAST(15.00 AS Decimal(18, 2)), CAST(150.95 AS Decimal(18, 2)), CAST(2264.25 AS Decimal(18, 2)), CAST(339.64 AS Decimal(18, 2)), CAST(2603.89 AS Decimal(18, 2)), 6)
GO
SET IDENTITY_INSERT [dbo].[QuotationDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([UserId], [UserName], [EmailAddress], [Password], [IsDeleted]) VALUES (5, N'Test111', N'Test111@gmail.com', N'Reset@123', 0)
GO
INSERT [dbo].[User] ([UserId], [UserName], [EmailAddress], [Password], [IsDeleted]) VALUES (6, N'Team111', N'Team111@gmail.com', N'Reset@123', 0)
GO
INSERT [dbo].[User] ([UserId], [UserName], [EmailAddress], [Password], [IsDeleted]) VALUES (7, N'nirenpatel', N'nirenmpatel@gmail.com', N'reset123', 0)
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[QuotationDetail]  WITH CHECK ADD  CONSTRAINT [FK_QuotationDetail_Quotation] FOREIGN KEY([QuotationId])
REFERENCES [dbo].[Quotation] ([QuotationId])
GO
ALTER TABLE [dbo].[QuotationDetail] CHECK CONSTRAINT [FK_QuotationDetail_Quotation]
GO
/****** Object:  StoredProcedure [dbo].[Authenticate]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Authenticate]
	@EmailAddress nvarchar(500),
	@Password nvarchar(500)
AS
BEGIN
	SET NOCOUNT ON;
	Select * from dbo.[User] where EmailAddress = @EmailAddress and [Password] = @Password
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteQuotation]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteQuotation]
    @QuotationNumber NVARCHAR(100),
    @UserId BIGINT
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @QuotationID BIGINT;
	DECLARE @IsDeleted BIT = 0
    

    SELECT @QuotationID = q.QuotationId
    FROM dbo.Quotation AS q
    WHERE q.QuotationNumber = @QuotationNumber
          AND q.UserId = @UserId;


    IF @QuotationID > 0
    BEGIN
        DELETE FROM dbo.QuotationDetail
        WHERE QuotationId = @QuotationID;

        DELETE FROM dbo.Quotation
        WHERE QuotationId = @QuotationID;

		SET @IsDeleted = 1
    END;

	SELECT @IsDeleted AS Result

END;
GO
/****** Object:  StoredProcedure [dbo].[GetQuotation]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetQuotation] 
	@QuotationById bigint,
	@UserId bigint
AS
BEGIN

	SET NOCOUNT ON;
    Select * from Quotation where (Quotation.QuotationId = @QuotationById Or @QuotationById = 0) and UserId= @UserId
END
GO
/****** Object:  StoredProcedure [dbo].[GetQuotationDetails]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetQuotationDetails] 
	@QuotationById bigint,
	@UserId bigint
AS
BEGIN

	SET NOCOUNT ON;
    Select * from QuotationDetail where (QuotationDetail.QuotationId = @QuotationById Or @QuotationById = 0) and (UserId= @UserId)
END
GO
/****** Object:  StoredProcedure [dbo].[SignUp]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SignUp]
@Name nvarchar(50),
@EmailAddress nvarchar(500), 
@Password nvarchar(500)
AS
BEGIN
	
	SET NOCOUNT ON;

	IF NOT EXISTS(Select Top 1 * from dbo.[user] where EmailAddress = @EmailAddress)
	begin

	Insert into dbo.[User](UserName,EmailAddress,[Password],IsDeleted) 
			          values(@Name,@EmailAddress,@Password,0)
	
	Select CONVERT(bigint, SCOPE_IDENTITY()) as Inserted
	end
	else
	begin
	Select 0 as Inserted
	end
END
GO
/****** Object:  StoredProcedure [dbo].[SubmitQuotation]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SubmitQuotation] 
@Quotation UT_Quotation READONLY   
,@QuotationDetail [UT_QuotationDetail] readonly
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Insert into Quotation
    (
	QuotationDate,
		CustomerName,
		CustomerAddress,
		[Status],UserId
	)
	Select 
	QuotationDate,
		CustomerName,
		CustomerAddress,1,UserId from @Quotation


		Declare @QuotationId bigint = convert(bigint, SCOPE_IDENTITY())

		Insert into QuotationDetail
    (
	
QuotationId,
QuotationDescription,
Quantity,
UnitPrice,
TotalAmount,
TotalVat,
TotalIncludingVat,UserId
	)
	Select 
	@QuotationId,
QuotationDescription,
Quantity,
UnitPrice,
(Quantity * UnitPrice) ,
((Quantity * UnitPrice)*14)/100,
(Quantity * UnitPrice)+(((Quantity * UnitPrice)*14)/100),UserId from @QuotationDetail


Declare @TotalAmount decimal(18,0),@TotalVat decimal(18,0),@TotalIncludingVat decimal(18,0)

Select  @TotalAmount = SUM(TotalAmount),@TotalVat = sum(TotalVat),@TotalIncludingVat = SUM(TotalIncludingVat) from QuotationDetail where QuotationId = @QuotationId


update Quotation
set QuotationNumber = 'QUOTE-'+ FORMAT(@QuotationId,'D4'),
TotalAmount = @TotalAmount,
TotalVat = @TotalVat,
TotalIncludingVat = @TotalIncludingVat
where Quotation.QuotationId = @QuotationId
Select @QuotationId as Inserted
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateQuotationStatus]    Script Date: 07-15-2021 16:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateQuotationStatus]
    @QuotationNumber NVARCHAR(100),
    @UserId BIGINT,
    @Status BIGINT
AS
BEGIN

    SET NOCOUNT ON;

    UPDATE dbo.Quotation
    SET Status = @Status
    WHERE QuotationNumber = @QuotationNumber
          AND UserId = @UserId;

END;
GO
USE [master]
GO
ALTER DATABASE [QuotationApi] SET  READ_WRITE 
GO
