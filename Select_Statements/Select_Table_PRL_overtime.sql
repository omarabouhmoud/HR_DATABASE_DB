USE HR_DATABASE_DB;
GO

-- ---------------------------------------------------------------------------------------
-- A query demonstrating how to extract the day name and week number from an overtime date
-- To determine whether the overtime occurred on regular workdays or during the weekend
-- ---------------------------------------------------------------------------------------
SELECT 
    id AS Overtime_ID,
    employee_id,
    date_overtime,
    DATENAME(WEEKDAY, date_overtime) AS Day_Of_Week,
    hours_overtime,
    CASE 
        WHEN DATENAME(WEEKDAY, date_overtime) IN ('Friday', 'Saturday') THEN 'Weekend Overtime (High Rate)'
        ELSE 'Weekday Overtime (Standard Rate)'
    END AS Overtime_Tier,
    overtime_status
FROM Payroll.PRL_overtime
ORDER BY date_overtime DESC;

-- --------------------------------------------------------------------------------------------------
-- A query that demonstrates how to aggregate data chronologically (by Year/Month) to populate charts, 
-- and to monitor the months in which requests for overtime work within the organization increase.
-- --------------------------------------------------------------------------------------------------
SELECT 
    YEAR(date_overtime) AS Work_Year,
    MONTH(date_overtime) AS Work_Month,
    COUNT(DISTINCT employee_id) AS Active_Employees_Count,
    SUM(hours_overtime) AS Total_Department_Overtime_Hours
FROM Payroll.PRL_overtime
WHERE overtime_status = 'Approved'
GROUP BY YEAR(date_overtime), MONTH(date_overtime)
ORDER BY Work_Year DESC, Work_Month DESC;

-- -------------------------------------------------------------------------------------------------------------------------------
-- Proactive querying to detect potential violations regarding working hours (e.g., more than 8 hours of overtime in a single day)
-- Or requests that have remained pending for an extended period without any action taken
-- -------------------------------------------------------------------------------------------------------------------------------
SELECT 
    id AS Overtime_ID,
    employee_id,
    date_overtime,
    hours_overtime,
    overtime_status
FROM Payroll.PRL_overtime
WHERE hours_overtime > 8.00 -- رصد الساعات غير المنطقية في يوم واحد
   OR (overtime_status = 'Pending' AND DATEDIFF(DAY, date_overtime, GETDATE()) > 14);