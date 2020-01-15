--Specify what database to use
USE PatientPortal;
--Separate statements
GO
--Check to see if the appointment complete procedure already exists, if it does then delete it
IF OBJECT_ID('spPatientDoctorApptComplete') IS NOT NULL
	DROP PROC spPatientDoctorApptComplete
--Separate statements
GO
/*
Otherwise create the procedure with the following column specifications
Parameters are for the doctors' id and the selected patients' id
*/
CREATE PROC spPatientDoctorApptComplete
@vdocID int, @vpatID int, @vapptID int, @vdocStatement varchar(MAX)
AS
BEGIN TRY
	BEGIN TRAN
	--Use joins in the following IF statements to verify that the doctor and patient are active and in an appt

	--If there is an active doctor in an appt, who's ID matches that of the parameter then set them to not active
	--Use join to get the correct doctor
		IF EXISTS(SELECT TOP 1 A.DoctorID FROM AppointmentsTable A JOIN Doctors D ON 
														A.DoctorID = D.DoctorID 
														WHERE A.DoctorID = @vdocID AND D.docActive = 1 AND ApptID = @vapptID)
			BEGIN
				UPDATE Doctors
				SET docActive = 0
				WHERE DoctorID = @vdocID
			END
	--If there is an active patient in an appt, who's ID matches that of the parameter then set them to not active
	--Use join to get the correct patient
		IF EXISTS(SELECT TOP 1 A.PatientID FROM AppointmentsTable A JOIN Patients P ON
														A.PatientID = P.PatientID
														WHERE A.PatientID = @vpatID AND P.patActive = 1 AND ApptID = @vapptID)
			BEGIN
				UPDATE Patients
				SET patActive = 0
				WHERE PatientID = @vpatID
			END

		--Test to see if the appointment is open, if it is then close it
		--If an appt is still open between the doctor and patient, then close it
		IF EXISTS (SELECT ApptOpenOrClosed FROM AppointmentsTable WHERE PatientID = @vpatID AND DoctorID = @vdocID AND ApptID = @vapptID)
		BEGIN 
			UPDATE AppointmentsTable
			SET ApptOpenOrClosed = 1
			WHERE DoctorID = @vdocID AND PatientID = @vpatID AND ApptID = @vapptID
		END
		UPDATE AppointmentsTable
		SET doctorSuggestions = @vdocStatement
		WHERE DoctorID = @vdocID AND PatientID = @vpatID AND ApptID = @vapptID
--Commit the transaction and notify user of changes
	COMMIT TRAN
	PRINT 'The appointment is now complete because the doctor treated the patient';
END TRY
/*
Rollback the transaction and 
catch/display any errors that may have occurred in the transaction
*/
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'An error occurred while trying to close this appt';
	PRINT 'Error message ' + CONVERT(varchar(200), ERROR_MESSAGE());
END CATCH
--Execute the procedure by passing in the following parameters by position
EXEC spPatientDoctorApptComplete 1, 1, 2, 'Tylenol should do the trick'
/*
Verify the statement worked,
The patient, doctor and appt availability should all be set to 0
*/
SELECT * FROM AppointmentsTable