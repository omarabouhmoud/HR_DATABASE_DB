USE HR_DATABASE_DB;
GO

-- ===================================================
-- 1. Create Loan Audit Table
-- ===================================================
IF OBJECT_ID('Payroll.PRL_loans_audit', 'U') IS NOT NULL
    DROP TABLE Payroll.PRL_loans_audit;
GO

CREATE TABLE Payroll.PRL_loans_audit (
    audit_id INT PRIMARY KEY IDENTITY(1,1),
    loan_id INT NOT NULL,
    employee_id INT NOT NULL,
    old_loan_amount DECIMAL(10,2),
    new_loan_amount DECIMAL(10,2),
    old_loan_status NVARCHAR(50),
    new_loan_status NVARCHAR(50),
    changed_by NVARCHAR(100) DEFAULT SUSER_NAME(),
    changed_at DATETIME DEFAULT GETDATE(),
    action_type NVARCHAR(20) -- UPDATE or DELETE
);
GO

-- ===================================================
-- 2. Create Loan Audit Trigger
-- ===================================================
IF OBJECT_ID('Payroll.trg_AuditLoanChanges', 'TR') IS NOT NULL
    DROP TRIGGER Payroll.trg_AuditLoanChanges;
GO

CREATE TRIGGER Payroll.trg_AuditLoanChanges
ON Payroll.PRL_loans
AFTER UPDATE, DELETE
AS
BEGIN
    -- Prevent row count messages from being returned for performance optimization
    SET NOCOUNT ON;

    -- Detect the database operation type (UPDATE or DELETE)
    DECLARE @Action NVARCHAR(20);
    
    IF EXISTS(SELECT 1 FROM deleted) AND EXISTS(SELECT 1 FROM inserted)
        SET @Action = 'UPDATE';
    ELSE IF EXISTS(SELECT 1 FROM deleted)
        SET @Action = 'DELETE';

    -- Handling UPDATE Operations
    IF @Action = 'UPDATE'
    BEGIN
        INSERT INTO Payroll.PRL_loans_audit (
            loan_id, 
            employee_id, 
            old_loan_amount, new_loan_amount, 
            old_loan_status, new_loan_status, 
            action_type
        )
        SELECT 
            i.id,
            i.employee_id,
            d.loan_amount, i.loan_amount,
            d.loan_status, i.loan_status,
            'UPDATE'
        FROM inserted i
        JOIN deleted d ON i.id = d.id
        -- Log only if financial loan figures or statuses actually change
        WHERE d.loan_amount <> i.loan_amount 
           OR d.loan_status <> i.loan_status;
    END

    -- Handling DELETE Operations
    IF @Action = 'DELETE'
    BEGIN
        INSERT INTO Payroll.PRL_loans_audit (
            loan_id, 
            employee_id, 
            old_loan_amount, 
            old_loan_status, 
            action_type
        )
        SELECT 
            d.id,
            d.employee_id,
            d.loan_amount,
            d.loan_status,
            'DELETE'
        FROM deleted d;
    END
END;
GO
