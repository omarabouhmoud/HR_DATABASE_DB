USE master;
GO


ALTER DATABASE HR_DATABASE_DB SET RECOVERY FULL;
GO

USE HR_DATABASE_DB;
GO
--===================================================================
-- Full Backup of database HR
-- Purpose: Captures the entire database (all data, tables, and logs) 
-- to create a complete baseline for full system recovery.
--====================================================================
PRINT 'Executing Full Database Backup...';

BACKUP DATABASE HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_Full.bak' -- Generic template placeholder
WITH FORMAT,
     INIT, -- Overwrites any existing file to clean up disk space
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Full Backup of HR_DATABASE_DB',
     STATS = 10; -- Displays progress percentage every 10%
GO
--=========================================
-- Differential Backup Database HR
-- Purpose: Captures only the changes made since the last Full Backup, 
-- making the backup process much faster and saving disk space.
--=========================================
PRINT 'Executing Differential Database Backup...';

BACKUP DATABASE HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_Differential.bak'
WITH DIFFERENTIAL,
     INIT,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Differential Backup of HR_DATABASE_DB',
     STATS = 10;
GO

--========================================================================
-- Transaction Log Backup Database HR
-- Purpose: Backs up the transaction logs to enable point-in-time recovery 
-- and keeps the log file size under control by clearing inactive logs.
--========================================================================
PRINT 'Executing Transaction Log Backup...';

BACKUP LOG HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_Log.trn'
WITH INIT,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Transaction Log Backup of HR_DATABASE_DB',
     STATS = 10;
GO

--==============================================================
-- Partial Backup Database HR
-- Purpose: Backs up only the primary and read-write filegroups, 
-- skipping read-only data to save time and storage space.
--==============================================================
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
