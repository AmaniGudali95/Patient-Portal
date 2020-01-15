--Specify what database to use
USE PatientPortal;
--Check to see if Doctor table exists, if it does already then delete it
IF OBJECT_ID('Doctors') IS NOT NULL
	DROP TABLE Doctors
--Otherwise create the table with the following column specifications
CREATE TABLE Doctors
(
	--DoctorID is primary key
	DoctorID INT IDENTITY(1,1) NOT NULL,
	CONSTRAINT PK_Doctors_DoctorID PRIMARY KEY CLUSTERED (DoctorID),
	--Define firstname of doctor
	docFirstname varchar(30) NOT NULL, 
	--Define lastname of doctor
	docLastname varchar(30) NOT NULL,
	--Define age of doctor 
	docAge int, 
	--Define the doctors area of work
	docSpecialty int,
	--Define the user for the doctor
	docUserName varchar(15) NOT NULL,
	--Define the password of the doctor
	docPassword varchar(15) NOT NULL,
	--Define whether the doctor is busy or not
	docActive int NOT NULL
);