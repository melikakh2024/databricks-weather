with T as (
    select *
    from {{ source('silversource', 'countries_clean') }}
    )
select * from T