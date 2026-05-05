/* 08_end_to_end_validation.sql */

-- 1. Confirm main tables have rows
SELECT 'DimEmployee' AS TableName, COUNT(*) AS RowCount FROM dw.DimEmployee
UNION ALL
SELECT 'DimDepartment', COUNT(*) FROM dw.DimDepartment
UNION ALL
SELECT 'DimJobTitle', COUNT(*) FROM dw.DimJobTitle
UNION ALL
SELECT 'DimPayType', COUNT(*) FROM dw.DimPayType
UNION ALL
SELECT 'DimDate', COUNT(*) FROM dw.DimDate
UNION ALL
SELECT 'FactPayroll', COUNT(*) FROM dw.FactPayroll;

-- 2. Confirm fact row count matches staging payroll
SELECT
    (SELECT COUNT(*) FROM stg.vPayrollTransaction_Clean) AS StagingPayrollRows,
    (SELECT COUNT(*) FROM dw.FactPayroll) AS FactPayrollRows;

-- 3. Confirm staging totals match warehouse totals
SELECT
    'Staging' AS SourceLayer,
    SUM(GrossPay) AS TotalGrossPay,
    SUM(NetPay) AS TotalNetPay
FROM stg.vPayrollTransaction_Clean

UNION ALL

SELECT
    'Warehouse',
    SUM(GrossPay),
    SUM(NetPay)
FROM dw.FactPayroll;

-- 4. Confirm no broken dimension keys
SELECT *
FROM dw.FactPayroll f
LEFT JOIN dw.DimEmployee e ON f.EmployeeKey = e.EmployeeKey
LEFT JOIN dw.DimDepartment d ON f.DepartmentKey = d.DepartmentKey
LEFT JOIN dw.DimJobTitle jt ON f.JobTitleKey = jt.JobTitleKey
LEFT JOIN dw.DimPayType pt ON f.PayTypeKey = pt.PayTypeKey
LEFT JOIN dw.DimDate dt ON f.PayDateKey = dt.DateKey
WHERE e.EmployeeKey IS NULL
   OR d.DepartmentKey IS NULL
   OR jt.JobTitleKey IS NULL
   OR pt.PayTypeKey IS NULL
   OR dt.DateKey IS NULL;

-- 5. Confirm ETL run log looks correct
SELECT *
FROM etl.ETL_RunLog
ORDER BY RunId DESC;

-- 6. Final business output check
SELECT
    d.DepartmentName,
    SUM(f.GrossPay) AS TotalGrossPay,
    SUM(f.NetPay) AS TotalNetPay,
    SUM(f.OvertimeHours) AS TotalOvertimeHours
FROM dw.FactPayroll f
JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
GROUP BY d.DepartmentName
ORDER BY TotalGrossPay DESC;