--ToTheRescue!
--Creation scrip
--Description: Creates and deletes the tables of the revised ER diagram

--Note: Feel free to edit any of the VARCHAR(50) to a reasonable amount of characters
USE robert_mooers

DROP TABLE CST324_Lake_Robert.ProfileProgressHistory;
DROP TABLE CST324_Lake_Robert.MiniGameMedia;
DROP TABLE CST324_Lake_Robert.MiniGames;
DROP TABLE CST324_Lake_Robert.GameCategories;
DROP TABLE CST324_Lake_Robert.ProfileAnimals;
DROP TABLE CST324_Lake_Robert.ProfileProgress;
DROP TABLE CST324_Lake_Robert.Profiles;
DROP TABLE CST324_Lake_Robert.Users;
DROP TABLE CST324_Lake_Robert.Animals;
DROP TABLE CST324_Lake_Robert.Nodes;
DROP TABLE CST324_Lake_Robert.Maps;
DROP TABLE CST324_Lake_Robert.Sounds;
DROP TABLE CST324_Lake_Robert.Images;

CREATE TABLE CST324_Lake_Robert.Images (
	ImageID INT PRIMARY KEY IDENTITY
	, ImageClass INT NOT NULL
	, Images VARBINARY(max) NOT NULL
	, ImageName VARCHAR(50) NOT NULL);

CREATE TABLE CST324_Lake_Robert.Sounds (
	SoundID INT PRIMARY KEY IDENTITY
	, SoundClass INT NOT NULL
	, Sound VARBINARY(max) NOT NULL
	, SoundName VARCHAR(50) NOT NULL);

CREATE TABLE CST324_Lake_Robert.Maps (
	MapID INT PRIMARY KEY IDENTITY
	, MapName VARCHAR(50) NOT NULL
	, ImageID INT REFERENCES CST324_Lake_Robert.Images (ImageID) NOT NULL
	, SoundID INT REFERENCES CST324_Lake_Robert.Sounds (SoundID) NOT NULL);

CREATE TABLE CST324_Lake_Robert.Nodes (
	MapID INT REFERENCES CST324_Lake_Robert.Maps (MapID) NOT NULL
	, NodeID INT IDENTITY
	, XCoordinate INT NOT NULL
	, YCoordinate INT NOT NULL
	, PRIMARY KEY (MapID, NodeID));

CREATE TABLE CST324_Lake_Robert.Animals (
	AnimalID INT PRIMARY KEY IDENTITY
	, FunFact VARCHAR(250)
	, Shiny BIT NOT NULL --1 means it is shiny
	, SoundID INT REFERENCES CST324_Lake_Robert.Sounds (SoundID) NOT NULL
	, ImageID INT REFERENCES CST324_Lake_Robert.Images (ImageID) NOT NULL);

CREATE TABLE CST324_Lake_Robert.Users (
	UserID INT PRIMARY KEY IDENTITY
	, UserPassword NVARCHAR(50) NOT NULL
	, Username NVARCHAR(50) unique NOT NULL); --NVARCHAR allows for unicode characters in other languages

CREATE TABLE CST324_Lake_Robert.Profiles (
	ProfileID INT PRIMARY KEY IDENTITY
	, UserID INT REFERENCES CST324_Lake_Robert.Users (UserID) NOT NULL
	, AvatarID INT REFERENCES CST324_Lake_Robert.Images (ImageID) NOT NULL
	, ProfileName NVARCHAR(30) NOT NULL
	, ToggleSound BIT NOT NULL DEFAULT 1 --0 = sound off, 1 = sound on, defualted to sound on
	, ToggleMusic BIT NOT NULL DEFAULT 1
	, MathDifficultyLevel INT NOT NULL DEFAULT 1 --default to the lowest difficulty level
	, MathPerformanceStat FLOAT NOT NULL
	, ReadingDifficultyLevel INT NOT NULL DEFAULT 1 --default to the lowest difficulty level
	, ReadingPerformanceStat FLOAT NOT NULL
	, SubjectFilter VARCHAR(50));

CREATE TABLE CST324_Lake_Robert.ProfileProgress (
	ProfileID INT PRIMARY KEY REFERENCES CST324_Lake_Robert.Profiles (ProfileID) NOT NULL
	, CurrentMap INT REFERENCES CST324_Lake_Robert.Maps (MapID) NOT NULL
	, CurrentNode INT NOT NULL --current node number in the map
	, AnimalID INT REFERENCES CST324_Lake_Robert.Animals (AnimalID) NOT NULL);

CREATE TABLE CST324_Lake_Robert.ProfileAnimals (
	ProfileAnimalID INT PRIMARY KEY IDENTITY
	, AnimalID INT REFERENCES CST324_Lake_Robert.Animals (AnimalID) NOT NULL
	, ProfileID INT REFERENCES CST324_Lake_Robert.Profiles (ProfileID) NOT NULL
	, Active BIT NOT NULL DEFAULT 1); -- 1 means active in sanctuary

CREATE TABLE CST324_Lake_Robert.GameCategories (
	GameCategoryID INT PRIMARY KEY IDENTITY
	, GameCategoryName VARCHAR(50) NOT NULL);

CREATE TABLE CST324_Lake_Robert.MiniGames (
	MiniGameID INT PRIMARY KEY IDENTITY
	, MiniGameCategoryID INT REFERENCES CST324_Lake_Robert.GameCategories (GameCategoryID) NOT NULL
	, MiniGameCode VARCHAR(max) NOT NULL --syntax for clob
	, MiniGameName VARCHAR(50) NOT NULL
	, MinDifficulty INT NOT NULL
	, MaxDifficulty INT NOT NULL);

CREATE TABLE CST324_Lake_Robert.MiniGameMedia (
	MediaID INT PRIMARY KEY IDENTITY
	, MiniGameID INT REFERENCES CST324_Lake_Robert.Minigames (MiniGameID) NOT NULL
	, Difficulty INT DEFAULT NULL	--nulled if media is used for every instance of that game
	, MiniGameMedia VARBINARY(max) NOT NULL);

CREATE TABLE CST324_Lake_Robert.ProfileProgressHistory (
	ProgressID INT PRIMARY KEY IDENTITY
	, ProfileID INT REFERENCES CST324_Lake_Robert.Profiles (ProfileID) NOT NULL
	, MiniGameID INT REFERENCES CST324_Lake_Robert.Minigames (MiniGameID) NOT NULL);