
USE HR_DATABASE_DB;
GO

CREATE SCHEMA Core;
GO

CREATE SCHEMA Payroll;
GO

CREATE SCHEMA Attendance;
GO

CREATE SCHEMA Recruitment;
GO

--DROP SCHEMA core;
/*
SELECT name AS [Core], principal_id, create_date
FROM sys.schemas
WHERE name = 'Core';
*/


IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'Attendance')
    SELECT 'المخطط [Attendance] YES!' AS [حالة المخطط];
ELSE
    SELECT 'المخطط [Attendance] NO!' AS [حالة المخطط];


