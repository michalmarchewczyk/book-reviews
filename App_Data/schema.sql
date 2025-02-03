/****** Object:  Table [dbo].[Authors]    Script Date: 04.02.2025 00:00:29 ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[Authors]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE [dbo].[Authors]
        (
            [Id]        [int] IDENTITY (1,1) NOT NULL,
            [FirstName] [nvarchar](max)      NULL,
            [LastName]  [nvarchar](max)      NOT NULL,
            CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED
                (
                 [Id] ASC
                    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
        ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    END

/****** Object:  Table [dbo].[Books]    Script Date: 04.02.2025 00:00:29 ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[Books]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE [dbo].[Books]
        (
            [Id]          [int] IDENTITY (1,1) NOT NULL,
            [Title]       [nvarchar](max)      NOT NULL,
            [AuthorId]    [int]                NOT NULL,
            [Description] [nvarchar](max)      NULL,
            [ISBN]        [char](13)           NOT NULL,
            [CoverPath]   [varchar](max)       NULL,
            [ReleaseYear] [int]                NOT NULL,
            CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED
                (
                 [Id] ASC
                    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
        ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    END

/****** Object:  Table [dbo].[ReviewLikes]    Script Date: 04.02.2025 00:00:29 ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[ReviewLikes]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE [dbo].[ReviewLikes]
        (
            [Id]       [int] IDENTITY (1,1) NOT NULL,
            [ReviewId] [int]                NOT NULL,
            [UserId]   [nvarchar](128)      NOT NULL,
            [Value]    [int]                NOT NULL,
            CONSTRAINT [PK_ReviewLikes] PRIMARY KEY CLUSTERED
                (
                 [Id] ASC
                    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
            CONSTRAINT [UK_ReviewLikes] UNIQUE NONCLUSTERED
                (
                 [ReviewId] ASC,
                 [UserId] ASC
                    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
        ) ON [PRIMARY]
    END

/****** Object:  Table [dbo].[Reviews]    Script Date: 04.02.2025 00:00:29 ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[Reviews]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE [dbo].[Reviews]
        (
            [Id]        [int] IDENTITY (1,1) NOT NULL,
            [BookId]    [int]                NOT NULL,
            [UserId]    [nvarchar](128)      NOT NULL,
            [Title]     [nvarchar](max)      NOT NULL,
            [Rating]    [int]                NOT NULL,
            [Content]   [nvarchar](max)      NULL,
            [CreatedAt] [datetime2](7)       NULL,
            CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED
                (
                 [Id] ASC
                    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
            CONSTRAINT [UK_Reviews] UNIQUE NONCLUSTERED
                (
                 [BookId] ASC,
                 [UserId] ASC
                    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
        ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    END

/****** Object:  Index [Index_Books_1]    Script Date: 04.02.2025 00:00:29 ******/
IF NOT EXISTS (SELECT *
               FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'[dbo].[Books]')
                 AND name = N'Index_Books_1')
CREATE NONCLUSTERED INDEX [Index_Books_1] ON [dbo].[Books]
    (
     [AuthorId] ASC
        ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Index_Books_2]    Script Date: 04.02.2025 00:00:29 ******/
IF NOT EXISTS (SELECT *
               FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'[dbo].[Books]')
                 AND name = N'Index_Books_2')
CREATE NONCLUSTERED INDEX [Index_Books_2] ON [dbo].[Books]
    (
     [ISBN] ASC
        ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

/****** Object:  Index [Index_ReviewLikes_1]    Script Date: 04.02.2025 00:00:29 ******/
IF NOT EXISTS (SELECT *
               FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'[dbo].[ReviewLikes]')
                 AND name = N'Index_ReviewLikes_1')
CREATE NONCLUSTERED INDEX [Index_ReviewLikes_1] ON [dbo].[ReviewLikes]
    (
     [ReviewId] ASC
        ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Index_ReviewLikes_2]    Script Date: 04.02.2025 00:00:29 ******/
IF NOT EXISTS (SELECT *
               FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'[dbo].[ReviewLikes]')
                 AND name = N'Index_ReviewLikes_2')
CREATE NONCLUSTERED INDEX [Index_ReviewLikes_2] ON [dbo].[ReviewLikes]
    (
     [UserId] ASC
        ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

/****** Object:  Index [Index_Reviews_1]    Script Date: 04.02.2025 00:00:29 ******/
IF NOT EXISTS (SELECT *
               FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'[dbo].[Reviews]')
                 AND name = N'Index_Reviews_1')
CREATE NONCLUSTERED INDEX [Index_Reviews_1] ON [dbo].[Reviews]
    (
     [BookId] ASC
        ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Index_Reviews_2]    Script Date: 04.02.2025 00:00:29 ******/
IF NOT EXISTS (SELECT *
               FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'[dbo].[Reviews]')
                 AND name = N'Index_Reviews_2')
CREATE NONCLUSTERED INDEX [Index_Reviews_2] ON [dbo].[Reviews]
    (
     [UserId] ASC
        ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[DEFAULT_Reviews_CreatedAt]')
                 AND type = 'D')
    BEGIN
        ALTER TABLE [dbo].[Reviews]
            ADD CONSTRAINT [DEFAULT_Reviews_CreatedAt] DEFAULT (getdate()) FOR [CreatedAt]
    END

IF NOT EXISTS (SELECT *
               FROM sys.foreign_keys
               WHERE object_id = OBJECT_ID(N'[dbo].[FK_Book_Author]')
                 AND parent_object_id = OBJECT_ID(N'[dbo].[Books]'))
ALTER TABLE [dbo].[Books]
    WITH CHECK ADD CONSTRAINT [FK_Book_Author] FOREIGN KEY ([AuthorId])
        REFERENCES [dbo].[Authors] ([Id])

IF EXISTS (SELECT *
           FROM sys.foreign_keys
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_Book_Author]')
             AND parent_object_id = OBJECT_ID(N'[dbo].[Books]'))
ALTER TABLE [dbo].[Books]
    CHECK CONSTRAINT [FK_Book_Author]

IF NOT EXISTS (SELECT *
               FROM sys.foreign_keys
               WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReviewLikes_Reviews]')
                 AND parent_object_id = OBJECT_ID(N'[dbo].[ReviewLikes]'))
ALTER TABLE [dbo].[ReviewLikes]
    WITH CHECK ADD CONSTRAINT [FK_ReviewLikes_Reviews] FOREIGN KEY ([ReviewId])
        REFERENCES [dbo].[Reviews] ([Id])
        ON DELETE CASCADE

IF EXISTS (SELECT *
           FROM sys.foreign_keys
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReviewLikes_Reviews]')
             AND parent_object_id = OBJECT_ID(N'[dbo].[ReviewLikes]'))
ALTER TABLE [dbo].[ReviewLikes]
    CHECK CONSTRAINT [FK_ReviewLikes_Reviews]

IF NOT EXISTS (SELECT *
               FROM sys.foreign_keys
               WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReviewLikes_Users]')
                 AND parent_object_id = OBJECT_ID(N'[dbo].[ReviewLikes]'))
ALTER TABLE [dbo].[ReviewLikes]
    WITH CHECK ADD CONSTRAINT [FK_ReviewLikes_Users] FOREIGN KEY ([UserId])
        REFERENCES [dbo].[Users] ([Id])

IF EXISTS (SELECT *
           FROM sys.foreign_keys
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_ReviewLikes_Users]')
             AND parent_object_id = OBJECT_ID(N'[dbo].[ReviewLikes]'))
ALTER TABLE [dbo].[ReviewLikes]
    CHECK CONSTRAINT [FK_ReviewLikes_Users]

IF NOT EXISTS (SELECT *
               FROM sys.foreign_keys
               WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reviews_Book]')
                 AND parent_object_id = OBJECT_ID(N'[dbo].[Reviews]'))
ALTER TABLE [dbo].[Reviews]
    WITH CHECK ADD CONSTRAINT [FK_Reviews_Book] FOREIGN KEY ([BookId])
        REFERENCES [dbo].[Books] ([Id])
        ON DELETE CASCADE

IF EXISTS (SELECT *
           FROM sys.foreign_keys
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reviews_Book]')
             AND parent_object_id = OBJECT_ID(N'[dbo].[Reviews]'))
ALTER TABLE [dbo].[Reviews]
    CHECK CONSTRAINT [FK_Reviews_Book]

IF NOT EXISTS (SELECT *
               FROM sys.foreign_keys
               WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reviews_Users]')
                 AND parent_object_id = OBJECT_ID(N'[dbo].[Reviews]'))
ALTER TABLE [dbo].[Reviews]
    WITH CHECK ADD CONSTRAINT [FK_Reviews_Users] FOREIGN KEY ([UserId])
        REFERENCES [dbo].[Users] ([Id])

IF EXISTS (SELECT *
           FROM sys.foreign_keys
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reviews_Users]')
             AND parent_object_id = OBJECT_ID(N'[dbo].[Reviews]'))
ALTER TABLE [dbo].[Reviews]
    CHECK CONSTRAINT [FK_Reviews_Users]

IF NOT EXISTS (SELECT *
               FROM sys.check_constraints
               WHERE object_id = OBJECT_ID(N'[dbo].[CK_ReviewLikes_1]')
                 AND parent_object_id = OBJECT_ID(N'[dbo].[ReviewLikes]'))
ALTER TABLE [dbo].[ReviewLikes]
    WITH CHECK ADD CONSTRAINT [CK_ReviewLikes_1] CHECK (([Value] = (1) OR [Value] = (-1)))

IF EXISTS (SELECT *
           FROM sys.check_constraints
           WHERE object_id = OBJECT_ID(N'[dbo].[CK_ReviewLikes_1]')
             AND parent_object_id = OBJECT_ID(N'[dbo].[ReviewLikes]'))
ALTER TABLE [dbo].[ReviewLikes]
    CHECK CONSTRAINT [CK_ReviewLikes_1]

IF NOT EXISTS (SELECT *
               FROM sys.check_constraints
               WHERE object_id = OBJECT_ID(N'[dbo].[CK_Reviews_1]')
                 AND parent_object_id = OBJECT_ID(N'[dbo].[Reviews]'))
ALTER TABLE [dbo].[Reviews]
    WITH CHECK ADD CONSTRAINT [CK_Reviews_1] CHECK (([Rating] > (0) AND [Rating] <= (5)))

IF EXISTS (SELECT *
           FROM sys.check_constraints
           WHERE object_id = OBJECT_ID(N'[dbo].[CK_Reviews_1]')
             AND parent_object_id = OBJECT_ID(N'[dbo].[Reviews]'))
ALTER TABLE [dbo].[Reviews]
    CHECK CONSTRAINT [CK_Reviews_1]

