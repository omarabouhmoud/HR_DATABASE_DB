USE HR_DATABASE_DB;
GO

CREATE TABLE Attendance.ATT_attendance (
	id INT PRIMARY KEY IDENTITY(1,1),                                             -- Attendance transaction number
	date_attendance DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),				  -- Automatic date-display movement
	time_in TIME NOT NULL,												          -- Time of clocking in for work             -(create index) 
	time_out TIME NULL,														      -- Time of clock-out fingerprint registration (remains empty until the end of the workday)
	employee_id INT NOT NULL,													  -- Employee number that fingerprinted                    
	    attendance_status NVARCHAR(20) DEFAULT 'Present',                         -- Attendance status (present, absent, late)
    FOREIGN KEY (employee_id) REFERENCES Core.COR_employees(id)
);
GO

CREATE TABLE Attendance.ATT_vacations (
    id INT PRIMARY KEY IDENTITY(1,1),                                             -- Leave request transaction number
	vacation_type NVARCHAR(50) NOT NULL,                                          -- Type of leave (annual, sick, emergency)
	start_date DATE NOT NULL,                                                     -- Leave start date                         -(create index)  
	end_date DATE NOT NULL,														  -- Leave end date and return-to-work date   -(create index)               
    employee_id INT NOT NULL,                                                     -- Employee number of the leave applicant   -(create index)
	    vacation_status NVARCHAR(20) DEFAULT 'Pending',                           -- Leave status (pending, approved, rejected)  
    FOREIGN KEY (employee_id) REFERENCES Core.COR_employees(id)					  
);
GO


