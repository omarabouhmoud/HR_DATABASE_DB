USE HR_DATABASE_DB;
GO

CREATE TABLE Attendance.ATT_attendance (
	id INT PRIMARY KEY IDENTITY(1,1),
	date_attendance DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	time_in TIME NOT NULL,
	time_out TIME NULL,
	employee_id INT NOT NULL,
	    attendance_status NVARCHAR(20) DEFAULT 'Present',
    FOREIGN KEY (employee_id) REFERENCES Core.COR_employees(id)
);
GO