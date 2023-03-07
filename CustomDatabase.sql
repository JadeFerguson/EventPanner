USE master
DROP DATABASE IF EXISTS EventPlanner


CREATE DATABASE EventPlanner
GO

USE EventPlanner
GO

/*********************
Tables
**********************/

CREATE TABLE Users
(
	UserId				int				PRIMARY KEY IDENTITY
	, PhoneNumber		varchar(15)		NOT NULL
	, Email				varchar(200)	NOT NULL
	, FirstName			varchar(25)		NOT NULL
	, LastName			varchar(25)		NOT NULL
	, DateJoined		datetime2(0)	NOT NULL
)

/*Dummy/Test Data for Users*/

SET IDENTITY_INSERT Users ON

INSERT INTO Users(UserId, PhoneNumber, Email
			, FirstName, LastName, DateJoined)
	VALUES(1, 5698561235, 'geraltrivia@gmail.com'
		, 'Geralt', 'Rivia', GETDATE())

INSERT INTO Users(UserId, PhoneNumber, Email
			, FirstName, LastName, DateJoined)
	VALUES(2, 8315991479, 'anakinskywalker@gmail.com'
		, 'Anakin', 'Skywalker', GETDATE())

INSERT INTO Users(UserId, PhoneNumber, Email
			, FirstName, LastName, DateJoined)
	VALUES(3, 4567897415, 'spencerreid@yahoo.com'
		, 'Spencer', 'Reid', GETDATE())

SET IDENTITY_INSERT Users OFF

CREATE TABLE UserImages
(
	ImageId				int				PRIMARY KEY IDENTITY
	, UserId			int				REFERENCES Users(UserId)
	, ImageUrl			varchar(400)	NOT NULL
)

/*Dummy/Test Data for UserImages*/

SET IDENTITY_INSERT UserImages ON

INSERT INTO UserImages(ImageId, UserId, ImageUrl)
	Values(1, 1, 'https://via.placeholder.com/300')

INSERT INTO UserImages(ImageId, UserId, ImageUrl)
	Values(2, 2, 'https://via.placeholder.com/300')

INSERT INTO UserImages(ImageId, UserId, ImageUrl)
	Values(3, 3, 'https://via.placeholder.com/300')

SET IDENTITY_INSERT UserImages OFF

CREATE TABLE UserLogins
(
	UserId				int				REFERENCES Users(UserId)
	, UserName			varchar(20)		NOT NULL UNIQUE
	, [Password]		varchar(65)		NOT NULL
)

/*Dummy/Test Data for UserLogins*/
INSERT INTO UserLogins(UserId, UserName, [Password])
	VALUES(1, 'TheWitcher1', HASHBYTES('SHA1', 'RoachIsBest'))

INSERT INTO UserLogins(UserId, UserName, [Password])
	VALUES(2, 'FutureJediMaster', HASHBYTES('SHA1', 'SenatorPalpatine'))

INSERT INTO UserLogins(UserId, UserName, [Password])
	VALUES(3, 'DrSpencerReid', HASHBYTES('SHA1', 'BestCsIAgent'))

CREATE TABLE CollaboratorRoles
(
	CollabRoleId		int				PRIMARY KEY IDENTITY
	, CollabRole		varchar(100)	NOT NULL
)

SET IDENTITY_INSERT CollaboratorRoles ON

INSERT INTO CollaboratorRoles(CollabRoleId, CollabRole)
	Values(1, 'Is the model')

INSERT INTO CollaboratorRoles(CollabRoleId, CollabRole)
	Values(2, 'Is the set designer and stylist, will be bringing thing needed for wordrobe and set')

INSERT INTO CollaboratorRoles(CollabRoleId, CollabRole)
	Values(3, 'Will be the photographer and will also take some BTS videos')

SET IDENTITY_INSERT CollaboratorRoles OFF

CREATE TABLE Collaborators
(
	CollabId				int				PRIMARY KEY IDENTITY
	, CollaboratorName		varchar(150)	NOT NULL
	, CollaboratorDetails	varchar(500)	NOT NULL
)

/*Dummy/Test data for collaborators*/

SET IDENTITY_INSERT Collaborators ON

INSERT INTO Collaborators(CollabId, CollaboratorName, CollaboratorDetails)
	VALUES(1, 'Garalt Rivia', 'Garalt is an experienced swordsman who has many years of experience as one
	, he will be our model for this dark fantasy themed shoot')

INSERT INTO Collaborators(CollabId, CollaboratorName, CollaboratorDetails)
	VALUES(2, 'Anakin Skywalker', 'Although he is a Jedi, he has some serious fashion sense, with connections
	to places such as nabu and other places, he will be our expert stylist and set designer')

INSERT INTO Collaborators(CollabId, CollaboratorName, CollaboratorDetails)
	VALUES(3, 'Spencer Reid', 'Spencer Reid is a talented photographer who knows his lighting and ways around photoshop')

SET IDENTITY_INSERT Collaborators OFF

CREATE TABLE InvolvedCollaborators
(
	UserId					int				REFERENCES Users(UserId)
	, CollabId				int				REFERENCES Collaborators(CollabId)
	, CollabRoleId			int				REFERENCES CollaboratorRoles(CollabRoleID)
	, PRIMARY KEY(UserId, CollabId)
)

INSERT INTO InvolvedCollaborators(UserId, CollabId, CollabRoleId)
	VALUES(1, 1, 1)

INSERT INTO InvolvedCollaborators(UserId, CollabId, CollabRoleId)
	VALUES(2, 3, 2)

INSERT INTO InvolvedCollaborators(UserId, CollabId, CollabRoleId)
	VALUES(3, 3, 3)


CREATE TABLE [Events]
(
	EventId					int				PRIMARY KEY IDENTITY
	, EventLocation			varchar(200)	NOT NULL
	, EventDescription		varchar(500)	NOT NULL
	, EventStartTime		smalldateTime	NOT NULL
	, EventEndTime			smalldateTime	NOT NULL
)

SET IDENTITY_INSERT [Events] ON

INSERT INTO [Events](EventId, EventLocation, EventDescription, EventStartTime, EventEndTime)
	VALUES(1, 'GeorgeTown Steam Plant', 'The shoot will comprise of group and individual shoots of Final Fantasy
		7 cosplayers', '2022/06/18 12:30:00', '2022/06/18 20:00:00')

INSERT INTO [Events](EventId, EventLocation, EventDescription, EventStartTime, EventEndTime)
	VALUES(2, 'Chambers Bay', 'This shoot will be a shoot that will be inspired by Alice in Wonderland.
		The models will be dressed in rococo dresses inspired by each character. Models will need to arrive early
		to get makeup, hair, and fitting done.'
		, '2022/08/20 09:30:00', '2022/06/20 20:00:00')

INSERT INTO [Events](EventId, EventLocation, EventDescription, EventStartTime, EventEndTime)
	VALUES(3, 'Freeway Park', 'The shoot will be high fashion in the city. So think of the fashion they wear in vouge
		and the poses. ', '2022/10/22 10:00:00', '2022/10/22 12:00:00')

SET IDENTITY_INSERT [Events] OFF

CREATE TABLE EventsInvolved
(
	EventId					int				PRIMARY KEY REFERENCES [Events](EventId)
	, UserId				int				REFERENCES Users(UserId)
)

INSERT INTO EventsInvolved(EventId, UserId)
	VALUES(2, 1)

INSERT INTO EventsInvolved(EventId, UserId)
	VALUES(3, 3)

INSERT INTO EventsInvolved(EventId, UserId)
	VALUES(1, 3)

CREATE TABLE EventType
(
	EventId					int				REFERENCES [Events](EventId)
	, EventType				varchar(25)		NOT NULL
)

INSERT INTO EventType(EventId, EventType)
	VALUES(2, 'Styled Photoshoot')

INSERT INTO EventType(EventId, EventType)
	VALUES(1, 'Cosplay Photoshoot')

INSERT INTO EventType(EventId, EventType)
	VALUES(3, 'High Fashion')


CREATE TABLE EventDiscussion
(
	EventDiscussionId		int				PRIMARY KEY IDENTITY
	, EventId				int				REFERENCES [Events](EventId)
	, UserId				int				REFERENCES Users(UserId)
	, DatePosted			dateTime2(0)	NOT NULL
	, DiscussionPost		varchar(850)	NOT NULL
)

SET IDENTITY_INSERT EventDiscussion ON

INSERT INTO EventDiscussion(EventDiscussionId, EventId, UserId, DatePosted, DiscussionPost)
	VALUES(1, 3, 1, GETDATE(), 'So excited to working with everyone!')

INSERT INTO EventDiscussion(EventDiscussionId, EventId, UserId, DatePosted, DiscussionPost)
	VALUES(2, 3, 3, GETDATE(), 'The shoot was super fun and it was great to work with the team.
		Thank you all for working with me.')

SET IDENTITY_INSERT EventDiscussion OFF

/****************SELECT Queries*****************/

-- Get a list of users and their login information
-- This is importants as users need to their info and the corresponding logins
SELECT Users.UserId
	, PhoneNumber
	, Email
	, FirstName
	, LastName
	, UserName
	, Password
FROM Users
	JOIN UserLogins ON
		UserLogins.UserId = Users.UserId

-- Get all of the events Spencer Reid is involved in
/* This would be useful as many models, photographers, etc like to know how many events they
do in a year or over time */
SELECT FirstName
	, LastName
	, EventsInvolved.EventId
FROM Users
	JOIN EventsInvolved ON
		EventsInvolved.UserId = Users.UserId
WHERE FirstName = 'Spencer' AND LastName = 'Reid'

-- Get all the disscussion posts and who posted it with date posted 
-- for Event 3 
/* This would be helpful as we can look back on events and see the things that were posted and when */
SELECT [Events].EventId
	, EventDiscussion.UserId
	, FirstName
	, LastName
	, DiscussionPost
	, DatePosted
FROM Users
	JOIN EventDiscussion ON
		EventDiscussion.UserId = Users.UserId
	JOIN [Events] ON
		EventDiscussion.EventId = [Events].EventId

-- Get events with their description and their event type and order by eventid
/* This would be helpful as seeing the events that are happening, what event type it is is really usuful 
for those involved in the events. 
Also helps photographers see which genres they photograph most or events such as weddings, newborn photos, senior
photos */
SELECT [Events].EventId
	, EventType
	, EventDescription
FROM [Events]
	JOIN EventType ON
		EventType.EventId = Events.EventId
ORDER BY [Events].EventId

-- get users(first and last name) and there collarborator roles for event 1
/* This is helpful as it helps with seeing the users collaborator roles for that particular event*/
SELECT [Events].EventId
	, FirstName
	, LastName
	, CollabRole
FROM Users
	JOIN InvolvedCollaborators ON
		InvolvedCollaborators.UserId = Users.UserId
	JOIN CollaboratorRoles ON
		InvolvedCollaborators.CollabRoleId = CollaboratorRoles.CollabRoleId
	JOIN EventsInvolved ON
		EventsInvolved.UserId = Users.UserId
	JOIN [Events] ON
		EventsInvolved.EventId = [Events].EventId
WHERE [Events].EventId = 1

-- select the user with the email anakinskywalker@gmail.com
/* Although a simple select statement, it helps with looking up the user under that email
for instances that the email needs to be updated or user people need to send that user an email with 
their photos
*/
SELECT *
FROM Users
WHERE Email = 'anakinskywalker@gmail.com'

-- users information and their images
/*This is helpful as it can show other users what the person looks like or their work and match it up 
to their name, and how to contact the other user
*/
SELECT [Users].UserID
	, PhoneNumber
	, Email
	, FirstName
	, LastName
	, DateJoined
	, ImageId
	, ImageURL
FROM Users
	JOIN UserImages ON
		UserImages.UserId = Users.UserId