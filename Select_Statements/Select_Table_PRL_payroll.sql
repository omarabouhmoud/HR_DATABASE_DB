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
