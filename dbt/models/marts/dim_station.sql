select
{{dbt_utils.generate_surrogate_key(['ID']) }} as station_sk,
ID as station_id,
latitude,
longitude,
elevation
from {{ ref('stations_stage') }}
