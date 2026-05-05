/*========================================================
  7. EMPLOYEES
  Insert managers first, then staff, then update managers
========================================================*/

-- Managers
INSERT INTO hr.Employee
(
    EmployeeNumber,
    FirstName,
    LastName,
    HireDate,
    TerminationDate,
    DepartmentId,
    JobTitleId,
    PayTypeId,
    StatusId,
    ManagerEmployeeId,
    BasePayRate,
    IsActive,
    CreatedDttm,
    ModifiedDttm
)
VALUES
('E1001', 'Alicia', 'Morgan', '2023-02-13', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'HR'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Department Manager'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 82000.00, 1, GETDATE(), GETDATE()),

('E1002', 'Brian', 'Turner', '2022-11-01', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Finance'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Department Manager'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 90000.00, 1, GETDATE(), GETDATE()),

('E1003', 'Carmen', 'Lopez', '2022-08-21', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'IT'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Department Manager'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 98000.00, 1, GETDATE(), GETDATE()),

('E1004', 'Derrick', 'Young', '2023-01-09', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Operations'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Department Manager'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 88000.00, 1, GETDATE(), GETDATE()),

('E1005', 'Elena', 'Price', '2023-03-20', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Sales'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Department Manager'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 86000.00, 1, GETDATE(), GETDATE()),

('E1006', 'Frank', 'Diaz', '2023-04-10', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Customer Support'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Department Manager'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 84000.00, 1, GETDATE(), GETDATE());
GO

-- Staff
INSERT INTO hr.Employee
(
    EmployeeNumber,
    FirstName,
    LastName,
    HireDate,
    TerminationDate,
    DepartmentId,
    JobTitleId,
    PayTypeId,
    StatusId,
    ManagerEmployeeId,
    BasePayRate,
    IsActive,
    CreatedDttm,
    ModifiedDttm
)
VALUES
('E1007', 'Grace', 'Hill', '2024-01-15', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'HR'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'HR Specialist'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 62000.00, 1, GETDATE(), GETDATE()),

('E1008', 'Henry', 'Scott', '2024-02-05', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Finance'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Payroll Analyst'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 68000.00, 1, GETDATE(), GETDATE()),

('E1009', 'Ivy', 'Reed', '2024-03-11', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Finance'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Senior Analyst'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 76000.00, 1, GETDATE(), GETDATE()),

('E1010', 'Jason', 'Cook', '2024-01-22', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'IT'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Data Analyst'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 70000.00, 1, GETDATE(), GETDATE()),

('E1011', 'Kara', 'Ward', '2024-02-12', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'IT'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Senior Analyst'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Salary'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 82000.00, 1, GETDATE(), GETDATE()),

('E1012', 'Luis', 'Brooks', '2024-01-08', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Operations'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Operations Associate'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Hourly'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 24.50, 1, GETDATE(), GETDATE()),

('E1013', 'Mia', 'Sanders', '2024-01-08', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Operations'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Operations Associate'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Hourly'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 25.25, 1, GETDATE(), GETDATE()),

('E1014', 'Noah', 'Bennett', '2024-01-29', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Operations'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Operations Associate'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Hourly'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 23.75, 1, GETDATE(), GETDATE()),

('E1015', 'Olivia', 'Flores', '2024-02-19', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Sales'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Sales Coordinator'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Hourly'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 22.00, 1, GETDATE(), GETDATE()),

('E1016', 'Paul', 'Gomez', '2024-02-19', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Sales'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Sales Coordinator'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Hourly'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 21.50, 1, GETDATE(), GETDATE()),

('E1017', 'Quinn', 'Bell', '2024-02-26', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Customer Support'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Support Representative'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Hourly'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 20.50, 1, GETDATE(), GETDATE()),

('E1018', 'Riley', 'Bailey', '2024-03-04', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Customer Support'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Support Representative'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Hourly'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Active'),
    NULL, 21.00, 1, GETDATE(), GETDATE()),

('E1019', 'Sofia', 'Murphy', '2024-03-11', NULL,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Customer Support'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Support Representative'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Hourly'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Leave'),
    NULL, 20.75, 1, GETDATE(), GETDATE()),

('E1020', 'Tyler', 'Rivera', '2024-03-18', '2025-05-01',
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Sales'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Sales Coordinator'),
    (SELECT PayTypeId FROM hr.PayType WHERE PayTypeName = 'Hourly'),
    (SELECT StatusId FROM hr.EmployeeStatus WHERE StatusName = 'Terminated'),
    NULL, 20.00, 0, GETDATE(), GETDATE());
GO

-- Assign managers
UPDATE e
SET ManagerEmployeeId = m.EmployeeId
FROM hr.Employee e
JOIN hr.Employee m
    ON (
        (e.DepartmentId = (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'HR')
         AND m.EmployeeNumber = 'E1001')
        OR
        (e.DepartmentId = (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Finance')
         AND m.EmployeeNumber = 'E1002')
        OR
        (e.DepartmentId = (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'IT')
         AND m.EmployeeNumber = 'E1003')
        OR
        (e.DepartmentId = (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Operations')
         AND m.EmployeeNumber = 'E1004')
        OR
        (e.DepartmentId = (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Sales')
         AND m.EmployeeNumber = 'E1005')
        OR
        (e.DepartmentId = (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Customer Support')
         AND m.EmployeeNumber = 'E1006')
       )
WHERE e.EmployeeNumber NOT IN ('E1001','E1002','E1003','E1004','E1005','E1006');
GO