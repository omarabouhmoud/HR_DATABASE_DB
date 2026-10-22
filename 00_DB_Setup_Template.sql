-- Switch to the master database to create the server-level login
USE master;
GO

-- Create a secure login for the Database Administrator (DBA) at the server level
CREATE LOGIN DBA_Admin 
WITH PASSWORD = 'YOUR_STRONG_PASSWORD_HERE', -- Placeholder: Replace with a strong password locally
     CHECK_POLICY = ON; -- Enable Windows password policy reinforcement for better security
GO

-- Switch to the specific Human Resources project database
USE HR_DATABASE_DB;
GO

-- Create a database-level user mapped to the server-level login
CREATE USER DBA_Admin_User FOR LOGIN DBA_Admin;
GO

-- Grant full Database Administrator (DBA) privileges by assigning the user to the db_owner role
ALTER ROLE db_owner ADD MEMBER DBA_Admin_User;
GO
