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
