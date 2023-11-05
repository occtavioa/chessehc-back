USE [chessehc]
GO
/****** Object:  Table [dbo].[Bye]    Script Date: 5/11/2023 18:39:06 ******/
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
/****** Object:  Table [dbo].[Game]    Script Date: 5/11/2023 18:39:06 ******/
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
/****** Object:  Table [dbo].[Player]    Script Date: 5/11/2023 18:39:06 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerPointsByRound]    Script Date: 5/11/2023 18:39:06 ******/
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
/****** Object:  Table [dbo].[Title]    Script Date: 5/11/2023 18:39:06 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tournament]    Script Date: 5/11/2023 18:39:06 ******/
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
INSERT [dbo].[Bye] ([TournamentId], [Round], [PlayerId], [ByePoint]) VALUES (1, 1, 2, N'U')
INSERT [dbo].[Bye] ([TournamentId], [Round], [PlayerId], [ByePoint]) VALUES (1, 2, 3, N'U')
GO
SET IDENTITY_INSERT [dbo].[Game] ON 

INSERT [dbo].[Game] ([Id], [TournamentId], [Round], [WhiteId], [BlackId], [WhitePoint], [BlackPoint], [Ongoing]) VALUES (1, 1, 1, 3, 1, N'L', N'W', 0)
INSERT [dbo].[Game] ([Id], [TournamentId], [Round], [WhiteId], [BlackId], [WhitePoint], [BlackPoint], [Ongoing]) VALUES (2, 1, 2, 1, 2, N'D', N'D', 0)
SET IDENTITY_INSERT [dbo].[Game] OFF
GO
SET IDENTITY_INSERT [dbo].[Player] ON 

INSERT [dbo].[Player] ([Id], [TournamentId], [Name], [Rating], [TitleId]) VALUES (1, 1, N'testp1', 2000, 3)
INSERT [dbo].[Player] ([Id], [TournamentId], [Name], [Rating], [TitleId]) VALUES (2, 1, N'testp2', 0, 2)
INSERT [dbo].[Player] ([Id], [TournamentId], [Name], [Rating], [TitleId]) VALUES (3, 1, N'testp3', 1500, NULL)
INSERT [dbo].[Player] ([Id], [TournamentId], [Name], [Rating], [TitleId]) VALUES (4, 2, N'testp1', 32, NULL)
INSERT [dbo].[Player] ([Id], [TournamentId], [Name], [Rating], [TitleId]) VALUES (5, 2, N'testp2', 0, 6)
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
INSERT [dbo].[PlayerPointsByRound] ([TournamentId], [PlayerId], [Round], [Points]) VALUES (1, 1, 1, CAST(1.0 AS Decimal(18, 1)))
INSERT [dbo].[PlayerPointsByRound] ([TournamentId], [PlayerId], [Round], [Points]) VALUES (1, 1, 2, CAST(1.5 AS Decimal(18, 1)))
INSERT [dbo].[PlayerPointsByRound] ([TournamentId], [PlayerId], [Round], [Points]) VALUES (1, 2, 1, CAST(1.0 AS Decimal(18, 1)))
INSERT [dbo].[PlayerPointsByRound] ([TournamentId], [PlayerId], [Round], [Points]) VALUES (1, 2, 2, CAST(1.5 AS Decimal(18, 1)))
INSERT [dbo].[PlayerPointsByRound] ([TournamentId], [PlayerId], [Round], [Points]) VALUES (1, 3, 1, CAST(0.0 AS Decimal(18, 1)))
INSERT [dbo].[PlayerPointsByRound] ([TournamentId], [PlayerId], [Round], [Points]) VALUES (1, 3, 2, CAST(1.0 AS Decimal(18, 1)))
GO
SET IDENTITY_INSERT [dbo].[Title] ON 

INSERT [dbo].[Title] ([Id], [Label]) VALUES (1, N'GM')
INSERT [dbo].[Title] ([Id], [Label]) VALUES (2, N'IM')
INSERT [dbo].[Title] ([Id], [Label]) VALUES (3, N'WGM')
INSERT [dbo].[Title] ([Id], [Label]) VALUES (4, N'FM')
INSERT [dbo].[Title] ([Id], [Label]) VALUES (5, N'WIM')
INSERT [dbo].[Title] ([Id], [Label]) VALUES (6, N'CM')
INSERT [dbo].[Title] ([Id], [Label]) VALUES (7, N'WFM')
INSERT [dbo].[Title] ([Id], [Label]) VALUES (8, N'WCM')
SET IDENTITY_INSERT [dbo].[Title] OFF
GO
SET IDENTITY_INSERT [dbo].[Tournament] ON 

INSERT [dbo].[Tournament] ([Id], [Name], [NumberOfRounds], [CurrentRound]) VALUES (1, N'testtournament', 5, 2)
INSERT [dbo].[Tournament] ([Id], [Name], [NumberOfRounds], [CurrentRound]) VALUES (2, N'testtournament2', 4, NULL)
SET IDENTITY_INSERT [dbo].[Tournament] OFF
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
/****** Object:  StoredProcedure [dbo].[GetTournamentByesByRound]    Script Date: 5/11/2023 18:39:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTournamentById]    Script Date: 5/11/2023 18:39:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTournamentGamesByRound]    Script Date: 5/11/2023 18:39:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTournamentPlayers]    Script Date: 5/11/2023 18:39:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTournaments]    Script Date: 5/11/2023 18:39:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTournamentStandingsByRound]    Script Date: 5/11/2023 18:39:06 ******/
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
