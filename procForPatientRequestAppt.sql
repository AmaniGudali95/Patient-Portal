--Specify what database to use
USE PatientPortal;
--Separate statements
GO
--Check to see if the patient request appointment procedure already exists, if it does then delete it
IF OBJECT_ID('spPatientRequest') IS NOT NULL
	DROP PROC spPatientRequest
--Separate statements
GO
--Otherwise create the procedure with the following column specifications
/*
Parameters are for the patients' id, the patients problem
and the details of the appointment
*/
CREATE PROC spPatientRequest @vpatID int, @vpatProb int, @vapptDetails varchar(30)
AS 
BEGIN TRY
		BEGIN TRAN
		--Test to see if the chosen patient is available, recall that the patient is initiating the appointment
		IF EXISTS (SELECT PatientID FROM Patients WHERE PatientID = @vpatID AND patActive = 0)
		--If he or she is, set their active value to 1, meaning they are now with a doctor
		BEGIN
			UPDATE Patients
			SET patActive = 1
			WHERE PatientID = @vpatID
		END
		INSERT INTO AppointmentsTable
		(PatientID, DateAndTimeOfAppt, patientProblem, ApptDetails)
		VALUES 
		(@vpatID, GETDATE(), @vpatProb, @vapptDetails)
		COMMIT TRAN
END TRY
/*
Rollback the transaction,
catch/display any errors that may have occurred in the transaction
*/
BEGIN CATCH
	ROLLBACK TRAN;
	PRINT 'An error occurred while trying to create your appointment';
	PRINT 'Error message ' + CONVERT(varchar(200), ERROR_MESSAGE());
END CATCH
--Execute the procedure by passing the variables by hard-code and position
EXEC spPatientRequest 1, 1, 'Minor headaches after exercise'
/*
Verify the statements worked,
by viewing the changes in both tables
*/
SELECT * FROM AppointmentsTable
SELECT * FROM Patients
SELECT * FROM PatientHistory