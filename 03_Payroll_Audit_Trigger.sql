USE HR_DATABASE_DB;
GO

-- ===================================================
-- 1. إنشاء جدول مراقبة مسيرات الرواتب (Audit Table)
-- ===================================================
IF OBJECT_ID('Payroll.PRL_payroll_audit', 'U') IS NOT NULL
    DROP TABLE Payroll.PRL_payroll_audit;
GO

CREATE TABLE Payroll.PRL_payroll_audit (
    audit_id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT NOT NULL,
    old_gross_salary DECIMAL(10,2),
    new_gross_salary DECIMAL(10,2),
    changed_by NVARCHAR(100) DEFAULT SUSER_NAME(),
    changed_at DATETIME DEFAULT GETDATE()
);
GO

-- ===================================================
-- 2. إنشاء التريجر الخاص بمراقبة وتوثيق الرواتب (Audit Trigger)
-- ===================================================
IF OBJECT_ID('Payroll.trg_AuditPayrollSalaryChanges', 'TR') IS NOT NULL
    DROP TRIGGER Payroll.trg_AuditPayrollSalaryChanges;
GO

CREATE TRIGGER Payroll.trg_AuditPayrollSalaryChanges
ON Payroll.PRL_payroll
AFTER UPDATE
AS
BEGIN
    -- منع إرسال رسائل نظام تعداد الأسطر المتأثرة لتحسين الأداء
    SET NOCOUNT ON;

    -- التحقق من أن التعديل شمل عمود الراتب الإجمالي فعلياً لتوفير مساحة التخزين
    IF UPDATE(gross_salary)
    BEGIN
        INSERT INTO Payroll.PRL_payroll_audit (employee_id, old_gross_salary, new_gross_salary)
        SELECT 
            i.employee_id,
            d.gross_salary AS old_gross_salary,
            i.gross_salary AS new_gross_salary
        FROM inserted i
        JOIN deleted d ON i.id = d.id
        -- توثيق السجلات التي تغيرت قيمتها الفعلية فقط لمنع التكرار غير المفيد
        WHERE i.gross_salary <> d.gross_salary;
    END
END;
GO
