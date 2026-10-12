CREATE DATABASE HR_DATABASE_DB;

CREATE TABLE employees (
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    Email VARCHAR(100),
    phone_number VARCHAR(20),
    position_id INT FOREIGN KEY REFERENCES positions(id),
    hire_date DATE,
    department_id INT FOREIGN KEY REFERENCES departments(id),
    employee_status VARCHAR(50)
);
