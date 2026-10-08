select
{{dbt_utils.generate_surrogate_key(['CODE']) }}as country_sk,
CODE as country_code,
NAME as country_name
from {{ ref('countries') }}

