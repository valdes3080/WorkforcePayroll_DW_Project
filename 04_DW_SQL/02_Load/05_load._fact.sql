-----/// Load Dw.FactPayroll


INSERT INTO dw.FactPayroll
(
    EmployeeKey,
    DepartmentKey,
    JobTitleKey,
    PayTypeKey,
    PayDateKey,
    RegularHours,
    OvertimeHours,
    GrossPay,
    BonusPay,
    DeductionAmount,
    NetPay
)
SELECT
    de.EmployeeKey,
    dd.DepartmentKey,
    djt.JobTitleKey,
    dpt.PayTypeKey,
    ddte.DateKey,
    p.RegularHours,
    p.OvertimeHours,
    p.GrossPay,
    p.BonusPay,
    p.DeductionAmount,
    p.NetPay
FROM stg.vPayrollTransaction_Clean p
JOIN dw.DimEmployee de
    ON p.EmployeeId = de.EmployeeId
JOIN dw.DimDepartment dd
    ON de.DepartmentName = dd.DepartmentName
JOIN dw.DimJobTitle djt
    ON de.JobTitleName = djt.JobTitleName
JOIN dw.DimPayType dpt
    ON de.PayTypeName = dpt.PayTypeName
JOIN dw.DimDate ddte
    ON p.PaymentDate = ddte.[Date];
GO



