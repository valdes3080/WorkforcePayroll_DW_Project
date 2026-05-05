/* FACT PAYROLL VALIDATION */

-- 1. Row count check
SELECT
    (SELECT COUNT(*) FROM stg.vPayrollTransaction_Clean) AS StagingPayrollRows,
    (SELECT COUNT(*) FROM dw.FactPayroll) AS FactPayrollRows;

-- 2. Total amount check
SELECT
    'Staging' AS SourceLayer,
    SUM(GrossPay) AS TotalGrossPay,
    SUM(BonusPay) AS TotalBonusPay,
    SUM(DeductionAmount) AS TotalDeductions,
    SUM(NetPay) AS TotalNetPay
FROM stg.vPayrollTransaction_Clean

UNION ALL

SELECT
    'Warehouse',
    SUM(GrossPay),
    SUM(BonusPay),
    SUM(DeductionAmount),
    SUM(NetPay)
FROM dw.FactPayroll;

-- 3. Missing dimension key check
SELECT *
FROM dw.FactPayroll
WHERE EmployeeKey IS NULL
   OR DepartmentKey IS NULL
   OR JobTitleKey IS NULL
   OR PayTypeKey IS NULL
   OR PayDateKey IS NULL;

-- 4. Failed dimension joins
SELECT f.*
FROM dw.FactPayroll f
LEFT JOIN dw.DimEmployee e
    ON f.EmployeeKey = e.EmployeeKey
LEFT JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
LEFT JOIN dw.DimJobTitle jt
    ON f.JobTitleKey = jt.JobTitleKey
LEFT JOIN dw.DimPayType pt
    ON f.PayTypeKey = pt.PayTypeKey
LEFT JOIN dw.DimDate dt
    ON f.PayDateKey = dt.DateKey
WHERE e.EmployeeKey IS NULL
   OR d.DepartmentKey IS NULL
   OR jt.JobTitleKey IS NULL
   OR pt.PayTypeKey IS NULL
   OR dt.DateKey IS NULL;

-- 5. Payroll by department
SELECT
    d.DepartmentName,
    SUM(f.GrossPay) AS TotalGrossPay,
    SUM(f.NetPay) AS TotalNetPay
FROM dw.FactPayroll f
JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
GROUP BY d.DepartmentName
ORDER BY TotalGrossPay DESC;

-- 6. Overtime by department
SELECT
    d.DepartmentName,
    SUM(f.OvertimeHours) AS TotalOvertimeHours
FROM dw.FactPayroll f
JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
GROUP BY d.DepartmentName
ORDER BY TotalOvertimeHours DESC;

-- 7. Payroll trend by month
SELECT
    dt.Year,
    dt.Month,
    dt.MonthName,
    SUM(f.GrossPay) AS TotalGrossPay,
    SUM(f.NetPay) AS TotalNetPay
FROM dw.FactPayroll f
JOIN dw.DimDate dt
    ON f.PayDateKey = dt.DateKey
GROUP BY dt.Year, dt.Month, dt.MonthName
ORDER BY dt.Year, dt.Month;