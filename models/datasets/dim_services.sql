with
    source as (
        select  distinct 
                review as service
        from  {{ref('order_items')}}
        where type_id = 2
    )

select 
        ROW_NUMBER() OVER(order by service) as sk_services
        , service
 from source