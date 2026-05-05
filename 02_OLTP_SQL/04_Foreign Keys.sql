
---Add FKs


ALTER TABLE hr.Employee
ADD CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentId)
REFERENCES hr.Department(DepartmentId);

ALTER TABLE hr.Employee
ADD CONSTRAINT FK_Employee_JobTitle FOREIGN KEY (JobTitleId)
REFERENCES hr.JobTitle(JobTitleId);

ALTER TABLE hr.Employee
ADD CONSTRAINT FK_Employee_PayType FOREIGN KEY (PayTypeId)
REFERENCES hr.PayType(PayTypeId);

ALTER TABLE hr.Employee
ADD CONSTRAINT FK_Employee_Status FOREIGN KEY (StatusId)
REFERENCES hr.EmployeeStatus(StatusId);

ALTER TABLE hr.Employee
ADD CONSTRAINT FK_Employee_Manager FOREIGN KEY (ManagerEmployeeId)
REFERENCES hr.Employee(EmployeeId);