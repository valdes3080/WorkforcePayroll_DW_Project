/* 11_etl_log_table_and_logging.sql */

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'etl')
BEGIN
    EXEC('CREATE SCHEMA etl');
END;
GO

IF OBJECT_ID('etl.ETL_RunLog', 'U') IS NULL
BEGIN
    CREATE TABLE etl.ETL_RunLog (
        RunId INT IDENTITY(1,1) PRIMARY KEY,
        PackageName VARCHAR(100),
        StartTime DATETIME,
        EndTime DATETIME,
        Status VARCHAR(20),
        RowsLoaded INT,
        ErrorMessage VARCHAR(MAX)
    );
END;
GO

/* MASTER_LOAD START */
INSERT INTO etl.ETL_RunLog (PackageName, StartTime, Status)
VALUES ('Master_Load', GETDATE(), 'STARTED');

/* MASTER_LOAD SUCCESS */
UPDATE etl.ETL_RunLog
SET EndTime = GETDATE(),
    Status = 'SUCCESS',
    RowsLoaded = (
        SELECT SUM(RowsLoaded)
        FROM etl.ETL_RunLog
        WHERE PackageName IN (
            'Load_Staging_From_OLTP',
            'Load_Dimensions',
            'Load_FactPayroll'
        )
        AND Status = 'SUCCESS'
    ),
    ErrorMessage = NULL
WHERE RunId = (
    SELECT MAX(RunId)
    FROM etl.ETL_RunLog
    WHERE PackageName = 'Master_Load'
      AND Status = 'STARTED'
);

/* LOAD_STAGING_FROM_OLTP START */
INSERT INTO etl.ETL_RunLog (PackageName, StartTime, Status)
VALUES ('Load_Staging_From_OLTP', GETDATE(), 'STARTED');

/* LOAD_STAGING_FROM_OLTP SUCCESS */
UPDATE etl.ETL_RunLog
SET EndTime = GETDATE(),
    Status = 'SUCCESS',
    RowsLoaded =
        (SELECT COUNT(*) FROM stg.Location)
      + (SELECT COUNT(*) FROM stg.Department)
      + (SELECT COUNT(*) FROM stg.JobTitle)
      + (SELECT COUNT(*) FROM stg.EmployeeStatus)
      + (SELECT COUNT(*) FROM stg.PayType)
      + (SELECT COUNT(*) FROM stg.Employee)
      + (SELECT COUNT(*) FROM stg.PayPeriod)
      + (SELECT COUNT(*) FROM stg.Timesheet)
      + (SELECT COUNT(*) FROM stg.PayrollTransaction)
      + (SELECT COUNT(*) FROM stg.EmployeeJobHistory),
    ErrorMessage = NULL
WHERE RunId = (
    SELECT MAX(RunId)
    FROM etl.ETL_RunLog
    WHERE PackageName = 'Load_Staging_From_OLTP'
      AND Status = 'STARTED'
);

/* LOAD_DIMENSIONS START */
INSERT INTO etl.ETL_RunLog (PackageName, StartTime, Status)
VALUES ('Load_Dimensions', GETDATE(), 'STARTED');

/* LOAD_DIMENSIONS SUCCESS */
UPDATE etl.ETL_RunLog
SET EndTime = GETDATE(),
    Status = 'SUCCESS',
    RowsLoaded =
        (SELECT COUNT(*) FROM dw.DimDate)
      + (SELECT COUNT(*) FROM dw.DimDepartment)
      + (SELECT COUNT(*) FROM dw.DimJobTitle)
      + (SELECT COUNT(*) FROM dw.DimPayType)
      + (SELECT COUNT(*) FROM dw.DimEmployee),
    ErrorMessage = NULL
WHERE RunId = (
    SELECT MAX(RunId)
    FROM etl.ETL_RunLog
    WHERE PackageName = 'Load_Dimensions'
      AND Status = 'STARTED'
);

/* LOAD_FACTPAYROLL START */
INSERT INTO etl.ETL_RunLog (PackageName, StartTime, Status)
VALUES ('Load_FactPayroll', GETDATE(), 'STARTED');

/* LOAD_FACTPAYROLL SUCCESS */
UPDATE etl.ETL_RunLog
SET EndTime = GETDATE(),
    Status = 'SUCCESS',
    RowsLoaded = (SELECT COUNT(*) FROM dw.FactPayroll),
    ErrorMessage = NULL
WHERE RunId = (
    SELECT MAX(RunId)
    FROM etl.ETL_RunLog
    WHERE PackageName = 'Load_FactPayroll'
      AND Status = 'STARTED'
);