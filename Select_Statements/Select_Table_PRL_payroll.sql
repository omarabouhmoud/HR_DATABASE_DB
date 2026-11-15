USE HR_DATABASE_DB;
GO

------------------------------------------------------------------------------------------
-- A query demonstrating how to filter and retrieve pending payroll records,
-- ordering the results chronologically by the most recent payment date.
------------------------------------------------------------------------------------------
SELECT id, employee_id, gross_salary, net_salary, payment_date
FROM Payroll.PRL_payroll
WHERE payroll_status = 'Pending'
ORDER BY payment_date DESC;

------------------------------------------------------------------------------------------
-- A query demonstrating the retrieval of high-earning payroll records,
-- filtering for net salaries above 5000 and sorting them from highest to lowest.
------------------------------------------------------------------------------------------
SELECT employee_id, gross_salary, income_tax, net_salary
FROM Payroll.PRL_payroll
WHERE net_salary > 5000
ORDER BY net_salary DESC;


------------------------------------------------------------------------------------------
-- A query demonstrating the ability to aggregate financial payroll metrics by status,
-- calculating total records, gross salaries, tax deductions, and net payouts.
------------------------------------------------------------------------------------------
SELECT 
    payroll_status, 
    COUNT(id) AS Total_Records, 
    SUM(gross_salary) AS Total_Gross, 
    SUM(income_tax) AS Total_Taxes, 
    SUM(net_salary) AS Total_Net_Paid 
FROM Payroll.PRL_payroll 
GROUP BY payroll_status;



------------------------------------------------------------------------------------------
-- A query demonstrating the calculation of overall payroll averages,
-- determining the mean gross and net salaries across all employee records.
------------------------------------------------------------------------------------------
SELECT 
    AVG(gross_salary) AS Average_Gross_Salary,
    AVG(net_salary) AS Average_Net_Salary
FROM Payroll.PRL_payroll;

------------------------------------------------------------------------------------------
-- A query demonstrating subquery filtering and group-level auditing using HAVING,
-- identifying employees earning above-average salaries with multiple payouts in a single month.
------------------------------------------------------------------------------------------
SELECT 
    employee_id,
    YEAR(payment_date) AS Pay_Year,
    MONTH(payment_date) AS Pay_Month,
    COUNT(id) AS Payout_Count,
    SUM(net_salary) AS Total_Received
FROM Payroll.PRL_payroll
WHERE net_salary > (SELECT AVG(net_salary) FROM Payroll.PRL_payroll)
GROUP BY employee_id, YEAR(payment_date), MONTH(payment_date)
HAVING COUNT(id) > 1
ORDER BY Total_Received DESC;


------------------------------------------------------------------------------------------
-- A query demonstrating Common Table Expressions (CTEs) and LAG analytical functions,
-- tracking month-over-month payroll expenditure growth and financial variance.
------------------------------------------------------------------------------------------
WITH MonthlyPayroll AS (
    SELECT 
        YEAR(payment_date) AS Pay_Year,
        MONTH(payment_date) AS Pay_Month,
        SUM(net_salary) AS Total_Monthly_Net
    FROM Payroll.PRL_payroll
    WHERE payroll_status = 'Paid'
    GROUP BY YEAR(payment_date), MONTH(payment_date)
)
SELECT 
    Pay_Year,
    Pay_Month,
    Total_Monthly_Net,
    LAG(Total_Monthly_Net) OVER (ORDER BY Pay_Year, Pay_Month) AS Previous_Month_Net,
    ROUND(
        ((Total_Monthly_Net - LAG(Total_Monthly_Net) OVER (ORDER BY Pay_Year, Pay_Month)) 
        / NULLIF(LAG(Total_Monthly_Net) OVER (ORDER BY Pay_Year, Pay_Month), 0)) * 100, 
    2) AS MoM_Growth_Percentage
FROM MonthlyPayroll;
