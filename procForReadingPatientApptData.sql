--Specify what database to use
USE PatientPortal;
--Separate statements 
GO
--Create a procedure with one required parameter, the appointment
--Get the appointment and patient data from the appointments table based on the appointment passed in 
CREATE PROC spReadData @vapptID int
AS 
SELECT ApptID, ApptOpenOrClosed, DateAndTimeOfAppt, ApptDetails, PatientID, patientProblem FROM AppointmentsTable WHERE ApptID = @vapptID