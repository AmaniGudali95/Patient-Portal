--Specify what database to use
USE PatientPortal
--Check to see if the appointment table already exists, if it does then delete it
IF OBJECT_ID('AppointmentsTable') IS NOT NULL
	DROP TABLE AppointmentsTable
--Create a table for the current appointments
--The table will be updated first by a patient, then by a doctor
CREATE TABLE AppointmentsTable
(
--AppointmentID is the primary key for this table
ApptID INT IDENTITY NOT NULL PRIMARY KEY,
--DoctorID with whom the appointment is fixed
DoctorID INT FOREIGN KEY REFERENCES Doctors(DoctorID),
--Date and time of the appointment
DateAndTimeOfAppt DateTime,
--Details/reason for the appointment
ApptDetails VARCHAR(MAX),
--Foreign key reference
PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
--Bit to track the status of appt
ApptOpenOrClosed BIT,
--Use the doctors lastname
docLastname varchar(30),
--Find the patientProblem
patientProblem int,
--The doctors notes
doctorSuggestions varchar(MAX)
);