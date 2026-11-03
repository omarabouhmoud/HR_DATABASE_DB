-- 1. Select and activate the target database for execution
USE HR_DATABASE_DB;
GO

-- 2. Create a schema to store {core} employee data
CREATE SCHEMA Core;
GO

-- 3. Create a schema to manage {payroll} and financial records
CREATE SCHEMA Payroll;
GO

-- 4. Create a schema for time-tracking and employee {attendance}
CREATE SCHEMA Attendance;
GO

-- 5. Create a schema for {recruitment} and hiring processes
CREATE SCHEMA Recruitment;
GO

-- Note: The following section contains commented-out code (not executed)
--DROP SCHEMA core;
/*
SELECT name AS [Core], principal_id, create_date
FROM sys.schemas
WHERE name = 'Core';
*/

-- 6. Check if the 'Attendance' schema exists and display the status
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'Attendance')
    SELECT 'المخطط Attendance YES!' AS [حالة المخطط];
ELSE
    SELECT 'المخطط Attendance NO!' AS [حالة المخطط];
