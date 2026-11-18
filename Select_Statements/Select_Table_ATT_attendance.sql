USE HR_DATABASE_DB;
GO

-- -----------------------------------------------------------------------------
-- A query demonstrating date filtering for current day attendance,
-- retrieving all employee check-ins recorded on the current system date.
-- -----------------------------------------------------------------------------
SELECT id, employee_id, time_in, time_out, attendance_status
FROM Attendance.ATT_attendance
WHERE date_attendance = CAST(GETDATE() AS DATE)
ORDER BY time_in ASC;

-- -----------------------------------------------------------------------------
-- A query demonstrating time difference calculations for completed shifts,
-- computing total working hours per employee where clock-out time is recorded.
-- -----------------------------------------------------------------------------
SELECT 
    id,
    employee_id,
    date_attendance,
    DATEDIFF(MINUTE, time_in, time_out) / 60.0 AS Total_Working_Hours
FROM Attendance.ATT_attendance
WHERE time_out IS NOT NULL
ORDER BY Total_Working_Hours DESC;

-- -----------------------------------------------------------------------------
-- A query demonstrating conditional aggregation using CASE statements,
-- summarizing present, late, and absent counts per employee in a single view.
-- -----------------------------------------------------------------------------
SELECT 
    employee_id,
    COUNT(CASE WHEN attendance_status = 'Present' THEN 1 END) AS Present_Days,
    COUNT(CASE WHEN attendance_status = 'Late' THEN 1 END) AS Late_Days,
    COUNT(CASE WHEN attendance_status = 'Absent' THEN 1 END) AS Absent_Days
FROM Attendance.ATT_attendance
GROUP BY employee_id
ORDER BY Present_Days DESC;



-- -----------------------------------------------------------------------------
-- A query demonstrating filtering by specific leave categories,
-- retrieving all approved sick and emergency leave records sorted by date.
-- -----------------------------------------------------------------------------
SELECT id, employee_id, vacation_type, start_date, end_date
FROM Attendance.ATT_vacations
WHERE vacation_status = 'Approved'
  AND vacation_type IN ('Sick', 'Emergency')
ORDER BY start_date DESC;

-- -----------------------------------------------------------------------------
-- A query demonstrating data aggregation grouped by vacation type,
-- calculating total requests and average leave duration for each category.
-- -----------------------------------------------------------------------------
SELECT 
    vacation_type,
    COUNT(id) AS Total_Requests,
    AVG(DATEDIFF(DAY, start_date, end_date) + 1) AS Avg_Leave_Duration
FROM Attendance.ATT_vacations
WHERE vacation_status = 'Approved'
GROUP BY vacation_type;
