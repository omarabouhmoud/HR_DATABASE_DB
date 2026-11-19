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