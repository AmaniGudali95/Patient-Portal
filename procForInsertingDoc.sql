--Specify what database to use
USE PatientPortal;
--Separate statements
GO
--Check to see if the insert doctor procedure already exists, if it does then delete it
IF OBJECT_ID('spDoctorsInsert') IS NOT NULL
	DROP PROC spDoctorsInsert
--Separate statements
GO
/*
Otherwise create the Procedure with the following parameters,
all are required except age because it has a default value
*/
CREATE PROC spDoctorsInsert
@vFirstName varchar(30), @vLastname varchar(30), @vSpecialty int,
@vAge int = 29, @vUserName varchar(15), @vPassword varchar(15), @vActive int = 0
AS 
BEGIN TRY
		BEGIN
					--Insert into the given columns the values specified in the parameters
					INSERT INTO dbo.Doctors
					(
						docFirstname, docLastname, docAge, docSpecialty, docUserName, docPassword, docActive
					)

					VALUES 
					(
						@vFirstName, @vLastname, @vAge, @vSpecialty, @vUserName, @vPassword, @vActive
					);
		END
END TRY
--Catch and display any errors that may have occured when changing the doctor's specialty
BEGIN CATCH
	PRINT 'An error occurred while trying to change the specialty';
	PRINT 'Error message ' + CONVERT(varchar(200), ERROR_MESSAGE());
END CATCH
/*
We create doctors using SSMS so that people cannot just create accounts like patients are able to,
it is easier to track doctors information this way as well
To add, it alleviates some of the administration overhead because the doctors have the ability to access the DB
*/
--Separate batches
GO
--Test procedure and triggers with age
--This should fail due to age being lower than range specified in trigger between 85 and 29
DECLARE @docFname varchar(15), @docLname varchar(15), @docAge varchar(15), @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15)
SET @docFname = 'Doogie'
SET @docLname = 'Howser'
SET @docAge = 23
SET @docSpecialty= 2
SET @docUserName = 'GHouse1'
SET @docPassword = 'difojaoijfiosdf'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword
--Separate batches
GO
--Test procedure and trigger again
--This should fail because the username in the statement is already in the database
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Jake'
SET @docLname = 'Doe'
SET @docAge = 38
SET @docSpecialty= 1
SET @docUserName = 'JDoe1'
SET @docPassword = 'test1'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword

/*
The next few lines will be successful doctor inserts to expand our website usability
*/
--Separate Statements
GO
--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Gregory'
SET @docLname = 'House'
SET @docAge = 38
SET @docSpecialty = 1
SET @docUserName = 'GHouse1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword
--Separate Statements
GO
--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Steve'
SET @docLname = 'Rogers'
SET @docAge = 70
SET @docSpecialty= 2
SET @docUserName = 'SRogers1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword
--Separate Statements
GO
--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Tony'
SET @docLname = 'Stark'
SET @docAge = 65
SET @docSpecialty= 3
SET @docUserName = 'TStark1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword
--Separate Statements
GO
--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Bruce'
SET @docLname = 'Banner'
SET @docAge = 48
SET @docSpecialty= 4
SET @docUserName = 'BBanner1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword
--Separate Statements
GO
--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Peter'
SET @docLname = 'Quill'
SET @docAge = 41
SET @docSpecialty= 5
SET @docUserName = 'PQuill1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword
--Separate Statements
GO
--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Peter'
SET @docLname = 'Parker'
SET @docAge = 30
SET @docSpecialty= 6
SET @docUserName = 'PParker1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword
--Separate Statements
GO
--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Nick'
SET @docLname = 'Fury'
SET @docAge = 39
SET @docSpecialty= 7
SET @docUserName = 'NFury1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword
--Separate Statements
GO
--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Bucky'
SET @docLname = 'Barnes'
SET @docAge = 54
SET @docSpecialty= 8
SET @docUserName = 'BBarnes1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword
--Separate Statements
GO
--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Sasha'
SET @docLname = 'Romenov'
SET @docAge = 65
SET @docSpecialty= 9
SET @docUserName = 'SRomenov1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword

--Test procedure and trigger, this statement should work
DECLARE @docFname varchar(30), @docLname varchar(30), @docAge int , @docSpecialty int, @docUserName varchar(15), @docPassword varchar(15) 
SET @docFname = 'Jon'
SET @docLname = 'Doe'
SET @docAge = 30
SET @docSpecialty= 10
SET @docUserName = 'JDoe1'
SET @docPassword = '123Doc'
--Pass parameters by position
EXEC spDoctorsInsert @docFname, @docLname, @docSpecialty, @docAge, @docUserName, @docPassword

--Verify the statements worked
SELECT * FROM Doctors
