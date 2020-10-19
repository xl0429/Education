CREATE TABLE [dbo].[Admin] (
    [AdminName]    VARCHAR (25) NOT NULL,
    [Email]        VARCHAR (50) NOT NULL,
    [HashPassword] CHAR (44)    NOT NULL,
    PRIMARY KEY CLUSTERED ([AdminName] ASC)
);
CREATE TABLE [dbo].[GrammarLevel] (
    [Level]     CHAR (3)     NOT NULL,
    [LevelName] VARCHAR (25) NOT NULL,
    PRIMARY KEY CLUSTERED ([Level] ASC)
);
CREATE TABLE [dbo].[Country] (
    [CountryCode] CHAR (2)     NOT NULL,
    [CountryName] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([CountryCode] ASC)
);
CREATE TABLE [dbo].[Learner] (
    [Username]     VARCHAR (25) NOT NULL,
    [Email]        VARCHAR (50) NOT NULL,
    [HashPassword] VARCHAR (44) NOT NULL,
    [CountryCode]  CHAR (2)     NOT NULL,
    [Birthday]     DATE         NOT NULL,
    [Status]       VARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([Username] ASC),
    CONSTRAINT [FK_Learner_Country] FOREIGN KEY ([CountryCode]) REFERENCES [dbo].[Country] ([CountryCode])
);
CREATE TABLE [dbo].[Exercise] (
    [NoQuest]  CHAR (5) NOT NULL,
    [Question] TEXT     NOT NULL,
    [Answer]   TEXT     NOT NULL,
    [Level]    CHAR (3) NOT NULL,
    PRIMARY KEY CLUSTERED ([NoQuest] ASC),
    CONSTRAINT [FK_Exercise_GrammarLevel] FOREIGN KEY ([Level]) REFERENCES [dbo].[GrammarLevel] ([Level])
);

CREATE TABLE [dbo].[Answer] (
    [NoQuest]  CHAR (5)     NOT NULL,
    [Username] VARCHAR (25) NOT NULL,
    CONSTRAINT [FK_Answer_Exercise] FOREIGN KEY ([NoQuest]) REFERENCES [dbo].[Exercise] ([NoQuest]),
    CONSTRAINT [FK_Answer_Learner] FOREIGN KEY ([Username]) REFERENCES [dbo].[Learner] ([Username])
);
CREATE TABLE [dbo].[GrammarType] (
    [GrammarCode] CHAR (5)       NOT NULL,
    [Title]       VARCHAR (100)  NOT NULL,
    [Description] TEXT           NOT NULL,
    [Rating]      DECIMAL (2, 1) NULL,
    [Level]       CHAR (3)       NOT NULL,
    [Image]       TEXT           NULL,
    PRIMARY KEY CLUSTERED ([GrammarCode] ASC),
    CONSTRAINT [FK_GrammarType_GrammarLevel] FOREIGN KEY ([Level]) REFERENCES [dbo].[GrammarLevel] ([Level])
);
CREATE TABLE [dbo].[Edition] (
    [Date]        DATE         NULL,
    [AdminName]   VARCHAR (25) NULL,
    [GrammarCode] CHAR (5)     NULL,
    CONSTRAINT [FK_Edition_Admin] FOREIGN KEY ([AdminName]) REFERENCES [dbo].[Admin] ([AdminName]),
    CONSTRAINT [FK_Edition_GrammarType] FOREIGN KEY ([GrammarCode]) REFERENCES [dbo].[GrammarType] ([GrammarCode])
);


CREATE TABLE [dbo].[Learning] (
    [Username] VARCHAR (25) NOT NULL,
    [Level]    CHAR (3)     NOT NULL,
    CONSTRAINT [FK_Learning_GrammarLevel] FOREIGN KEY ([Level]) REFERENCES [dbo].[GrammarLevel] ([Level]),
    CONSTRAINT [FK_Learning_Learner] FOREIGN KEY ([Username]) REFERENCES [dbo].[Learner] ([Username])
);

CREATE TABLE [dbo].[LoginInfo] (
    [LoginId]  NUMERIC (5)  IDENTITY(1,1) NOT NULL,
    [DateTime] DATETIME     NOT NULL,
    [Username] VARCHAR (25) NOT NULL,
    PRIMARY KEY CLUSTERED ([LoginId] ASC),
    CONSTRAINT [FK_LoginInfo_Learner] FOREIGN KEY ([Username]) REFERENCES [dbo].[Learner] ([Username])
);

CREATE TABLE [dbo].[Rating] (
    [Username]    VARCHAR (25) NOT NULL,
    [GrammarCode] CHAR (5)     NOT NULL,
    [Rating]      DECIMAL (1)  NULL,
    CONSTRAINT [FK_Rating_Learner] FOREIGN KEY ([Username]) REFERENCES [dbo].[Learner] ([Username]),
    CONSTRAINT [FK_Rating_ToGrammarType] FOREIGN KEY ([GrammarCode]) REFERENCES [dbo].[GrammarType] ([GrammarCode])
);
