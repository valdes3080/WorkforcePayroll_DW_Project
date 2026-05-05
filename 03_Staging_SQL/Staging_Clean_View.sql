


--///vEmployee_Clean view
CREATE VIEW stg.vEmployee_Clean AS
SELECT
    EmployeeId,
    LTRIM(RTRIM(EmployeeNumber)) AS EmployeeNumber,
    LTRIM(RTRIM(FirstName)) AS FirstName,
    LTRIM(RTRIM(LastName)) AS LastName,
    LTRIM(RTRIM(FirstName)) + ' ' + LTRIM(RTRIM(LastName)) AS FullName,
    HireDate,
    TerminationDate,
    DepartmentId,
    JobTitleId,
    PayTypeId,
    StatusId,
    ManagerEmployeeId,
    BasePayRate,
    IsActive,
    CreatedDttm,
    ModifiedDttm
FROM stg.Employee;
GO

--///vDepartment_Clean view

CREATE VIEW stg.vDepartment_Clean AS
SELECT
    DepartmentId,
    LTRIM(RTRIM(DepartmentName)) AS DepartmentName,
    LTRIM(RTRIM(CostCenter)) AS CostCenter,
    LocationId
FROM stg.Department;
GO


--///vJobTitle_Clean view
CREATE VIEW stg.vJobTitle_Clean AS
SELECT
    JobTitleId,
    LTRIM(RTRIM(JobTitleName)) AS JobTitleName,
    JobLevel
FROM stg.JobTitle
GO





--///vLocation_Clean view

CREATE VIEW stg.vLocation_Clean AS
SELECT
    LocationId,
    LTRIM(RTRIM(LocationName)) AS LocationName,
    LTRIM(RTRIM(City)) AS City,
    LTRIM(RTRIM(State)) AS State,
    LTRIM(RTRIM(Region)) AS Region
FROM stg.Location;
GO









--///EmployeeStatus_Clean view


CREATE VIEW stg.vEmployeeStatus_Clean AS
SELECT
    StatusId,
    LTRIM(RTRIM(StatusName)) AS StatusName
FROM stg.EmployeeStatus;
GO





--///_vPayType_Clean view
CREATE VIEW stg.vPayType_Clean AS
SELECT
    PayTypeId,
    LTRIM(RTRIM(PayTypeName)) AS PayTypeName
FROM stg.PayType;
GO




--///_vPayType_Period view
CREATE VIEW stg.vPayPeriod_Clean AS
SELECT
    PayPeriodId,
    PeriodStartDate,
    PeriodEndDate,
    CheckDate,
    PayrollMonth,
    PayrollYear
FROM stg.PayPeriod;
GO







--///_vTimesheet_Clean view


CREATE VIEW stg.vTimesheet_Clean AS
SELECT
    TimesheetId,
    EmployeeId,
    WorkDate,
    ISNULL(RegularHours, 0.00) AS RegularHours,
    ISNULL(OvertimeHours, 0.00) AS OvertimeHours,
    DepartmentId,
    ApprovedFlag,
    CreatedDttm
FROM stg.Timesheet
WHERE ApprovedFlag = 1;
GO

















--///_vPayrollTransaction_Clean view


CREATE VIEW stg.vPayrollTransaction_Clean AS
SELECT
    PayrollTransactionId,
    PayrollRunId,
    EmployeeId,
    PayPeriodId,
    ISNULL(RegularHours, 0.00) AS RegularHours,
    ISNULL(OvertimeHours, 0.00) AS OvertimeHours,
    ISNULL(BasePayRate, 0.00) AS BasePayRate,
    ISNULL(OvertimePayRate, 0.00) AS OvertimePayRate,
    ISNULL(GrossPay, 0.00) AS GrossPay,
    ISNULL(BonusPay, 0.00) AS BonusPay,
    ISNULL(DeductionAmount, 0.00) AS DeductionAmount,
    ISNULL(NetPay, 0.00) AS NetPay,
    PaymentDate
FROM stg.PayrollTransaction;
GO







--///_vEmployeeJobHistory_Clean view



CREATE VIEW stg.vEmployeeJobHistory_Clean AS
SELECT
    EmployeeJobHistoryId,
    EmployeeId,
    DepartmentId,
    JobTitleId,
    BasePayRate,
    EffectiveStartDate,
    EffectiveEndDate,
    ISNULL(IsCurrent, 0) AS IsCurrent
FROM stg.EmployeeJobHistory;
GO