--Specify what database to use
USE PatientPortal;
--Separate statements
GO
--Check to see if the appointment history procedure already exists, if it does then delete it
IF OBJECT_ID('spPatientDoctorApptHistory') IS NOT NULL
	DROP PROC spPatientDoctorApptHistory
--Separate statements
GO
--Otherwise create the procedure for updating the patienthistory table
CREATE PROC spPatientDoctorApptHistory
AS
BEGIN TRY
	BEGIN TRAN
		--Test to see if the appointment is already archived by comparing its apptID to one in the Appointments table
		IF NOT EXISTS (SELECT PH.ApptID FROM PatientHistory PH WHERE PH.ApptID IN (SELECT ApptID FROM AppointmentsTable))
			BEGIN
				--If the appointmentID is not known, then add the appointment data into the appointment history table
				--Only insert this data if the current date is greater than the date given from the Appointments table
				INSERT PatientHistory
				SELECT ApptID, PatientID, DoctorID, DateAndTimeOfAppt, apptDetails, docLastName, patientProblem, doctorSuggestions
				FROM AppointmentsTable
				--Verify that the appointment is in the past and the appointment has been closed
				WHERE GETDATE() > DateAndTimeOfAppt AND ApptOpenOrClosed = 1
			END
		--If the appointment was successfully moved to the appointment history table, then delete the appointment from the appointments table
		IF EXISTS (SELECT A.ApptID FROM AppointmentsTable A WHERE A.ApptID IN (SELECT ApptID FROM PatientHistory))
		BEGIN
			DELETE FROM AppointmentsTable;
		END
	COMMIT TRAN
	PRINT 'Appointment successfully archived';
END TRY
/*
Rollback the transaction and 
catch/display any errors that may have occurred in the transaction
*/
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'An error occurred while archiving the transaction';
	PRINT 'Error message ' + CONVERT(varchar(200), ERROR_MESSAGE());
END CATCH
/*Verify the statement worked correctly, this means the appointment history page was updated*/
SELECT * FROM PatientHistory;