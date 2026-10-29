USE HR_DATABASE_DB;
GO

-- ===================================================
-- 1. Create Database Master Key
-- ===================================================
-- NOTE: For security reasons, replace 'YOUR_SECURE_PASSWORD' with a strong password 
-- in your local environment. Do not push real passwords to public repositories.
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<YOUR_SECURE_PASSWORD>';
GO

-- ===================================================
-- 2. Create Database Certificate
-- ===================================================
CREATE CERTIFICATE HR_Data_Certificate 
WITH SUBJECT = 'Employee Sensitive Data Protection';
GO

-- ===================================================
-- 3. Create Symmetric Key
-- ===================================================
-- AES_256 is the industry standard for strong encryption
CREATE SYMMETRIC KEY HR_Symmetric_Key
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE HR_Data_Certificate;
GO

-- ===================================================
-- 4. How to ENCRYPT Data (INSERT/UPDATE Example)
-- ===================================================
-- You must OPEN the symmetric key before using it
OPEN SYMMETRIC KEY HR_Symmetric_Key
DECRYPTION BY CERTIFICATE HR_Data_Certificate;

-- Example: Updating the encrypted salary for Employee ID 1
-- EncryptByKey converts clear text into binary encrypted data varbinary
UPDATE Payroll.PRL_payroll
SET encrypted_net_salary = EncryptByKey(Key_GUID('HR_Symmetric_Key'), CONVERT(varchar(50), '5500.00'))
WHERE employee_id = 1;

-- Always CLOSE the symmetric key after finishing the operation for security
CLOSE SYMMETRIC KEY HR_Symmetric_Key;
GO

-- ===================================================
-- 5. How to DECRYPT Data (SELECT Report Example)
-- ===================================================
OPEN SYMMETRIC KEY HR_Symmetric_Key
DECRYPTION BY CERTIFICATE HR_Data_Certificate;

-- Read and decrypt the data back to readable format
SELECT 
    employee_id,
    encrypted_net_salary AS Raw_Encrypted_Data, -- Displays as hexadecimal binary
    CONVERT(varchar(50), DecryptByKey(encrypted_net_salary)) AS Decrypted_Net_Salary -- Displays as '5500.00'
FROM Payroll.PRL_payroll;

-- Always CLOSE the symmetric key
CLOSE SYMMETRIC KEY HR_Symmetric_Key;
GO
