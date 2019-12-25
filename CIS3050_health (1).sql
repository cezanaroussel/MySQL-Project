DROP DATABASE IF EXISTS cis_3050_health;
CREATE DATABASE cis_3050_health;
USE cis_3050_health;

CREATE TABLE Employee_T
             (EmployeeID          VARCHAR(10)    NOT NULL,
              EmployeeFirstName        VARCHAR(10),
              EmployeeLastName      VARCHAR(10),
              EmployeeAddress     VARCHAR(30),
              EmployeeState       CHAR(2),
              EmployeeDateHired   DATE,
              EmployeeType        CHAR(2), 
CONSTRAINT Employee_PK PRIMARY KEY (EmployeeID));



CREATE TABLE Doctor_T
             (EmployeeID         VARCHAR(10)      NOT NULL,
              FirstName          VARCHAR(10),
              LastName           VARCHAR(10),
              OfficeNumber       VARCHAR(3),
              Specialty          VARCHAR(20),
			  ParkingSpotNum     VARCHAR(2),
		
	
CONSTRAINT Doctor_PK PRIMARY KEY (EmployeeID),
CONSTRAINT Doctor_FK1 FOREIGN KEY (EmployeeID) REFERENCES Employee_T(EmployeeID));


CREATE TABLE Receptionist_T
             (EmployeeID            VARCHAR(10)    NOT NULL,
              AssignedDoctorID      VARCHAR(10)    NOT NULL,
              ReceptionistFirstName VARCHAR(10),
              ReceptionistLastName  VARCHAR(10),
		      WPM                   DECIMAL(3),
              Skill                 VARCHAR(40),
              DateHired             DATE, 
              EducationLvl          VARCHAR(20),
              
CONSTRAINT Receptionist_PK PRIMARY KEY (EmployeeID),
CONSTRAINT Receptionist_FK1 FOREIGN KEY (EmployeeID) REFERENCES Employee_T(EmployeeID),
CONSTRAINT Receptionist_FK2 FOREIGN KEY (AssignedDoctorID) REFERENCES Doctor_T(EmployeeID));


CREATE TABLE Nurse_T
			(EmployeeID             VARCHAR(10)    NOT NULL,
            NurseFirstName          VARCHAR(10),
            NurseLastName           VARCHAR(10), 
            DeptNum                 VARCHAR(3)     NOT NULL,
            ShiftType               VARCHAR(2)       NOT NULL, 
			SkillDescription        VARCHAR(25), 
            BoardCertified               CHAR(1), 
             
            
CONSTRAINT Nurse_PK PRIMARY KEY (EmployeeID),
CONSTRAINT Nurse_FK1 FOREIGN KEY (EmployeeID) REFERENCES Employee_T(EmployeeID));


CREATE TABLE Patient_T
			(PatientID        VARCHAR(11)     NOT NULL,
			PatientFirstName   VARCHAR(10)     NOT NULL,
            PatientLastName    VARCHAR(10)     NOT NULL, 
			PatientAddress     VARCHAR(30),
			PatientCity        VARCHAR(20),              
			PatientState       CHAR(2),
			PatientPostalCode  VARCHAR(10),
CONSTRAINT Patient_PK PRIMARY KEY (PatientID));




CREATE TABLE Treatment_T
             (TreatmentID         INT                   NOT NULL AUTO_INCREMENT,
              PatientID          VARCHAR(11)     NOT NULL, 
              PatientName        VARCHAR (10)    NOT NULL, 
              DoctorID           VARCHAR(10)     NOT NULL, 
              NurseID            VARCHAR(10)     NOT NULL, 
              TreatmentDate      DATE       NOT NULL, 
              TreatmentDescription    VARCHAR(50)     NOT NULL, 
              
			
CONSTRAINT Treatment_PK PRIMARY KEY (TreatmentID),
CONSTRAINT Treatment_FK1 FOREIGN KEY (DoctorID) REFERENCES Doctor_T(EmployeeID),
CONSTRAINT Treatment_FK2 FOREIGN KEY (NurseID) REFERENCES Nurse_T(EmployeeID),
CONSTRAINT Treatment_FK3 FOREIGN KEY (PatientID) REFERENCES Patient_T(PatientID));




CREATE TABLE Appointment_T
             (AppointmentID          INT    NOT NULL  AUTO_INCREMENT,
              PatientID             VARCHAR(10)    NOT NULL,
              PatientName           VARCHAR(10)    NOT NULL, 
              ReceptionistID        VARCHAR(10)    NOT NULL,
              DoctorID              VARCHAR(10)    NOT NULL,
              ApptDate              DATE      NOT NULL,
              ApptDesc              VARCHAR(50), 
              
CONSTRAINT Appointment_PK PRIMARY KEY (AppointmentID),
CONSTRAINT Appointment_FK1 FOREIGN KEY (PatientID) REFERENCES Patient_T (PatientID),
CONSTRAINT Appointment_FK2 FOREIGN KEY (ReceptionistID) REFERENCES Receptionist_T(EmployeeID),
CONSTRAINT Appointment_FK3 FOREIGN KEY (DoctorID) REFERENCES Doctor_T(EmployeeID));

INSERT INTO Employee_T (EmployeeID, EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeState, EmployeeDateHired, EmployeeType) VALUES
('1593698521', 'Brent', 'Allen', '2261 Maple St', 'CA', '2019-11-10', 'D'),
('7894561235', 'Sarah', 'Punj', '8752 Catalina Dr', 'CA', '2015-05-11', 'D'),
('8726523523', 'Bella', 'Ham', '4522 Burlwood Ln', 'CA', '2004-09-22', 'D'),
('7852452153', 'James', 'Booth', '9852 Beverly Ct', 'CA', '2008-10-08','N'),
('8527415642', 'Jake','Brennan', '6000 Burry St', 'CA', '2010-06-08', 'N'), 
('2322154242', 'Maria','Jo', '8564 Cappa Dr', 'CA', '2011-10-20', 'N'),
('4963852164', 'Jamie', 'Rodrigo', '4200 Circle Way', 'CA', '2005-12-12', 'N'),
('7584221501', 'Anna', 'Sullen', '2051 Roosevelt Ct', 'CA', '2015-07-20', 'R'),
('1054505205', 'Lucas', 'Beltman', '9865 Droors Hwy', 'CA', '2006-04-10', 'R'),
('5422214542', 'Brianna', 'Salsgiver', '5842 Cooler Way', 'CA', '2019-02-10', 'R'),
('8597252135', 'Julia','Baker', '9982 Fructose Pl', 'CA', '2016-04-21', 'R');

INSERT INTO Doctor_T (EmployeeID, FirstName, LastName, OfficeNumber, Specialty, ParkingSpotNum) VALUES
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '1593698521'), 'Brent', 'Allen','203', 'psychiatric', '03'),
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '7894561235'), 'Sarah', 'Punj', '204', 'brain surgeon', '04'),
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '8726523523'), 'Bella', 'Ham',  '205', 'pediatric', '05');

INSERT INTO Receptionist_T (EmployeeID, AssignedDoctorID, ReceptionistFirstName, ReceptionistLastName, WPM, Skill, DateHired, EducationLvl) VALUES
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '7584221501'), '1593698521',  'Sally', 'May','52', 'MS Word, MS PPT', '2014-06-25', 'High School'),
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '1054505205'), '7894561235', 'Rory', 'Mann','60', 'MS Word, MS PPT', '2009-05-05', 'Some College'),
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '5422214542'), '8726523523', 'Marissa', 'Lorde', '65', 'MS Word, MS Excel', '2011-07-15', 'College'),
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '8597252135'), '7894561235', 'Hayley', 'Hum', '58','MS Word, Email', '2015-10-08', 'High School');

INSERT INTO Nurse_T (EmployeeID, NurseFirstName, NurseLastName, DeptNum, ShiftType, SkillDescription, BoardCertified) VALUES
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '7852452153'),'Sarah', 'Moe', '103', 'AM', 'Critical Care Nurse', 'Y'),
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '8527415642'),'Leslie', 'Powers', '105', 'PM', 'Elderly Care Nurse', 'N'),
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '2322154242'), 'Lara', 'Roe', '200', 'PM', 'Clinical Nurse Specialist', 'Y'),
((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '4963852164'), 'Ben', 'Palmer', '202', 'AM', 'Pediatric Specialist', 'Y');

INSERT INTO Patient_T (PatientID, PatientFirstName, PatientLastName, PatientAddress, PatientCity, PatientState, PatientPostalCode) VALUES
('1000', 'Nick', 'Diaz', '2445 Patrich Ave', 'Pomona', 'CA', '91750'),
('1001','Pat', 'Smith', '8544 Greenbelt Dr', 'Anaheim', 'CA', '92807'),
('1002', 'Jerry', 'Kwan', '9154 Irvine Way', 'Irvine', 'CA', '92602'),
('1003', 'Perry', 'Ron', '855 Cleary St', 'Costa Mesa', 'CA', '92626');

INSERT INTO Appointment_T (AppointmentID, PatientID, PatientName, ReceptionistID, DoctorID, ApptDate, ApptDesc) VALUES
('001', ((SELECT PatientID FROM Patient_T WHERE PatientID = '1000')), 'Nick Diaz', ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '7584221501')), ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '1593698521')), '2019-11-10', 'Therapy Session'),
('002', ((SELECT PatientID FROM Patient_T WHERE PatientID = '1000')), 'Nick Diaz', ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '7584221501')), ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '1593698521')), '2019-11-11', 'Check Up'),
('003', ((SELECT PatientID FROM Patient_T WHERE PatientID = '1001')), 'Pat Smith', ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '1054505205')), ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '7894561235')), '2019-11-13', 'Post Surgical Meet'),
('004', ((SELECT PatientID FROM Patient_T WHERE PatientID = '1001')), 'Pat Smith', ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '1054505205')), ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '7894561235')), '2019-11-13', 'Brain Scan Day'),
('005', ((SELECT PatientID FROM Patient_T WHERE PatientID = '1002')), 'Jerry Kwan', ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '5422214542')), ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '8726523523')), '2019-11-21', 'Annual Physical'),
('006', ((SELECT PatientID FROM Patient_T WHERE PatientID = '1003')), 'Perry Ron', ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '8597252135')), ((SELECT EmployeeID FROM Employee_T WHERE EmployeeID = '7894561235')), '2019-11-28', 'CAT Scan');

INSERT INTO Treatment_T  (TreatmentID, PatientID, PatientName, DoctorID, NurseID, TreatmentDate, TreatmentDescription) VALUES
('101', '1000', 'Nick Diaz', '1593698521', '4963852164', '2019-11-09', 'Behavior Analysis'),
('102', '1001', 'Pat Smith', '7894561235', '2322154242', '2019-11-15', 'Surgery'),
('105', '1003', 'Perry Ron', '7894561235', '2322154242', '2019-11-29', 'CAT Scan Analysis');

















































