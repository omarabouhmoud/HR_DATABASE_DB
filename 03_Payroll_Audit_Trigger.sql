USE HR_DATABASE_DB;
GO

-- 1. حذف جدول الـ Audit القديم من السيرفر إن وجد لتنظيف البيئة
IF OBJECT_ID('Payroll.PRL_payroll_audit', 'U') IS NOT NULL
    DROP TABLE Payroll.PRL_payroll_audit;
GO

-- 2. إنشاء الجدول الصحيح والمتناسق بالكامل بدون أي علامات تعارض
CREATE TABLE Payroll.PRL_payroll_audit (
    audit_id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT NOT NULL,
    old_gross_salary DECIMAL(10,2),
    new_gross_salary DECIMAL(10,2),
    changed_by NVARCHAR(100) DEFAULT SUSER_NAME(),
    changed_at DATETIME DEFAULT GETDATE()
);
GO
