
---Load DimDate

TRUNCATE TABLE dw.DimDate;
GO

DECLARE @StartDate DATE = '2025-01-01';
DECLARE @EndDate   DATE = '2026-12-31';

;WITH DateSeries AS
(
    SELECT @StartDate AS [Date]
    UNION ALL
    SELECT DATEADD(DAY, 1, [Date])
    FROM DateSeries
    WHERE [Date] < @EndDate
)
INSERT INTO dw.DimDate
(
    DateKey,
    [Date],
    [Year],
    [Quarter],
    [Month],
    MonthName,
    [Day],
    DayName,
    IsWeekend
)
SELECT
    CAST(CONVERT(CHAR(8), [Date], 112) AS INT) AS DateKey,
    [Date],
    YEAR([Date]) AS [Year],
    DATEPART(QUARTER, [Date]) AS [Quarter],
    MONTH([Date]) AS [Month],
    DATENAME(MONTH, [Date]) AS MonthName,
    DAY([Date]) AS [Day],
    DATENAME(WEEKDAY, [Date]) AS DayName,
    CASE
        WHEN DATENAME(WEEKDAY, [Date]) IN ('Saturday', 'Sunday') THEN 1
        ELSE 0
    END AS IsWeekend
FROM DateSeries
OPTION (MAXRECURSION 0);
GO

-----//////////////---------


---///Load DimDepartment

INSERT INTO dw.DimDepartment
(
    DepartmentId,
    DepartmentName,
    CostCenter,
    LocationName,
    Region
)
SELECT
    d.DepartmentId,
    d.DepartmentName,
    d.CostCenter,
    l.LocationName,
    l.Region
FROM stg.vDepartment_Clean d
LEFT JOIN stg.vLocation_Clean l
    ON d.LocationId = l.LocationId;
GO



---///Load dw.DimJobTitle

INSERT INTO dw.DimJobTitle
(
    JobTitleId,
    JobTitleName,
    JobLevel
)
SELECT
    JobTitleId,
    JobTitleName,
    JobLevel
FROM stg.vJobTitle_Clean;
GO



---/// Load dw.DimPayType

INSERT INTO dw.DimPayType
(
    PayTypeId,
    PayTypeName
)
SELECT
    PayTypeId,
    PayTypeName
FROM stg.vPayType_Clean;
GO


---/// Load dw.DimEmployee

INSERT INTO dw.DimEmployee
(
    EmployeeId,
    EmployeeNumber,
    FullName,
    DepartmentName,
    JobTitleName,
    PayTypeName,
    StatusName,
    ManagerName,
    BasePayRate,
    IsActive
)
SELECT
    e.EmployeeId,
    e.EmployeeNumber,
    e.FullName,
    d.DepartmentName,
    jt.JobTitleName,
    pt.PayTypeName,
    es.StatusName,
    mgr.FullName AS ManagerName,
    e.BasePayRate,
    e.IsActive
FROM stg.vEmployee_Clean e
LEFT JOIN stg.vDepartment_Clean d
    ON e.DepartmentId = d.DepartmentId
LEFT JOIN stg.vJobTitle_Clean jt
    ON e.JobTitleId = jt.JobTitleId
LEFT JOIN stg.vPayType_Clean pt
    ON e.PayTypeId = pt.PayTypeId
LEFT JOIN stg.vEmployeeStatus_Clean es
    ON e.StatusId = es.StatusId
LEFT JOIN stg.vEmployee_Clean mgr
    ON e.ManagerEmployeeId = mgr.EmployeeId;
GO









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



