-- =================================================================================
-- Project: HR_DATABASE_DB (Human Resources Database Management System)
-- Component: 09_Database_Backup_Strategy.sql
-- Author: Omar Salman Abuhmoud
-- Date: November 2026
-- Description: Demonstrating Advanced SQL Server DBA Skills through a Comprehensive 
--              Backup Strategy including Full, Differential, Transaction Log, and Partial backups.
-- Note: This is a public template. Replace 'YOUR_BACKUP_DIRECTORY' with your local path.
-- =================================================================================

USE master;
GO

-- =================================================================================
-- STEP 1: Configure Recovery Model
-- Ensure the database recovery model is set to FULL to support Transaction Log Backups
-- =================================================================================
ALTER DATABASE HR_DATABASE_DB SET RECOVERY FULL;
GO

USE HR_DATABASE_DB;
GO

-- =================================================================================
-- STEP 2: Full Database Backup (The Base Backup)
-- Backs up the entire database including schemas, structural objects, and core data.
-- =================================================================================
PRINT 'Executing Full Database Backup...';

BACKUP DATABASE HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_Full.bak' -- Generic template placeholder
WITH FORMAT,
     INIT, -- Overwrites any existing file to clean up disk space
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Full Backup of HR_DATABASE_DB',
     STATS = 10; -- Displays progress percentage every 10%
GO

-- =================================================================================
-- STEP 3: Differential Database Backup
-- Backs up only the changes made since the last Full Database Backup.
-- =================================================================================
PRINT 'Executing Differential Database Backup...';

BACKUP DATABASE HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_Differential.bak'
WITH DIFFERENTIAL,
     INIT,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Differential Backup of HR_DATABASE_DB',
     STATS = 10;
GO

-- =================================================================================
-- STEP 4: Transaction Log Backup (Point-in-Time Recovery)
-- Backs up the transaction logs to enable minute-by-minute system rollback capabilities.
-- =================================================================================
PRINT 'Executing Transaction Log Backup...';

BACKUP LOG HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_Log.trn'
WITH INIT,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Transaction Log Backup of HR_DATABASE_DB',
     STATS = 10;
GO

-- =================================================================================
-- STEP 5: Partial Database Backup (Advanced DBA Practice)
-- Backs up the Primary filegroup and all active read-write filegroups.
-- =================================================================================
PRINT 'Executing Partial Database Backup...';

BACKUP DATABASE HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_PartialBackup.bak'
WITH PARTIAL,
     INIT,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Partial Backup of HR_DATABASE_DB',
     STATS = 10;
GO

PRINT 'Database Backup Strategy Script Executed Successfully!';
