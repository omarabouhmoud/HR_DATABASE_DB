USE master;
GO


ALTER DATABASE HR_DATABASE_DB SET RECOVERY FULL;
GO

USE HR_DATABASE_DB;
GO

--Full Backup of database HR
PRINT 'Executing Full Database Backup...';

BACKUP DATABASE HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_Full.bak' -- Generic template placeholder
WITH FORMAT,
     INIT, -- Overwrites any existing file to clean up disk space
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Full Backup of HR_DATABASE_DB',
     STATS = 10; -- Displays progress percentage every 10%
GO

--Differential Backup Database HR
PRINT 'Executing Differential Database Backup...';

BACKUP DATABASE HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_Differential.bak'
WITH DIFFERENTIAL,
     INIT,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Differential Backup of HR_DATABASE_DB',
     STATS = 10;
GO

--Transaction Log Backup Database HR
PRINT 'Executing Transaction Log Backup...';

BACKUP LOG HR_DATABASE_DB
TO DISK = 'C:\YOUR_BACKUP_DIRECTORY\HR_DATABASE_DB_Log.trn'
WITH INIT,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Transaction Log Backup of HR_DATABASE_DB',
     STATS = 10;
GO

--Partial Backup Database HR
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
