USE [master]
GO
/****** Object:  Database [chessehc]    Script Date: 10/12/2023 18:23:50 ******/
CREATE DATABASE [chessehc]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'chessehc', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\chessehc.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'chessehc_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\chessehc_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [chessehc] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [chessehc].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [chessehc] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [chessehc] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [chessehc] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [chessehc] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [chessehc] SET ARITHABORT OFF 
GO
ALTER DATABASE [chessehc] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [chessehc] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [chessehc] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [chessehc] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [chessehc] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [chessehc] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [chessehc] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [chessehc] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [chessehc] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [chessehc] SET  DISABLE_BROKER 
GO
ALTER DATABASE [chessehc] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [chessehc] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [chessehc] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [chessehc] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [chessehc] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [chessehc] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [chessehc] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [chessehc] SET RECOVERY FULL 
GO
ALTER DATABASE [chessehc] SET  MULTI_USER 
GO
ALTER DATABASE [chessehc] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [chessehc] SET DB_CHAINING OFF 
GO
ALTER DATABASE [chessehc] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [chessehc] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [chessehc] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [chessehc] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'chessehc', N'ON'
GO
ALTER DATABASE [chessehc] SET QUERY_STORE = OFF
GO
USE [chessehc]
GO
/****** Object:  User [chessehc]    Script Date: 10/12/2023 18:23:50 ******/
CREATE USER [chessehc] FOR LOGIN [chessehc] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [chessehc]
GO
/****** Object:  Table [dbo].[Bye]    Script Date: 10/12/2023 18:23:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bye](
	[TournamentId] [int] NOT NULL,
	[Round] [int] NOT NULL,
	[PlayerId] [int] NOT NULL,
	[ByePoint] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Bye] PRIMARY KEY CLUSTERED 
(
	[TournamentId] ASC,
	[Round] ASC,
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Game]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Game](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[Round] [int] NOT NULL,
	[WhiteId] [int] NOT NULL,
	[BlackId] [int] NOT NULL,
	[WhitePoint] [varchar](50) NULL,
	[BlackPoint] [varchar](50) NULL,
	[Ongoing] [bit] NOT NULL,
 CONSTRAINT [PK_Game] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Rating] [int] NOT NULL,
	[Title] [varchar](50) NULL,
 CONSTRAINT [PK_Player] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerPointsByRound]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerPointsByRound](
	[TournamentId] [int] NOT NULL,
	[PlayerId] [int] NOT NULL,
	[Round] [int] NOT NULL,
	[Points] [decimal](18, 1) NOT NULL,
 CONSTRAINT [PK_PlayerPointsByRound] PRIMARY KEY CLUSTERED 
(
	[TournamentId] ASC,
	[PlayerId] ASC,
	[Round] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tournament]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tournament](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[NumberOfRounds] [int] NOT NULL,
	[CurrentRound] [int] NULL,
 CONSTRAINT [PK_Tournament] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bye]  WITH CHECK ADD  CONSTRAINT [FK_Bye_Player] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([Id])
GO
ALTER TABLE [dbo].[Bye] CHECK CONSTRAINT [FK_Bye_Player]
GO
ALTER TABLE [dbo].[Bye]  WITH CHECK ADD  CONSTRAINT [FK_Bye_Tournament] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournament] ([Id])
GO
ALTER TABLE [dbo].[Bye] CHECK CONSTRAINT [FK_Bye_Tournament]
GO
ALTER TABLE [dbo].[Game]  WITH CHECK ADD  CONSTRAINT [FK_Game_Player] FOREIGN KEY([WhiteId])
REFERENCES [dbo].[Player] ([Id])
GO
ALTER TABLE [dbo].[Game] CHECK CONSTRAINT [FK_Game_Player]
GO
ALTER TABLE [dbo].[Game]  WITH CHECK ADD  CONSTRAINT [FK_Game_Player1] FOREIGN KEY([BlackId])
REFERENCES [dbo].[Player] ([Id])
GO
ALTER TABLE [dbo].[Game] CHECK CONSTRAINT [FK_Game_Player1]
GO
ALTER TABLE [dbo].[Game]  WITH CHECK ADD  CONSTRAINT [FK_Game_Tournament] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournament] ([Id])
GO
ALTER TABLE [dbo].[Game] CHECK CONSTRAINT [FK_Game_Tournament]
GO
ALTER TABLE [dbo].[Player]  WITH CHECK ADD  CONSTRAINT [FK_Player_Tournament] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournament] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Player] CHECK CONSTRAINT [FK_Player_Tournament]
GO
ALTER TABLE [dbo].[PlayerPointsByRound]  WITH CHECK ADD  CONSTRAINT [FK_PlayerPointsByRound_Player] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([Id])
GO
ALTER TABLE [dbo].[PlayerPointsByRound] CHECK CONSTRAINT [FK_PlayerPointsByRound_Player]
GO
ALTER TABLE [dbo].[PlayerPointsByRound]  WITH CHECK ADD  CONSTRAINT [FK_PlayerPointsByRound_Tournament] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournament] ([Id])
GO
ALTER TABLE [dbo].[PlayerPointsByRound] CHECK CONSTRAINT [FK_PlayerPointsByRound_Tournament]
GO
/****** Object:  StoredProcedure [dbo].[GetPlayerById]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPlayerById]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Player
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetTournamentByesByRound]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTournamentByesByRound]
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@Round int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Bye
	WHERE Bye.TournamentId = @TournamentId AND Bye.Round = @Round
END
GO
/****** Object:  StoredProcedure [dbo].[GetTournamentById]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTournamentById]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Tournament
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetTournamentGamesByRound]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTournamentGamesByRound]
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@Round int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Game
	WHERE Game.TournamentId = @TournamentId AND Game.Round = @Round
END
GO
/****** Object:  StoredProcedure [dbo].[GetTournamentPlayers]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTournamentPlayers]
	-- Add the parameters for the stored procedure here
	@TournamentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Player.Id
	,Player.Name
	,Player.Rating
	,ISNULL(PlayerPointsByRound.Points, 0) AS Points
	,Player.Title
	FROM Player
	INNER JOIN Tournament ON Tournament.Id = Player.TournamentId
	LEFT JOIN PlayerPointsByRound ON PlayerPointsByRound.PlayerId = Player.Id AND PlayerPointsByRound.Round = Tournament.CurrentRound
	WHERE Tournament.Id = @TournamentId
END
GO
/****** Object:  StoredProcedure [dbo].[GetTournaments]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTournaments]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Tournament
END
GO
/****** Object:  StoredProcedure [dbo].[GetTournamentStandingsByRound]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTournamentStandingsByRound]
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@Round int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Player.Id
	,Player.Name
	,Player.Rating
	,PlayerPointsByRound.Points
	,Player.Title
	FROM Player
	INNER JOIN PlayerPointsByRound ON PlayerPointsByRound.PlayerId = Player.Id AND PlayerPointsByRound.Round = @Round
	WHERE Player.TournamentId = @TournamentId
END
GO
/****** Object:  StoredProcedure [dbo].[InsertBye]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertBye] 
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@Round int,
	@PlayerId int,
	@ByePoint varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Bye
	VALUES (@TournamentId, @Round, @PlayerId, @ByePoint)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertGame]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertGame]
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@Round int,
	@WhiteId int,
	@BlackId int,
	@WhitePoint varchar(50),
	@BlackPoint varchar(50),
	@Ongoing int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Game
	OUTPUT inserted.Id
	VALUES(@TournamentId, @Round, @WhiteId, @BlackId, @WhitePoint, @BlackPoint, @Ongoing)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertPlayer]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertPlayer]
	-- Add the parameters for the stored procedure here
	@TournamentID int,
	@Name varchar(50),
	@Rating int,
	@Title varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Player
	OUTPUT INSERTED.Id
	VALUES (@TournamentID, @Name, @Rating, @Title)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertPlayerPointsByRound]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertPlayerPointsByRound]
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@PlayerId int,
	@Round int,
	@Points decimal(18, 1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO PlayerPointsByRound
	VALUES (@TournamentId, @PlayerId, @Round, @Points)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertTournament]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertTournament]
	-- Add the parameters for the stored procedure here
	@Name varchar(50),
	@NumberOfRounds int,
	@CurrentRound int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Tournament
	OUTPUT INSERTED.Id
	VALUES (@Name, @NumberOfRounds, @CurrentRound)
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateGameResult]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateGameResult] 
	-- Add the parameters for the stored procedure here
	@Id int,
	@WhitePoint varchar(50),
	@BlackPoint varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Game
	SET WhitePoint = @WhitePoint
	,BlackPoint = @BlackPoint
	,Ongoing = 0
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePlayerPointsByRound]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdatePlayerPointsByRound]
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@PlayerId int,
	@Round int,
	@Points decimal(18, 1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE PlayerPointsByRound
	SET Points = @Points
	WHERE TournamentId = @TournamentId AND PlayerId = @PlayerId AND Round = @Round
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateTournamentRound]    Script Date: 10/12/2023 18:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateTournamentRound] 
	-- Add the parameters for the stored procedure here
	@Id int,
	@Round int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Tournament
	SET CurrentRound = @Round
	WHERE Id = @Id
END
GO
USE [master]
GO
ALTER DATABASE [chessehc] SET  READ_WRITE 
GO
