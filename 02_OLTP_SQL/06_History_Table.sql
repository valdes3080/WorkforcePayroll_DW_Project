


---History Table

--hr.EmployeeJobHistory
CREATE TABLE hr.EmployeeJobHistory (
    EmployeeJobHistoryId INT IDENTITY PRIMARY KEY,
    EmployeeId INT,
    DepartmentId INT,
    JobTitleId INT,
    BasePayRate DECIMAL(10,2),
    EffectiveStartDate DATE,
    EffectiveEndDate DATE,
    IsCurrent BIT
);


---Add FKs:

ALTER TABLE hr.EmployeeJobHistory
ADD CONSTRAINT FK_JobHistory_Employee FOREIGN KEY (EmployeeId)
REFERENCES hr.Employee(EmployeeId);

ALTER TABLE hr.EmployeeJobHistory
ADD CONSTRAINT FK_JobHistory_Department FOREIGN KEY (DepartmentId)
REFERENCES hr.Department(DepartmentId);

ALTER TABLE hr.EmployeeJobHistory
ADD CONSTRAINT FK_JobHistory_JobTitle FOREIGN KEY (JobTitleId)
REFERENCES hr.JobTitle(JobTitleId);