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