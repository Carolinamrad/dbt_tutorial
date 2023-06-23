with
    source as (
        select  distinct 
                order_type_id
                , type
        from  {{ref('order_types')}}

    )

select * from source