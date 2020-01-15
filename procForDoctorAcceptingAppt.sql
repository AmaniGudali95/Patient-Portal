--Specify what database to use
USE PatientPortal;
--Separate statements
GO
--Check to see if the doctor accepting appt procedure already exists, if it does then delete it
IF OBJECT_ID('spDoctorAccept') IS NOT NULL
	DROP PROC spDoctorAccept
--Separate statements
GO
/*
Otherwise create the procedure with the following column specifications
Parameters are for the doctors' username 
and the ID of the appointment
*/
CREATE PROC spDoctorAccept @vdocUsername varchar(15), @vapptID int
AS 
BEGIN TRY
	BEGIN TRAN
		/*Based on the data given, we can get the needed data to fill the appointment row*/
		--Declare scalar variables to hold the current doctors information for later use and comparison
		DECLARE @vdocID int, @vdocLastname varchar(15), @vdocSpecialty int
		--Set the ID and lastname of the current doctor, to insert into the appt that was selected by the doctor
		SET @vdocID = (SELECT TOP 1 DoctorID FROM Doctors WHERE docUserName = @vdocUsername AND docActive = 0)
		SET @vdocLastname = (SELECT docLastname FROM Doctors WHERE DoctorID = @vdocID)
		--Select the current doctors specialty to verify that the doctor has the skills necessary to treat this patient
		SET @vdocSpecialty = (SELECT docSpecialty FROM Doctors WHERE DoctorID = @vdocID)
		IF EXISTS (SELECT patientProblem FROM AppointmentsTable WHERE ApptID = @vapptID AND patientProblem = @vdocSpecialty) 
			BEGIN 
				--First update the doctors table to reflect that the doctor is now unavailable
				UPDATE Doctors
				SET docActive = 1
				WHERE DoctorID = @vDocID
				--Start the appointment and fill in the rest of the table with needed data
				UPDATE AppointmentsTable
				SET DoctorID = @vdocID, docLastname = @vdocLastname, ApptOpenOrClosed = 0
				WHERE ApptID = @vapptID AND patientProblem = @vdocSpecialty
			END
	--If there are no errors then notify the doctor of changes and commit the transaction 
	PRINT 'The doctor is now treating the patient';
	COMMIT TRAN
END TRY
/*
Rollback the transaction,
catch/display any errors that may have occurred in the transaction
*/
BEGIN CATCH
	ROLLBACK TRAN;
	PRINT 'An error occurred while trying to create select this appointment';
	PRINT 'Error message ' + CONVERT(varchar(200), ERROR_MESSAGE());
END CATCH
--Execute the procedure with the following parameters passed by position
EXEC spDoctorAccept 'JDoe1', 2
/*
Verify the procedure worked,
The doctor information should now appear in the appointments table and
both the doctor, patient and appt availability should all be set to 1
*/
SELECT * FROM AppointmentsTable
SELECT * FROM Patients
SELECT * FROM Doctors

