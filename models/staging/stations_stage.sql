with T as (
    select *
    from {{ source('silversource', 'states_clean') }}
    )
select * from T
