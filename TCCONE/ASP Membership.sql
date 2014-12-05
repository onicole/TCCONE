/****** ASP.NET Membership sub-schema ******/

USE master
GO

--Force delete database if exist
IF EXISTS(select * from sys.databases where name='TCCONE_members')
BEGIN
	ALTER DATABASE TCCONE_members SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE TCCONE_members
END
GO

CREATE DATABASE TCCONE_members
GO

USE TCCONE_members
GO

CREATE TABLE __MigrationHistory(
	MigrationId nvarchar(150) NOT NULL,
	ContextKey nvarchar(300) NOT NULL,
	Model varbinary(max) NOT NULL,
	ProductVersion nvarchar(32) NOT NULL,
 CONSTRAINT PK_dbo__MigrationHistory PRIMARY KEY CLUSTERED 
(
	MigrationId ASC,
	ContextKey ASC
))

GO

CREATE TABLE Applications(
	ApplicationId uniqueidentifier NOT NULL,
	ApplicationName nvarchar(235) NOT NULL,
	Description nvarchar(256) NULL,
 CONSTRAINT PK_dboApplications PRIMARY KEY CLUSTERED 
(
	ApplicationId ASC
))

GO

CREATE TABLE Memberships(
	UserId uniqueidentifier NOT NULL,
	ApplicationId uniqueidentifier NOT NULL,
	Password nvarchar(128) NOT NULL,
	PasswordFormat int NOT NULL,
	PasswordSalt nvarchar(128) NOT NULL,
	Email nvarchar(256) NULL,
	PasswordQuestion nvarchar(256) NULL,
	PasswordAnswer nvarchar(128) NULL,
	IsApproved bit NOT NULL,
	IsLockedOut bit NOT NULL,
	CreateDate datetime NOT NULL,
	LastLoginDate datetime NOT NULL,
	LastPasswordChangedDate datetime NOT NULL,
	LastLockoutDate datetime NOT NULL,
	FailedPasswordAttemptCount int NOT NULL,
	FailedPasswordAttemptWindowStart datetime NOT NULL,
	FailedPasswordAnswerAttemptCount int NOT NULL,
	FailedPasswordAnswerAttemptWindowsStart datetime NOT NULL,
	Comment nvarchar(256) NULL,
 CONSTRAINT PK_dbo_Memberships PRIMARY KEY CLUSTERED 
(
	UserId ASC
))

GO

CREATE TABLE Profiles(
	UserId uniqueidentifier NOT NULL,
	PropertyNames nvarchar(max) NOT NULL,
	PropertyValueStrings nvarchar(max) NOT NULL,
	PropertyValueBinary varbinary(max) NOT NULL,
	LastUpdatedDate datetime NOT NULL,
 CONSTRAINT PK_dbo_Profiles PRIMARY KEY CLUSTERED 
(
	UserId ASC
))

GO

CREATE TABLE Roles(
	RoleId uniqueidentifier NOT NULL,
	ApplicationId uniqueidentifier NOT NULL,
	RoleName nvarchar(256) NOT NULL,
	Description nvarchar(256) NULL,
 CONSTRAINT PK_dbo_Roles PRIMARY KEY CLUSTERED 
(
	RoleId ASC
))

GO

CREATE TABLE Users(
	UserId uniqueidentifier NOT NULL,
	ApplicationId uniqueidentifier NOT NULL,
	Firstname varchar(45) NULL,
	LastName varchar(45) NULL,
	UserName nvarchar(50) NOT NULL,
	IsAnonymous bit NOT NULL,
	LastActivityDate datetime NOT NULL,
 CONSTRAINT PK_dbo_Users PRIMARY KEY CLUSTERED 
(
	UserId ASC
))

GO

CREATE TABLE UsersInRoles(
	UserId uniqueidentifier NOT NULL,
	RoleId uniqueidentifier NOT NULL,
 CONSTRAINT PK_dbo_UsersInRoles PRIMARY KEY CLUSTERED 
(
	UserId ASC,
	RoleId ASC
))

GO

ALTER TABLE Roles  WITH CHECK ADD  CONSTRAINT FK_dbo_Roles_dbo_Applications_ApplicationId FOREIGN KEY(ApplicationId)
REFERENCES Applications (ApplicationId)
GO

ALTER TABLE Profiles  WITH CHECK ADD  CONSTRAINT FK_dbo_Profiles_dbo_Users_UserId FOREIGN KEY(UserId)
REFERENCES Users (UserId)
GO

ALTER TABLE Memberships  WITH CHECK ADD  CONSTRAINT FK_dbo_Memberships_dbo_Applications_ApplicationId FOREIGN KEY(ApplicationId) 
REFERENCES Applications (ApplicationId)
GO

ALTER TABLE Memberships  WITH CHECK ADD  CONSTRAINT FK_dbo_Memberships_dbo_Users_UserId FOREIGN KEY(UserId)
REFERENCES Users (UserId) ON DELETE CASCADE
GO

ALTER TABLE Users  WITH CHECK ADD  CONSTRAINT FK_dbo_Users_dbo_Applications_ApplicationId FOREIGN KEY(ApplicationId)
REFERENCES Applications (ApplicationId)
GO

ALTER TABLE UsersInRoles  WITH CHECK ADD  CONSTRAINT FK_dbo_UsersInRoles_dbo_Roles_RoleId FOREIGN KEY(RoleId)
REFERENCES Roles (RoleId)
GO

ALTER TABLE UsersInRoles  WITH CHECK ADD  CONSTRAINT FK_dbo_UsersInRoles_dbo_Users_UserId FOREIGN KEY(UserId)
REFERENCES Users (UserId)
GO

