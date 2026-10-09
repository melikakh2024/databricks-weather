
CREATE OR REFRESH STREAMING TABLE declarative_bronze_years
AS
SELECT
    _metadata.file_path AS filepath,
    _metadata.file_modification_time AS modificationtime,
    current_timestamp() AS ingesttime,
    *
FROM STREAM read_files(
    "/Volumes/workspace/default/weatherproject/year/*.csv.gz",
    format => "csv",
    header => false,
    schema => "ID STRING, DATE STRING, ELEMENT STRING, DATA_VALUE STRING, M_FLAG STRING, Q_FLAG STRING, S_FLAG STRING, OBS_TIME STRING"
);
create or refresh MATERIALIZED view declarative_bronze_stations
as 
select 
_metadata.file_name as file_name,
_metadata.file_modification_time as file_modification_time,
    current_timestamp() as ingestion_time,
    TRIM(SUBSTRING(value, 1, 11))  AS ID,
    TRIM(SUBSTRING(value, 13, 8))  AS LATITUDE,
    TRIM(SUBSTRING(value, 22, 9))  AS LONGITUDE,
    TRIM(SUBSTRING(value, 32, 6))  AS ELEVATION,
    TRIM(SUBSTRING(value, 39, 2))  AS STATE,
    TRIM(SUBSTRING(value, 42, 30)) AS NAME,
    TRIM(SUBSTRING(value, 73, 3))  AS GSN_FLAG,
    TRIM(SUBSTRING(value, 77, 3))  AS HCN_CRN_FLAG,
    TRIM(SUBSTRING(value, 81, 5))  AS WMO_ID
FROM read_files(
    "/Volumes/workspace/default/weatherproject/stations.txt",
    format => "text");

CREATE OR REFRESH MATERIALIZED VIEW declarative_bronze_countries
AS
SELECT
    _metadata.file_path AS filepath,
    _metadata.file_modification_time AS modificationtime,
    current_timestamp() AS ingesttime,
    TRIM(SUBSTRING(value, 1, 2)) AS CODE,
    TRIM(SUBSTRING(value, 4, 100)) AS NAME
FROM read_files(
    "/Volumes/workspace/default/weatherproject/countries.txt",
    format => "text"
);