--Specify what database to use
USE PatientPortal;
--Check to see if PatientHistory table exists, if it does already then delete it
IF OBJECT_ID('PatientHistory') IS NOT NULL
	DROP TABLE PatientHistory
--Otherwise create the table with the following column specifications
CREATE TABLE PatientHistory
(
	--AppointmentID is referenced from the Appointments table  
	ApptID INT,
	--PatientID is referenced from the Patients table 
	PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
	--DoctorID is referenced from the Doctors table 
	DoctorID INT FOREIGN KEY REFERENCES Doctors(DoctorID),
	--Date and time Of Appointment
	DateAndTimeOfAppt datetime,
	--Details of the Appointment 
	ApptDetails VARCHAR(MAX),
	--Use the doctors lastname
	docLastname varchar(30),
	--The patients previous problem
	patientProblem int,
	--The doctors notes for previous visit
	doctorSuggestions varchar(MAX)
);