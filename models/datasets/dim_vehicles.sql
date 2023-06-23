with
    source as (
        select  distinct 
                model
        from  {{ref('order_items')}}
        where type_id = 2
    )

select 
        ROW_NUMBER() OVER(order by model) as sk_vehicles
        , model
 from source