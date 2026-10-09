
{{ config(materialized='table') }}

with t as ({{
dbt_utils.date_spine(
    datepart='day',
    start_date="cast('2024-01-01' as date)",
    end_date="cast('2025-12-31' as date)"
)}}

)
select

date_day as date,
year(date_day) as year,
month(date_day) as month,
day(date_day) as day,
date_format(date_day,'EEEE') as day_of_week,
quarter(date_day) as quarter
from t
