USE HR_DATABASE_DB;
GO

-- ===================================================================
-- TECHNICAL SHOWCASE QUERIES FOR TABLE: Core.COR_employees
-- Purpose: To demonstrate high-level data manipulation, date functions,
--          and data profiling skills on the central master table.
-- ===================================================================
-- -----------------------------------------------------------------------------------------------------------------------
-- A query demonstrating the skill of combining names and displaying job statuses in a well-organized, professional format
-- -----------------------------------------------------------------------------------------------------------------------
SELECT 
    id AS Employee_ID,
    CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(first_name, 2, LEN(first_name))), ' ', 
           UPPER(SUBSTRING(last_name, 1, 1)), LOWER(SUBSTRING(last_name, 2, LEN(last_name)))) AS Formatted_Full_Name,
    LOWER(Email) AS Official_Email,
    phone_number AS Contact_Number,
    UPPER(employee_status) AS Current_Status
FROM Core.COR_employees
ORDER BY last_name ASC;
-- --------------------------------------------------------------------------------------------------
-- [Skill 2: Professional Handling of Dates and Date Arithmetic]
-- A query demonstrating a data engineer's proficiency in using the DATEDIFF and GETDATE() functions 
-- to automatically calculate the tenure of each employee upon data entry, and to identify new hires.
-- --------------------------------------------------------------------------------------------------
SELECT 
    id,
    first_name,
    last_name,
    hire_date,
    DATEDIFF(year, hire_date, GETDATE()) AS Projected_Years_Of_Service, -- Automatically calculate the number of years of service
    DATEADD(month, 3, hire_date) AS Probation_End_Date -- Automatically calculate the trial period end date (after 3 months)
FROM Core.COR_employees
WHERE hire_date <= GETDATE();

