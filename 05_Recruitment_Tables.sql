USE HR_DATABASE_DB;
GO

CREATE TABLE Recruitment.REC_job_postings (
	id INT PRIMARY KEY IDENTITY(1,1),
	title NVARCHAR(100) NOT NULL,
	department_id INT NOT NULL,
	requirements_description NVARCHAR(MAX),
	post_date DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	status NVARCHAR(10) DEFAULT 'Open' CHECK (status IN ('Open', 'Closed')),
	FOREIGN KEY (department_id) REFERENCES Core.COR_departments(id)
);
GO