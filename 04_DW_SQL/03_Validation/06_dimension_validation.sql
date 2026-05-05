---//validate dw.DimDate



SELECT MIN([Date]), MAX([Date]), COUNT(*)
FROM dw.DimDate;




---///validate clean_views

SELECT COUNT(*) FROM stg.vDepartment_Clean;
SELECT COUNT(*) FROM stg.vJobTitle_Clean;
SELECT COUNT(*) FROM stg.vPayType_Clean;
SELECT COUNT(*) FROM stg.vEmployee_Clean;



---///validate dw.DimDepartment

SELECT * FROM dw.DimDepartment;
SELECT COUNT(*) FROM dw.DimDepartment;



---///validate dw.DimJobTitle


SELECT * FROM dw.DimJobTitle;
SELECT COUNT(*) FROM dw.DimJobTitle;




---/// validate dw.DimPayType

SELECT * FROM dw.DimPayType;
SELECT COUNT(*) FROM dw.DimPayType;



---/// validate dw.DimEmployee

SELECT TOP 20 *
FROM dw.DimEmployee;


SELECT COUNT(*) FROM dw.DimEmployee;

SELECT PayTypeName, COUNT(*)
FROM dw.DimEmployee
GROUP BY PayTypeName;

SELECT DepartmentName, COUNT(*)
FROM dw.DimEmployee
GROUP BY DepartmentName;

SELECT StatusName, COUNT(*)
FROM dw.DimEmployee
GROUP BY StatusName;





-------//// Validate dw.FactPayroll


SELECT COUNT(*) AS StagingPayrollRows
FROM stg.vPayrollTransaction_Clean;

SELECT COUNT(*) AS FactPayrollRows
FROM dw.FactPayroll;