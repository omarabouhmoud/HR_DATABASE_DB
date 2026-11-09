-- ===================================================================
-- SCHEMA: CORE (COR) - TESTING & ANALYTICAL QUERIES
-- Description: This file contains baseline queries for Core tables
-- ===================================================================

-- Connecting to the database
USE HR_DATABASE_DB;
GO
----------------------------------------------------------------------
-- 1. TABLES: COR_departments 
----------------------------------------------------------------------
-- Retrieve the complete list of active sections 
SELECT id, department_nema, location_nema
FROM Core.COR_departments;
-- ---------------------------------------------------------------------------------
-- [Comprehensive Structured Data and Output Formatting]
-- Retrieve all departments, combining the ID and name into a single formatted field
-- ---------------------------------------------------------------------------------
SELECT 
    id, 
    UPPER(department_nema) AS Formatted_Department_Name, 
    location_nema, 
    LOWER(Email) AS Cleaned_Email, 
    phone_number
FROM Core.COR_departments
ORDER BY department_nema ASC; 
-- -----------------------------------------------------------------------------------------------------------------
-- An advanced query demonstrating data grouping, used to determine the number of departments in each city or branch
-- Results are sorted in ascending order based on the highest counts, highlighting the analytical aspect
-- -----------------------------------------------------------------------------------------------------------------
SELECT 
    location_nema AS Branch_Location, 
    COUNT(id) AS Projected_Departments_Count
FROM Core.COR_departments
GROUP BY location_nema
HAVING COUNT(id) > 0 
ORDER BY Projected_Departments_Count DESC;

ddd