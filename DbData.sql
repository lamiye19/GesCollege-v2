USE [master]
GO
/****** Object:  Database [GesCollegeBd2]    Script Date: 10/04/2021 19:13:11 ******/
CREATE DATABASE [GesCollegeBd2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GesCollegeBd2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\GesCollegeBd2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GesCollegeBd2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\GesCollegeBd2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [GesCollegeBd2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GesCollegeBd2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GesCollegeBd2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET ARITHABORT OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [GesCollegeBd2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GesCollegeBd2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GesCollegeBd2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GesCollegeBd2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GesCollegeBd2] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [GesCollegeBd2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GesCollegeBd2] SET  MULTI_USER 
GO
ALTER DATABASE [GesCollegeBd2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GesCollegeBd2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GesCollegeBd2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GesCollegeBd2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GesCollegeBd2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GesCollegeBd2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GesCollegeBd2] SET QUERY_STORE = OFF
GO
USE [GesCollegeBd2]
GO
/****** Object:  Table [dbo].[College]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[College](
	[CodeCollege] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](30) NOT NULL,
	[SiteWeb] [varchar](100) NOT NULL,
 CONSTRAINT [PK_dbo.College] PRIMARY KEY CLUSTERED 
(
	[CodeCollege] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departement]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departement](
	[CodeDep] [int] IDENTITY(1,1) NOT NULL,
	[NomDep] [varchar](30) NOT NULL,
	[CodeCollege] [int] NOT NULL,
	[Directeur_Id] [int] NULL,
 CONSTRAINT [PK_dbo.Departement] PRIMARY KEY CLUSTERED 
(
	[CodeDep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enseignant]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enseignant](
	[NumEnseignant] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](30) NOT NULL,
	[Prenom] [varchar](30) NOT NULL,
	[Tel] [nvarchar](max) NULL,
	[Mail] [varchar](100) NOT NULL,
	[DatePriseFonction] [datetime] NOT NULL,
	[Indice] [varchar](3) NOT NULL,
	[CourseId] [int] NOT NULL,
	[DepartementId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Enseignant] PRIMARY KEY CLUSTERED 
(
	[NumEnseignant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[DepView]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DepView]
	AS SELECT c.Nom as College, d.NomDep, e.Nom, e.Prenom FROM [Departement] d Join [College] c
	on d.CodeCollege = c.CodeCollege Join [Enseignant] e
	on d.Directeur_Id = e.NumEnseignant
GO
/****** Object:  Table [dbo].[Course]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[NumCours] [int] IDENTITY(1,1) NOT NULL,
	[LibelleCours] [varchar](30) NOT NULL,
	[SalleId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Course] PRIMARY KEY CLUSTERED 
(
	[NumCours] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CourseView]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CourseView]
	AS SELECT c.LibelleCours, e.Nom, e.Prenom FROM [Course] c Join [Enseignant] e
	on c.NumCours = e.CourseId
GO
/****** Object:  Table [dbo].[Etudiant]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Etudiant](
	[NumEtudiant] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](30) NOT NULL,
	[Prenom] [varchar](30) NOT NULL,
	[Tel] [nvarchar](max) NULL,
	[Mail] [varchar](100) NOT NULL,
	[DateEntree] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Etudiant] PRIMARY KEY CLUSTERED 
(
	[NumEtudiant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Note]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Note](
	[NumNote] [int] IDENTITY(1,1) NOT NULL,
	[NoteControle] [float] NOT NULL,
	[IdCourse] [int] NOT NULL,
	[IdEtudiant] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Note] PRIMARY KEY CLUSTERED 
(
	[NumNote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[EtuDepView]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EtuDepView]
	AS  SELECT c.LibelleCours, e.Nom, e.Prenom, n.NoteControle FROM [Course] c Join [Note] n
	on c.NumCours = n.IdCourse Join [Etudiant] e
	on n.IdEtudiant = e.NumEtudiant
GO
/****** Object:  Table [dbo].[Salle]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salle](
	[NumSalle] [int] IDENTITY(1,1) NOT NULL,
	[NomSalle] [nvarchar](10) NOT NULL,
	[Capacite] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Salle] PRIMARY KEY CLUSTERED 
(
	[NumSalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ReleveView]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReleveView]
	AS  SELECT c.NumCours, c.LibelleCours, e.Nom, e.Prenom, e.DateEntree, n.NoteControle, s.NomSalle, e.NumEtudiant
 FROM [Course] c Join [Note] n
	on c.NumCours = n.IdCourse Join [Etudiant] e
	on n.IdEtudiant = e.NumEtudiant Join [Salle] s
	on c.SalleId = s.NumSalle
GO
/****** Object:  View [dbo].[FichEnsView]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FichEnsView]
	AS SELECT e.*, d.NomDep, c.LibelleCours FROM [Enseignant] e join [Departement] d
	on e.DepartementId = d.CodeDep join [Course] c
	on e.CourseId = c.NumCours
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EtudiantCourses]    Script Date: 10/04/2021 19:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EtudiantCourses](
	[Etudiant_Id] [int] NOT NULL,
	[Course_Id] [int] NOT NULL,
 CONSTRAINT [PK_dbo.EtudiantCourses] PRIMARY KEY CLUSTERED 
(
	[Etudiant_Id] ASC,
	[Course_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_SalleId]    Script Date: 10/04/2021 19:13:11 ******/
CREATE NONCLUSTERED INDEX [IX_SalleId] ON [dbo].[Course]
(
	[SalleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CodeCollege]    Script Date: 10/04/2021 19:13:11 ******/
CREATE NONCLUSTERED INDEX [IX_CodeCollege] ON [dbo].[Departement]
(
	[CodeCollege] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Directeur_Id]    Script Date: 10/04/2021 19:13:11 ******/
CREATE NONCLUSTERED INDEX [IX_Directeur_Id] ON [dbo].[Departement]
(
	[Directeur_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CourseId]    Script Date: 10/04/2021 19:13:11 ******/
CREATE NONCLUSTERED INDEX [IX_CourseId] ON [dbo].[Enseignant]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DepartementId]    Script Date: 10/04/2021 19:13:11 ******/
CREATE NONCLUSTERED INDEX [IX_DepartementId] ON [dbo].[Enseignant]
(
	[DepartementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Course_Id]    Script Date: 10/04/2021 19:13:11 ******/
CREATE NONCLUSTERED INDEX [IX_Course_Id] ON [dbo].[EtudiantCourses]
(
	[Course_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Etudiant_Id]    Script Date: 10/04/2021 19:13:11 ******/
CREATE NONCLUSTERED INDEX [IX_Etudiant_Id] ON [dbo].[EtudiantCourses]
(
	[Etudiant_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_IdCourse]    Script Date: 10/04/2021 19:13:11 ******/
CREATE NONCLUSTERED INDEX [IX_IdCourse] ON [dbo].[Note]
(
	[IdCourse] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_IdEtudiant]    Script Date: 10/04/2021 19:13:11 ******/
CREATE NONCLUSTERED INDEX [IX_IdEtudiant] ON [dbo].[Note]
(
	[IdEtudiant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Course_dbo.Salle_SalleId] FOREIGN KEY([SalleId])
REFERENCES [dbo].[Salle] ([NumSalle])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_dbo.Course_dbo.Salle_SalleId]
GO
ALTER TABLE [dbo].[Departement]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Departement_dbo.College_CodeCollege] FOREIGN KEY([CodeCollege])
REFERENCES [dbo].[College] ([CodeCollege])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Departement] CHECK CONSTRAINT [FK_dbo.Departement_dbo.College_CodeCollege]
GO
ALTER TABLE [dbo].[Departement]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Departement_dbo.Enseignant_Directeur_Id] FOREIGN KEY([Directeur_Id])
REFERENCES [dbo].[Enseignant] ([NumEnseignant])
GO
ALTER TABLE [dbo].[Departement] CHECK CONSTRAINT [FK_dbo.Departement_dbo.Enseignant_Directeur_Id]
GO
ALTER TABLE [dbo].[Enseignant]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Enseignant_dbo.Course_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([NumCours])
GO
ALTER TABLE [dbo].[Enseignant] CHECK CONSTRAINT [FK_dbo.Enseignant_dbo.Course_CourseId]
GO
ALTER TABLE [dbo].[Enseignant]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Enseignant_dbo.Departement_Departement_Id] FOREIGN KEY([DepartementId])
REFERENCES [dbo].[Departement] ([CodeDep])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enseignant] CHECK CONSTRAINT [FK_dbo.Enseignant_dbo.Departement_Departement_Id]
GO
ALTER TABLE [dbo].[EtudiantCourses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.EtudiantCourses_dbo.Course_Course_Id] FOREIGN KEY([Course_Id])
REFERENCES [dbo].[Course] ([NumCours])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EtudiantCourses] CHECK CONSTRAINT [FK_dbo.EtudiantCourses_dbo.Course_Course_Id]
GO
ALTER TABLE [dbo].[EtudiantCourses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.EtudiantCourses_dbo.Etudiant_Etudiant_Id] FOREIGN KEY([Etudiant_Id])
REFERENCES [dbo].[Etudiant] ([NumEtudiant])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EtudiantCourses] CHECK CONSTRAINT [FK_dbo.EtudiantCourses_dbo.Etudiant_Etudiant_Id]
GO
ALTER TABLE [dbo].[Note]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Note_dbo.Course_IdCourse] FOREIGN KEY([IdCourse])
REFERENCES [dbo].[Course] ([NumCours])
GO
ALTER TABLE [dbo].[Note] CHECK CONSTRAINT [FK_dbo.Note_dbo.Course_IdCourse]
GO
ALTER TABLE [dbo].[Note]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Note_dbo.Etudiant_IdEtudiant] FOREIGN KEY([IdEtudiant])
REFERENCES [dbo].[Etudiant] ([NumEtudiant])
GO
ALTER TABLE [dbo].[Note] CHECK CONSTRAINT [FK_dbo.Note_dbo.Etudiant_IdEtudiant]
GO
USE [master]
GO
ALTER DATABASE [GesCollegeBd2] SET  READ_WRITE 
GO
