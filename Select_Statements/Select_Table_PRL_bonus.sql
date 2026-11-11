USE HR_DATABASE_DB;
GO

-- -----------------------------------------------------------------------------------------------
-- A query demonstrating the ability to programmatically categorize monetary amounts into segments, 
-- and to format dates for easier presentation in senior management reports.
-- -----------------------------------------------------------------------------------------------
SELECT 
    id AS Bonus_ID,
    employee_id,
    bonus_amount,
    bonus_date,
    DATENAME(MONTH, bonus_date) AS Bonus_Month_Name,
    CASE 
        WHEN bonus_amount >= 5000 THEN 'Executive / High Tier Bonus'
        WHEN bonus_amount BETWEEN 1500 AND 4999.99 THEN 'Performance Tier Bonus'
        ELSE 'Spot / Recognition Bonus'
    END AS Bonus_Category,
    bonus_status
FROM Payroll.PRL_bonus
ORDER BY bonus_amount DESC;