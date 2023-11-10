USE [chessehc]
GO
/****** Object:  User [chessehc]    Script Date: 10/11/2023 11:39:38 ******/
CREATE USER [chessehc] FOR LOGIN [chessehc] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [chessehc]
GO
/****** Object:  Table [dbo].[Bye]    Script Date: 10/11/2023 11:39:38 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Game]    Script Date: 10/11/2023 11:39:38 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 10/11/2023 11:39:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Rating] [int] NOT NULL,
	[TitleId] [int] NULL,
 CONSTRAINT [PK_Player] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerPointsByRound]    Script Date: 10/11/2023 11:39:38 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Title]    Script Date: 10/11/2023 11:39:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Title](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Title] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tournament]    Script Date: 10/11/2023 11:39:38 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE [dbo].[Player]  WITH CHECK ADD  CONSTRAINT [FK_Player_Title] FOREIGN KEY([TitleId])
REFERENCES [dbo].[Title] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Player] CHECK CONSTRAINT [FK_Player_Title]
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
/****** Object:  StoredProcedure [dbo].[GetTournamentByesByRound]    Script Date: 10/11/2023 11:39:38 ******/
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
	@RoundNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Bye.Round
	,Player.Id
	,Player.Name
	,Player.Rating
	,PlayerPointsByRound.Points
	,Title.Label AS Title
	,Bye.ByePoint
	FROM Bye
	INNER JOIN Player ON Player.Id = Bye.PlayerId
	LEFT JOIN Title ON Title.Id = Player.TitleId
	INNER JOIN PlayerPointsByRound ON PlayerPointsByRound.PlayerId = Player.Id AND PlayerPointsByRound.Round = Bye.Round
	WHERE Bye.TournamentId = @TournamentId AND Bye.Round = @RoundNumber
END
GO
/****** Object:  StoredProcedure [dbo].[GetTournamentById]    Script Date: 10/11/2023 11:39:38 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTournamentGamesByRound]    Script Date: 10/11/2023 11:39:38 ******/
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
	@RoundNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Game.Id
      ,Game.Round
	  ,White.Id
	  ,White.Name
	  ,White.Rating
	  ,WhiteTitle.Label AS Title
	  ,WhitePointsByRound.Points
	  ,Black.Id
	  ,Black.Name
	  ,Black.Rating
	  ,BlackTitle.Label AS Title
      ,BlackPointsByRound.Points
	  ,Game.WhitePoint
      ,Game.BlackPoint
      ,Game.Ongoing
	FROM Game
	INNER JOIN Player AS White ON White.Id = Game.WhiteId
	INNER JOIN PlayerPointsByRound AS WhitePointsByRound ON WhitePointsByRound.PlayerId = White.Id AND WhitePointsByRound.Round = Game.Round
	LEFT JOIN Title AS WhiteTitle ON WhiteTitle.Id = White.TitleId
	INNER JOIN Player AS Black ON Game.BlackId = Black.Id
	INNER JOIN PlayerPointsByRound AS BlackPointsByRound ON BlackPointsByRound.PlayerId = Black.Id AND BlackPointsByRound.Round = Game.Round
	LEFT JOIN Title AS BlackTitle ON BlackTitle.Id = Black.TitleId
	WHERE Game.TournamentId = @TournamentId AND Game.Round = @RoundNumber
END
GO
/****** Object:  StoredProcedure [dbo].[GetTournamentPlayers]    Script Date: 10/11/2023 11:39:38 ******/
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
	,Title.Label AS Title
	FROM Player
	INNER JOIN Tournament ON Tournament.Id = Player.TournamentId
	LEFT JOIN PlayerPointsByRound ON PlayerPointsByRound.PlayerId = Player.Id AND PlayerPointsByRound.Round = Tournament.CurrentRound
	LEFT JOIN Title ON Title.Id = Player.TitleId
	WHERE Tournament.Id = @TournamentId
END
GO
/****** Object:  StoredProcedure [dbo].[GetTournaments]    Script Date: 10/11/2023 11:39:38 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTournamentStandingsByRound]    Script Date: 10/11/2023 11:39:38 ******/
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
	@RoundNumber int
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
	,Title.Label AS Title
	FROM Player
	INNER JOIN PlayerPointsByRound ON PlayerPointsByRound.PlayerId = Player.Id AND PlayerPointsByRound.Round = @RoundNumber
	LEFT JOIN Title ON Title.Id = Player.TitleId
	WHERE Player.TournamentId = @TournamentId
END
GO
/****** Object:  StoredProcedure [dbo].[InsertPlayer]    Script Date: 10/11/2023 11:39:38 ******/
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
	VALUES (@TournamentID, @Name, @Rating, (SELECT Title.Id FROM Title WHERE Title.Label = @Title))
END
GO
/****** Object:  StoredProcedure [dbo].[InsertPlayerPointsByRound]    Script Date: 10/11/2023 11:39:38 ******/
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
	@RoundNumber int,
	@Points decimal(18, 1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO PlayerPointsByRound
	VALUES (@TournamentId, @PlayerId, @RoundNumber, @Points)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertTournament]    Script Date: 10/11/2023 11:39:38 ******/
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
