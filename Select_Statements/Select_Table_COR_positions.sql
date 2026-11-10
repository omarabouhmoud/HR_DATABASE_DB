-- Connecting to the database
USE HR_DATABASE_DB;
GO
-- ------------------------------------------------------------------------------------------------------
-- A query demonstrating the ability to format text and apply an "executive format,"
-- while also calculating the length of job descriptions to ensure compliance with data quality standards.
-- -------------------------------------------------------------------------------------------------------
SELECT 
    id AS Position_ID,
    LTRIM(RTRIM(Position_nema)) AS Clean_Job_Title, 
    LEN(Position_description) AS Description_Length_Chars, 
    SUBSTRING(Position_description, 1, 50) + '...' AS Short_Preview 
FROM Core.COR_positions
ORDER BY Position_nema;

-- ------------------------------------------------------------------------------------------------------------------------
-- A proactive query demonstrating a DBA’s skill in identifying roles created 
-- without an adequate job description (fewer than 15 characters) or left entirely blank, ensuring robust system governance.
-- ------------------------------------------------------------------------------------------------------------------------
SELECT id, Position_nema, Position_description
FROM Core.COR_positions
WHERE Position_description IS NULL 
   OR LEN(Position_description) < 15;