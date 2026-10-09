with T as (
    select *
    from {{ source('silversource', 'years_clean') }}
    )
select * from T

