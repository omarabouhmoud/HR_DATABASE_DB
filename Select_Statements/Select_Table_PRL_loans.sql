USE HR_DATABASE_DB;
GO

-- -----------------------------------------------------------------------------
-- A query demonstrating how to filter and retrieve active loan records,
-- ordering the results chronologically by the loan receipt date.
-- -----------------------------------------------------------------------------
SELECT id, employee_id, loan_amount, loan_date, loan_start, loan_end
FROM Payroll.PRL_loans
WHERE loan_status = 'Active'
ORDER BY loan_date DESC;

-- -----------------------------------------------------------------------------
-- A query demonstrating the retrieval of high-value loans,
-- filtering for loan amounts above 10000 and sorting them from highest to lowest.
-- -----------------------------------------------------------------------------
SELECT id, employee_id, loan_amount, loan_status
FROM Payroll.PRL_loans
WHERE loan_amount > 10000
ORDER BY loan_amount DESC;

-- -----------------------------------------------------------------------------
-- A query demonstrating subquery filtering and group-level auditing using HAVING,
-- identifying employees with multiple loans exceeding the company average amount.
-- -----------------------------------------------------------------------------
SELECT 
    employee_id,
    COUNT(id) AS Loan_Count,
    SUM(loan_amount) AS Total_Borrowed
FROM Payroll.PRL_loans
WHERE loan_amount > (SELECT AVG(loan_amount) FROM Payroll.PRL_loans)
GROUP BY employee_id
HAVING COUNT(id) > 1
ORDER BY Total_Borrowed DESC;

-- -----------------------------------------------------------------------------
-- A query demonstrating table joins and window functions (RANK),
-- combining employee details with their loans and ranking highest borrowers.
-- -----------------------------------------------------------------------------
SELECT 
    l.id AS Loan_ID,
    e.id AS Employee_ID,
    l.loan_amount,
    l.loan_status,
    RANK() OVER (ORDER BY l.loan_amount DESC) AS Loan_Amount_Rank
FROM Payroll.PRL_loans l
INNER JOIN Core.COR_employees e ON l.employee_id = e.id;
-- -----------------------------------------------------------------------------
-- A query demonstrating data aggregation grouped by loan status,
-- calculating total loan counts and overall disbursed amounts per status.
-- -----------------------------------------------------------------------------
SELECT 
    loan_status,
    COUNT(id) AS Total_Loans,
    SUM(loan_amount) AS Total_Amount,
    AVG(loan_amount) AS Average_Loan_Amount
FROM Payroll.PRL_loans
GROUP BY loan_status;

-- -----------------------------------------------------------------------------
-- A query demonstrating date-based filtering and duration calculation,
-- determining the repayment period in months for each active loan.
-- -----------------------------------------------------------------------------
SELECT 
    id,
    employee_id,
    loan_amount,
    DATEDIFF(MONTH, loan_start, loan_end) AS Repayment_Months
FROM Payroll.PRL_loans
WHERE loan_status = 'Active' 
  AND loan_end >= GETDATE();
