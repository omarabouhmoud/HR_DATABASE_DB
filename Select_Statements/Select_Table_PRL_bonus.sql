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

-- -----------------------------------------------------------------------------------------------------------
-- Strong analytical skill demonstrated by using the DATEPART(QUARTER) function to group the bonus budget 
-- by fiscal quarter (Q1, Q2, Q3, Q4) and calculating the maximum, minimum, and average bonus for each quarter.
-- -----------------------------------------------------------------------------------------------------------
SELECT 
    YEAR(bonus_date) AS Fiscal_Year,
    CONCAT('Q', DATEPART(QUARTER, bonus_date)) AS Fiscal_Quarter,
    COUNT(id) AS Total_Bonuses_Issued,
    SUM(bonus_amount) AS Total_Quarterly_Payout,
    CAST(AVG(bonus_amount) AS DECIMAL(10,2)) AS Average_Bonus_Value,
    MAX(bonus_amount) AS Highest_Single_Bonus
FROM Payroll.PRL_bonus
WHERE bonus_status = 'Approved'
GROUP BY YEAR(bonus_date), DATEPART(QUARTER, bonus_date)
ORDER BY Fiscal_Year DESC, Fiscal_Quarter ASC;


------------------------------------------------------------------------------------------
-- A query demonstrating conditional salary tier classification and tax ratio calculation,
-- safely handling potential division-by-zero errors for executive financial analysis.
------------------------------------------------------------------------------------------
SELECT 
    employee_id,
    gross_salary,
    income_tax,
    net_salary,
    ROUND((income_tax / NULLIF(gross_salary, 0)) * 100, 2) AS Tax_Percentage,
    CASE 
        WHEN net_salary >= 10000 THEN 'Executive Tier'
        WHEN net_salary BETWEEN 5000 AND 9999.99 THEN 'Mid-Level Tier'
        ELSE 'Entry-Level Tier'
    END AS Salary_Bracket
FROM Payroll.PRL_payroll
WHERE payroll_status = 'Paid'
ORDER BY Tax_Percentage DESC;
