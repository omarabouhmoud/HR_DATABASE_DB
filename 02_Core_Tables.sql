USE HR_DATABASE_DB;
GO


CREATE TABLE Core.COR_departments (
id INT PRIMARY KEY IDENTITY(1,1),                              -- Department ID (primary key, auto-generated)
department_nema NVARCHAR(100) NOT NULL,                        -- Department Name (Required)
location_nema NVARCHAR(100),                                   -- Department or Branch Location
Email NVARCHAR(100) UNIQUE,                                    -- Department Email (Unique)
phone_number NVARCHAR(20) NOT NULL                             -- Department phone number
);

CREATE TABLE Core.COR_positions (
id INT PRIMARY KEY IDENTITY(1,1),                              -- Job ID (Primary Key)
Position_nema NVARCHAR(100) NOT NULL,                          -- Job Title (Required)
Position_description NVARCHAR(255)                             -- Job Duties Description
);

CREATE TABLE Core.COR_employees (
    id INT PRIMARY KEY IDENTITY(1,1),                          -- Employee's unique employee number (primary key)
    first_name NVARCHAR(50) NOT NULL,                          -- Employee's first name
    last_name NVARCHAR(50) NOT NULL,                           -- last name
    date_of_birth DATE NOT NULL,                               -- date of birth
    Email NVARCHAR(100) UNIQUE NOT NULL,                       -- Employee email (mandatory and unique to prevent duplication)   -(create index)
    phone_number NVARCHAR(20) NOT NULL,                        -- The employee's mobile number
    position_id INT NOT NULL,                                  -- Job ID (foreign key linking to the jobs table)                 -(create index)
    hire_date DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),   -- Appointment date (automatically defaults to today's date)
    department_id INT NOT NULL,                                -- Department ID (foreign key linking to the departments table)   -(create index)
    employee_status NVARCHAR(20) DEFAULT 'Active',             -- Employee status (automatically active/on duty, or resigned)
                                                               -- To effectively connect the employee with their department and job.
    FOREIGN KEY (position_id) REFERENCES Core.COR_positions(id),
    FOREIGN KEY (department_id) REFERENCES Core.COR_departments(id)
    );
GO