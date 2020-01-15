--Specify what database to use
USE PatientPortal;
--Check to see if Doctor table exists, if it does already then delete it
IF OBJECT_ID('Patients') IS NOT NULL
	DROP TABLE Patients
--Otherwise create the table with the following column specifications
CREATE TABLE Patients
(
	--PatientID is primary key
	PatientID INT IDENTITY(1,1) NOT NULL,
	CONSTRAINT PK_Patients_PatientID PRIMARY KEY CLUSTERED (PatientID),
	--Define firstname of Patient
	patFirstname varchar(30) NOT NULL, 
	--Define lastname of Patient
	patLastname varchar(30) NOT NULL,
	--Define age of Patient 
	patAge int, 
	--Define the Patient insurance
	patInsurance varchar(15) NOT NULL,
	--Define the patient email
	patEmail varchar(15) NOT NULL,
	--Define the gender of the patient
	patGender varchar(10) NOT NULL,
	--Define the password for patient
	patPassword varchar(15) NOT NULL,
	--Define whether the patient is busy or not
	patActive int NOT NULL
);
