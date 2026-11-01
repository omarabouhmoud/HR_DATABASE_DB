USE HR_DATABASE_DB;
GO

-- ===================================================
-- 1. Optimize Employee Searches (Core Schema)
-- ===================================================
-- Indexing the Email column because it is frequently used for corporate logins and employee lookups
CREATE UNIQUE NONCLUSTERED INDEX IX_COR_employees_Email
ON Core.COR_employees (Email);
GO

-- Indexing Department and Position Foreign Keys to drastically speed up JOIN operations in reports
CREATE NONCLUSTERED INDEX IX_COR_employees_Dept_Position
ON Core.COR_employees (department_id, position_id);
GO

-- ===================================================
-- 2. Optimize Attendance & Leave Tracking (Attendance Schema)
-- ===================================================
-- Indexing employee_id and date fields to speed up daily attendance and absence dashboard reports
CREATE NONCLUSTERED INDEX IX_ATT_attendance_Employee_Date
ON Attendance.ATT_attendance (employee_id, time_in);
GO

CREATE NONCLUSTERED INDEX IX_ATT_vacations_Employee_Dates
ON Attendance.ATT_vacations (employee_id, start_date, end_date);
GO

-- ===================================================
-- 3. Optimize Financial Audits & Payroll Queries (Payroll Schema)
-- ===================================================
-- Indexing payroll records by employee and status to quickly fetch pending or disbursed salaries
CREATE NONCLUSTERED INDEX IX_PRL_payroll_Employee_Status
ON Payroll.PRL_payroll (employee_id, payroll_status);
GO