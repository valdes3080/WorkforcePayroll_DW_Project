



--Run Check---
SELECT COUNT(*) FROM stg.Employee;
SELECT COUNT(*) FROM stg.vEmployee_Clean;

SELECT COUNT(*) FROM stg.Timesheet;
SELECT COUNT(*) FROM stg.vTimesheet_Clean;

SELECT COUNT(*) FROM stg.PayrollTransaction;
SELECT COUNT(*) FROM stg.vPayrollTransaction_Clean;



--Quality Check--
SELECT * FROM stg.vEmployee_Clean WHERE EmployeeNumber IS NULL;

SELECT * FROM stg.vTimesheet_Clean
WHERE RegularHours < 0 OR OvertimeHours < 0;

SELECT EmployeeId, COUNT(*)
FROM stg.vEmployeeJobHistory_Clean
WHERE IsCurrent = 1
GROUP BY EmployeeId
HAVING COUNT(*) > 1;