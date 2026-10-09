create or refresh streaming table declarative_silver_years
(
constraint valid_filepath    expect(filepath is not null),
constraint valid_id          expect(ID is not null),
constraint valid_date        expect(date between '2024-01-01' and '2025-12-31'),
constraint valid_date_n      expect (date is not null),
constraint valid_datavalue   expect(data_value is not null),
constraint valid_element     expect(element is not null)
)
as 
select
filepath,
modificationtime,
ingesttime,
ID,
to_date(date,'yyyyMMdd') as date,
element,
try_cast( data_value as integer)  as data_value
from  STREAM(workspace.declarative_bronze.declarative_bronze_years)
;


create or refresh materialized view declarative_silver_countries
(
    constraint valid_pathfile expect(filepath is not null),
    constraint valid_code     expect(code is not null),
    constraint valid_name    expect(name is not null)
)
as
select
filepath,
modificationtime,
ingesttime,
code,
name
from workspace.declarative_bronze.declarative_bronze_countries
where code in ('AU','AS','GM')

;
create or refresh materialized view declarative_silver_stations
(
    constraint valid_pathfile_station  expect(file_name is not null),
    constraint valid_id_station      expect(id is not null),
    constraint valid_latitude    expect(latitude is not null),
    constraint valid_longitude      expect(longitude is not null),
    constraint valid_elevation   expect(elevation is not null)
)
as
select
file_name,
file_modification_time,
ingestion_time,
id,
try_cast(latitude as double) as latitude,
try_cast(longitude as double) as longitude,
try_cast(elevation as int) as elevation
from workspace.declarative_bronze.declarative_bronze_stations