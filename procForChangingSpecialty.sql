--Specify what database to use
USE PatientPortal;
--Separate statements
GO
--Check to see if the update specialty procedure already exists, if it does then delete it
IF OBJECT_ID('spDoctorsUpdateSpecialty') IS NOT NULL
	DROP PROC spDoctorsUpdateSpecialty
--Separate statements
GO
/*
Otherwise create the procedure with the following column specifications
The procedure has 2 required parameters, the doctors id and the specialty to change to
*/
CREATE PROC spDoctorsUpdateSpecialty @vdocID int, @vSpecialty int
AS 
BEGIN TRY
--We do not verify a doctor's ID because they should know their corresponding ID when changing their information
	--If statement to verify that the doctor is within our specialty ranges of 1 and 10
	IF(@vSpecialty > 0 AND @vSpecialty < 11)
		BEGIN
			--Set the doctors' specialty for the doctor with the corresponding
			--Parameter ID given
			UPDATE Doctors
			SET docSpecialty = @vSpecialty
			WHERE DoctorID = @vdocID;
		END
	ELSE 
	BEGIN
		RAISERROR(': Please insert a specialty between 1 and 10, try again',16,1);
	END
END TRY
/*
Rollback the transaction and 
catch/display any errors that may have occurred in the transaction
*/
BEGIN CATCH
	PRINT 'An error occurred while trying to change the specialty';
	PRINT 'Error message ' + CONVERT(varchar(200), ERROR_MESSAGE());
END CATCH
--Separate batches
GO
--Test to see if procedure works
EXEC spDoctorsUpdateSpecialty 1, 1
--Verify it works
SELECT * FROM Doctors
/*
If the id and specialty passed in are not valid,
then no rows are affected.
*/