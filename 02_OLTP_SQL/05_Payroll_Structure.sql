


--- Payroll Structure

--pay.PayPeriod Table

CREATE TABLE pay.PayPeriod (
    PayPeriodId INT IDENTITY PRIMARY KEY,
    PeriodStartDate DATE,
    PeriodEndDate DATE,
    CheckDate DATE,
    PayrollMonth INT,
    PayrollYear INT
);



--pay.Timesheet Table
CREATE TABLE pay.Timesheet (
    TimesheetId INT IDENTITY PRIMARY KEY,
    EmployeeId INT,
    WorkDate DATE,
    RegularHours DECIMAL(5,2),
    OvertimeHours DECIMAL(5,2),
    DepartmentId INT,
    ApprovedFlag BIT,
    CreatedDttm DATETIME
);


---ADD FKs

ALTER TABLE pay.Timesheet
ADD CONSTRAINT FK_Timesheet_Employee FOREIGN KEY (EmployeeId)
REFERENCES hr.Employee(EmployeeId);

ALTER TABLE pay.Timesheet
ADD CONSTRAINT FK_Timesheet_Department FOREIGN KEY (DepartmentId)
REFERENCES hr.Department(DepartmentId);



--payPayrollRun Table
CREATE TABLE pay.PayrollRun (
    PayrollRunId INT IDENTITY PRIMARY KEY,
    PayPeriodId INT,
    RunDate DATE,
    RunStatus VARCHAR(50),
    TotalEmployeesPaid INT,
    TotalGrossPay DECIMAL(12,2)
);



--pay.PayrollTransaction (CORE FACT-LIKE TABLE)
CREATE TABLE pay.PayrollTransaction (
    PayrollTransactionId INT IDENTITY PRIMARY KEY,
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


--Add FK's
ALTER TABLE pay.PayrollTransaction
ADD CONSTRAINT FK_PayrollTransaction_Employee FOREIGN KEY (EmployeeId)
REFERENCES hr.Employee(EmployeeId);

ALTER TABLE pay.PayrollTransaction
ADD CONSTRAINT FK_PayrollTransaction_PayPeriod FOREIGN KEY (PayPeriodId)
REFERENCES pay.PayPeriod(PayPeriodId);

ALTER TABLE pay.PayrollTransaction
ADD CONSTRAINT FK_PayrollTransaction_Run FOREIGN KEY (PayrollRunId)
REFERENCES pay.PayrollRun(PayrollRunId);