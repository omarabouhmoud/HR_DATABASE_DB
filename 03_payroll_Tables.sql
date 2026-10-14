USE HR_DATABASE_DB;
GO

CREATE TABLE Payroll.PRL_payroll (
	id INT PRIMARY KEY IDENTITY(1,1),
	gross_salary DECIMAL(10,2) NOT NULL CHECK (gross_salary > 0), 
    income_tax DECIMAL(10,2) DEFAULT 0 CHECK (income_tax >= 0),  
    net_salary DECIMAL(10,2) NOT NULL,        
    payment_date DATE NOT NULL,              
    employee_id INT NOT NULL,                  
    payroll_status NVARCHAR(20) DEFAULT 'Pending', 
    encrypted_net_salary VARBINARY(MAX),      
    
    FOREIGN KEY (employee_id) REFERENCES Core.COR_employees(id)
);
GO