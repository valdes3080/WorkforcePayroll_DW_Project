USE WorkforcePayroll_OLTP;
GO

/*========================================================
  OPTIONAL: CLEAR TABLES FIRST
  Run this only if you want to wipe existing seed data
========================================================*/
/*
DELETE FROM pay.PayrollTransaction;
DELETE FROM pay.PayrollRun;
DELETE FROM pay.Timesheet;
DELETE FROM hr.EmployeeJobHistory;
DELETE FROM hr.Employee;
DELETE FROM pay.PayPeriod;
DELETE FROM hr.Department;
DELETE FROM hr.JobTitle;
DELETE FROM hr.PayType;
DELETE FROM hr.EmployeeStatus;
DELETE FROM hr.Location;
GO
*/

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

/*========================================================
  6. PAY PERIODS (12 BIWEEKLY PERIODS)
========================================================*/
DECLARE @StartDate DATE = '2025-01-06'; -- Monday
DECLARE @i INT = 0;

WHILE @i < 12
BEGIN
    INSERT INTO pay.PayPeriod
    (
        PeriodStartDate,
        PeriodEndDate,
        CheckDate,
        PayrollMonth,
        PayrollYear
    )
    VALUES
    (
        DATEADD(DAY, @i * 14, @StartDate),
        DATEADD(DAY, @i * 14 + 13, @StartDate),
        DATEADD(DAY, @i * 14 + 16, @StartDate), -- check date a few days later
        MONTH(DATEADD(DAY, @i * 14, @StartDate)),
        YEAR(DATEADD(DAY, @i * 14, @StartDate))
    );

    SET @i += 1;
END;
GO

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

/*========================================================
  8. EMPLOYEE JOB HISTORY
========================================================*/

-- Current/history baseline rows from employee table
INSERT INTO hr.EmployeeJobHistory
(
    EmployeeId,
    DepartmentId,
    JobTitleId,
    BasePayRate,
    EffectiveStartDate,
    EffectiveEndDate,
    IsCurrent
)
SELECT
    EmployeeId,
    DepartmentId,
    JobTitleId,
    BasePayRate,
    HireDate,
    CASE
        WHEN TerminationDate IS NOT NULL THEN TerminationDate
        ELSE NULL
    END,
    CASE
        WHEN TerminationDate IS NOT NULL THEN 0
        ELSE 1
    END
FROM hr.Employee;
GO

-- Add historical changes for a few employees

-- E1010 promoted from Data Analyst to Senior Analyst later,
-- so first close out original row then add new one
UPDATE hjh
SET EffectiveEndDate = '2025-03-31',
    IsCurrent = 0
FROM hr.EmployeeJobHistory hjh
JOIN hr.Employee e
    ON hjh.EmployeeId = e.EmployeeId
WHERE e.EmployeeNumber = 'E1010'
  AND hjh.IsCurrent = 1;

INSERT INTO hr.EmployeeJobHistory
(
    EmployeeId,
    DepartmentId,
    JobTitleId,
    BasePayRate,
    EffectiveStartDate,
    EffectiveEndDate,
    IsCurrent
)
SELECT
    e.EmployeeId,
    e.DepartmentId,
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Senior Analyst'),
    78000.00,
    '2025-04-01',
    NULL,
    1
FROM hr.Employee e
WHERE e.EmployeeNumber = 'E1010';

-- E1015 transferred from Customer Support to Sales
UPDATE hjh
SET EffectiveEndDate = '2025-02-28',
    IsCurrent = 0
FROM hr.EmployeeJobHistory hjh
JOIN hr.Employee e
    ON hjh.EmployeeId = e.EmployeeId
WHERE e.EmployeeNumber = 'E1015'
  AND hjh.IsCurrent = 1;

INSERT INTO hr.EmployeeJobHistory
(
    EmployeeId,
    DepartmentId,
    JobTitleId,
    BasePayRate,
    EffectiveStartDate,
    EffectiveEndDate,
    IsCurrent
)
SELECT
    e.EmployeeId,
    (SELECT DepartmentId FROM hr.Department WHERE DepartmentName = 'Sales'),
    (SELECT JobTitleId FROM hr.JobTitle WHERE JobTitleName = 'Sales Coordinator'),
    22.00,
    '2025-03-01',
    NULL,
    1
FROM hr.Employee e
WHERE e.EmployeeNumber = 'E1015';

-- E1012 pay increase
UPDATE hjh
SET EffectiveEndDate = '2025-04-15',
    IsCurrent = 0
FROM hr.EmployeeJobHistory hjh
JOIN hr.Employee e
    ON hjh.EmployeeId = e.EmployeeId
WHERE e.EmployeeNumber = 'E1012'
  AND hjh.IsCurrent = 1;

INSERT INTO hr.EmployeeJobHistory
(
    EmployeeId,
    DepartmentId,
    JobTitleId,
    BasePayRate,
    EffectiveStartDate,
    EffectiveEndDate,
    IsCurrent
)
SELECT
    e.EmployeeId,
    e.DepartmentId,
    e.JobTitleId,
    26.00,
    '2025-04-16',
    NULL,
    1
FROM hr.Employee e
WHERE e.EmployeeNumber = 'E1012';
GO

/*========================================================
  9. TIMESHEETS
  Hourly employees only
  One row per employee per weekday within each pay period
========================================================*/

;WITH Calendar AS
(
    SELECT CAST('2025-01-06' AS DATE) AS WorkDate
    UNION ALL
    SELECT DATEADD(DAY, 1, WorkDate)
    FROM Calendar
    WHERE WorkDate < '2025-06-22'
)
INSERT INTO pay.Timesheet
(
    EmployeeId,
    WorkDate,
    RegularHours,
    OvertimeHours,
    DepartmentId,
    ApprovedFlag,
    CreatedDttm
)
SELECT
    e.EmployeeId,
    c.WorkDate,
    8.00 AS RegularHours,
    CASE
        WHEN d.DepartmentName = 'Operations'
             AND DATENAME(WEEKDAY, c.WorkDate) IN ('Tuesday','Thursday')
             THEN 2.00
        WHEN d.DepartmentName = 'Customer Support'
             AND DATENAME(WEEKDAY, c.WorkDate) = 'Monday'
             THEN 1.50
        WHEN d.DepartmentName = 'Sales'
             AND DAY(c.WorkDate) IN (10, 25)
             THEN 1.00
        ELSE 0.00
    END AS OvertimeHours,
    e.DepartmentId,
    1,
    GETDATE()
FROM hr.Employee e
JOIN hr.PayType pt
    ON e.PayTypeId = pt.PayTypeId
JOIN hr.Department d
    ON e.DepartmentId = d.DepartmentId
CROSS JOIN Calendar c
WHERE pt.PayTypeName = 'Hourly'
  AND DATENAME(WEEKDAY, c.WorkDate) NOT IN ('Saturday','Sunday')
  AND c.WorkDate >= e.HireDate
  AND (e.TerminationDate IS NULL OR c.WorkDate <= e.TerminationDate)
OPTION (MAXRECURSION 1000);
GO

/*========================================================
  10. PAYROLL RUN
  One row per pay period
========================================================*/
INSERT INTO pay.PayrollRun
(
    PayPeriodId,
    RunDate,
    RunStatus,
    TotalEmployeesPaid,
    TotalGrossPay
)
SELECT
    PayPeriodId,
    CheckDate,
    'Completed',
    0,
    0.00
FROM pay.PayPeriod;
GO

/*========================================================
  11. PAYROLL TRANSACTION
  One row per employee per pay period
========================================================*/

-- Hourly employees: use timesheet totals
INSERT INTO pay.PayrollTransaction
(
    PayrollRunId,
    EmployeeId,
    PayPeriodId,
    RegularHours,
    OvertimeHours,
    BasePayRate,
    OvertimePayRate,
    GrossPay,
    BonusPay,
    DeductionAmount,
    NetPay,
    PaymentDate
)
SELECT
    pr.PayrollRunId,
    e.EmployeeId,
    pp.PayPeriodId,
    SUM(ts.RegularHours) AS RegularHours,
    SUM(ts.OvertimeHours) AS OvertimeHours,
    e.BasePayRate,
    ROUND(e.BasePayRate * 1.5, 2) AS OvertimePayRate,
    ROUND(
        SUM(ts.RegularHours) * e.BasePayRate +
        SUM(ts.OvertimeHours) * (e.BasePayRate * 1.5),
        2
    ) AS GrossPay,
    CASE
        WHEN e.EmployeeNumber IN ('E1012','E1017') AND pp.PayPeriodId IN (4,8,12)
            THEN 150.00
        ELSE 0.00
    END AS BonusPay,
    ROUND(
        (
            SUM(ts.RegularHours) * e.BasePayRate +
            SUM(ts.OvertimeHours) * (e.BasePayRate * 1.5)
        ) * 0.18,
        2
    ) AS DeductionAmount,
    ROUND(
        (
            SUM(ts.RegularHours) * e.BasePayRate +
            SUM(ts.OvertimeHours) * (e.BasePayRate * 1.5)
        ) +
        CASE
            WHEN e.EmployeeNumber IN ('E1012','E1017') AND pp.PayPeriodId IN (4,8,12)
                THEN 150.00
            ELSE 0.00
        END
        -
        (
            (
                SUM(ts.RegularHours) * e.BasePayRate +
                SUM(ts.OvertimeHours) * (e.BasePayRate * 1.5)
            ) * 0.18
        ),
        2
    ) AS NetPay,
    pp.CheckDate AS PaymentDate
FROM hr.Employee e
JOIN hr.PayType pt
    ON e.PayTypeId = pt.PayTypeId
JOIN pay.PayPeriod pp
    ON pp.PeriodStartDate >= e.HireDate
   AND (e.TerminationDate IS NULL OR pp.PeriodStartDate <= e.TerminationDate)
JOIN pay.PayrollRun pr
    ON pr.PayPeriodId = pp.PayPeriodId
JOIN pay.Timesheet ts
    ON ts.EmployeeId = e.EmployeeId
   AND ts.WorkDate BETWEEN pp.PeriodStartDate AND pp.PeriodEndDate
WHERE pt.PayTypeName = 'Hourly'
GROUP BY
    pr.PayrollRunId,
    e.EmployeeId,
    pp.PayPeriodId,
    e.BasePayRate,
    e.EmployeeNumber,
    pp.CheckDate;
GO

-- Salary employees: fixed pay per pay period
INSERT INTO pay.PayrollTransaction
(
    PayrollRunId,
    EmployeeId,
    PayPeriodId,
    RegularHours,
    OvertimeHours,
    BasePayRate,
    OvertimePayRate,
    GrossPay,
    BonusPay,
    DeductionAmount,
    NetPay,
    PaymentDate
)
SELECT
    pr.PayrollRunId,
    e.EmployeeId,
    pp.PayPeriodId,
    80.00 AS RegularHours,
    CASE
        WHEN d.DepartmentName IN ('IT','Finance') AND pp.PayPeriodId IN (3,6,9,12)
            THEN 4.00
        ELSE 0.00
    END AS OvertimeHours,
    e.BasePayRate,
    0.00 AS OvertimePayRate,
    ROUND(
        (e.BasePayRate / 26.0) +
        CASE
            WHEN d.DepartmentName IN ('IT','Finance') AND pp.PayPeriodId IN (3,6,9,12)
                THEN 300.00
            ELSE 0.00
        END,
        2
    ) AS GrossPay,
    CASE
        WHEN e.EmployeeNumber IN ('E1003','E1005','E1009') AND pp.PayPeriodId IN (6,12)
            THEN 500.00
        ELSE 0.00
    END AS BonusPay,
    ROUND(
        (
            (e.BasePayRate / 26.0) +
            CASE
                WHEN d.DepartmentName IN ('IT','Finance') AND pp.PayPeriodId IN (3,6,9,12)
                    THEN 300.00
                ELSE 0.00
            END
        ) * 0.22,
        2
    ) AS DeductionAmount,
    ROUND(
        (
            (e.BasePayRate / 26.0) +
            CASE
                WHEN d.DepartmentName IN ('IT','Finance') AND pp.PayPeriodId IN (3,6,9,12)
                    THEN 300.00
                ELSE 0.00
            END
        ) +
        CASE
            WHEN e.EmployeeNumber IN ('E1003','E1005','E1009') AND pp.PayPeriodId IN (6,12)
                THEN 500.00
            ELSE 0.00
        END
        -
        (
            (
                (e.BasePayRate / 26.0) +
                CASE
                    WHEN d.DepartmentName IN ('IT','Finance') AND pp.PayPeriodId IN (3,6,9,12)
                        THEN 300.00
                    ELSE 0.00
                END
            ) * 0.22
        ),
        2
    ) AS NetPay,
    pp.CheckDate
FROM hr.Employee e
JOIN hr.PayType pt
    ON e.PayTypeId = pt.PayTypeId
JOIN hr.Department d
    ON e.DepartmentId = d.DepartmentId
JOIN pay.PayPeriod pp
    ON pp.PeriodStartDate >= e.HireDate
   AND (e.TerminationDate IS NULL OR pp.PeriodStartDate <= e.TerminationDate)
JOIN pay.PayrollRun pr
    ON pr.PayPeriodId = pp.PayPeriodId
WHERE pt.PayTypeName = 'Salary';
GO

/*========================================================
  12. UPDATE PAYROLL RUN TOTALS
========================================================*/
UPDATE pr
SET
    TotalEmployeesPaid = x.TotalEmployeesPaid,
    TotalGrossPay = x.TotalGrossPay
FROM pay.PayrollRun pr
JOIN
(
    SELECT
        PayrollRunId,
        COUNT(*) AS TotalEmployeesPaid,
        SUM(GrossPay + BonusPay) AS TotalGrossPay
    FROM pay.PayrollTransaction
    GROUP BY PayrollRunId
) x
    ON pr.PayrollRunId = x.PayrollRunId;
GO

/*========================================================
  13. VALIDATION QUERIES
========================================================*/
SELECT 'hr.Location' AS TableName, COUNT(*) AS RowCount FROM hr.Location
UNION ALL
SELECT 'hr.Department', COUNT(*) FROM hr.Department
UNION ALL
SELECT 'hr.JobTitle', COUNT(*) FROM hr.JobTitle
UNION ALL
SELECT 'hr.PayType', COUNT(*) FROM hr.PayType
UNION ALL
SELECT 'hr.EmployeeStatus', COUNT(*) FROM hr.EmployeeStatus
UNION ALL
SELECT 'hr.Employee', COUNT(*) FROM hr.Employee
UNION ALL
SELECT 'hr.EmployeeJobHistory', COUNT(*) FROM hr.EmployeeJobHistory
UNION ALL
SELECT 'pay.PayPeriod', COUNT(*) FROM pay.PayPeriod
UNION ALL
SELECT 'pay.Timesheet', COUNT(*) FROM pay.Timesheet
UNION ALL
SELECT 'pay.PayrollRun', COUNT(*) FROM pay.PayrollRun
UNION ALL
SELECT 'pay.PayrollTransaction', COUNT(*) FROM pay.PayrollTransaction;
GO

-- Employees by department
SELECT
    d.DepartmentName,
    COUNT(*) AS EmployeeCount
FROM hr.Employee e
JOIN hr.Department d
    ON e.DepartmentId = d.DepartmentId
GROUP BY d.DepartmentName
ORDER BY d.DepartmentName;
GO

-- Overtime by department
SELECT
    d.DepartmentName,
    SUM(ts.OvertimeHours) AS TotalOvertimeHours
FROM pay.Timesheet ts
JOIN hr.Department d
    ON ts.DepartmentId = d.DepartmentId
GROUP BY d.DepartmentName
ORDER BY TotalOvertimeHours DESC;
GO

-- Payroll totals by pay period
SELECT
    pp.PayPeriodId,
    pp.PeriodStartDate,
    pp.PeriodEndDate,
    SUM(pt.GrossPay + pt.BonusPay) AS TotalPayroll
FROM pay.PayrollTransaction pt
JOIN pay.PayPeriod pp
    ON pt.PayPeriodId = pp.PayPeriodId
GROUP BY
    pp.PayPeriodId,
    pp.PeriodStartDate,
    pp.PeriodEndDate
ORDER BY pp.PayPeriodId;
GO