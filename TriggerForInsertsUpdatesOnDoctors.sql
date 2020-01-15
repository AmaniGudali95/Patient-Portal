--Specify what database to use
USE PatientPortal
--Separate statements
GO
--Check to see if the doctor insert trigger already exists, if it does then delete it
IF OBJECT_ID('docTriggerInsertUpdate') IS NOT NULL
	DROP TRIGGER docTriggerInsertUpdate
--Separate statements
GO
/*
Otherwise create the trigger for inserts/updates,
on the doctors table
*/
CREATE TRIGGER docTriggerInsertUpdate
ON Doctors
--After inserts and updates
AFTER INSERT, UPDATE
AS
BEGIN
--Declare scalar variable to hold age input
DECLARE @vAge int;
--Set the variable to the inserted doctor's age
SET @vAge = (SELECT docAge FROM inserted)
	--Notify user of what happened
	PRINT 'An update or insertion has occured to the doctors table';
	--If statement to check validity of input, verify with the age range
		IF (@vAge) > 85 OR (@vAge) < 29
			BEGIN
				--Rollback the transaction and display error if the age range is not met
				 RAISERROR (': Age must be between 29 and 85, please try again', 16, 10)
				 ROLLBACK TRAN
				 RETURN
			END;
	--Make sure the inserted username is not already taken
	IF(		--Get the inserted username count, should be 1
			SELECT COUNT(Doc1.docUserName)
			FROM Inserted Doc1 JOIN Doctors realDoc
			--Compare the inserted username with usernames already stored
			ON Doc1.docUserName = realDoc.docUserName
		) > 1
			--If the inserted doctor has the same username 
			--As a doctor already in the table then throw an error
			BEGIN
				RAISERROR(': That username is already taken, please try again',16,1);
				ROLLBACK TRAN
				RETURN
			END;
		--If no errors in the trigger then let the insertion or update happen
END