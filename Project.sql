use [TA/LD Management System]

create Table Section
(
Sec_dept Varchar(100),
Sec_alp Varchar(100),
Sec_Batch Varchar(100),
Primary Key(Sec_dept,Sec_alp,Sec_Batch)
);
Create Table Course
(
C_id Int Not Null,
C_Title Varchar(100),
Primary Key(C_id)
);
Create Table Faculty
( Fac_id int Not Null,
Fac_Name Varchar(100),
Fac_pass Varchar(100),
Fac_contact Varchar(100),
Fac_Email Varchar(100),
Primary key(Fac_id),
unique(Fac_Email)
);
 
Create Table Applicants
(
Appl_ID int Not Null,
Appl_Name Varchar(100),
Appl_Pass Varchar(100),
Appl_Contact Varchar(100),
Appl_hire_status Bit Default 0,------0 false;1 true
Appl_cgpa float,
Appl_Email Varchar(100),
Appl_TA Bit Default 0 ,
Appl_LD Bit Default 0,
Primary Key(Appl_ID),
check( (Appl_hire_status=0 and Appl_TA=0 and Appl_LD =0 ) or (Appl_hire_status =1 and (Appl_TA=1 or Appl_LD=1))),
unique(Appl_Email)
);
 Create Table Admin
(Admin_id Int Not Null,
Admin_Name Varchar(100),
Admin_Pass Varchar(100),
Admin_Contact Varchar(100),
Admin_Email Varchar(100),
Primary Key(Admin_id),
unique (Admin_Email)
);
Create Table Assignment
(Assig_ID int Not Null,
Assig_Title Varchar(100),
Complete_Status BIT Default 0,
Due_Time Time,
Due_Date Date,
---Course foreign key
Cour_ID int Not NULL,
Primary Key(Assig_ID),
Foreign Key (Cour_ID) references Course (C_id)
);
ALTER TABLE Assignment
ADD Late BIT DEFAULT 0;
UPDATE Assignment
SET Late = 0;

Create Table Learns_Course 
(
Sec_dept Varchar(100),
Sec_alp Varchar(100),
Sec_Batch Varchar(100),
Cour_id Int Not Null,
Primary Key(Sec_dept,Sec_alp,Sec_Batch,Cour_id),
Foreign key(Sec_dept,Sec_alp,Sec_Batch) references Section (Sec_dept,Sec_alp,Sec_Batch),
Foreign key(Cour_id) references Course (C_ID)
);
Create Table Teaches_Course
(Sec_dept Varchar(100),
Sec_alp Varchar(100),
Sec_Batch Varchar(100),
Cour_id Int Not Null,
Fac_ID Int Not Null,
Start_time Time,
End_time Time,
Primary Key(Sec_dept,Sec_alp,Sec_Batch,Cour_id,Fac_ID),
Foreign key(Sec_dept,Sec_alp,Sec_Batch) references Section (Sec_dept,Sec_alp,Sec_Batch),
Foreign key(Cour_id) references Course (C_ID),
Foreign key(Fac_ID) references Faculty(Fac_ID)
);
 Create Table Apply_for
 (
 Appl_ID int not null,
 Cour_ID int not null,
 Sec_dept Varchar(100),
Sec_alp Varchar(100),
Sec_Batch Varchar(100),
Grade Varchar(3) Not null,
Start_Time Time,
End_Time Time ,
Primary Key(Appl_ID,Cour_ID,Sec_dept,Sec_alp,Sec_Batch),
Foreign key(Sec_dept,Sec_alp,Sec_Batch) references Section (Sec_dept,Sec_alp,Sec_Batch),
Foreign key(Appl_ID) references Applicants(Appl_ID),
Foreign key(Cour_ID) references Course(C_ID),
);
Create Table Assigns 
(
Assig_ID int Not NUll,
Fac_ID int Not Null,
Appl_ID int Not NULL,
Primary Key(Assig_ID,Fac_ID,Appl_ID),
Foreign key(Appl_ID) references Applicants(Appl_ID),
Foreign key(Fac_ID) references Faculty(Fac_ID),
Foreign key(Assig_ID) references Assignment (Assig_ID)
);
 
Create Table FeedBack
(
Form_ID  int identity(1,1),
Fac_ID int Not Null,
Appl_ID int Not Null,
Primary Key(Form_ID),
Foreign key(Appl_ID) references Applicants(Appl_ID),
Foreign key(Fac_ID) references Faculty(Fac_ID)
);
 
Create Table Responses
( 
Form_ID int not NULL,
Response Varchar(100) Not Null,
Question VarChar(200) Not NUll,
Primary Key(Form_ID,Response,Question),
Foreign Key(Form_ID) references FeedBack (Form_ID)
);
-------------------- HIRE TABLE ----------------
 
Create Table Hire 
(
Admin_ID int not null,
Fac_ID int Not NUll,
Appl_ID int Not Null,
TA BIT default 0,
LD BIT default 0,
Primary Key(Admin_ID,Fac_ID,Appl_ID,TA,LD),
Foreign key(Admin_ID) references Admin (Admin_ID),
Foreign key(Appl_ID) references Applicants(Appl_ID),
Foreign key(Fac_ID) references Faculty(Fac_ID)
);
-- Insert data into Section table
INSERT INTO Section (Sec_dept, Sec_alp, Sec_Batch) VALUES
('Computer Science', 'A', 'Fall2020'),
('Computer Science', 'B', 'Spring2021'),
('Electrical Engineering', 'C', 'Summer2022'),
('Electrical Engineering', 'D', 'Fall2022'),
('Mechanical Engineering', 'A', 'Spring2023'),
('Mechanical Engineering', 'B', 'Summer2023'),
('Biotechnology', 'C', 'Fall2020'),
('Biotechnology', 'D', 'Spring2021'),
('Chemistry', 'A', 'Summer2022'),
('Chemistry', 'B', 'Fall2022');

-- Insert data into Course table
INSERT INTO Course (C_id, C_Title) VALUES
(1001, 'Introduction to Programming'),
(1002, 'Digital Circuits and Systems'),
(1003, 'Mechanics of Materials'),
(1004, 'Bioprocess Engineering'),
(1005, 'Organic Chemistry'),
(1006, 'Database Management Systems'),
(1007, 'Control Systems'),
(1008, 'Thermodynamics'),
(1009, 'Bioinformatics'),
(1010, 'Machine Learning');


-- Insert data into Applicants table with encrypted passwords
INSERT INTO Applicants (Appl_ID, Appl_Name, Appl_Pass, Appl_Contact, Appl_hire_status, Appl_cgpa, Appl_Email) VALUES
(10401, 'Muhammad Ali', 'Nvy@2627', '03011112222', 0, 3.5, 'muhammad.ali@example.com'),
(10402, 'Sadia Khan', 'Fnqn@2829', '03112223333', 0, 3.9, 'sadia.khan@example.com'),
(10403, 'Kamran Malik', 'Xnzen@3031', '03223334444', 0, 3.2, 'kamran.malik@example.com'),
(10404, 'Ayesha Ahmed', 'Nrlfn@3233', '03334445555', 0, 3.7, 'ayesha.ahmed@example.com'),
(10405, 'Zainab Ali', 'Mnva@3435', '03445556666', 0, 3.6, 'zainab.ali@example.com'),
(10406, 'Saad Iqbal', 'Fnq@3637', '03556667777', 0, 3.8, 'saad.iqbal@example.com'),
(10407, 'Nadia Shahzad', 'Anqvn@3839', '03667778888', 0, 3.1, 'nadia.shahzad@example.com'),
(10408, 'Imran Javed', 'Vzena@4041', '03778889999', 0, 3.4, 'imran.javed@example.com'),
(10409, 'Saima Ahmed', 'Fnzvn@4243', '03889990000', 0, 3.3, 'saima.ahmed@example.com'),
(10410, 'Ali Mansoor', 'Nvy@4445', '03900001111', 0, 3.6, 'ali.mansoor@example.com');

-- Insert data into Admin table with encrypted passwords
INSERT INTO Admin (Admin_id, Admin_Name, Admin_Pass, Admin_Contact, Admin_Email) VALUES
(10501, 'Bilal Abdul', 'Ovyyn@4647', '03011234567', 'bilal.abdul@example.com'),
(10502, 'Abdul Rahman', 'Nqhn@4849', '03122345678', 'abdul.rahman@example.com'),
(10503, 'Farhan Dar', 'Snen@5051', '03233456789', 'farhan.dar@example.com'),
(10504, 'Nadia Khan', 'Anqn@5253', '03344567890', 'nadia.khan@example.com'),
(10505, 'Imran Ahmed', 'Vzena@5455', '03455678901', 'imran.ahmed@example.com'),
(10506, 'Sara Malik', 'Fnenx@5657', '03566789012', 'sara.malik@example.com'),
(10507, 'Ahmed Ali', 'Nuvqr@5859', '03677890123', 'ahmed.ali@example.com'),
(10508, 'Aisha Javed', 'Nvfun@6061', '03788901234', 'aisha.javed@example.com'),
(10509, 'Usman Khan', 'Hfnan@6263', '03890012345', 'usman.khan@example.com'),
(10510, 'Sophia Ahmed', 'Fbcuvn@6465', '03901123456', 'sophia.ahmed@example.com');


-- Insert data into Faculty table with encrypted passwords
INSERT INTO Faculty (Fac_id, Fac_Name, Fac_pass, Fac_contact, Fac_Email) VALUES
(10301, 'Dr. Ahmed Khan', 'Nqvzr@1234', '03011234567', 'ahmed.khan@example.com'),
(10302, 'Prof. Fatima Malik', 'Sngvn@5678', '03122345678', 'fatima.malik@example.com'),
(10303, 'Dr. Usman Ali', 'Hfnan@91011', '03233456789', 'usman.ali@example.com'),
(10304, 'Prof. Ayesha Aziz', 'Nlrfn@1213', '03344567890', 'ayesha.aziz@example.com'),
(10305, 'Dr. Fahad Iqbal', 'Snunq@1415', '03455678901', 'fahad.iqbal@example.com'),
(10306, 'Prof. Saima Nadeem', 'Fnvn@1617', '03566789012', 'saima.nadeem@example.com'),
(10307, 'Dr. Amir Shahzad', 'Nvze@1819', '03677890123', 'amir.shahzad@example.com'),
(10308, 'Prof. Hina Javed', 'Uvan@2021', '03788901234', 'hina.javed@example.com'),
(10309, 'Dr. Kamran Ahmed', 'Xnzen@2223', '03890012345', 'kamran.ahmed@example.com'),
(10310, 'Prof. Sara Mansoor', 'Fnen@2425', '03901123456', 'sara.mansoor@example.com');
 
INSERT INTO Assignment (Assig_ID, Assig_Title, Complete_Status, Due_Time, Due_Date, Cour_ID) VALUES
(10001, 'Programming Assignment 1', 0, '18:00', '2023-12-01', 1001),
(10002, 'Digital Circuits Project', 0, '16:00', '2023-12-15', 1002),
(10003, 'Materials Lab Report', 0, '14:00', '2023-11-20', 1003),
(10004, 'Bioprocess Engineering Design', 0, '17:30', '2023-11-30', 1004),
(10005, 'Organic Chemistry Paper', 0, '15:45', '2023-12-10', 1005),
(10006, 'Database Management System Project', 0, '13:15', '2023-11-25', 1006),
(10007, 'Control Systems Analysis', 0, '12:00', '2023-12-05', 1007),
(10008, 'Thermodynamics Problem Set', 0, '11:30', '2023-12-08', 1008),
(10009, 'Bioinformatics Research Paper', 0, '10:45', '2023-12-18', 1009),
(10010, 'Machine Learning Project', 0, '09:30', '2023-12-22', 1010);



-- Insert data into Learns_Course table
INSERT INTO Learns_Course (Sec_dept, Sec_alp, Sec_Batch, Cour_id) VALUES
('Computer Science', 'A', 'Fall2020', 1001),
('Computer Science', 'B', 'Spring2021', 1002),
('Electrical Engineering', 'C', 'Summer2022', 1003),
('Electrical Engineering', 'D', 'Fall2022', 1004),
('Mechanical Engineering', 'A', 'Spring2023', 1005),
('Mechanical Engineering', 'B', 'Summer2023', 1006),
('Biotechnology', 'C', 'Fall2020', 1007),
('Biotechnology', 'D', 'Spring2021', 1008),
('Chemistry', 'A', 'Summer2022', 1009),
('Chemistry', 'B', 'Fall2022', 1010);

-- Insert data into Teaches_Course table
INSERT INTO Teaches_Course (Sec_dept, Sec_alp, Sec_Batch, Cour_id, Fac_ID, Start_time, End_time) VALUES
('Computer Science', 'A', 'Fall2020', 1001, 10301, '08:00', '10:00'),
('Computer Science', 'B', 'Spring2021', 1002, 10302, '09:00', '11:00'),
('Electrical Engineering', 'C', 'Summer2022', 1003, 10303, '10:00', '12:00'),
('Electrical Engineering', 'D', 'Fall2022', 1004, 10304, '11:00', '13:00'),
('Mechanical Engineering', 'A', 'Spring2023', 1005, 10305, '12:00', '14:00'),
('Mechanical Engineering', 'B', 'Summer2023', 1006, 10306, '13:00', '15:00'),
('Biotechnology', 'C', 'Fall2020', 1007, 10307, '14:00', '16:00'),
('Biotechnology', 'D', 'Spring2021', 1008, 10308, '15:00', '17:00'),
('Chemistry', 'A', 'Summer2022', 1009, 10309, '16:00', '18:00'),
('Chemistry', 'B', 'Fall2022', 1010, 10310, '17:00', '19:00');

-- Insert data into Apply_for table
INSERT INTO Apply_for (Appl_ID, Cour_ID, Sec_dept, Sec_alp, Sec_Batch, Grade, Start_Time, End_Time) VALUES
(10401, 1001, 'Computer Science', 'A', 'Fall2020', 'A', '08:00', '10:00'),
(10402, 1002, 'Computer Science', 'B', 'Spring2021', 'B', '09:00', '11:00'),
(10403, 1003, 'Electrical Engineering', 'C', 'Summer2022', 'C', '10:00', '12:00'),
(10404, 1004, 'Electrical Engineering', 'D', 'Fall2022', 'B', '11:00', '13:00'),
(10405, 1005, 'Mechanical Engineering', 'A', 'Spring2023', 'A', '12:00', '14:00'),
(10406, 1006, 'Mechanical Engineering', 'B', 'Summer2023', 'B', '13:00', '15:00'),
(10407, 1007, 'Biotechnology', 'C', 'Fall2020', 'C', '14:00', '16:00'),
(10408, 1008, 'Biotechnology', 'D', 'Spring2021', 'B', '15:00', '17:00'),
(10409, 1009, 'Chemistry', 'A', 'Summer2022', 'A', '16:00', '18:00'),
(10410, 1010, 'Chemistry', 'B', 'Fall2022', 'A', '17:00', '19:00');

 
---drop function EncryptPassword
CREATE FUNCTION EncryptPassword(@original_password VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @len INT = LEN(@original_password);
    DECLARE @encrypted_password VARCHAR(100) = '';

    WHILE @i <= @len
    BEGIN
        SET @encrypted_password = @encrypted_password +
            CASE
                WHEN SUBSTRING(@original_password, @i, 1) BETWEEN 'A' AND 'M' THEN
                    CHAR(ASCII(SUBSTRING(@original_password, @i, 1)) + 13)
                WHEN SUBSTRING(@original_password, @i, 1) BETWEEN 'N' AND 'Z' THEN
                    CHAR(ASCII(SUBSTRING(@original_password, @i, 1)) - 13)
                WHEN SUBSTRING(@original_password, @i, 1) BETWEEN 'a' AND 'm' THEN
                    CHAR(ASCII(SUBSTRING(@original_password, @i, 1)) + 13)
               WHEN SUBSTRING(@original_password, @i, 1) BETWEEN 'n' AND 'z' THEN
                    CHAR(ASCII(SUBSTRING(@original_password, @i, 1)) - 13)
                WHEN SUBSTRING(@original_password, @i, 1) BETWEEN '0' AND '4' THEN
                    CHAR(ASCII(SUBSTRING(@original_password, @i, 1)) + 5)
				 WHEN SUBSTRING(@original_password, @i, 1) BETWEEN '5' AND '9' THEN
                    CHAR(ASCII(SUBSTRING(@original_password, @i, 1)) - 5)	 
					 ELSE
                    SUBSTRING(@original_password, @i, 1)
            END;

        SET @i = @i + 1;
    END;

    RETURN @encrypted_password;
END;



select dbo.EncryptPassword(Admin_pass) from admin
select dbo.EncryptPassword(Fac_pass) from Faculty
select dbo.EncryptPassword(Appl_pass) from Applicants
    
   -------------------------------------------------TRIGGERS AND AUDIT----------------------------------------------------------------------
 GO
 DROP TABLE IF EXISTS AUDIT_LOG;
CREATE TABLE AUDIT_LOG
(
    AUDIT_LOG_ID INT IDENTITY(1,1) PRIMARY KEY,
    TABLE_NAME VARCHAR(50) NOT NULL,
    USER_ID INT NOT NULL,
    ACTION VARCHAR(10) NOT NULL,
    CHANGE_DATETIME DATETIME NOT NULL
);
GO

-----------------------------FOR ADMIN -----------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS ADMIN_INSERT_TR_AUDIT;
GO

CREATE TRIGGER ADMIN_INSERT_TR_AUDIT
ON Admin
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Admin'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS ADMIN_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER ADMIN_UPDATE_TR_AUDIT
ON Admin
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Admin'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS ADMIN_DELETE_TR_AUDIT;
GO

CREATE TRIGGER ADMIN_DELETE_TR_AUDIT
ON Admin
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Admin'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO
------------------------------------------- FOR APPLICANTS --------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS APPLICANTS_INSERT_TR_AUDIT;
GO

CREATE TRIGGER APPLICANTS_INSERT_TR_AUDIT
ON Applicants
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Applicants'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS APPLICANTS_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER APPLICANTS_UPDATE_TR_AUDIT
ON Applicants
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Applicants'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS APPLICANTS_DELETE_TR_AUDIT;
GO

CREATE TRIGGER APPLICANTS_DELETE_TR_AUDIT
ON Applicants
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Applicants'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

------------------------------------------------- FOR APPLY_FOR ---------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS APPLY_FOR_INSERT_TR_AUDIT;
GO

CREATE TRIGGER APPLY_FOR_INSERT_TR_AUDIT
ON Apply_for
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Apply_for'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS APPLY_FOR_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER APPLY_FOR_UPDATE_TR_AUDIT
ON Apply_for
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Apply_for'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS APPLY_FOR_DELETE_TR_AUDIT;
GO

CREATE TRIGGER APPLY_FOR_DELETE_TR_AUDIT
ON Apply_for
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Apply_for'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO


-------------------------------------------------- FOR ASSIGNMENT -------------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS ASSIGNMENT_INSERT_TR_AUDIT;
GO

CREATE TRIGGER ASSIGNMENT_INSERT_TR_AUDIT
ON Assignment
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Assignment'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS ASSIGNMENT_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER ASSIGNMENT_UPDATE_TR_AUDIT
ON Assignment
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Assignment'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS ASSIGNMENT_DELETE_TR_AUDIT;
GO

CREATE TRIGGER ASSIGNMENT_DELETE_TR_AUDIT
ON Assignment
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Assignment'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

----------------------------------------------- FOR ASSIGNS ------------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS ASSIGNS_INSERT_TR_AUDIT;
GO

CREATE TRIGGER ASSIGNS_INSERT_TR_AUDIT
ON Assigns
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Assigns'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS ASSIGNS_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER ASSIGNS_UPDATE_TR_AUDIT
ON Assigns
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Assigns'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS ASSIGNS_DELETE_TR_AUDIT;
GO

CREATE TRIGGER ASSIGNS_DELETE_TR_AUDIT
ON Assigns
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Assigns'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO


--------------------------------------------------------------- FOR COURSE ------------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS COURSE_INSERT_TR_AUDIT;
GO

CREATE TRIGGER COURSE_INSERT_TR_AUDIT
ON Course
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Course'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS COURSE_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER COURSE_UPDATE_TR_AUDIT
ON Course
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Course'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS COURSE_DELETE_TR_AUDIT;
GO

CREATE TRIGGER COURSE_DELETE_TR_AUDIT
ON Course
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Course'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO


----------------------------------------------------------------- FOR FACULTY ----------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS FACULTY_INSERT_TR_AUDIT;
GO

CREATE TRIGGER FACULTY_INSERT_TR_AUDIT
ON Faculty
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Faculty'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS FACULTY_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER FACULTY_UPDATE_TR_AUDIT
ON Faculty
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Faculty'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS FACULTY_DELETE_TR_AUDIT;
GO

CREATE TRIGGER FACULTY_DELETE_TR_AUDIT
ON Faculty
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Faculty'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

---------------------------------------------------------- FOR FEEDBACK -------------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS FEEDBACK_INSERT_TR_AUDIT;
GO

CREATE TRIGGER FEEDBACK_INSERT_TR_AUDIT
ON Feedback
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Feedback'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS FEEDBACK_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER FEEDBACK_UPDATE_TR_AUDIT
ON Feedback
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Feedback'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS FEEDBACK_DELETE_TR_AUDIT;
GO

CREATE TRIGGER FEEDBACK_DELETE_TR_AUDIT
ON Feedback
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Feedback'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

---------------------------------------------------------- FOR HIRE -----------------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS HIRE_INSERT_TR_AUDIT;
GO

CREATE TRIGGER HIRE_INSERT_TR_AUDIT
ON Hire
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Hire'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS HIRE_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER HIRE_UPDATE_TR_AUDIT
ON Hire
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Hire'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS HIRE_DELETE_TR_AUDIT;
GO

CREATE TRIGGER HIRE_DELETE_TR_AUDIT
ON Hire
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Hire'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO
--------------------------------------------------------------- FOR LEARNS_COURSE------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS LEARNS_COURSE_INSERT_TR_AUDIT;
GO

CREATE TRIGGER LEARNS_COURSE_INSERT_TR_AUDIT
ON Learns_Course
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Learns_Course'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS LEARNS_COURSE_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER LEARNS_COURSE_UPDATE_TR_AUDIT
ON Learns_Course
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Learns_Course'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS LEARNS_COURSE_DELETE_TR_AUDIT;
GO

CREATE TRIGGER LEARNS_COURSE_DELETE_TR_AUDIT
ON Learns_Course
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Learns_Course'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO
------------------------------------------------------------FOR RESPONSES --------------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS RESPONSES_INSERT_TR_AUDIT;
GO

CREATE TRIGGER RESPONSES_INSERT_TR_AUDIT
ON Responses
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Responses'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS RESPONSES_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER RESPONSES_UPDATE_TR_AUDIT
ON Responses
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Responses'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS RESPONSES_DELETE_TR_AUDIT;
GO

CREATE TRIGGER RESPONSES_DELETE_TR_AUDIT
ON Responses
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Responses'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-------------------------------------------------------------- FOR SECTION ------------------------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS SECTION_INSERT_TR_AUDIT;
GO

CREATE TRIGGER SECTION_INSERT_TR_AUDIT
ON Section
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Section'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS SECTION_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER SECTION_UPDATE_TR_AUDIT
ON Section
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Section'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS SECTION_DELETE_TR_AUDIT;
GO

CREATE TRIGGER SECTION_DELETE_TR_AUDIT
ON Section
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Section'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

--------------------------------------------------- FOR TEACHES_COURSE ---------------------------------------------------
-- Insert trigger
DROP TRIGGER IF EXISTS TEACHES_COURSE_INSERT_TR_AUDIT;
GO

CREATE TRIGGER TEACHES_COURSE_INSERT_TR_AUDIT
ON Teaches_Course
FOR INSERT
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Teaches_Course'
    DECLARE @Action varchar(10) = 'I'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Update trigger
DROP TRIGGER IF EXISTS TEACHES_COURSE_UPDATE_TR_AUDIT;
GO

CREATE TRIGGER TEACHES_COURSE_UPDATE_TR_AUDIT
ON Teaches_Course
FOR UPDATE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Teaches_Course'
    DECLARE @Action varchar(10) = 'U'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

-- Delete trigger
DROP TRIGGER IF EXISTS TEACHES_COURSE_DELETE_TR_AUDIT;
GO

CREATE TRIGGER TEACHES_COURSE_DELETE_TR_AUDIT
ON Teaches_Course
FOR DELETE
AS
BEGIN
    DECLARE @TableName varchar(50) = 'Teaches_Course'
    DECLARE @Action varchar(10) = 'D'
    DECLARE @ChangeDate datetime = (SELECT GETDATE() AS CurrentDateTime);
    DECLARE @UserId int = USER_ID();

    INSERT INTO AUDIT_LOG (USER_ID, TABLE_NAME, ACTION, CHANGE_DATETIME)
    VALUES (@UserId, @TableName, @Action, @ChangeDate)
END;
GO

