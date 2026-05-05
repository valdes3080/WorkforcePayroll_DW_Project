create schema etl



CREATE TABLE etl.ETL_RunLog (
    RunId INT IDENTITY(1,1),
    PackageName VARCHAR(100),
    StartTime DATETIME,
    EndTime DATETIME,
    Status VARCHAR(20),
    RowsLoaded INT,
    ErrorMessage VARCHAR(MAX)
);