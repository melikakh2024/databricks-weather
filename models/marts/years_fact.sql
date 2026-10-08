{{ config(
    materialized='incremental',
    unique_key=['station_sk', 'date', 'element'],
    partition_by=['date'],
    cluster_by=['station_sk', 'element']
) }}

with t as (

    select *
    from {{ ref('years_stage') }}

)

select
    s.station_sk,
    dt.date,
    t.element,
    t.data_value

from t

left join {{ ref('dim_station') }} as s
    on t.ID = s.station_id

left join {{ ref('dim_date') }} as dt
    on t.date = dt.date
