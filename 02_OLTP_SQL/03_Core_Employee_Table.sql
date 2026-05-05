


---HR Employee Table

CREATE TABLE hr.Employee (
    EmployeeId INT IDENTITY PRIMARY KEY,
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