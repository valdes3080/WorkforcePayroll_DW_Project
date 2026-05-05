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