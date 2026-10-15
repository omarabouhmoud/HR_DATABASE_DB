USE HR_DATABASE_DB;
GO

CREATE TABLE Recruitment.REC_job_postings (
	id INT PRIMARY KEY IDENTITY(1,1),                                                              --Job Vacancy Announcement Number
	title NVARCHAR(100) NOT NULL,                                                                  --Advertised job title (e.g., Data Engineer)
	department_id INT NOT NULL,                                                                    -- The department that requires this job (links to the departments table)
	requirements_description NVARCHAR(MAX),                                                        -- Requirements and experience needed for the position (open text)
	post_date DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),                                       -- Automatic ad publication date
	status NVARCHAR(10) DEFAULT 'Open' CHECK (status IN ('Open', 'Closed')),                       -- Advertisement status (open for applications, closed)
	FOREIGN KEY (department_id) REFERENCES Core.COR_departments(id)
);
GO

CREATE TABLE Recruitment.REC_applicants (
	id INT PRIMARY KEY IDENTITY(1,1),                                                              -- Job applicant file number
	job_id INT NOT NULL,																		   -- The number of the vacancy applied for (linked to the previous table)
	full_name NVARCHAR(150) NOT NULL,															   -- Applicant's full name
	email NVARCHAR(100) NOT NULL,																   -- Applicant's email for communication
	interview_date DATETIME NULL,																   -- Date and time of the scheduled personal interview
	interview_notes NVARCHAR(MAX),																   -- Committee observations and evaluation during the interview
	    application_status NVARCHAR(20) DEFAULT 'Applied' CHECK (application_status IN ('Applied', 'Interviewing', 'Offered', 'Rejected')),
    
    FOREIGN KEY (job_id) REFERENCES Recruitment.REC_job_postings(id)
);
GO