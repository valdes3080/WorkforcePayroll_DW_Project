
/*========================================================
  13. VALIDATION QUERIES
========================================================*/
SELECT 'hr.Location' AS TableName, COUNT(*) AS [RowCount] FROM hr.Location
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