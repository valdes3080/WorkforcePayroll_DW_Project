
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