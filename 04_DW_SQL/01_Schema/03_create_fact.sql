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