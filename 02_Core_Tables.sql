USE HR_DATABASE_DB;
GO


CREATE TABLE Core.COR_departments (
id INT PRIMARY KEY IDENTITY(1,1),
department_nema NVARCHAR(100) NOT NULL,
location_nema NVARCHAR(100),
Email NVARCHAR(100) UNIQUE,
phone_number NVARCHAR(20) NOT NULL
);

CREATE TABLE Core.COR_positions (
id INT PRIMARY KEY IDENTITY(1,1),
Position_nema NVARCHAR(100) NOT NULL,
Position_description NVARCHAR(255)
);

CREATE TABLE Core.COR_employees (
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    phone_number NVARCHAR(20) NOT NULL,
    position_id INT NOT NULL,
    hire_date DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    department_id INT NOT NULL,
    employee_status NVARCHAR(20) DEFAULT 'Active',
    
    FOREIGN KEY (position_id) REFERENCES Core.COR_positions(id),
    FOREIGN KEY (department_id) REFERENCES Core.COR_departments(id)
    );
GO




