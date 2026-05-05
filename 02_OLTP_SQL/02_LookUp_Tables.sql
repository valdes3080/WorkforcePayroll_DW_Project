

--Lookup tables:


---HR Department Table


CREATE TABLE hr.Department (
    DepartmentId INT IDENTITY PRIMARY KEY,
    DepartmentName VARCHAR(100),
    CostCenter VARCHAR(50),
    LocationId INT
);

---HR Job Title Table
CREATE TABLE hr.JobTitle (
    JobTitleId INT IDENTITY PRIMARY KEY,
    JobTitleName VARCHAR(100),
    JobLevel INT
);


--- HR Paytype Table

CREATE TABLE hr.PayType (
    PayTypeId INT IDENTITY PRIMARY KEY,
    PayTypeName VARCHAR(50)
);


--- HR Emplyee Status Table

CREATE TABLE hr.EmployeeStatus (
    StatusId INT IDENTITY PRIMARY KEY,
    StatusName VARCHAR(50)
);



--- HR Location
CREATE TABLE hr.Location (
    LocationId INT IDENTITY PRIMARY KEY,
    LocationName VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(50),
    Region VARCHAR(50)
);


--Add FK

CREATE NONCLUSTERED INDEX IX_Department_LocationId
ON hr.Department(LocationId);