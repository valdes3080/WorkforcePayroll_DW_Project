/* 12_etl_validation_failures.sql */

/* MASTER_LOAD FAILURE */
UPDATE etl.ETL_RunLog
SET EndTime = GETDATE(),
    Status = 'FAILED',
    ErrorMessage = 'Master_Load package failed.'
WHERE RunId = (
    SELECT MAX(RunId)
    FROM etl.ETL_RunLog
    WHERE PackageName = 'Master_Load'
      AND Status = 'STARTED'
);

/* LOAD_STAGING_FROM_OLTP FAILURE */
UPDATE etl.ETL_RunLog
SET EndTime = GETDATE(),
    Status = 'FAILED',
    ErrorMessage = 'Load_Staging_From_OLTP package failed.'
WHERE RunId = (
    SELECT MAX(RunId)
    FROM etl.ETL_RunLog
    WHERE PackageName = 'Load_Staging_From_OLTP'
      AND Status = 'STARTED'
);

/* LOAD_DIMENSIONS FAILURE */
UPDATE etl.ETL_RunLog
SET EndTime = GETDATE(),
    Status = 'FAILED',
    ErrorMessage = 'Load_Dimensions package failed.'
WHERE RunId = (
    SELECT MAX(RunId)
    FROM etl.ETL_RunLog
    WHERE PackageName = 'Load_Dimensions'
      AND Status = 'STARTED'
);

/* LOAD_FACTPAYROLL FAILURE */
UPDATE etl.ETL_RunLog
SET EndTime = GETDATE(),
    Status = 'FAILED',
    ErrorMessage = 'Load_FactPayroll package failed.'
WHERE RunId = (
    SELECT MAX(RunId)
    FROM etl.ETL_RunLog
    WHERE PackageName = 'Load_FactPayroll'
      AND Status = 'STARTED'
);