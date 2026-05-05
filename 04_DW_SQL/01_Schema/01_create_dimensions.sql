--CREATE SCHEMA dw;
--GO


--DW.DimDate

CREATE TABLE dw.DimDate (
    DateKey INT PRIMARY KEY,
    Date DATE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName VARCHAR(20),
    Day INT,
    DayName VARCHAR(20),
    IsWeekend BIT
);


--DW.DimDepartment
CREATE TABLE dw.DimDepartment (
    DepartmentKey INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentId INT,
    DepartmentName VARCHAR(100),
    CostCenter VARCHAR(50),
    LocationName VARCHAR(100),
    Region VARCHAR(50)
);



--DW.DimJobTitle
CREATE TABLE dw.DimJobTitle (
    JobTitleKey INT IDENTITY(1,1) PRIMARY KEY,
    JobTitleId INT,
    JobTitleName VARCHAR(100),
    JobLevel INT
);



--DW.DimPayType
CREATE TABLE dw.DimPayType (
    PayTypeKey INT IDENTITY(1,1) PRIMARY KEY,
    PayTypeId INT,
    PayTypeName VARCHAR(50)
);






--DW.DimEmployee

CREATE TABLE dw.DimEmployee (
    EmployeeKey INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeId INT,
    EmployeeNumber VARCHAR(50),
    FullName VARCHAR(200),
    DepartmentName VARCHAR(100),
    JobTitleName VARCHAR(100),
    PayTypeName VARCHAR(50),
    StatusName VARCHAR(50),
    ManagerName VARCHAR(200),
    BasePayRate DECIMAL(10,2),
    IsActive BIT
);



--DW.FactTable
CREATE TABLE dw.FactPayroll (
    PayrollFactId INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeKey INT,
    DepartmentKey INT,
    JobTitleKey INT,
    PayTypeKey INT,
    PayDateKey INT,

    RegularHours DECIMAL(10,2),
    OvertimeHours DECIMAL(10,2),
    GrossPay DECIMAL(12,2),
    BonusPay DECIMAL(12,2),
    DeductionAmount DECIMAL(12,2),
    NetPay DECIMAL(12,2)
);



