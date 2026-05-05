--CREATE SCHEMA stg;
--GO

-------//////////Stg.Employee----------\\\\\\\\\\\\
CREATE TABLE stg.Employee (
    EmployeeId INT,
    EmployeeNumber VARCHAR(50),
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    HireDate DATE,
    TerminationDate DATE,
    DepartmentId INT,
    JobTitleId INT,
    PayTypeId INT,
    StatusId INT,
    ManagerEmployeeId INT,
    BasePayRate DECIMAL(10,2),
    IsActive BIT,
    CreatedDttm DATETIME,
    ModifiedDttm DATETIME
);


-------//////////Stg.Department----------\\\\\\\\\\\\

CREATE TABLE stg.Department (
    DepartmentId INT,
    DepartmentName VARCHAR(100),
    CostCenter VARCHAR(50),
    LocationId INT
);




-------//////////Stg.JobTitle----------\\\\\\\\\\\\
CREATE TABLE stg.JobTitle (
    JobTitleId INT,
    JobTitleName VARCHAR(100),
    JobLevel INT
);




-------//////////Stg.Location----------\\\\\\\\\\\\
CREATE TABLE stg.Location (
    LocationId INT,
    LocationName VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(50),
    Region VARCHAR(50)
);


-------//////////Stg.PayPeriod----------\\\\\\\\\\\\
CREATE TABLE stg.PayPeriod (
    PayPeriodId INT,
    PeriodStartDate DATE,
    PeriodEndDate DATE,
    CheckDate DATE,
    PayrollMonth INT,
    PayrollYear INT
);


-------//////////Stg.Timesheet----------\\\\\\\\\\\\

CREATE TABLE stg.Timesheet (
    TimesheetId INT,
    EmployeeId INT,
    WorkDate DATE,
    RegularHours DECIMAL(5,2),
    OvertimeHours DECIMAL(5,2),
    DepartmentId INT,
    ApprovedFlag BIT,
    CreatedDttm DATETIME
);


-------//////////Stg.PayrollTransactions----------\\\\\\\\\\\\
CREATE TABLE stg.PayrollTransaction (
    PayrollTransactionId INT,
    PayrollRunId INT,
    EmployeeId INT,
    PayPeriodId INT,
    RegularHours DECIMAL(5,2),
    OvertimeHours DECIMAL(5,2),
    BasePayRate DECIMAL(10,2),
    OvertimePayRate DECIMAL(10,2),
    GrossPay DECIMAL(12,2),
    BonusPay DECIMAL(12,2),
    DeductionAmount DECIMAL(12,2),
    NetPay DECIMAL(12,2),
    PaymentDate DATE
);





-------//////////Stg.EmployeeJobHistory----------\\\\\\\\\\\\


CREATE TABLE stg.EmployeeJobHistory (
    EmployeeJobHistoryId INT,
    EmployeeId INT,
    DepartmentId INT,
    JobTitleId INT,
    BasePayRate DECIMAL(10,2),
    EffectiveStartDate DATE,
    EffectiveEndDate DATE,
    IsCurrent BIT
);




-------//////////Stg.EmployeeStatus----------\\\\\\\\\\\\


CREATE TABLE stg.EmployeeStatus (
    StatusId INT IDENTITY PRIMARY KEY,
    StatusName VARCHAR(50)
);



-------//////////Stg.PayType----------\\\\\\\\\\\\

CREATE TABLE stg.PayType (
    PayTypeId INT IDENTITY PRIMARY KEY,
    PayTypeName VARCHAR(50)
);
