USE HR_DATABASE_DB;
GO

CREATE TABLE Payroll.PRL_payroll (
	id INT PRIMARY KEY IDENTITY(1,1),                                  -- Financial Administrator Mobility Number
	gross_salary DECIMAL(10,2) NOT NULL CHECK (gross_salary > 0),      -- Gross salary (Condition: Must be greater than zero)
    income_tax DECIMAL(10,2) DEFAULT 0 CHECK (income_tax >= 0),        -- Withheld taxes (negative values ​​not allowed)
    net_salary DECIMAL(10,2) NOT NULL,                                 -- Net salary after deductions
    payment_date DATE NOT NULL,                                        -- Date of salary transfer to the employee's bank
    employee_id INT NOT NULL,                                          -- Receiving employee ID (foreign key)          -(create index)
    payroll_status NVARCHAR(20) DEFAULT 'Pending',                     -- Disbursement Status (Pending, Disbursed)     -(create index)
    encrypted_net_salary VARBINARY(MAX),                               -- A binary data field prepared for future salary value encryption.
    
    FOREIGN KEY (employee_id) REFERENCES Core.COR_employees(id)
);
GO

CREATE TABLE Payroll.PRL_overtime (
    id INT PRIMARY KEY IDENTITY(1,1),                                  -- Overtime Record Number
    date_overtime DATE NOT NULL,                                       -- Date on which the overtime work was performed
    hours_overtime DECIMAL(4,2) NOT NULL CHECK (hours_overtime > 0),   -- Number of hours (condition: greater than zero)
    employee_id INT NOT NULL,                                          -- Employee number of the person who worked overtime
    overtime_status NVARCHAR(20) DEFAULT 'Pending',                    -- Order status (Pending, Approved)
        FOREIGN KEY (employee_id) REFERENCES Core.COR_employees(id)
);
GO

CREATE TABLE Payroll.PRL_bonus (
    id INT PRIMARY KEY IDENTITY(1,1),                                  -- Reward Record Number
    bonus_amount DECIMAL(10,2) NOT NULL CHECK (bonus_amount > 0),      -- Value of the financial reward
    bonus_date DATE NOT NULL,                                          -- Date the bonus was awarded to the employee
    employee_id INT NOT NULL,                                          -- Employee number of the bonus recipient
    bonus_status NVARCHAR(20) DEFAULT 'Pending',                       -- Bonus Approval Status
    FOREIGN KEY (employee_id) REFERENCES Core.COR_employees(id)
);
GO

CREATE TABLE Payroll.PRL_loans (
    id INT PRIMARY KEY IDENTITY(1,1),                                  -- Loan record number
    loan_amount DECIMAL(10,2) NOT NULL CHECK (loan_amount > 0),        -- Total advance amount
    loan_date DATE NOT NULL,                                           -- Loan receipt date
    loan_start DATE NOT NULL,                                          -- Date of commencement of installment deductions from the monthly salary
    loan_end DATE NOT NULL,                                            -- Date of full loan repayment
    employee_id INT NOT NULL,                                          -- Borrowing employee's ID number
    loan_status NVARCHAR(20) DEFAULT 'Active',                         -- Loan status (active and under repayment, or concluded and fully repaid)
     FOREIGN KEY (employee_id) REFERENCES Core.COR_employees(id)
 );
GO