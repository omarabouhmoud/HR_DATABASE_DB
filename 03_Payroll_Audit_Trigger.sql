USE HR_DATABASE_DB;
GO

DROP TABLE Payroll.PRL_payroll_audit;
GO


CREATE TABLE Payroll.PRL_payroll_audit (
    audit_id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT NOT NULL,
    old_gross_salary DECIMAL(10,2), 
    new_gross_salary DECIMAL(10,2), 
    changed_by NVARCHAR(100) DEFAULT SUSER_NAME(),
    changed_at DATETIME DEFAULT GETDATE()
);
GO
