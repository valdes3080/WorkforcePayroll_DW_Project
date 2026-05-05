/*========================================================
  1. LOCATION
========================================================*/
INSERT INTO hr.Location (LocationName, City, State, Region)
VALUES
('Headquarters', 'Chicago', 'IL', 'Midwest'),
('East Branch', 'Atlanta', 'GA', 'Southeast'),
('West Branch', 'Phoenix', 'AZ', 'West'),
('South Hub', 'Dallas', 'TX', 'South');
GO

/*========================================================
  2. PAY TYPE
========================================================*/
INSERT INTO hr.PayType (PayTypeName)
VALUES
('Hourly'),
('Salary');
GO

/*========================================================
  3. EMPLOYEE STATUS
========================================================*/
INSERT INTO hr.EmployeeStatus (StatusName)
VALUES
('Active'),
('Leave'),
('Terminated');
GO

/*========================================================
  4. JOB TITLE
========================================================*/
INSERT INTO hr.JobTitle (JobTitleName, JobLevel)
VALUES
('HR Specialist', 2),
('Payroll Analyst', 2),
('Data Analyst', 2),
('Support Representative', 1),
('Operations Associate', 1),
('Sales Coordinator', 1),
('Department Manager', 3),
('Senior Analyst', 3);
GO

/*========================================================
  5. DEPARTMENT
========================================================*/
INSERT INTO hr.Department (DepartmentName, CostCenter, LocationId)
VALUES
('HR', 'CC100',
    (SELECT LocationId FROM hr.Location WHERE LocationName = 'Headquarters')),
('Finance', 'CC200',
    (SELECT LocationId FROM hr.Location WHERE LocationName = 'Headquarters')),
('IT', 'CC300',
    (SELECT LocationId FROM hr.Location WHERE LocationName = 'West Branch')),
('Operations', 'CC400',
    (SELECT LocationId FROM hr.Location WHERE LocationName = 'South Hub')),
('Sales', 'CC500',
    (SELECT LocationId FROM hr.Location WHERE LocationName = 'East Branch')),
('Customer Support', 'CC600',
    (SELECT LocationId FROM hr.Location WHERE LocationName = 'East Branch'));
GO
