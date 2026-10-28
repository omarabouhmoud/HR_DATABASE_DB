USE HR_DATABASE_DB;
GO

-- ===================================================
-- 1. Create Employee Audit Table
-- ===================================================
IF OBJECT_ID('Core.COR_employees_audit', 'U') IS NOT NULL
    DROP TABLE Core.COR_employees_audit;
GO

CREATE TABLE Core.COR_employees_audit (
    audit_id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT NOT NULL,
    old_position_id INT,
    new_position_id INT,
    old_department_id INT,
    new_department_id INT,
    changed_by NVARCHAR(100) DEFAULT SUSER_NAME(),
    changed_at DATETIME DEFAULT GETDATE(),
    action_type NVARCHAR(20) -- INSERT, UPDATE, or DELETE
);
GO

-- ===================================================
-- 2. Create Employee Audit Trigger
-- ===================================================
IF OBJECT_ID('Core.trg_AuditEmployeeChanges', 'TR') IS NOT NULL
    DROP TRIGGER Core.trg_AuditEmployeeChanges;
GO

CREATE TRIGGER Core.trg_AuditEmployeeChanges
ON Core.COR_employees
AFTER UPDATE, DELETE
AS
BEGIN
    -- Prevent row count messages from being returned for performance optimization
    SET NOCOUNT ON;

    -- DECLARE variable to detect the database operation type
    DECLARE @Action NVARCHAR(20);
    
    IF EXISTS(SELECT 1 FROM deleted) AND EXISTS(SELECT 1 FROM inserted)
        SET @Action = 'UPDATE';
    ELSE IF EXISTS(SELECT 1 FROM deleted)
        SET @Action = 'DELETE';

    -- Handling UPDATE Operations
    IF @Action = 'UPDATE'
    BEGIN
        INSERT INTO Core.COR_employees_audit (
            employee_id, 
            old_position_id, new_position_id, 
            old_department_id, new_department_id, 
            action_type
        )
        SELECT 
            i.id,
            d.position_id, i.position_id,
            d.department_id, i.department_id,
            'UPDATE'
        FROM inserted i
        JOIN deleted d ON i.id = d.id
        -- Log only if critical structural career data changes (Position or Department)
        WHERE d.position_id <> i.position_id 
           OR d.department_id <> i.department_id;
    END

    -- Handling DELETE Operations
    IF @Action = 'DELETE'
    BEGIN
        INSERT INTO Core.COR_employees_audit (
            employee_id, 
            old_position_id, 
            old_department_id, 
            action_type
        )
        SELECT 
            d.id,
            d.position_id,
            d.department_id,
            'DELETE'
        FROM deleted d;
    END
END;
GO


SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'Core' AND TABLE_NAME = 'COR_employees';
