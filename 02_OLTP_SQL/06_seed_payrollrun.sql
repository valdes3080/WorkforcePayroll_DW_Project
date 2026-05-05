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